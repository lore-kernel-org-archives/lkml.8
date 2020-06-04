Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FE32075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591255171;
	bh=ETl2ZxNOKb1cDLDKRZ2alx6UEVWZ+SN+r8+JbZmbJnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rMwhAngU7mwFGwGCPLzI2vIkUonF6YVoiL67PhCFEs4f9nESA5kBlM5f2VqMna2yj
	 3/ZIF68k73x6KE64oPyY0lHuCDd2lz0l527yZI2Cggchb2miAhZaguy9XoKc10XE3x
	 tjFXu8UeXlyqpc+1nSbsW8lqaVOBDiN3S2hqa97o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgFDHTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgFDHTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:19:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AEC206DC;
        Thu,  4 Jun 2020 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591255169;
        bh=ETl2ZxNOKb1cDLDKRZ2alx6UEVWZ+SN+r8+JbZmbJnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufXYBTJPnU5EFSxHKDYwKnUA4G8CcNq1OZhCCHpQMkayuaguK9VP/u8SKUL4R4xbT
         c8XDu2PQXPgtEwnYiHgQfIFtmjiyCjIH6uNzAqDUWBviaatZM50AFO8/f2x0vFje22
         9IgYTM16yaUTXaK+ouUXysDmGRmO6wU6AuaGXQ+U=
Date:   Thu, 4 Jun 2020 08:19:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Kamlakant Patel <kamlakantp@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>
Subject: Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
Message-ID: <20200604071923.GB30155@willie-the-truck>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
 <DM6PR18MB24258C2F2B91E4BF407421CDD2880@DM6PR18MB2425.namprd18.prod.outlook.com>
 <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:04:58AM +0530, Bhupesh Sharma wrote:
> On Wed, Jun 3, 2020 at 4:50 PM Kamlakant Patel <kamlakantp@marvell.com> wrote:
> > > diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> > > index 1f646b07e3e9..314391a156ee 100644
> > > --- a/arch/arm64/kernel/crash_core.c
> > > +++ b/arch/arm64/kernel/crash_core.c
> > > @@ -7,6 +7,14 @@
> > >  #include <linux/crash_core.h>
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/memory.h>
> > > +#include <asm/pgtable-hwdef.h>
> > > +
> > > +static inline u64 get_tcr_el1_t1sz(void);
> > > +
> > > +static inline u64 get_tcr_el1_t1sz(void) {
> > > +     return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET; }
> > >
> > >  void arch_crash_save_vmcoreinfo(void)
> > >  {
> > > @@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
> > >                                               kimage_voffset);
> > >       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> > >                                               PHYS_OFFSET);
> > > +     vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
> > > +                                             get_tcr_el1_t1sz());
> > I tested this patch on top of upstream kernel v5.7 and I am getting "crash: cannot determine VA_BITS_ACTUAL" error with crash tool.
> > I looked into crash-utility source and it is expecting tcr_el1_t1sz not TCR_EL1_T1SZ.
> > Could you please check.
> 
> Indeed. As per James comments on the v5 (see [1]) where he suggested
> converting ttcr_el1_t1sz into TCR_EL1_T1SZ, I made the change in v6
> accordingly.
> 
> This time I haven't sent out the v6 userspace changes
> (makedumpfile/crash-utility) upstream first, since we are waiting for
> kernel changes to be accepted first, as we have seen in the past that
> while the userspace patches have been accepted, the kernel patches
> required a respin cycle, thus leading to inconsistencies, as you also
> pointed out with crash-utility.

Yes, and that';s the right way to do it. Userspace can't rely on the
stability of a kernel interface if it's no in the upstream kernel!

So doing with the ALL CAPS names is the right thing to do.

Will
