Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644AC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1B5206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBTUnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:43:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:21836 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgBTUnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:43:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 12:43:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="269732380"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2020 12:43:01 -0800
Message-ID: <1a3553f2c6b7c6905ffc5daae3d42ac1aa66353a.camel@intel.com>
Subject: Re: [PATCH v2 1/8] x86/fpu/xstate: Define new macros for supervisor
 and user xstates
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 20 Feb 2020 12:23:00 -0800
In-Reply-To: <20200220114713.GB30188@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
         <20200121201843.12047-2-yu-cheng.yu@intel.com>
         <20200220114713.GB30188@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-20 at 12:47 +0100, Borislav Petkov wrote:
> On Tue, Jan 21, 2020 at 12:18:36PM -0800, Yu-cheng Yu wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > [...]
> > +/* All currently supported supervisor features */
> > +#define SUPPORTED_XFEATURES_MASK_SUPERVISOR (0)
> > +
> > +/*
> > + * Unsupported supervisor features. When a supervisor feature in this mask is
> > + * supported in the future, move it to the supported supervisor feature mask.
> > + */
> > +#define UNSUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> > +
> > +/* All supervisor states including supported and unsupported states. */
> > +#define ALL_XFEATURES_MASK_SUPERVISOR (SUPPORTED_XFEATURES_MASK_SUPERVISOR | \
> > +				       UNSUPPORTED_XFEATURES_MASK_SUPERVISOR)
> 
> So frankly having the namespace prepended in those macros makes it more
> readable to me: you know that those masks all belong together if you had
> this:
> 
> XFEATURE_MASK_SUPERVISOR
> XFEATURE_MASK_SUPERVISOR_SUPPORTED
> XFEATURE_MASK_SUPERVISOR_UNSUPPORTED
> XFEATURE_MASK_SUPERVISOR_ALL
> XFEATURE_MASK_USER_SUPPORTED
> 
> Now they all begin with different words: "ALL", "UNSUPPORTED",
> "SUPPORTED", ... and makes you go and look up the mask to make sure it
> is the correct type of mask used.
> 
> Even more so if the single feature masks also start with
> "XFEATURE_MASK_" so it is only logical to have them all start with
> XFEATURE_MASK_ IMO.

I will make the changes.

Yu-cheng

