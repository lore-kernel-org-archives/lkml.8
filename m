Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B2AC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADB82051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7xU/aen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCQVNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:13:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33066 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:13:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so24645272ljp.0;
        Tue, 17 Mar 2020 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LARHXuaKUkUDUGOK/jHk/g5Im0xzFquLTlHFxXm0daM=;
        b=t7xU/aenX4xqSWnjdQPZN30yZ/IjtmHuiFKftszZqzwhQWL8TRlOqqDYY2SwOL5+I/
         qQQPKX0PFV/6+99DGDQ6pfyVXCNEvOPtcZ6yIMdxkn3rMT1VonrudSTSx0X8Ckv28ry5
         Fx4Uv/CcSo6k0iskVK3ZsZn33unZQzzGpHKtlOExLnDT3euQjXcSevzg9HxgqysxlxvR
         G17Ikijijdpn/COzDMczpwkds4lCXoH4gXCjOlSwOLEjROcZWM9tshGGpsh0qPbvos/a
         v2i0ZjqJaFpemIEzgTnnWIgKAucfWHQhccIuf8YRJBDNj4kJXvXT1sIkRPDr/hoFkney
         LoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LARHXuaKUkUDUGOK/jHk/g5Im0xzFquLTlHFxXm0daM=;
        b=QB5SG+vPrn3O+lIK3nAgkuOkQGZNPGllOVuYdGll3GJ7qOm8eJwG3SxQPyiA9A3+KF
         d43R0ETNtZ6r+q/PKUsgN5VScK21vtU70+e8a2WK+WBJgdFAtymNY77puYuQkQB7nge9
         If5T3ufcvVezEWgVSMA5+1PsQojLV/y98keOFl+pGIGNGpEYlr4WqzJPjl+cU+WDFSgT
         7c6dFL8o5t6M4ZhYrwsttLXxUVUP4BBz2kBrmXPlCoqNyUhTJCXOIc0uiOhCvvZchcbS
         rgrdxrr1S2hbYGI1PsFgtzBbto4rDxmI9Mbys6Gfv1X7YbmrRS3fXyCxIv7/WURnZ+Vr
         y3VQ==
X-Gm-Message-State: ANhLgQ2KCnkCsWmcbm6CXEKWggRt54v3XpUOxqseg631F7R8zIJx0esn
        /Cntyb2ECtvjscujXFdt8rjF9OD5MQU=
X-Google-Smtp-Source: ADFU+vuyM49tC3h/AoMvCI49PxDJ6dQ5ze4WGJnrp9JpPJcDjaJwpK77nRLAOABktoWj2YSKBvJ4dA==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr435422ljg.104.1584479625500;
        Tue, 17 Mar 2020 14:13:45 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-78.NA.cust.bahnhof.se. [158.174.186.78])
        by smtp.gmail.com with ESMTPSA id 23sm3341652lfa.28.2020.03.17.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 14:13:44 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RESEND] clk: sunxi: Fix incorrect usage of round_down()
Date:   Tue, 17 Mar 2020 22:13:32 +0100
Message-Id: <20200317211333.2597793-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

round_down() can only round to powers of 2. If round_down() is asked
to round to something that is not a power of 2, incorrect results are
produced. The incorrect results can be both too large and too small.

Instead, use rounddown() which can round to any number.

Fixes: 6a721db180a2 ("clk: sunxi: Add A31 clocks support")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Resend to include lists, appologies for missing that.

Patch has only been compile tested, I don't have the hardware.

 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 27201fd26e44..e1aa1fbac48a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -90,7 +90,7 @@ static void sun6i_a31_get_pll1_factors(struct factors_request *req)
 	 * Round down the frequency to the closest multiple of either
 	 * 6 or 16
 	 */
-	u32 round_freq_6 = round_down(freq_mhz, 6);
+	u32 round_freq_6 = rounddown(freq_mhz, 6);
 	u32 round_freq_16 = round_down(freq_mhz, 16);
 
 	if (round_freq_6 > round_freq_16)
-- 
2.25.1

