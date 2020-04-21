Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C7BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE62075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1+MTefLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgDUMW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:22:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BDCC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Z2RFbR3SDVpdahpgAdwxxD2MyeutNvasm9kZ/3o1Qw=; b=1+MTefLgrcUUGRryRNn4I5Ubg
        NHqCHj3Jg51ilBg/oUOHXkVDM8km4QX7so379adQEIytm9Bmgs9WeaR1gAXjx3aUFD+fWFw5ksryK
        iURih+rN0fFeZOQqS3I46QS6KcxWuAX8y6QgX0jmae6Do6NpBNNL56xjwSAdSl2StR4DlLQVbqExb
        XnI93Q2kXAg5zY3dKlcw+TsnY7xtqD0Mu24LL4OM3rbJq3+qwQ4p88+k8oDTu0k9lqe8GzFIUkWog
        bwvOdsIFG7WSQIUWc4b000Ekx0ptcW0seVV/kfmYurUKaDNHt+uZM7AW6JjSaJ+L/igGD6oOn2sNG
        7hY/S96OQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53236)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jQrv5-0001Q5-Dv; Tue, 21 Apr 2020 13:22:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jQruy-00071c-Nf; Tue, 21 Apr 2020 13:22:24 +0100
Date:   Tue, 21 Apr 2020 13:22:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        gregkh@linuxfoundation.org, info@metux.net, allison@lohutok.net,
        james.morse@arm.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] arm32: fix flushcache syscall with device address
Message-ID: <20200421122224.GC25745@shell.armlinux.org.uk>
References: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:08:34PM +0800, Tian Tao wrote:
> An issue has been observed on our Kungpeng916 systems when using a PCI
> express GPU. This occurs when a 32 bit application running on a 64 bit
> kernel issues a cache flush operation to a memory address that is in
> a PCI BAR of the GPU.The results in an illegal operation and
> subsequent crash.

The arm32 cacheflush interface is *NOT* for syncing memory for accesses
performed by another device.  This can't be said strongly enough.

It is _only_ to support synchronisation of the I/D caches for
applications that need to "write their own code", i.o.w.
self-modification.

Your use of this interface is therefore incorrect.

If you have the privileges of being able to map PCI BARs, then you
already have privileged access to the system.

Please stop pointing the metaphorical gun at your foot.

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Signed-off-by: Lixin Chen <chenlixin1@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  arch/arm64/kernel/sys_compat.c | 69 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
> index 3c18c24..6c07944 100644
> --- a/arch/arm64/kernel/sys_compat.c
> +++ b/arch/arm64/kernel/sys_compat.c
> @@ -15,12 +15,74 @@
>  #include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/system_misc.h>
>  #include <asm/tlbflush.h>
>  #include <asm/unistd.h>
>  
> +static long __check_pt_cacheable(unsigned long vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pudval_t pudval;
> +	pmd_t *pmd;
> +	pmdval_t pmdval;
> +	pte_t *pte;
> +	pteval_t pteval;
> +	pgprot_t pgprot;
> +
> +	spin_lock(&mm->page_table_lock);
> +	pgd = pgd_offset(mm, vaddr);
> +	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
> +		goto no_page;
> +
> +	p4d = p4d_offset(pgd, vaddr);
> +	if (p4d_none(*p4d) || unlikely(p4d_bad(*p4d)))
> +		goto no_page;
> +
> +	pud = pud_offset(p4d, vaddr);
> +	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
> +		goto no_page;
> +	if (pud_huge(*pud)) {
> +		pudval = pud_val(*pud);
> +		pgprot = __pgprot(pudval);
> +		goto out;
> +	}
> +
> +	pmd = pmd_offset(pud, vaddr);
> +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> +		goto no_page;
> +	if (pmd_huge(*pmd)) {
> +		pmdval = pmd_val(*pmd);
> +		pgprot = __pgprot(pmdval);
> +		goto out;
> +	}
> +
> +	pte = pte_offset_map(pmd, vaddr);
> +	if (!pte_present(*pte) || pte_none(*pte))
> +		goto no_page;
> +	pteval = pte_val(*pte);
> +	pgprot = __pgprot(pteval);
> +
> +out:
> +	pgprot.pgprot &= PTE_ATTRINDX_MASK;
> +	if (pgprot.pgprot != PTE_ATTRINDX(MT_NORMAL)) {
> +		pr_debug("non-cache page pgprot value=0x%llx.\n",
> +			pgprot.pgprot);
> +		goto no_page;
> +	}
> +	spin_unlock(&mm->page_table_lock);
> +	return 1;
> +
> +no_page:
> +	spin_unlock(&mm->page_table_lock);
> +	return 0;
> +}
> +
>  static long
>  __do_compat_cache_op(unsigned long start, unsigned long end)
>  {
> @@ -32,6 +94,13 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
>  		if (fatal_signal_pending(current))
>  			return 0;
>  
> +		 /* do not flush page table is non-cacheable */
> +		if (!__check_pt_cacheable(start)) {
> +			cond_resched();
> +			start += chunk;
> +			continue;
> +		}
> +
>  		if (cpus_have_const_cap(ARM64_WORKAROUND_1542419)) {
>  			/*
>  			 * The workaround requires an inner-shareable tlbi.
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
