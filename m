Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9944E207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgETBZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:25:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:57023 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETBZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:25:29 -0400
IronPort-SDR: cmJSgNikuq0rsM3wh0R2+DN/brhvSZ0s9dACNChL6EO0b/95bkfSOD6cG6uH9do/7DseCDpa2k
 +zEQEa8ScW6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 18:25:29 -0700
IronPort-SDR: MDx3VP1Ag3njQZh53RjtNhipvr8a/FY2Meq9Bv17SiqNpQJAh3/K1jVEYEsAkqeGXFuYpc7kJ1
 hu9Mz+vnpMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="466194708"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 19 May 2020 18:25:26 -0700
Date:   Wed, 20 May 2020 09:24:04 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>, lkp <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
Message-ID: <20200520012404.GA3992@intel.com>
References: <202005200123.gFjGzJEH%lkp@intel.com>
 <20200519205505.GD444@zn.tnic>
 <20200519212541.GA3580016@ubuntu-s3-xlarge-x86>
 <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
 <831EE4E5E37DCC428EB295A351E6624952648ACF@shsmsx102.ccr.corp.intel.com>
 <CAKwvOdmoA5ZFCiUQ5fVf7+970Y4bxvU=kYWb49NENQzxdm7F1Q@mail.gmail.com>
 <20200520005218.GA3101@intel.com>
 <CAKwvOdkPW2p-4fDUNT6so3DrxiJgtUNEFPJcHNf7VROozc4wjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkPW2p-4fDUNT6so3DrxiJgtUNEFPJcHNf7VROozc4wjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 06:07:14PM -0700, Nick Desaulniers wrote:
> On Tue, May 19, 2020 at 5:53 PM Philip Li <philip.li@intel.com> wrote:
> >
> > On Tue, May 19, 2020 at 05:26:18PM -0700, Nick Desaulniers wrote:
> > > I think having in the top of the warning that this is a W=1 build will
> > > make it more obvious.
> > >
> > > I get that -Wmissing-prototypes can be noisy, but it's trivial to fix.
> > > I do worry what other warnings lurk in W=1 though...
> > with some monitoring, so far, issue like unused-but-set-variable is quite
> > helpful. We will keep monitor for other issues and feedbacks.
> 
> Hey, I'm always happy to see more warnings turned on.  In our
> experience, we had to get a sense of how many instances of a newly
> enabled warning there are, and estimate how much time it would take to
> fix them all.  It's further complicated by the fix going into
> different maintainers' trees and reaching mainline at different points
> in time, while regressions continue to sneak in until the warning is
> enabled.
thanks and agree all the thinking here. For the 0-day ci side, we will
be very careful, since the mechanism for us is to notify newly introduced
problems from developer's patch, this can allow relatively min effort
to solve the new problems.

The other consideration is we test a lot of developer's tree and mailing
list before they are upstream, we also hope such shift left testing can
expose these warnings in new patches before maintainer's trees. Of course,
there're extra reports due to W=1 against stable or mainline, while the
number is small comparing to developer and mailing list part.

> 
> It may be time to consider "promoting" some warnings from W=1 to be on
> by default.  But that takes careful manual review and estimation of
> the work involved.  Turning on W=1 may be blasting people with a lot
> of new warnings, but if developers treat them with the same respect as
> the default enabled ones for Kbuild then I'm not complaining.
> -- 
> Thanks,
> ~Nick Desaulniers
