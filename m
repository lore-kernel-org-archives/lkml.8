Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4F22145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgIGUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:06:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:52240 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:06:24 -0400
IronPort-SDR: OOO1ZrY6bt76iFmxtS1h4Fk2de1Izoux0es3ifjoXrbQPRq+a8Wdf2INqQqI+gLQwTJytcjhb+
 k8Ibsv5qnFcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="222248571"
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="scan'208";a="222248571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 13:06:23 -0700
IronPort-SDR: /YU9WwoNRI1S0TgiNOU2IbDGqPimsrWl/Gr9O4gRf267CnFEIZVEXKFfQehCU1nbpXYVXmVIvK
 4ZUe3ZKr5FAQ==
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="scan'208";a="303844854"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 13:06:23 -0700
Date:   Mon, 7 Sep 2020 13:06:22 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
References: <20200906212130.GA28456@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906212130.GA28456@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 11:21:30PM +0200, Borislav Petkov wrote:
> Hi,
> 
> Ingo and I talked about this thing this morning and tglx has had it on
> his to-fix list too so here's a first attempt at it.
> 
> Below is just a brain dump of what we talked about so let's start with
> it and see where it would take us.

This very much looks to be the right thing to do. Returning "0" from
a failed RDMSR in MCE handling might be a much worse thing to do than
crashing. It papers over a serious error and the system might keep
running using corrupted data.

Digging into the history it seems that this rdmsrl_safe() was added for
a possible bug on a pentiumIII back in 2009 that was eventually closed
as "unreproducible".

Do we have three distinct classes of calls to RDMSR now?


1) This case. Architecture checks have been made. This call can't
fail. We are calling from a tricky state (on IST) so no tracing
allowed.

2) Normal case ... architecture checks have been done so shouldn't
fail. Safe state for tracing etc. Use rdmsrl().

3) Probe case. Architecture didn't provide definitive enumeration,
so we might take a #GP. Use the rdmsrl_safe().

> +	/*
> +	 * RDMSR on MCA MSRs should not fault. If they do, this is very much an
> +	 * architectural violation and needs to be reported to hw vendor.
> +	 */
> +	asm volatile("rdmsr" : EAX_EDX_RET(val, low, high) : "c" (msr));

If mce subsystem is the only instance of case "1", then this
inline is OK.  If there are others then rather than inlining
the asm here, we should have some new rdmsrl_notrace() inline
function declared for all to use.

Needs a:

Fixes: 11868a2dc4f5 ("x86: mce: Use safer ways to access MCE registers")

since this is undoing an earlier change.

-Tony
