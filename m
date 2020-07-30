Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891EBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4EF20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096435;
	bh=R9hzIx86H0YmVD4nczJYlxjSGqSLi+ZiBU8ciPc5xLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GkNfMvVe232m9nLOR39+B0KZlvEOMQ6LD6mdvfZY6X5GwmA8V5FDnMRqVSCxubrWu
	 b+f5LHrhBJRWPC7/QzSk/z46gjPnPxibD6QPa+K8c3UrTX4/heOzQPiaZqrwTsFqWJ
	 Lu+8CgjhTJa5jEnj1NsxbmUlm5tWvKOcXg5dDPJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgG3IHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgG3IHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:07:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1EB82070B;
        Thu, 30 Jul 2020 08:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096430;
        bh=R9hzIx86H0YmVD4nczJYlxjSGqSLi+ZiBU8ciPc5xLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vm8l36rODUrlSOT031NOYCZxDPjJtgT0Zeelcddd+z0Wv2P5tmYtkI7TA8HUaGeaB
         2VEnlVz4ola8xQktqB5DRJtbRtDJYvBBBFuXC3XMXiEiwTKC0sQT1DcYFsmtP3yzsS
         7Z8IZkyHUSg2J+81OiffeyYUQkr7UzFOVTE/Gkk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 17/17] regmap: debugfs: check count when read regmap file
Date:   Thu, 30 Jul 2020 10:04:43 +0200
Message-Id: <20200730074421.305841643@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.449233408@linuxfoundation.org>
References: <20200730074420.449233408@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 74edd08a4fbf51d65fd8f4c7d8289cd0f392bd91 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/regmap/regmap-debugfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -209,6 +209,9 @@ static ssize_t regmap_read_debugfs(struc
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -357,6 +360,9 @@ static ssize_t regmap_reg_ranges_read_fi
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;


