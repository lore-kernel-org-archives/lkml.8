Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B06EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A5F20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCJSdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:33:49 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54465 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgCJSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:33:48 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 685B520004;
        Tue, 10 Mar 2020 18:33:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spinand: toshiba: Add comment about Kioxia ID
Date:   Tue, 10 Mar 2020 19:33:45 +0100
Message-Id: <20200310183345.20023-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1581051561-7302-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: a91f8170df832967dc75d5bd594c496999882e22
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 04:59:21 UTC, Yoshio Furuyama wrote:
> Add a comment above NAND_MFR_TOSHIBA and SPINAND_MFR_TOSHIBA definitions
> that Toshiba and Kioxia ID are the same.
> Since its independence from Toshiba Group, Toshiba memory Co has become
> Kioxia Co.
> 
> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
