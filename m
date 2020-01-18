Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08846C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55C2468B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1lNqSZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgARTzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:55:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35018 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgARTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 14:55:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so10893444wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxN8NgQyJPLhiFmmBvyQRdEWEtV2Q5inuy5tn3SfqVM=;
        b=U1lNqSZYAuKktYU80diBlGP7MleOGvm300d0W4cVYR+MgqwkvQdlV2uETKL0WItUkb
         LaI5ROeO4AUJ+wm/mLnFODmUZjKxlcw1Z+Wx062wt9W8KRC+qBpNBI2dA95LsGyGwxje
         b4b0n2vY22dak0KJChhwg04lfAlKd6lzYL//iYqsy0PWdXvArh6BQW7q81ouUaQj6zBO
         YtNbuBpRO5le14ReFWuqNPodMVuMZ8c6T2pB1FPbRE358lvdsppkQrCvyOHx2LKxczOc
         SIBIhLDZ2FMhm9Nft73iQ8UHOdjoXsZxrvPbaNrPZ8zKysZyI+i6AlpQgywAzl0LAB/E
         +kWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxN8NgQyJPLhiFmmBvyQRdEWEtV2Q5inuy5tn3SfqVM=;
        b=N4qPQc2gehvkDuxOUS6DRm7eJA8GYQHbhFE7dXknXtYzaeD6EOkM1Qw95geEQzyP0D
         Klj9Om93YAggJeDHWw2TmFdZXT+94PMhZrOsascw+pUrmwvct12ma7TVBPgQyhN9ckeK
         pOqU27J6c6AigLYn5+OdG4YhRxgfX+w7QFNhuBv9OjYj768X11QRv/MWj6L/tEv7wrDt
         PDNzfx6qEw6rMS761U48CVoR++iURzlNiNvO9zPfaTBLOejX8aiCVpuO/AUerU0aoOpk
         iqwuSxzHYvXCcodT2Dm+Rucul2S0Fd+gyUt6KX5CLpGybp3RbTF9n7lQp6fCC5s97szd
         M+Bg==
X-Gm-Message-State: APjAAAVoe+hFl+ktKhL2fVNyw7zWaZKuF3rV2Thj62aUwcUACXfTxd3c
        5ptfziA/dVD5mFVZWn63yhGaBi+e
X-Google-Smtp-Source: APXvYqxWZhFkri3wgMk+sETjBnzCD2pFHkdpv8YCz1RGqBaIs1RuAQIPM/zKnFner/3RPlyj6Tsn0Q==
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr11212572wmd.102.1579377312738;
        Sat, 18 Jan 2020 11:55:12 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-143-199.002.204.pools.vodafone-ip.de. [2.204.143.199])
        by smtp.gmail.com with ESMTPSA id z3sm39877523wrs.94.2020.01.18.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 11:55:12 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192u: simplify rtl819x_evm_dbtopercentage()
Date:   Sat, 18 Jan 2020 20:53:04 +0100
Message-Id: <20200118195305.16685-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118195305.16685-1-straube.linux@gmail.com>
References: <20200118195305.16685-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clamp() to simplify function rtl819x_evm_dbtopercentage() and
reduce object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 00fdcbf64b0b..a40ce0d7a467 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3954,18 +3954,11 @@ static u8 rtl819x_query_rxpwrpercentage(s8 antpower)
 
 static u8 rtl819x_evm_dbtopercentage(s8 value)
 {
-	s8 ret_val;
+	s8 ret_val = clamp(-value, 0, 33) * 3;
 
-	ret_val = value;
-
-	if (ret_val >= 0)
-		ret_val = 0;
-	if (ret_val <= -33)
-		ret_val = -33;
-	ret_val = 0 - ret_val;
-	ret_val *= 3;
 	if (ret_val == 99)
 		ret_val = 100;
+
 	return ret_val;
 }
 
-- 
2.24.1

