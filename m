Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7953BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5348124656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANRJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:09:05 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39251 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgANRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:09:05 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13.lan (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 51844E0011;
        Tue, 14 Jan 2020 17:09:00 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chen Wandun <chenwandun@huawei.com>, kyungmin.park@samsung.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: onenand: samsung: remove variable 'tmp' set but not used
Date:   Tue, 14 Jan 2020 18:08:49 +0100
Message-Id: <20200114170849.2229-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1574424534-141265-1-git-send-email-chenwandun@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: dce02513d9922dd41c49a4bf1b9fd21c22fee76c
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-22 at 12:08:54 UTC, Chen Wandun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/mtd/nand/onenand/samsung_mtd.c: In function s3c_onenand_check_lock_status:
> drivers/mtd/nand/onenand/samsung_mtd.c:731:6: warning: variable tmp set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
