Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F703C10F27
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586B620656
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583574951;
	bh=gQRp4hFTqo4KkDpvhpmcHmhosoj3bEke3t7VFR4Ae1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Mfdg/XE2gMzU+Hqk7cKvLIdfY5cR1VFs3FNajFYLxQ7lL1EDDzvsLcC8piB0Ac95E
	 mSXllwlYio0UZeIKmJDQu9pKtb3mWWFi/IZyT+gLCLAprAzqEfzChXmrhWveTr/5JL
	 n8QcAtK45zJlvXjhHo7kJmPyN7PUxbxcvrWR4tlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGJyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 04:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgCGJyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:54:44 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDBC2073D;
        Sat,  7 Mar 2020 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583574884;
        bh=gQRp4hFTqo4KkDpvhpmcHmhosoj3bEke3t7VFR4Ae1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U49/ZN5xSCyzsM/kraUH/xSsLapsiK4cis7pIBjBD0nMOJoWNVhakn2slJnjrZs7A
         pX6CmHD9zoNFF0XLdZ55qFgfjLjWq8Z7V7gFOzxKYphWjMXElOTM2P5h+2koWGd+Pc
         arFIlMBCwThbkHb3pWO+EKAL/P+mPE7J9tVAWzeI=
Date:   Sat, 7 Mar 2020 18:54:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>,
        <bobo.shaobowang@huawei.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>
Subject: Re: [PATCH] kretprobe: check re-registration of the same kretprobe
 earlier
Message-Id: <20200307185439.9e88f3c8b55a3f11923ea694@kernel.org>
In-Reply-To: <9b122a6f-f5fa-3eb4-4fd7-f101b8aec205@huawei.com>
References: <1583487306-81985-1-git-send-email-cj.chengjian@huawei.com>
        <20200307002115.b96be2310cc553a922e1ba31@kernel.org>
        <9b122a6f-f5fa-3eb4-4fd7-f101b8aec205@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Mar 2020 10:16:35 +0800
"chengjian (D)" <cj.chengjian@huawei.com> wrote:

> 
> On 2020/3/6 23:21, Masami Hiramatsu wrote:
> > Hi Cheng,
> >
> > On Fri, 6 Mar 2020 17:35:06 +0800
> > Cheng Jian <cj.chengjian@huawei.com> wrote:
> >
> >> Our system encountered a use-after-free when re-register a
> >> same kretprobe. it access the hlist node in rp->free_instances
> >> which has been released already.
> >>
> >> Prevent re-registration has been implemented for kprobe before,
> >> but it's too late for kretprobe. We must check the re-registration
> >> before re-initializing the kretprobe, otherwise it will destroy the
> >> data and struct of the kretprobe registered, it can lead to memory
> >> leak and use-after-free.
> > I couldn't get how it cause use-after-free, but it causes memory leak.
> > Anyway, if we can help to find a wrong usage, it might be good.
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > BTW, I think we should use WARN_ON() for this error, because this
> > means the caller is completely buggy.
> >
> > Thank you,
> 
> Hi Masami
> 
> When we try to re-register the same kretprobe, the register_kprobe() 
> return failed and try to free_rp_inst
> 
>      register_kretprobe()
> 
>          raw_spin_lock_init(&rp->lock);
>          INIT_HLIST_HEAD(&rp->free_instances);    # re-init
> 
>          inst = kmalloc(sizeof(struct kretprobe_instance) + 
> p->data_size, GFP_KERNEL); # re-alloc
> 
>          ret = register_kprobe(&rp->kp);  # failed
> 
>          free_rp_inst(rp);   # free all the free_instances
> 
> at the same time, the kretprobe registed handle(trigger), it tries to 
> access the free_instances.
> 
> Since we broke the rp->lock and free_instances when re-registering, we 
> are accessing the newly
> 
> allocated free_instances and it's being released.
> 
> pre_handler_kretprobe
> 
>      ri = hlist_entry(rp->free_instances.first, struct 
> kretprobe_instance, hlist); # access the new free_instances. BOOM!!!
> 
>      hlist_del(&ri->hlist); #BOOM!!!

Ah, I see. I thought that you said ri is use-after-free, but in reality,
rp is use-after-free (use-after-init). OK.

> And the problem here is destructive, it destroyed all the data of the 
> previously registered kretprobe,
> it can lead to a system crash, memory leak, use-after-free and even some 
> other unexpected behavior.

Yes, so I think we should do 

+	/* Return error if it's being re-registered */
+	ret = check_kprobe_rereg(&rp->kp);
+	if (WARN_ON(ret))
+		return ret;

This will give a warning message to the developer.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
