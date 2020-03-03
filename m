Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E4DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7643E20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgCCMcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:32:35 -0500
Received: from elvis.franken.de ([193.175.24.41]:49595 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgCCMcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:32:35 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1j96iu-0003ir-00; Tue, 03 Mar 2020 13:32:32 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 43958C0EC5; Tue,  3 Mar 2020 13:32:14 +0100 (CET)
Date:   Tue, 3 Mar 2020 13:32:14 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Boddie <paul@boddie.org.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] MIPS: DTS: CI20: fix PMU definitions for ACT8600
Message-ID: <20200303123214.GA15333@alpha.franken.de>
References: <cover.1583005548.git.hns@goldelico.com>
 <02f18080fa0e0c214b40431749ca1ce514c53d37.1583005548.git.hns@goldelico.com>
 <20200303101818.GA12103@alpha.franken.de>
 <85F9D066-EAF6-4840-8F54-24E6D8A534DC@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85F9D066-EAF6-4840-8F54-24E6D8A534DC@goldelico.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 01:10:22PM +0100, H. Nikolaus Schaller wrote:
> > And please seperate fixes from improvments, thank you.
> 
> What do you mean by "separate"? Two separate patches?
> This patch only contains fixes (which I would consider
> all of them to be improvements).

There are two patches with Fixes tag, which IMHO should go
into 5.6 via mips-fixes branch. All others are going
via mips-next into 5.7. So it helps me, if they come in different
patch series (or as single patches).

I see other DT changes in your other patch series. Are the changes
there independent from each other or do they require correct order
when appling them ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
