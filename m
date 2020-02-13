Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67785C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D5420675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608634;
	bh=MRdGMjutinYGYiS4uueb/cSnR9n8EX3kqsC1u8p/7kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3M0WFQCzi36tV43XlR2Cf9Wh89smrYwRA7TFPLgT+kYS0IvNILTROiTf3aGWcfaD
	 joK9kXTq5WK/kqt1ykwBm8ohjIxOzJJ1VXF2hFyI9jJuoHvr5A3AIkMXOO78NpJiYs
	 kkhMsI/r7jhvgqzMzz4+MW5BFYcpG9B0g2Gx4zE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgBMPnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387706AbgBMP1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:48 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A2A20661;
        Thu, 13 Feb 2020 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607667;
        bh=MRdGMjutinYGYiS4uueb/cSnR9n8EX3kqsC1u8p/7kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQQ0LdSPn+6DjfaKxEHplbBccfLzGFSvFuQi/+Wqmq1k+6khh2slPO3NiY0al2VsW
         b+czQSkOidNq10P3TiEiwVeZkO3YqRDCHxuZSZyuqFeTuSDm8ssOiS9gzfTAkcVdN1
         WqmijvOfGcfvtoCgp0l1OwOSx0r3j+r0YhqQsUX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 89/96] regmap: fix writes to non incrementing registers
Date:   Thu, 13 Feb 2020 07:21:36 -0800
Message-Id: <20200213151912.406961661@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

commit 2e31aab08bad0d4ee3d3d890a7b74cb6293e0a41 upstream.

When checking if a register block is writable we must ensure that the
block does not start with or contain a non incrementing register.

Fixes: 8b9f9d4dc511 ("regmap: verify if register is writeable before writing operations")
Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
Link: https://lore.kernel.org/r/20200118205625.14532-1-ben.whitten@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/regmap/regmap.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1488,11 +1488,18 @@ static int _regmap_raw_write_impl(struct
 
 	WARN_ON(!map->bus);
 
-	/* Check for unwritable registers before we start */
-	for (i = 0; i < val_len / map->format.val_bytes; i++)
-		if (!regmap_writeable(map,
-				     reg + regmap_get_offset(map, i)))
-			return -EINVAL;
+	/* Check for unwritable or noinc registers in range
+	 * before we start
+	 */
+	if (!regmap_writeable_noinc(map, reg)) {
+		for (i = 0; i < val_len / map->format.val_bytes; i++) {
+			unsigned int element =
+				reg + regmap_get_offset(map, i);
+			if (!regmap_writeable(map, element) ||
+				regmap_writeable_noinc(map, element))
+				return -EINVAL;
+		}
+	}
 
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;


