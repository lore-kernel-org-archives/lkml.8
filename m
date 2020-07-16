Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18994C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 22:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB2B2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 22:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c9lNl2Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGPWNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 18:13:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34214 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgGPWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 18:13:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200716221306euoutp015fd5205a220295278d9c5e28c7cebc62~iW0jsgCbQ2502725027euoutp01D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:13:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200716221306euoutp015fd5205a220295278d9c5e28c7cebc62~iW0jsgCbQ2502725027euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594937586;
        bh=HjIjeHgkDeMXSlbgvN73SHtLE9qoIS6zNqK3nPhBbiU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c9lNl2MpCH4OvQAgEUooubROp7RTZ4hPCUJeRqOL81C8FpqQ1inQ9G5DYhsslmm0Q
         pXtrlJa/elseaLRYO0aRagSaSNW1fraolPuYFXNA6LICaqEHRWz6pE6ugB96TIzMBN
         4lx3a6vdWggo/xbrFGjq/8a0rk5QJ7J5m6eQ7Cfc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200716221305eucas1p299911ed0e5e59a9b68b5bf6e54776874~iW0i3fTJC1724017240eucas1p2V;
        Thu, 16 Jul 2020 22:13:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 41.07.05997.1F0D01F5; Thu, 16
        Jul 2020 23:13:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200716221305eucas1p2c00ea97653e782ebc09345f3cc2816ce~iW0iNpJg71725117251eucas1p2Y;
        Thu, 16 Jul 2020 22:13:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200716221305eusmtrp1781ec0955969b8f706b7ae0f7b377d4c~iW0iNC-hL0133001330eusmtrp1n;
        Thu, 16 Jul 2020 22:13:05 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-72-5f10d0f1130a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.BE.06314.1F0D01F5; Thu, 16
        Jul 2020 23:13:05 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200716221304eusmtip2683580ded0a0ece30cdbe0c7c7c8297e~iW0h0dug12908729087eusmtip2a;
        Thu, 16 Jul 2020 22:13:04 +0000 (GMT)
Subject: Re: [PATCH v2] driver core: Fix sleeping in invalid context during
 device link deletion
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <6b37125c-96f5-c59c-f170-934d68c9bed1@samsung.com>
Date:   Fri, 17 Jul 2020 00:13:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716214523.2924704-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87ofLwjEG/T+MLRoXryezWLHdhGL
        y7vmsFk8WXiGyWLul6nMFl2H/rI5sHls272N1WPBplKPTas62Tz2z13D7rHzewO7x+dNcgFs
        UVw2Kak5mWWpRfp2CVwZN2buYi54q1Zx+uBbxgbGrQpdjJwcEgImEofO7mfsYuTiEBJYwSix
        800vK4TzhVHi48s7UM5nRonOXfOZYVrWH/oL1bKcUeL73QtQzntGiWUnHrCDVAkLJEns+bOT
        GSQhItDGKPFw308WkASzQLxE57nvYDabgKFE19suNhCbV8BOYvPULiYQm0VAVWLmjouMILao
        QJzE+pfbmSBqBCVOznwC1sspYCNxZUM/K8RMeYntb+cwQ9jiEreezGcCWSwhsIldYsvNP0wQ
        d7tInNw8nx3CFpZ4dXwLlC0jcXpyDwtEQzPQpefWskM4PYwSl5tmMEJUWUvcOfcL6FQOoBWa
        Eut36YOYEgKOEo/7ciFMPokbbwUhbuCTmLRtOjNEmFeio00IYoaaxKzj6+C2HrxwiXkCo9Is
        JJ/NQvLNLCTfzEJYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgCjr97/iXHYy7
        /iQdYhTgYFTi4V3gJRAvxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYI+1exHvZtsyaV83xTCcvV2HBoYoS+VDj5jqr
        P19j3A8FG9325CuQbdY6t3vmXRdB5eSAaxaJ/CFfdZ1U+Rm5Ppzuz2CarxtgcZr3krND1Nkb
        XuUHftTdCzCal7Fi7aXJP3c1yZlPZUkXDlbju7F7fbAjr01Wjf6fPRlTfiS8SVNfs2FSJIMS
        S3FGoqEWc1FxIgDH00u0PQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7ofLwjEG2z7x27RvHg9m8WO7SIW
        l3fNYbN4svAMk8XcL1OZLboO/WVzYPPYtnsbq8eCTaUem1Z1snnsn7uG3WPn9wZ2j8+b5ALY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQybszc
        xVzwVq3i9MG3jA2MWxW6GDk5JARMJNYf+svYxcjFISSwlFHi6q7XzBAJGYmT0xpYIWxhiT/X
        utggit4ySmz7+pIRJCEskCSx589OZpCEiEAHo8S3q9fZQBLMAvESU7omMkF09DNKLD3yGWws
        m4ChRNfbLrAiXgE7ic1Tu5hAbBYBVYmZOy6CTRUViJNYvmU+O0SNoMTJmU9YQGxOARuJKxv6
        WSEWmEnM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucW
        G+oVJ+YWl+al6yXn525iBEbdtmM/N+9gvLQx+BCjAAejEg/vAi+BeCHWxLLiytxDjBIczEoi
        vE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wIeSVxBuaGppbWBqaG5sbm1koifN2
        CByMERJITyxJzU5NLUgtgulj4uCUamB0/C16Re5BZq5pylTrzudfOy+Lde3Km3dZ7XaxvvK7
        ORtq0ytzNz7zLVhgWxh6xe3BmxvOKycwbbe+v6ri56n7Zpd+rPjv7DhjaeJTr4eXD5u2vTQS
        koqTttxxfsnJKeldrz8qLr8S+GnZlOr43uafW/4+XM8iZ8bQd7xy/+JzTYud+c/1VuorK7EU
        ZyQaajEXFScCADfCUs7QAgAA
