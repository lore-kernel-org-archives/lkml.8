Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D39206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584117253;
	bh=xYnFlH4nZnuXIqF3xDVzseie3Dj5DOU8L0rrx6clFSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=kNayS/Ok40u2TeVYvTCaQyEuV/MtOIGg2jvXM7tfcIvwvUW825W1J879t/MyPMHEA
	 HNqcKoR8kb0Abe4y2wdaXwCWa1M3A97Kh639FMVRPU6xOH680yUdw6PZIe+F/4W0Nb
	 aqhcbUQvdoCoMeJ43bnnfVPsIL/SrbywMTD5ukCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCMQeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:34:12 -0400
Received: from foss.arm.com ([217.140.110.172]:60874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCMQeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7B231B;
        Fri, 13 Mar 2020 09:34:11 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F22D53F6CF;
        Fri, 13 Mar 2020 09:34:10 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:34:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        rafael@kernel.org
Subject: Applied "regmap: debugfs: check count when read regmap file" to the regmap tree
In-Reply-To:  <1584064687-12964-1-git-send-email-peng.fan@nxp.com>
Message-Id:  <applied-1584064687-12964-1-git-send-email-peng.fan@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: debugfs: check count when read regmap file

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 74edd08a4fbf51d65fd8f4c7d8289cd0f392bd91 Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 13 Mar 2020 09:58:07 +0800
Subject: [PATCH] regmap: debugfs: check count when read regmap file

When executing the following command, we met kernel dump.
dmesg -c > /dev/null; cd /sys;
for i in `ls /sys/kernel/debug/regmap/* -d`; do
	echo "Checking regmap in $i";
	cat $i/registers;
done && grep -ri "0x02d0" *;

It is because the count value is too big, and kmalloc fails. So add an
upper bound check to allow max size `PAGE_SIZE << (MAX_ORDER - 1)`.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1584064687-12964-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e72843fe41df..089e5dc7144a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -227,6 +227,9 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -371,6 +374,9 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.20.1

