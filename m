Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91263C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2E2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgANRFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:05:06 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:58623 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:05:05 -0500
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id EFA8524000D;
        Tue, 14 Jan 2020 17:05:01 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, andrea.adami@gmail.com,
        bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: sharpslpart: Fix unsigned comparison to zero
Date:   Tue, 14 Jan 2020 18:05:00 +0100
Message-Id: <20200114170500.1384-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230032945.18708-1-yuehaibing@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 662d990e1919dfb0b75834f71f28576343c83d82
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-30 at 03:29:45 UTC, YueHaibing wrote:
> The unsigned variable log_num is being assigned a return value
> from the call to sharpsl_nand_get_logical_num that can return
> -EINVAL.
> 
> Detected using Coccinelle:
> ./drivers/mtd/parsers/sharpslpart.c:207:6-13: WARNING: Unsigned expression compared with zero: log_num > 0
> 
> Fixes: 8a4580e4d298 ("mtd: sharpslpart: Add sharpslpart partition parser")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
