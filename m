Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49673C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297D420738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgH3Vi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:38:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:48748 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgH3ViZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:38:25 -0400
IronPort-SDR: YjPfvuUfB7jIEN9NHe3X0xF72EhOJom+zBiNDd+rT1wJKGi6cOkNrm4zKsoBBBpbmJiErqs427
 HM8GbVWLk4xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144563395"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="144563395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 14:38:25 -0700
IronPort-SDR: Fu1apSQaaOoTA69/VmOdkNAlEU5LNsLNOFe7iQ0OV2tyuvtLnJt6KBVVZmomCXSsINarmh4wEA
 2Tj1M7R0L1Qw==
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="445502270"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 14:38:24 -0700
Message-ID: <58ec8ad4f6712fb8aa3db08e4a8d661d5531d7a0.camel@intel.com>
Subject: Re: [PATCH v2] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, dave.hansen@intel.com, ricardo.neri@intel.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ak@linux.intel.com,
        ravi.v.shankar@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Sun, 30 Aug 2020 14:21:03 -0700
In-Reply-To: <20200830115024.GA4297@zn.tnic>
References: <20200824180412.9440-1-kyung.min.park@intel.com>
         <20200828184209.GC19342@zn.tnic>
         <b171209faab7e141a9988ecf47fa55bf855cb664.camel@intel.com>
         <20200830115024.GA4297@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-30 at 13:50 +0200, Borislav Petkov wrote:
> On Fri, Aug 28, 2020 at 03:30:32PM -0700, Kyung Min Park wrote:
> > Should I mention the tool specifically although the tool is WIP?
> 
> Well, if you wanna look at it that way, the whole kernel is
> constantly
> and forever WIP. :-)
> 
> Also, if there's some functionality missing, pointing to it might
> make
> people send patches.

That makes sense. :)

> > As you commented previously, should I use
> > tools/arch/x86/tools/cpuid/cpuid as the future tool and its
> > location?
> 
> Yeah, let's just drop the second "tools", i.e.,
> 
> tools/arch/x86/kcpuid/
> 
> or so should be good enough.
> 
> Thx.

Sure, I'll update in the next patch. Thank you for clarifying.

