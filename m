Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC1FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D67F2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXiqV1ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCIPXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:23:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53928 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCIPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:23:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id g134so10405594wme.3;
        Mon, 09 Mar 2020 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ve80bvQpmKNJ+h2omwraZB9P4ugFSfvavWFO8c8fRu0=;
        b=ZXiqV1ek4RHVvW3AO8Lpds8Ra66k1BSfGZ0EmZXquaYdOIQXVmQVpIz+nJillyOJ1b
         ODlUWeUeCXhS4S1JOb2ttzFCkV9XKXdjLBUcmBdO94O5wwvFwvEWeaSvYS2+piaoIjPS
         /GJZLchXEc51KPnlwE8M5NGkJiQSO/K1lORWiDTD+tvkfoKMsFXMKHOLZfBaJ0v/1+HY
         iZcLztOAdk3o2P6b0PpAYSGJ+i0pOwdGELa+5+TcgigHpqz4Tizat3C2oouhO+lWdgmR
         NJ4p+MZ+q+yJtYaaF9ZfLla+vPffzFri/f2jo+5584uXaMbeZJZlER/eA2MzGU3wBQgF
         eA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ve80bvQpmKNJ+h2omwraZB9P4ugFSfvavWFO8c8fRu0=;
        b=kGp48o3yTJiy4/D43eEUJh3q435zKe4XdciebRDSlym/TfYD5oyx30qV7da+0OPGig
         GQv9h5a8exB8cEqE9FPZwgpflsITbuBN8GvdTh3wg17wPnockpXCyY956dRNonvGS2Wj
         lGDuvBOP3wrE3rPYEHmfoqaART2UeaKuVgyFur5hHT21UnooHzAXA0lym/WCrBRv1xmY
         MArGJ46qg5IKPbKlAhqKQd5U/a2yAymTvFrNjgDYjk1TARoBjFxhtsNvHUq4N4uD6Vl+
         g2QW57vxJf6mR9Mkf9qzbC9NeSOezgUfrPF/xyv7YhRS+QkGF9C3e0GfnjR+uYTZ/N7F
         ODdg==
X-Gm-Message-State: ANhLgQ0jRh6tU8Sn42q0plT52maZeAfIpOxAdCrXr0IkkaxPYjfmldFn
        DgUiAlPyKBSdL3Vt8Zoiv6c=
X-Google-Smtp-Source: ADFU+vuCCpLKjE1CVcv5XtRb6odrFJpcsbO+MU1F2xdoU086rwZGkiduSYGI1UIEfKUGV1VjqfzJqA==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr20500194wmc.65.1583767396281;
        Mon, 09 Mar 2020 08:23:16 -0700 (PDT)
Received: from localhost.localdomain (178.43.54.24.ipv4.supernova.orange.pl. [178.43.54.24])
        by smtp.gmail.com with ESMTPSA id a5sm12052400wrm.40.2020.03.09.08.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 08:23:15 -0700 (PDT)
From:   Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc:     dominik.b.czarnota@gmail.com, Byungho An <bh74.an@samsung.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix off by one in samsung driver strncpy size arg
Date:   Mon,  9 Mar 2020 16:22:50 +0100
Message-Id: <20200309152250.5686-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: disconnect3d <dominik.b.czarnota@gmail.com>

This patch fixes an off-by-one error in strncpy size argument in
drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c. The issue is that in:

        strncmp(opt, "eee_timer:", 6)

the passed string literal: "eee_timer:" has 10 bytes (without the NULL
byte) and the passed size argument is 6. As a result, the logic will
also accept other, malformed strings, e.g. "eee_tiXXX:".

This bug doesn't seem to have any security impact since its present in
module's cmdline parsing code.

Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
---

Notes:
    I can't test this patch, so if someone can, please, do so.
    
    The bug could also be fixed by changing the size argument to
    `sizeof("string literal")-1` or by using kernel's `strstarts` function that
    uses `strlen` under the hood [1]
    
    There are also more cases like this in kernel sources which I
    reported/will report soon.
    
    This bug has been found by running a massive grep-like search using
    Google's BigQuery on GitHub repositories data. I am also going to work
    on a CodeQL/Semmle query to be able to find more sophisticated cases
    like this that can't be found via grepping.
    
    [1] https://elixir.bootlin.com/linux/latest/source/include/linux/string.h#L226

 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index c705743d69f7..2cc8184b7e6b 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2277,7 +2277,7 @@ static int __init sxgbe_cmdline_opt(char *str)
 	if (!str || !*str)
 		return -EINVAL;
 	while ((opt = strsep(&str, ",")) != NULL) {
-		if (!strncmp(opt, "eee_timer:", 6)) {
+		if (!strncmp(opt, "eee_timer:", 10)) {
 			if (kstrtoint(opt + 10, 0, &eee_timer))
 				goto err;
 		}
-- 
2.25.1

