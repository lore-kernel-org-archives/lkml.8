Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948BC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D10F20749
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e/K93zIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgCKUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:49:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56902 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgCKUtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:49:51 -0400
Received: from zn.tnic (p200300EC2F12AA00C8DD6D45313019C7.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:aa00:c8dd:6d45:3130:19c7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 535DC1EC0249;
        Wed, 11 Mar 2020 21:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583959790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qbWnuJhl18sGBSNqPzFCkx33tva9OsDCousxTaIEf3Y=;
        b=e/K93zIt06HtLNUfXJKd1Pmddgaj18Mjl3epOEsRLRBJFS3tchZRve7yHjJHuZnodcrQKu
        1GvgP0SPXSjyGwDBbSerSSUEyABGNoPUBtgktgHwS+/pYOMTe0QJqNxy5TRjWmTOSAjcc+
        /FiaXP3Me12y9nhedrMsz2GfzH4m+iA=
Date:   Wed, 11 Mar 2020 21:49:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200311204813.GM3470@zn.tnic>
References: <20200221165941.508653-1-hdegoede@redhat.com>
 <202003010150.eyjF3gp0%lkp@intel.com>
 <b9a34773-ab38-a3c7-3e35-7da95dc625f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9a34773-ab38-a3c7-3e35-7da95dc625f4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:12:57PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/29/20 6:16 PM, kbuild test robot wrote:
> > Hi Hans,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on tip/x86/core]
> > [also build test ERROR on v5.6-rc3 next-20200228]
> > [cannot apply to tip/auto-latest]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/x86-purgatory-Make-sure-we-fail-the-build-if-purgatory-ro-has-missing-symbols/20200223-040035
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 248ed51048c40d36728e70914e38bffd7821da57
> > config: x86_64-randconfig-s1-20200229 (attached as .config)
> > compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
> > reproduce:
> >          # save the attached .config to linux build tree
> >          make ARCH=x86_64
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     ld: arch/x86/purgatory/purgatory.ro: in function `kstrtoull':
> > > > (.text+0x2b0e): undefined reference to `ftrace_likely_update'
> 
> AFAICT this is the patch working as intended and pointing out an actual issue
> with the purgatory code. Which shows that we really should get this
> patch merged...

... and break the build? I don't think so.

I know, it would fail silently now but I don't recall anyone complaining
about it. So it was a don't care so far.

IOW, first this ftrace_likely_update thing needs to be sorted out and
then this merged.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