X-CMS-MailID: 20200716221305eucas1p2c00ea97653e782ebc09345f3cc2816ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200716214531eucas1p2c173df09a6e00ef15dfae43ce8f1f9cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200716214531eucas1p2c173df09a6e00ef15dfae43ce8f1f9cd
References: <CGME20200716214531eucas1p2c173df09a6e00ef15dfae43ce8f1f9cd@eucas1p2.samsung.com>
        <20200716214523.2924704-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 16.07.2020 23:45, Saravana Kannan wrote:
> Marek and Guenter reported that commit 287905e68dd2 ("driver core:
> Expose device link details in sysfs") caused sleeping/scheduling while
> atomic warnings.
>
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
> 2 locks held by kworker/0:1/12:
>    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
>    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> Preemption disabled at:
> [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> ----- 8< ----- SNIP
> [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
> [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
> [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
> [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
> [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
> [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> Exception stack(0xee921fb0 to 0xee921ff8)
>
> This was caused by the device link device being released in the context
> of srcu_invoke_callbacks().  There is no need to wait till the RCU
> callback to release the device link device.  So release the device
> earlier and move the call_srcu() into the device release code. That way,
> the memory will get freed only after the device is released AND the RCU
> callback is called.
>
> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> v1->v2:
> - Better fix
> - Changed subject
> - v1 is this patch https://lore.kernel.org/lkml/20200716050846.2047110-1-saravanak@google.com/
>
> Marek and Guenter,
>
> I reproduced the original issue and tested this fix. Seems to work for
> me. Can you confirm?

Confirmed, this one fixes the issue! :)

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Thanks,
> Saravana
>
>   drivers/base/core.c | 45 +++++++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5373ddd029f6..ec16b97d45ed 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -306,10 +306,34 @@ static struct attribute *devlink_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(devlink);
>   
> +static void device_link_free(struct device_link *link)
> +{
> +	while (refcount_dec_not_one(&link->rpm_active))
> +		pm_runtime_put(link->supplier);
> +
> +	put_device(link->consumer);
> +	put_device(link->supplier);
> +	kfree(link);
> +}
> +
> +#ifdef CONFIG_SRCU
> +static void __device_link_free_srcu(struct rcu_head *rhead)
> +{
> +	device_link_free(container_of(rhead, struct device_link, rcu_head));
> +}
> +
>   static void devlink_dev_release(struct device *dev)
>   {
> -	kfree(to_devlink(dev));
> +	struct device_link *link = to_devlink(dev);
> +
> +	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
>   }
> +#else
> +static void devlink_dev_release(struct device *dev)
> +{
> +	device_link_free(to_devlink(dev));
> +}
> +#endif
>   
>   static struct class devlink_class = {
>   	.name = "devlink",
> @@ -730,22 +754,7 @@ static void device_link_add_missing_supplier_links(void)
>   	mutex_unlock(&wfs_lock);
>   }
>   
> -static void device_link_free(struct device_link *link)
> -{
> -	while (refcount_dec_not_one(&link->rpm_active))
> -		pm_runtime_put(link->supplier);
> -
> -	put_device(link->consumer);
> -	put_device(link->supplier);
> -	device_unregister(&link->link_dev);
> -}
> -
>   #ifdef CONFIG_SRCU
> -static void __device_link_free_srcu(struct rcu_head *rhead)
> -{
> -	device_link_free(container_of(rhead, struct device_link, rcu_head));
> -}
> -
>   static void __device_link_del(struct kref *kref)
>   {
>   	struct device_link *link = container_of(kref, struct device_link, kref);
> @@ -758,7 +767,7 @@ static void __device_link_del(struct kref *kref)
>   
>   	list_del_rcu(&link->s_node);
>   	list_del_rcu(&link->c_node);
> -	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> +	device_unregister(&link->link_dev);
>   }
>   #else /* !CONFIG_SRCU */
>   static void __device_link_del(struct kref *kref)
> @@ -773,7 +782,7 @@ static void __device_link_del(struct kref *kref)
>   
>   	list_del(&link->s_node);
>   	list_del(&link->c_node);
> -	device_link_free(link);
> +	device_unregister(&link->link_dev);
>   }
>   #endif /* !CONFIG_SRCU */
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

