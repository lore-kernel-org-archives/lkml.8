Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FFDC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDC020732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgDJTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:02:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:4270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgDJTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:02:44 -0400
IronPort-SDR: 6Tjbf4bI3ZYjfd4u4KLzBXje8dw0OLoGP1xmwoco9tle5tZvKICv5gIjQEalv+5YEpxPv8cmvW
 b0gqWbaSCVeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 12:02:44 -0700
IronPort-SDR: CUtVAerjlxQ4wnYnfmzNLzjubKaH1QSENwxzaKxpFS7TQPRQ21jO01rpiq8ivNztIL0hyUzZzj
 LjbLYt1vGkJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,367,1580803200"; 
   d="scan'208";a="276269360"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2020 12:02:43 -0700
Date:   Fri, 10 Apr 2020 12:02:43 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 0/3] x86/kvm: Basic split lock #AC handling
Message-ID: <20200410190243.GH22482@linux.intel.com>
References: <20200410115359.242241855@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410115359.242241855@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 01:53:59PM +0200, Thomas Gleixner wrote:
> This is a reworked version of the patches posted by Sean:
> 
>  https://lore.kernel.org/r/20200402155554.27705-1-sean.j.christopherson@intel.com
> 
> The changes vs. this are:
> 
>     1) Use a separate function for guest split lock handling
> 
>     2) Force SIGBUS when SLD mode fatal

Not that it matters as the code is correct, but I think you meant
"when SLD mode off" here.

>     3) Rename the misnomed helper function which decides whether
>        #AC is injected into the guest or not and move the feature
>        check and the comments into that helper.

Thanks a bunch for helping push this along!
