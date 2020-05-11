Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1EFC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99370206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgEKPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:23:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:1038 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgEKPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:23:30 -0400
IronPort-SDR: f9TUY7F23pBoNev8MB6oOJHI+gjokQfE/+IEgYPARLQAI8b2Cwk3cg72DqzwL4uHA1cPtvZY9P
 FguKoTdYlW8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 08:23:30 -0700
IronPort-SDR: gWRS8Uw2Cii8V8cNVBn4P2RMuZ1yscVv4ucq0aFDc5Q2/90YH2yCy8tmyoIKf6MesNgpfTDeEj
 7PDEnSQ5lgHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="286310905"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 08:23:30 -0700
Date:   Mon, 11 May 2020 08:23:30 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH RFC] Microcode late loading feature identification
Message-ID: <20200511152329.GB79981@otc-nc-03>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
 <56ae9070-5960-1498-c021-74ef4451c222@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ae9070-5960-1498-c021-74ef4451c222@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihai

Thanks for an attempt to find a fix. To solve this for real there
are several other factors to consider and I'm afraid its not as simple
as you have articulated here. There are lots of practical limitations that
prevent us from solving this completely. But we haven't given up :-)

In order to be successful, this needs to be factored in by the vendor either
as part of the development process or somehow generated automatically. Both
have pitfalls, and as you read below some of it might become clear.

On Mon, May 11, 2020 at 05:11:23PM +0300, Mihai Carabas wrote:
> La 27.04.2020 10:27, Mihai Carabas a scris:
> >This RFC patch set aims to provide a way to identify the modifications
> >brought in by the new microcode updated at runtime (aka microcode late
> >loading). This was debated last year and this patch set implements
> >point #1 from Thomas Gleixner's idea:
> >https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/
> >
> 
> +Ashok and Thomas to get a feedback from vendor side on file
> format/integration in the microcode blob and signature.

To understand the complications of microcode there are a few things to consider.

We have been working on this internally, and here is why its difficult to 
simplify it as +msr/-msr, +cpuid etc. Yes these are things that possibly
controlled by microcode, but microcode has several parts, not just CPU microcode.

The revision you see is just one big running number. There are other parts of the 
microcode that you don't see its internal version. In addition some parts of the
microcode are effective only when deployed by FIT. That cpu picks up right after
reset. During late load, even though you see the version updated, it doesn't
mean all the internal versions of ucode are latched and effective.

In addition, there are differences how some mitigations are deployed, as you know
some have MSR's that OS can find, there are others that need BIOS/early boot to 
make the mitigations effective. In order to get a full picture of weather a microcode 
file is late-loadable you need to know a lot more about how we got here to this
version loaded on the CPU.
> 
> Thank you,
> Mihai
> 
> >This patch set has the following patches:
> >
> >- patch 1 is introducing a new metadata file that comes with the microcode
> >(provided by the CPU manufacture) that describes what modifications are
> >done by loading the new microcode
> >
> >- patch 2 parses the metadata file and is verifying it against kernel
> >policy. In this patch, as an RFC, as a kernel policy, it was imposed
> >the rule of not allowing to remove any feature. If so, it won't be
> >loaded a new microcode. The policy can be further extended and describe
> >in different ways

Haven't read the individual patches yet. but you would need every interim
patch metadata to be always available. 

Since if you move from patch x->y you can find that an msr was removed.
But say you go from patch x->z, but there was no msr removed in patch y-z.
You need to process and collate all the msr/cpuid to comprehend what changing
between x->z since that also removes the msr for e.g.

To add more complications CPU has fuses and each patch content can be effective
on some but not all SKU's. So the exact same microcode can have different behavior
depending on which SKU its loaded into. So generating the common meta-data file
is also not a trivial process.

Cheers,
Ashok
