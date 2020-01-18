Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D154C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C6824690
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B519eFUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgARU4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:56:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35540 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgARU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:56:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so25824684wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=76oGiDrq8kVI9ofJf4Cj0FF8xLQAXivYPqr31KwJvbA=;
        b=B519eFUoq9aYU2Hroc3ku2dSbFfpLhYrLX3/lPqZr8RJ1/mfhkb2sxrtrVX0Qp+3sv
         2ZMeARit+ZIGpFwcTp/galJOipbpqXxxYYX4EkVEmDW8JpNY0iCIYwZEg8/vO2rMPgBn
         Ka4VbX4Fa8cw07BUx4Lgv7dGn4GTiZsbWqQVb0kafRWC6LkaLzRoWXtD70hADSLNp5P3
         QDjDkLFysmbZshIu6c1Xw/HmipoF39d0sv8QHyt3kBfMpgcOhnqb5muoFdpyCNMVeuun
         jFWawypvpJTdhwNPYtFwIdB3quug/IZFP8MilSbk318frQdrMyS67lLZmstfatgIHZup
         Lo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=76oGiDrq8kVI9ofJf4Cj0FF8xLQAXivYPqr31KwJvbA=;
        b=rXQiYdfu73zbqWLiqSX6PArqrbe0Ogdqo/lDpjak7SiU3lh26x5eC2FVMsqAFVS4mx
         Y7XiioBDtfSrPwfW8E4D/780UAaUrQ/sRmPUSvEvJZasBaahZQ2vBRq3qa4AB/Zmg+re
         ruVZAwZu3bKKOIH4DUSKwCW7akcowhRk03MJXgNcpFnrknR0NZHBY85+oZD1aijcy+AN
         AYlOwfYahOE31Fb9eMYaLjk5PzGNnpQlR6c2vuQetMLbMF0gGyQlR8wT15rXfGRdDGnX
         nQf73cXy7fx3Xa/mE1IDNhndqstZZAu6EqjdgnJ5Qia3tYvegt5LhOaVpTZsgHVZXc0x
         Hxnw==
X-Gm-Message-State: APjAAAW+U2TnkJsppsJkmdVtAy8vPyDSiDJ6xqp5JNBN0jbx5iOV2pDB
        oib0hCWqyGUaUlqyQ8IV9M3HrJdeaUyrKw==
X-Google-Smtp-Source: APXvYqy4rwLBc1QYJrE8daRAziDK3Ob8LGEQ6GlbZ9BEa4nGLNmRd4LhueGNitrdzfVKpLUBixuc+g==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr10264690wrs.143.1579380998222;
        Sat, 18 Jan 2020 12:56:38 -0800 (PST)
Received: from Lappy.lan (cpc157701-rdng30-2-0-cust857.15-3.cable.virginm.net. [86.18.131.90])
        by smtp.gmail.com with ESMTPSA id t125sm16244042wmf.17.2020.01.18.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:56:37 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     afaerber@suse.de, Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/2] regmap: stop splitting writes to non incrementing registers
Date:   Sat, 18 Jan 2020 20:56:25 +0000
Message-Id: <20200118205625.14532-2-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118205625.14532-1-ben.whitten@gmail.com>
References: <20200118205625.14532-1-ben.whitten@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing to non incrementing registers we should not split
the writes in any way, writing in one transaction.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/base/regmap/regmap.c | 38 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 59f911e57719..d0dbf0ffd70f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1528,24 +1528,30 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		int win_offset = (reg - range->range_min) % range->window_len;
 		int win_residue = range->window_len - win_offset;
 
-		/* If the write goes beyond the end of the window split it */
-		while (val_num > win_residue) {
-			dev_dbg(map->dev, "Writing window %d/%zu\n",
-				win_residue, val_len / map->format.val_bytes);
-			ret = _regmap_raw_write_impl(map, reg, val,
-						     win_residue *
-						     map->format.val_bytes);
-			if (ret != 0)
-				return ret;
+		if (!regmap_writeable_noinc(map, reg)) {
+			/* If the write goes beyond the end of the window
+			 * split it */
+			while (val_num > win_residue) {
+				dev_dbg(map->dev, "Writing window %d/%zu\n",
+					win_residue,
+					val_len / map->format.val_bytes);
+				ret = _regmap_raw_write_impl(map, reg, val,
+							     win_residue *
+							     map->format.val_bytes);
+				if (ret != 0)
+					return ret;
 
-			reg += win_residue;
-			val_num -= win_residue;
-			val += win_residue * map->format.val_bytes;
-			val_len -= win_residue * map->format.val_bytes;
+				reg += win_residue;
+				val_num -= win_residue;
+				val += win_residue * map->format.val_bytes;
+				val_len -= win_residue * map->format.val_bytes;
 
-			win_offset = (reg - range->range_min) %
-				range->window_len;
-			win_residue = range->window_len - win_offset;
+				win_offset = (reg - range->range_min) %
+					range->window_len;
+				win_residue = range->window_len - win_offset;
+			}
+		} else {
+			val_num = 1;
 		}
 
 		ret = _regmap_select_page(map, &reg, range, val_num);
-- 
2.17.1

