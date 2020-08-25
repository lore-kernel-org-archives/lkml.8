Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365E82071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHYSjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:39:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:30308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYSjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:39:01 -0400
IronPort-SDR: fyh7gH0/Dnr9VDL+a2ocIRuIW1oUy6sWmofqWLoIxnhwmamtWLEZc63wBL9g3NGZXNgzw0XLBU
 ADEuF/GDNDiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136241445"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136241445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 11:38:33 -0700
IronPort-SDR: W+W31qKdhNSZEG/Vp/ikQWjkchFRz37NxQkVgLQdiz9i+rK5lw4wS4TMpEyd4yzF12K3Z1SG/c
 ha/97AnNQELw==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="474462673"
Received: from mmendo7x-mobl.amr.corp.intel.com (HELO [10.251.24.55]) ([10.251.24.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 11:38:32 -0700
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
To:     Andrew Cooper <amc96@cam.ac.uk>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>
References: <875z98jkof.fsf@nanos.tec.linutronix.de>
 <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice>
 <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice>
 <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
 <dfce335fefe043868301bacf57120759@intel.com>
 <44754766-c996-48a3-a20e-013fa627c0a1@cam.ac.uk>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <31ff691d-ac71-861d-07f4-113fe3c918aa@intel.com>
Date:   Tue, 25 Aug 2020 11:38:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44754766-c996-48a3-a20e-013fa627c0a1@cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 10:59 AM, Andrew Cooper wrote:
> If I've read the TDX spec/whitepaper properly, the main hypervisor can
> write to all the encrypted pages.  This will destroy data, break the
> MAC, and yields #PF inside the SEAM hypervisor, or the TD when the cache
> line is next referenced.

I think you're talking about:

> Attempting to access a private KeyID by software outside the SEAM
> mode would cause a page-fault exception (#PF).

I don't think that ever results in a TD guest #PF.  "A MAC-verification
failure would be fatal to the TD and lead to its termination."  In this
context, I think that means that the TD stops running and can not be
reentered.
