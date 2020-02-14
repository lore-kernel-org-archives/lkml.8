Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE30C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489432467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701288;
	bh=ab0ALA7QeyFFt8xfeX1sv16lhosGZFNhWcq5ie5xykg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFGvpr5is6lP0F0ug5y6VPweD3htfGGTY8EL//VvTx4ueCm8mda7wxdun9Qqy0ZhQ
	 l7DMYeXU1ZG3/ZjHJaFmHpaHfHphfU8Ugp8bWDttsib0yq8/DVipI5L14uS2RN6IBp
	 ONoO5P61g9eI9YwfC+k9CRFXpHT9vRe+ZBynxQTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394593AbgBNR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390186AbgBNQIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201B824676;
        Fri, 14 Feb 2020 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696488;
        bh=ab0ALA7QeyFFt8xfeX1sv16lhosGZFNhWcq5ie5xykg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vdc5B7vL15SLdfDIwzpa0rs/+H+Wc4qKatB7Mk9soq9LrNHHr4h4Fg7Q5IpPoZbge
         hkBNChmgViLxOi4iC2mtUgVozenjcbeH8D3rV9j2O+pd90mm5p4RfuXEtOMVx9/Hn4
         l2df6vaEmc3DLnYDLKzjuy12X0rjLtoV/BjP74JU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 294/459] raid6/test: fix a compilation warning
Date:   Fri, 14 Feb 2020 10:59:04 -0500
Message-Id: <20200214160149.11681-294-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>

[ Upstream commit 5e5ac01c2b8802921fee680518a986011cb59820 ]

The compilation warning is redefination showed as following:

        In file included from tables.c:2:
        ../../../include/linux/export.h:180: warning: "EXPORT_SYMBOL" redefined
         #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")

        In file included from tables.c:1:
        ../../../include/linux/raid/pq.h:61: note: this is the location of the previous definition
         #define EXPORT_SYMBOL(sym)

Fixes: 69a94abb82ee ("export.h, genksyms: do not make genksyms calculate CRC of trimmed symbols")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/raid/pq.h | 2 ++
 lib/raid6/mktables.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 0b6e7ad9cd2a8..e0ddb47f44020 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -58,7 +58,9 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
 #define enable_kernel_altivec()
 #define disable_kernel_altivec()
 
+#undef	EXPORT_SYMBOL
 #define EXPORT_SYMBOL(sym)
+#undef	EXPORT_SYMBOL_GPL
 #define EXPORT_SYMBOL_GPL(sym)
 #define MODULE_LICENSE(licence)
 #define MODULE_DESCRIPTION(desc)
diff --git a/lib/raid6/mktables.c b/lib/raid6/mktables.c
index 9c485df1308fb..f02e10fa62381 100644
--- a/lib/raid6/mktables.c
+++ b/lib/raid6/mktables.c
@@ -56,8 +56,8 @@ int main(int argc, char *argv[])
 	uint8_t v;
 	uint8_t exptbl[256], invtbl[256];
 
-	printf("#include <linux/raid/pq.h>\n");
 	printf("#include <linux/export.h>\n");
+	printf("#include <linux/raid/pq.h>\n");
 
 	/* Compute multiplication table */
 	printf("\nconst u8  __attribute__((aligned(256)))\n"
-- 
2.20.1

