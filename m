Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C13C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C642075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgG2X2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:28:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:31754 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgG2X2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:28:10 -0400
IronPort-SDR: INjKOM/+yw7RBJgVKmxjxv1O/yz16A7RkrwIeODznbGGkaXlIxJ+BKnhTy43/np2N9N83E+Qzp
 3MvaYLM4kgIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236379224"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="236379224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:28:09 -0700
IronPort-SDR: 6IXRQWPsYnycLnkAm/UyYMMR5UZE3qBPgzTNyH6mvZ9S59ktFDmD4Pala+4/KnlmVTTrjlYyVL
 CX3Jm5sa3jMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="394804237"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2020 16:28:08 -0700
Date:   Wed, 29 Jul 2020 16:28:08 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729232808.GP27751@linux.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
 <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
 <20200729200033.GJ27751@linux.intel.com>
 <20200729203557.GA318595@otcwcpicx6.sc.intel.com>
 <20200729203905.GN27751@linux.intel.com>
 <20200729220714.GA318659@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729220714.GA318659@otcwcpicx6.sc.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:07:14PM +0000, Fenghua Yu wrote:
> Hi, Sean,
> 
> On Wed, Jul 29, 2020 at 01:39:05PM -0700, Sean Christopherson wrote:
> > On Wed, Jul 29, 2020 at 08:35:57PM +0000, Fenghua Yu wrote:
> > > If sld=fatal and bld=ratelimit (both sld and bld are enabled in hw),
> > > a split lock always generates #AC and kills the app and bld will never have
> > > a chance to trigger #DB for split lock. So effectively the combination makes
> > > the kernel to take two different actions after detecting a bus lock: if the
> > > bus lock comes from a split lock, fatal (sld); if the bus lock comes from
> > > lock to non-WB memory, ratelimit (bld). Seems this is not a useful combination
> > > and is not what the user really wants to do because the user wants ratelimit
> > > for BLD, right?
> > 
> > I understood all off that.  And as I user I want to run sld=fatal and
> > bld=ratelimit to provide maximum protection, i.e. disallow split locks at
> > all times, and ratelimit the crud SLD #AC can't catch.
> 
> Then this will expand the current usages and do need two options. Let me work
> on adding a new "bus_lock_detect=" option as you suggested.

I'd wait for feedback from others before spending too much effort rewriting
everything, I'm just one person with an opinion.
