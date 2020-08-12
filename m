Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F78C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B917020781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHLHXq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:23:46 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34675 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHLHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:23:46 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 10716FF803;
        Wed, 12 Aug 2020 07:23:42 +0000 (UTC)
Date:   Wed, 12 Aug 2020 09:23:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] mtd: lpddr: Fix bad logic bug in print_drs_error
Message-ID: <20200812092341.0adf08e2@xps13>
In-Reply-To: <98383342041c87a8d50fe9cef486a687c50af248.camel@perches.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
        <98383342041c87a8d50fe9cef486a687c50af248.camel@perches.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe, Gustavo,

Joe Perches <joe@perches.com> wrote on Tue, 11 Aug 2020 16:47:36 -0700:

> On Mon, 2020-04-27 at 14:00 -0500, Gustavo A. R. Silva wrote:
> > Hi,
> > 
> > This series aims to fix a bad logic bug in print_drs_error, which is
> > tagged for -stable.  The series also include some formatting fixups.  
> 
> AFAICT: This series is still not applied to any tree.
> 
> Can someone please apply it?

I thought a v2 was coming, Gustavo, can you please send an update? IIRC
there are strings that need to be "unbroken" and an extra "inline"
which needs to be dropped.

Thanks,
Miquèl
