Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D95C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CB2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgB1Lxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:53:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1Lxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:53:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1934B2;
        Fri, 28 Feb 2020 03:53:44 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A473F7B4;
        Fri, 28 Feb 2020 03:53:43 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:53:40 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Olof Johansson <olof@lixom.net>
List-Id: <soc.lore.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, SoC Team <soc@kernel.org>,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 13/13] MAINTAINERS: Update Calxeda Highbank
 maintainership
Message-ID: <20200228115340.26495693@donnerap.cambridge.arm.com>
In-Reply-To: <CAOesGMg1AiF5kLipKpD+3BYNE1hPfs2XYwSnFr0Szp3t=4zw-w@mail.gmail.com>
References: <20200227182210.89512-1-andre.przywara@arm.com>
        <20200227182210.89512-14-andre.przywara@arm.com>
        <20200227223523.GH26010@bogus>
        <CAOesGMg1AiF5kLipKpD+3BYNE1hPfs2XYwSnFr0Szp3t=4zw-w@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 16:39:44 -0800
Olof Johansson <olof@lixom.net> wrote:

> On Thu, Feb 27, 2020 at 2:35 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Feb 27, 2020 at 06:22:10PM +0000, Andre Przywara wrote:  
> > > Rob sees little point in maintaining the Calxeda architecture (early ARM
> > > 32-bit server) anymore.
> > > Since I have a machine sitting under my desk, change the maintainership
> > > to not lose support for that platform.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  MAINTAINERS | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)  
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > Send a PR to arm-soc folks for this and the dts changes. I'll pickup the
> > bindings.  
> 
> Given that it's likely to be a low volume of code, we can also just
> apply patches directly in this case (if it's easier than setting up a
> kernel.org account, etc). Andre, just let us know your preference.

I am happy (and more familiar) with just sending a final series via email. Especially if you insist on pulling from kernel.org git trees only, that is probably the only way for now.

To gain more independence from "corporate email" I am looking forward to setting up a kernel.org account and sending proper PRs in the future, but indeed this is probably overkill given the expected volume of patches.

Let me just run some test with the final version of the DT, then I will send a v3.

Cheers,
Andre


