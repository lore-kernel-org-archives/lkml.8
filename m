Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C48520848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCEOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:50:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55388 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgCEOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:50:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 41E97295EE7
Subject: Re: [PATCH v3 0/4] Implement FUTEX_WAIT_MULTIPLE operation
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20200229105130.15436-1-hdanton@sina.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <fdcd5f32-803f-7665-22a2-d674840a3e54@collabora.com>
Date:   Thu, 5 Mar 2020 11:48:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229105130.15436-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/29/20 7:51 AM, Hillf Danton wrote:
> 
> On Thu, 13 Feb 2020 18:45:21 -0300 Andre Almeida wrote:
>>
>> When a write or a read operation in an eventfd file succeeds, it will try
>> to wake up all threads that are waiting to perform some operation to
>> the file. The lock (ctx->wqh.lock) that hold the access to the file value
>> (ctx->count) is the same lock used to control access the waitqueue. When
>> all those those thread woke, they will compete to get this lock. Along
>> with that, the poll() also manipulates the waitqueue and need to hold
>> this same lock. This lock is specially hard to acquire when poll() calls
>> poll_freewait(), where it tries to free all waitqueues associated with
>> this poll. While doing that, it will compete with a lot of read and
>> write operations that have been waken.
> 
> Want to know if a rwsem is likely to help mitigate the tension between the
> readers and writers in your workloads.
> 

Thanks for the suggestion Hillf. However, keep in mind that the lock
that is causing the tension (ctx->wqh.lock) is shared between eventfd()
and poll() syscall, so a solution to help mitigate the tension would
need to be shared between both codes. And since wqh.lock isn't a
read/write lock, even if a lot of readers manage to get this lock in
parallel, they will compete wqh.lock

> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -40,6 +40,7 @@ struct eventfd_ctx {
>  	__u64 count;
>  	unsigned int flags;
>  	int id;
> +	struct rw_semaphore rwsem;
>  };
>  
>  /**
> @@ -212,6 +213,8 @@ static ssize_t eventfd_read(struct file
>  	if (count < sizeof(ucnt))
>  		return -EINVAL;
>  
> +	/* take sem in write mode for event read */
> +	down_write(&ctx->rwsem);
>  	spin_lock_irq(&ctx->wqh.lock);
>  	res = -EAGAIN;
>  	if (ctx->count > 0)
> @@ -229,7 +232,9 @@ static ssize_t eventfd_read(struct file
>  				break;
>  			}
>  			spin_unlock_irq(&ctx->wqh.lock);
> +			up_write(&ctx->rwsem);
>  			schedule();
> +			down_write(&ctx->rwsem);
>  			spin_lock_irq(&ctx->wqh.lock);
>  		}
>  		__remove_wait_queue(&ctx->wqh, &wait);
> @@ -241,6 +246,7 @@ static ssize_t eventfd_read(struct file
>  			wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
>  	}
>  	spin_unlock_irq(&ctx->wqh.lock);
> +	up_write(&ctx->rwsem);
>  
>  	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
>  		return -EFAULT;
> @@ -262,6 +268,8 @@ static ssize_t eventfd_write(struct file
>  		return -EFAULT;
>  	if (ucnt == ULLONG_MAX)
>  		return -EINVAL;
> +	/* take sem in read mode for event write */
> +	down_read(&ctx->rwsem);
>  	spin_lock_irq(&ctx->wqh.lock);
>  	res = -EAGAIN;
>  	if (ULLONG_MAX - ctx->count > ucnt)
> @@ -279,7 +287,9 @@ static ssize_t eventfd_write(struct file
>  				break;
>  			}
>  			spin_unlock_irq(&ctx->wqh.lock);
> +			up_read(&ctx->rwsem);
>  			schedule();
> +			down_read(&ctx->rwsem);
>  			spin_lock_irq(&ctx->wqh.lock);
>  		}
>  		__remove_wait_queue(&ctx->wqh, &wait);
> @@ -291,6 +301,7 @@ static ssize_t eventfd_write(struct file
>  			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>  	}
>  	spin_unlock_irq(&ctx->wqh.lock);
> +	up_read(&ctx->rwsem);
>  
>  	return res;
>  }
> @@ -408,6 +419,7 @@ static int do_eventfd(unsigned int count
>  	init_waitqueue_head(&ctx->wqh);
>  	ctx->count = count;
>  	ctx->flags = flags;
> +	init_rwsem(&ctx->rwsem);
>  	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
>  
>  	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
> 

