Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C47F2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGGTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:24:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:64625 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGTY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:24:57 -0400
IronPort-SDR: RpI9cLnxOqVjbvIgLycPxZO7rKi/oDzfyaU9CyFzQDpkRLf8pERGrgm0509TBwT7MeL1eLXPp/
 kyJqKkVGSg6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146751596"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="146751596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:24:56 -0700
IronPort-SDR: HwD4dl4M8N6O263Cd6QQGKT2rxFA+wypNC9yjjXSAeXec5ZrhS1U3t4crIrukvPh2nXFW9HiFT
 l6bfJH01Oe4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="283546505"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2020 12:24:55 -0700
Date:   Tue, 7 Jul 2020 12:24:55 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu
 on crash or panic
Message-ID: <20200707192455.GI20096@linux.intel.com>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-3-dpreed@deepplum.com>
 <20200707050932.GF5208@linux.intel.com>
 <1594148978.965916054@apps.rackspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594148978.965916054@apps.rackspace.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:09:38PM -0400, David P. Reed wrote:
> 
> On Tuesday, July 7, 2020 1:09am, "Sean Christopherson" <sean.j.christopherson@intel.com> said:
> Sean, are you the one who would get this particular fix pushed into Linus's
> tree, by the way? The "maintainership" is not clear to me.

Nope, I'm just here to complain and nitpick :-)  There's no direct maintainer
for virtext.h so it falls under the higher level arch/x86 umbrella, i.e. I
expect Boris/Thomas/Ingo will pick this up.
