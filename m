Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C22C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 18:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC2C206DA
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 18:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALqaq4PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgHBS4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHBS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:56:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FBC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 11:56:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so22577191ejr.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cnCjYRNqnIWIP18OeomXg3bwbUwwai9RTXGWxuiPisM=;
        b=ALqaq4PTH00unplMpME8tHNS9X8OOg0HZP+6krndLVEy3yDxsNEaOV4vVyY8q8Fti5
         4O4AtnePguod3q2M41EKFibv5iB8M7hHbPbIrBjfsqhQpooXd8EKR1TrrjjzDvw/Xeew
         hEB8IW35mX1RqWqmpi8YOMl9I6uokLGDjt3ruBw8JF8JQC/sMjxUKjBkuffH4rJ7RjB3
         M7ZPw6T04iUnGtW8UP15nFSRpJeWfHczhmgTsAL4E1YvlvTBzhLv3GNJPAe4unZn+Tnt
         C6/OYIzePv46E4dDXmKTHHdwrq/UTfrpvvzda/E+tNHKgot3RlFQESu7Q3qIGU243aNb
         AdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cnCjYRNqnIWIP18OeomXg3bwbUwwai9RTXGWxuiPisM=;
        b=JYYd17d0+DplHDBRgxAWUFvcq/IP/RjH3oZ8En9B1Qmn9yxsZJf1yMFOgUcUwmtk00
         U9HsfbQMWnpxTlcAZgTz5uGGk7QWy3lboQZDqRi7P16OB9Jn/d3NXqtlsbRyKGwYIgWo
         htX6bppimWI2fWVyalxl3X81hrSZhcIERbpFiinut2j1NeK6shkOMrG1Nx5ILomu/yg7
         tBh2GY+LWcBQ+dElsGXoum3VpANzL1NP7LMl/EDXtgHtpPA1QEmH8iwPtpxOOlDFJVLu
         9ZtCMXiMEa5GQ27aRslaWxWcEj71Bs4keq7ZRy6vtYDd+S2X2oH1ukGXp+p/x1eD4bHz
         hBcQ==
X-Gm-Message-State: AOAM533cCIi4B+a+eVKZ0UHqHNPeZkJAzsyCHB/91IepnejU8TDbFlAE
        EKpHU/aktaMx/PBG9IaWGpg=
X-Google-Smtp-Source: ABdhPJwM0nZXjFTUA6Gu1ic4tZKtq34l0GN5uN2AmSKK9x4JC23Z80/h4Ruxh+6rcP7KVA2kwHoKGQ==
X-Received: by 2002:a17:907:408c:: with SMTP id nt20mr13149049ejb.503.1596394608593;
        Sun, 02 Aug 2020 11:56:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1821:5abb:3429:e2f4:15c4:b960])
        by smtp.gmail.com with ESMTPSA id f23sm2264270ejd.30.2020.08.02.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 11:56:48 -0700 (PDT)
From:   Mohammed Rushad <mohammedrushad@gmail.com>
To:     gregkh@linuxfoundation.org, vkor@vkten.in, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, john.oldman@polehill.co.uk,
        yanaijie@huawei.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: fix coding style issue in xmit_linux.c
Date:   Mon,  3 Aug 2020 00:26:44 +0530
Message-Id: <20200802185644.19674-1-mohammedrushad@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to the xmit_linux.c file that fixes brace and missing
line warning found by checkpatch.pl tool

Signed-off-by: Mohammed Rushad <mohammedrushad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index fec8a8caaa46..b199d355e568 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -148,13 +148,13 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 	/* free sta asoc_queue */
 	while (phead != plist) {
 		int stainfo_offset;
+
 		psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
 		plist = get_next(plist);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
-		if (stainfo_offset_valid(stainfo_offset)) {
+		if (stainfo_offset_valid(stainfo_offset))
 			chk_alive_list[chk_alive_num++] = stainfo_offset;
-		}
 	}
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
-- 
2.17.1

