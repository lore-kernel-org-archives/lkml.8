Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79653C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DF724676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgANRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:05:33 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49523 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgANRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:05:33 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 50E90E0009;
        Tue, 14 Jan 2020 17:05:30 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] mtd: onenand: samsung: Fix pointer cast -Wpointer-to-int-cast warnings on 64 bit
Date:   Tue, 14 Jan 2020 18:05:28 +0100
Message-Id: <20200114170528.1554-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191229183612.22133-1-krzk@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: d321e010dc0dd3a28d48f1d9314161678ac13aa1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-12-29 at 18:36:10 UTC, Krzysztof Kozlowski wrote:
> iomem pointers should be casted to unsigned long to avoid
> -Wpointer-to-int-cast warnings when compiling on 64-bit platform (e.g.
> with COMPILE_TEST):
> 
>     drivers/mtd/nand/onenand/samsung_mtd.c: In function ‘s3c_onenand_readw’:
>     drivers/mtd/nand/onenand/samsung_mtd.c:251:6: warning:
>         cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       if ((unsigned int) addr < ONENAND_DATARAM && onenand->bootram_command) {
>           ^
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
