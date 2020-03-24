Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C20C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B2D20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgCXWFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:05:51 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34505 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgCXWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:05:50 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D43DF200002;
        Tue, 24 Mar 2020 22:05:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mtd: phram: fix a double free issue in error path
Date:   Tue, 24 Mar 2020 23:05:46 +0100
Message-Id: <20200324220546.15403-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318153156.25612-1-wenyang@linux.alibaba.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 49c64df880570034308e4a9a49c4bc95cf8cdb33
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 15:31:56 UTC, Wen Yang wrote:
> The variable 'name' is released multiple times in the error path,
> which may cause double free issues.
> This problem is avoided by adding a goto label to release the mem
> uniformly. And this change also makes the code a bit more cleaner.
> 
> Fixes: 4f678a58d335 ("mtd: fix memory leaks in phram_setup")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Joern Engel <joern@lazybastard.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
