Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C35C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B353F218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Fyul7HR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgIII57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:57:59 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:3356 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIII56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:57:58 -0400
IronPort-SDR: M1T4w66rXU37rJ9FYIAauOEDca4Jt8nuMpnl3yK7tGXYU2Hlvud6Sedxxra5TQHula/pIUUmY/
 6EKCjAOQ+PAEKXYRUMB3gjTm547G7PoThj+rA4XQ3B7Z85yeXQDuoW8se3Z6ParAXGZ/NEvKF6
 U5hIF5J7Qhqq1yJfKbyoAT5aSZYoppkpyF8YVVSz28j/2AiVH1OtMCSRltQDkEcK68d4aWovkW
 FdS8uGVV2a+Jney29FeN4nLP/zdIpIMeHWOxt9ZISCY4/V99R/k2/kqevx4xB96e0lLlmr1Nfn
 wp0=
X-IronPort-AV: E=Sophos;i="5.76,409,1592863200"; 
   d="scan'208";a="13789128"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Sep 2020 10:57:56 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 09 Sep 2020 10:57:56 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 09 Sep 2020 10:57:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599641876; x=1631177876;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QdPwhLyTflMpS2HnD72qHq2Cn93k9rDsOl9YxSKnCdw=;
  b=Fyul7HR14W9PYmB0oeQXPIWtBX69v8f3a2lPftqaN84TYCSJ2mGX+D7l
   9WWHT89Rupsp6kFCzCAwfmTGPThU41Xy8gPPyFnEk08Oom0QUa4mfaiWm
   riSQrmZZDsS3VaZTUmlMGbXEOEWn1iLhSJGGOxEAP5OS/cEqI/FsvMHVu
   /HkvPcDAVz/pnyIfd661HFXWc7zG8vXw7XerTxxM1myDRYpG5wCEgwUg0
   emiZ6xP10l+L3iPoP9spt7O/0uSr/PaM0yTejQFNAxmCOGTi9LLdAj0Zb
   XpAMxgeTxhXWscGSt7LizUCDLA7ydqSGuEtqJfUTij1LkarBmUI9RK2iZ
   Q==;
IronPort-SDR: bomHdjKVuZal3jcRDf9zoJLM23+9QnhDjHZEYvTfxsrGCJ7cTDru8zqMd3MtfN6VRF4mup16j7
 hUd1qpoCH0uqjY+HJkvwwq+Ul1RZZnvTFowTispmzxTUunbTeGH/5Tp1frlxOmZkjKlEYwdxgk
 XOr3J6jRn24Y4cymnH/0GVnMQslL3lc1NlTbIoLQrh8P9pLxquEmTz3dL/r6lcdpE2vG1LLg/s
 D3LVyrA9SrmNld6o2qRhvej3H3KMMUA9T+cWSRvFK8aZnCsB8UQ1Gc7C0NYC1gkjZEj8gvJLT8
 we4=
X-IronPort-AV: E=Sophos;i="5.76,409,1592863200"; 
   d="scan'208";a="13789127"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Sep 2020 10:57:56 +0200
Received: from schifferm-ubuntu4 (unknown [10.117.49.22])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8021F280070;
        Wed,  9 Sep 2020 10:57:56 +0200 (CEST)
Message-ID: <735c00caa90746d20bfaafa42c4d911c61729228.camel@ew.tq-group.com>
Subject: Re: [PATCH] of: skip disabled CPU nodes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Date:   Wed, 09 Sep 2020 10:57:54 +0200
In-Reply-To: <d7dc1017818e935acf9ba838080bcc3c11b30888.camel@ew.tq-group.com>
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
         <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com>
         <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
         <ac64852a-7f2a-6005-f914-268670cd4f95@gmail.com>
         <CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com>
         <d7dc1017818e935acf9ba838080bcc3c11b30888.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 09:10 +0200, Matthias Schiffer wrote:
> On Wed, 2020-08-26 at 13:26 -0600, Rob Herring wrote:
> > On Wed, Aug 26, 2020 at 8:47 AM Frank Rowand <
> > frowand.list@gmail.com>
> > wrote:
> > > 
> > > Hi Rob,
> > > 
> > > On 2020-08-26 08:54, Matthias Schiffer wrote:
[snip]
> > > > 
> > > > Hmm, I see. This difference in behaviour is quite unfortunate,
> > > > as
> > > > I'm
> > > > currently looking for a way to *really* disable a CPU core.
> > > > 
> > > > In arch/arm64/boot/dts/freescale/imx8mn.dtsi (and other
> > > > variants
> > > > of the
> > > > i.MX8M), there are 4 CPU nodes for the full-featured quad-core
> > > > version.
> > > > The reduced single- and dual-core versions are currently
> > > > handled
> > > > in
> > > > NXP's U-Boot fork by deleting the additional nodes.
> > > > 
> > > > Not doing so causes the kernel to hang for a while when trying
> > > > to
> > > > online the non-existent cores during boot (at least in linux-
> > > > imx
> > > > 5.4 -
> > > > I have not checked a more recent mainline kernel yet), but the
> > > > deletion
> > > > is non-trivial to do without leaving dangling phandle
> > > > references.
> > > 
> > > Any thoughts on implementing another universal property that
> > > means
> > > something like "the hardware described by this node does not
> > > exist
> > > or is so broken that you better not use it".
> > 
> > There's a couple of options:
> > 
> > The DT spec defines 'fail' value for status. We could use that
> > instead
> > of 'disabled'.
> > 
> > The spec behavior with cpu 'disabled' is only on PPC AFAIK. On
> > arm/arm64 (probably riscv now too) we've never followed it where we
> > online 'disabled' CPUs. So we could just make the check conditional
> > on
> > !IS_ENABLED(CONFIG_PPC). This would need some spec update.
> 
> On ARM(64), the "disabled" status on CPUs doesn't have any effect. I
> assume this changed with the mentioned commit c961cb3be906 "of: Fix
> cpu
> node iterator to not ignore disabled cpu nodes", as reverting it
> gives
> me the desired behaviour of considering the disabled CPUs non-
> existent.
> 
> So it seems that we already changed the interpretation in a non-
> compatible way once (back in v4.20), and somehow PPC has yet another
> different behaviour?
> 
> How do we get out of this mess? Is going back to the v4.19 logic for
> non-PPC platforms an acceptable regression fix, or would this be
> considered another breaking change?
> 

Any new insights on this? I'll gladly provide patches or proposals for
a spec update if we can decide where we want to go with this.

Kind regards,
Matthias

