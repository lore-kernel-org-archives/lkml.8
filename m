Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C97207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbgEXTJF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:09:05 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:4823 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgEXTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:09:05 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0C57A240003;
        Sun, 24 May 2020 19:09:01 +0000 (UTC)
Date:   Sun, 24 May 2020 21:08:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] mtd: rawnand: Fix runtime PM imbalance on error
Message-ID: <20200524210859.6c8e81dd@xps13>
In-Reply-To: <20200524190259.3429-1-miquel.raynal@bootlin.com>
References: <20200522104008.28340-1-dinghao.liu@zju.edu.cn>
        <20200524190259.3429-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun, 24 May 2020
21:02:59 +0200:

> On Fri, 2020-05-22 at 10:40:06 UTC, Dinghao Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > when it returns an error code. Thus a pairing decrement is needed on
> > the error handling path to keep the counter balanced.
> > 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.
> 
> Miquel

FYI I changed the title to integrate the driver's name.

Miquèl
