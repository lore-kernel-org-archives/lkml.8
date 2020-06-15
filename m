Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3956C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2D2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgFOI7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:59:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60601 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFOI7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:59:40 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B10DD20016;
        Mon, 15 Jun 2020 08:59:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: brcmnand: Don't default to edu transfer
Date:   Mon, 15 Jun 2020 10:59:36 +0200
Message-Id: <20200615085936.22328-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612212902.21347-2-kdasu.kdev@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: d08f85de4fde11d60c4cf8b6a014b3f217993eb2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-12 at 21:29:01 UTC, Kamal Dasu wrote:
> When flash-dma is absent do not default to using flash-edu.
> Make sure flash-edu is enabled before setting EDU transfer
> function.
> 
> Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
