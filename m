Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B2AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E57C2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404547AbgDNOpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:45:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:13080 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404517AbgDNOpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:45:21 -0400
IronPort-SDR: aYmMNxt+SQouH7In8pYnsmuMCVp/GRiN0NcSbdoz5ETFgXng21i1OXhFOIHJJ13hkkHrolyqkd
 7UH1IQ3Mu+JA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 07:45:16 -0700
IronPort-SDR: PobXDpZNf0jtNRkWrmz39i7ngBS/sjvnT/2SR1sUU6i3DDm9UZChQ8gK20Ek7t3sMQHiHYzgOD
 uY8zsXymYUog==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="253216826"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.11.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 07:45:15 -0700
Message-ID: <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, bp@suse.de
Date:   Tue, 14 Apr 2020 07:45:14 -0700
In-Reply-To: <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
         <20200407063345.4484-3-Jason@zx2c4.com>
         <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
         <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 22:21 -0600, Jason A. Donenfeld wrote:
> On Mon, Apr 13, 2020 at 9:38 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > > The thermal IRQ handler uses 1.21% CPU on my system when it's hot
> > > from
> > > compiling things. Indeed looking at /proc/interrupts reveals
> > > quite a
> > > lot
> > I am curious why you are hitting threshold frequently?
> > What is rdmsr 0x1a2
> 
> 5640000
You are getting too many interrupts at 95C. You should look at your
cooling system. 

> 
> > > of events coming in. Beyond logging them, the existing drivers on
> > > the
> > > system don't appear to do very much that I'm interested in. So,
> > > add a
> > > way to disable this entirely so that I can regain precious CPU
> > > cycles.
> > It is showing amount of time system is running in a constrained
> > environment. Lots of real time and HPC folks really care about
> > this.
> 
> Which is why this patch adds an option, not a full removal or
> something. Real time and HPC people can keep their expensive
> interrupt. Other people with different varieties of system
> disable
> it.
Generally compile time flag is not desirable. If it is what required
then we should have boot time flag something in lines of existing
"int_pln_enable" option.

Thanks,
Srinivas



