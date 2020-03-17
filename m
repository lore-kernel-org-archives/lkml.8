Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A58C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA72073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584483989;
	bh=+JTzPXcPkCyKYx1B4NwENKXSxFboyMHPPJwk0dqBWAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QFsviytI/3S15oIJ4sgGa8D9T1dmMm2K7NrgPjOiImudknlENh/7MVX4IZ2+fDAmu
	 dlNGXetyDSNmoBxt+jqwOTQCAWVgEWTjOWk8EXlD0Rl5OoCK3zmu0DdqCF38VbHq1j
	 wv/t1y6BPVNsH8xtlj98RVumraQeITgF7YPzTHv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCQW02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgCQW02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:26:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C41206EC;
        Tue, 17 Mar 2020 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483987;
        bh=+JTzPXcPkCyKYx1B4NwENKXSxFboyMHPPJwk0dqBWAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKOtdBSRfspBsti0dNCifFouGHgJZrHbGryZbBD2IZWHNxSs6q73WIZBN92aYusx7
         GY9H4Dk4MNZUI2M6wlAUftjFM9Blhr4It8B2S+crfp2VTURfSSrDHskyeU+DVyLYFa
         zVFCSSNpNEXLCvJ4GgS8enHTvpq9JqyoT8bnCnT0=
Received: by pali.im (Postfix)
        id BA5CD700; Tue, 17 Mar 2020 23:26:25 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points above U+FFFF
Date:   Tue, 17 Mar 2020 23:25:52 +0100
Message-Id: <20200317222555.29974-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317222555.29974-1-pali@kernel.org>
References: <20200317222555.29974-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function partial_name_hash() takes long type value into which can be stored
one Unicode code point. Therefore conversion from UTF-32 to UTF-16 is not
needed.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/exfat/namei.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index a8681d91f569..e0ec4ff366f5 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -147,16 +147,10 @@ static int exfat_utf8_d_hash(const struct dentry *dentry, struct qstr *qstr)
 			return charlen;
 
 		/*
-		 * Convert to UTF-16: code points above U+FFFF are encoded as
-		 * surrogate pairs.
 		 * exfat_toupper() works only for code points up to the U+FFFF.
 		 */
-		if (u > 0xFFFF) {
-			hash = partial_name_hash(exfat_high_surrogate(u), hash);
-			hash = partial_name_hash(exfat_low_surrogate(u), hash);
-		} else {
-			hash = partial_name_hash(exfat_toupper(sb, u), hash);
-		}
+		hash = partial_name_hash(u <= 0xFFFF ? exfat_toupper(sb, u) : u,
+					 hash);
 	}
 
 	qstr->hash = end_name_hash(hash);
-- 
2.20.1

