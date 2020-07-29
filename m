Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C97C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A1F206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgG2WHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:07:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:21934 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2WHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:07:15 -0400
IronPort-SDR: 8fpMMl/Ic870kAW6sFiHdtf3VzsEJ2Wsfo6B40IWq8DrcSlo/Php+ZWeqg6Z3gjiYz3F1yZuZ9
 lY5KntjafGfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139511045"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="139511045"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 15:07:14 -0700
IronPort-SDR: sWuxLoWojkxjsr4BOfxDQrzxADpJPxark3spRp2R6u6StfOBIgnrH2GmW9peBdrAju1I4SeHzj
 3fv01O4nRsHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="313183177"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2020 15:07:14 -0700
Date:   Wed, 29 Jul 2020 22:07:14 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729220714.GA318659@otcwcpicx6.sc.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
 <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
 <20200729200033.GJ27751@linux.intel.com>
 <20200729203557.GA318595@otcwcpicx6.sc.intel.com>
 <20200729203905.GN27751@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729203905.GN27751@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sean,

On Wed, Jul 29, 2020 at 01:39:05PM -0700, Sean Christopherson wrote:
> On Wed, Jul 29, 2020 at 08:35:57PM +0000, Fenghua Yu wrote:
> > If sld=fatal and bld=ratelimit (both sld and bld are enabled in hw),
> > a split lock always generates #AC and kills the app and bld will never have
> > a chance to trigger #DB for split lock. So effectively the combination makes
> > the kernel to take two different actions after detecting a bus lock: if the
> > bus lock comes from a split lock, fatal (sld); if the bus lock comes from
> > lock to non-WB memory, ratelimit (bld). Seems this is not a useful combination
> > and is not what the user really wants to do because the user wants ratelimit
> > for BLD, right?
> 
> I understood all off that.  And as I user I want to run sld=fatal and
> bld=ratelimit to provide maximum protection, i.e. disallow split locks at
> all times, and ratelimit the crud SLD #AC can't catch.

Then this will expand the current usages and do need two options. Let me work
on adding a new "bus_lock_detect=" option as you suggested.

Thanks.

-Fenghua
