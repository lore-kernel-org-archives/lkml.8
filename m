Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC69CC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22D520747
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDUT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:56:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:12926 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgDUT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:56:30 -0400
IronPort-SDR: v8v6KWO4hLM0DHT29242Oqjx9v9hZefrPttW9s8u9UgpFXRuvh9klig0bjdE786AqX9UodomnC
 KThs3Psf2qWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:56:29 -0700
IronPort-SDR: 45310gdaHpjeDnHv2hE60TDlC//gOb8vlpjLnefdzstkd68oq4wZxwg5+NG5M02X/mrpeKURgR
 /7BG5DiXnDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="456228915"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2020 12:56:29 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 967233019B6; Tue, 21 Apr 2020 12:56:29 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:56:29 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200421195629.GE608746@tassilo.jf.intel.com>
References: <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
 <20200414003205.GF397326@tassilo.jf.intel.com>
 <20200417133021.GT1068@sasha-vm>
 <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
 <20200420141320.GC608746@tassilo.jf.intel.com>
 <87y2qqaxkp.fsf@nanos.tec.linutronix.de>
 <20200421160622.GJ1809@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421160622.GJ1809@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi's point is that there is no known user it breaks, and the Intel
> folks did some digging into potential users who might be affected by
> this, including 'rr' brought up by Andy, and concluded that there won't
> be breakage as a result of this patchset:
> 
> 	https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
> 
> Sure, if you poke at it you could see a behavior change, but is there
> an actual user that will be affected by it? I suspect not.

Actually we don't know of any behavior changes caused by the kernel
with selectors.

The application can change itself of course, but only if it uses the 
new instructions, which no current application does.

[This was different in the original patch kit long ago which could
change behavior on context switch for programs with out of sync selectors,
but this has been long fixed]

A debugger can also change behavior, but we're not aware of any case
that it would break.

For rr or criu we're also not aware of any case that could break.

I honestly don't know what else could be done in due diligence.

Also just to reiterate merging this would immediately shave off
hundreds of cycles in most context switches.

-Andi
