Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56341C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1842076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgHETyF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:05 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42396 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgHEQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:49:09 -0400
X-Greylist: delayed 2502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 12:49:07 EDT
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 947DC3A9F99;
        Wed,  5 Aug 2020 15:27:41 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 385F760004;
        Wed,  5 Aug 2020 15:22:18 +0000 (UTC)
Date:   Wed, 5 Aug 2020 17:22:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>
Subject: Re: [PATCH 3/4] i3c: master: svc: Add Silvaco I3C master driver
Message-ID: <20200805172217.27a00af5@xps13>
In-Reply-To: <nycvar.YSQ.7.77.849.2008051105550.1112668@knanqh.ubzr>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com>
        <20200709080159.2178-3-miquel.raynal@bootlin.com>
        <nycvar.YSQ.7.77.849.2008031546570.1112668@knanqh.ubzr>
        <BN6PR16MB1762D6CE430AB08B7A2BE5FCF14A0@BN6PR16MB1762.namprd16.prod.outlook.com>
        <nycvar.YSQ.7.77.849.2008051105550.1112668@knanqh.ubzr>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Nicolas Pitre <nico@fluxnic.net> wrote on Wed, 5 Aug 2020 11:13:41
-0400 (EDT):

> On Tue, 4 Aug 2020, Conor Culhane wrote:
> 
> > Miquel is passing 0 as the delay_us argument.  
> 
> Good point.
> 
> > Is this still a concern?  
> 
> Not in that case.

I will check again if looping over this register read actually
makes sense or not. If yes, I will add a comment here.

Thanks,
Miquèl
