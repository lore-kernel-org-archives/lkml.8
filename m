Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63286C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411212074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFHO67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:58:59 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:42582 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbgFHO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:58:59 -0400
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 9942F2004D0;
        Mon,  8 Jun 2020 14:58:57 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 44D6C201F7; Mon,  8 Jun 2020 16:58:42 +0200 (CEST)
Date:   Mon, 8 Jun 2020 16:58:42 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, huawei.libin@huawei.com,
        cj.chengjian@huawei.com, xiexiuqi@huawei.com, mark.rutland@arm.com,
        hch@infradead.org, wcohen@redhat.com, linux-kernel@vger.kernel.org,
        mtk.manpages@gmail.com, wezhang@redhat.com,
        gregkh@linuxfoundation.org, Will Deacon <will@kernel.org>
Subject: Re: [RESEND PATCH] sys_personality: Add optional arch hook
 arch_check_personality
Message-ID: <20200608145842.GA716055@light.dominikbrodowski.net>
References: <20200608024925.42510-1-bobo.shaobowang@huawei.com>
 <20200608094640.GA13596@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608094640.GA13596@gaia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 10:46:41AM +0100, Catalin Marinas wrote:
> On Mon, Jun 08, 2020 at 10:49:25AM +0800, Wang ShaoBo wrote:
> > Currently arm64 personality syscall uses wrapper __arm64_sys_personality
> > to redirect to __arm64_sys_arm64_personality, it's easily confused,
> > Whereas using an normal hook arch_check_personality() can reject
> > additional settings like this for special case of different architectures.
> > 
> > This makes code clean and easier for subsequent modification.
> 
> Do you plan to add more stuff here? Curious what triggered this patch.
> 
> > diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> > index d5ffaaab31a7..5c01816d7a77 100644
> > --- a/arch/arm64/kernel/sys.c
> > +++ b/arch/arm64/kernel/sys.c
> > @@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> >  	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> >  }
> >  
> > -SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
> > +int arch_check_personality(unsigned int personality)
> >  {
> >  	if (personality(personality) == PER_LINUX32 &&
> >  		!system_supports_32bit_el0())
> >  		return -EINVAL;
> > -	return ksys_personality(personality);
> > +
> > +	return 0;
> >  }
> 
> We use the ksys_* pattern in other places as well, so this wouldn't be
> something new.
> 
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 1815065d52f3..3dbbad498027 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1393,16 +1393,6 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
> >  	return do_sys_truncate(pathname, length);
> >  }
> >  
> > -static inline unsigned int ksys_personality(unsigned int personality)
> > -{
> > -	unsigned int old = current->personality;
> > -
> > -	if (personality != 0xffffffff)
> > -		set_personality(personality);
> > -
> > -	return old;
> > -}
> > -
> >  /* for __ARCH_WANT_SYS_IPC */
> >  long ksys_semtimedop(int semid, struct sembuf __user *tsops,
> >  		     unsigned int nsops,
> > diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
> > index 33f07c5f2515..f3682f4bf205 100644
> > --- a/kernel/exec_domain.c
> > +++ b/kernel/exec_domain.c
> > @@ -35,9 +35,21 @@ static int __init proc_execdomains_init(void)
> >  module_init(proc_execdomains_init);
> >  #endif
> >  
> > +int __weak arch_check_personality(unsigned int personality)
> > +{
> > +	return 0;
> > +}
> > +
> >  SYSCALL_DEFINE1(personality, unsigned int, personality)
> >  {
> > -	unsigned int old = current->personality;
> > +	int err;
> > +	unsigned int old;
> > +
> > +	err = arch_check_personality(personality);
> > +	if (err)
> > +		return err;
> > +
> > +	old = current->personality;
> 
> I'm surprised that the generic sys_personality() doesn't call
> ksys_personality() directly but rather duplicates the code.

It was the other way round, and the duplication is based on a
suggestion by Christoph Hellwig IIRC,
	https://lore.kernel.org/lkml/20180514120756.GA11638@infradead.org/

Thanks,
	Dominik
