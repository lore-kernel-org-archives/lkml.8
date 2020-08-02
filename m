Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A17C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07AE206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpjA2ki3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHBQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:18:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35158 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727033AbgHBQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596385093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=DC5t+PmpRFhs8Bz6/gHStakurAIrA6SZBjJ4584VI1M=;
        b=XpjA2ki34xM75zaB4U7iXkHh+pusQh9P1cxUsjRSICmKmpOXvuoyGEzYKlCrfeD7zzJTlr
        R7wsfwYwvpsO2n1MalNBEgV0eyxHBTsz4VYRYDIX98HGvLigUXAQOEXU36rzOF2lBQam8F
        0YIteQdsspDbBseW5E6ujIxAB06QFkc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-KdjbUlAJOa6n7-vsvnG7pw-1; Sun, 02 Aug 2020 12:18:11 -0400
X-MC-Unique: KdjbUlAJOa6n7-vsvnG7pw-1
Received: by mail-qt1-f200.google.com with SMTP id b1so17719088qto.17
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 09:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DC5t+PmpRFhs8Bz6/gHStakurAIrA6SZBjJ4584VI1M=;
        b=kYYVQovE761fAUGPvKR+2Jnz7D4t2S3pPkKnpY5U/f08lEDOQO29NIokvaldlc1H7e
         4vttSS/P3zINIGWPPeFUqXp7KS9e1EWozGTRFe80jcZYCE4A5lSy1XgqynD9IDi9xcCe
         P3JsNBkQl2cAcJ7BwDlhLmHAaOknzLrVWywsSvCtvr83qZPVsTGai+QzjJp5i9kVk4cD
         hmZIKA6M2qaSU5JnGv9ad5B/zV46D971szoHVXgGwHYHZqjcmFyBpvew0tkrDKhwxHsQ
         1XPVE28IsWZfC9uQQeKe2t9tRb22tK54Cy/8sWWa+GIkdr0SrPv1Mf7iy/gNbadi18Yr
         R2tA==
X-Gm-Message-State: AOAM530W01V2iVrwXG9cozgTanmB+ZUIMuTkJ2vztEJanxC5rf6WjQsG
        Vy4P7dCFVE+ZOjymyQd9yJ9ZdB9aC/GbR8cI5N6TedxfJSsTWXRHJig9CYEQ5E15ZKghQi22OHP
        4zJEp9Z+VLF0G/dD+Bn+fmEL2
X-Received: by 2002:a37:7245:: with SMTP id n66mr1708743qkc.83.1596385090917;
        Sun, 02 Aug 2020 09:18:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyJG+khVAE61twpw/2VDMswy7YJJ9z/qUZwBj75oPhJFWqmgB2x/V/ktTRJ09btbojwttjIg==
X-Received: by 2002:a37:7245:: with SMTP id n66mr1708726qkc.83.1596385090658;
        Sun, 02 Aug 2020 09:18:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x3sm16790666qkx.3.2020.08.02.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 09:18:10 -0700 (PDT)
From:   trix@redhat.com
To:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, rafal@milecki.pl, tklauser@distanz.ch
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] brcmfmac: check ndev pointer
Date:   Sun,  2 Aug 2020 09:18:04 -0700
Message-Id: <20200802161804.6126-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

brcmfmac/core.c:490:4: warning: Dereference of null pointer
        (*ifp)->ndev->stats.rx_errors++;
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this block of code

	if (ret || !(*ifp) || !(*ifp)->ndev) {
		if (ret != -ENODATA && *ifp)
			(*ifp)->ndev->stats.rx_errors++;
		brcmu_pkt_buf_free_skb(skb);
		return -ENODATA;
	}

(*ifp)->ndev being NULL is caught as an error
But then it is used to report the error.

So add a check before using it.

Fixes: 91b632803ee4 ("brcmfmac: Use net_device_stats from struct net_device")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index f89010a81ffb..aa9ced3c86fb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -486,7 +486,7 @@ static int brcmf_rx_hdrpull(struct brcmf_pub *drvr, struct sk_buff *skb,
 	ret = brcmf_proto_hdrpull(drvr, true, skb, ifp);
 
 	if (ret || !(*ifp) || !(*ifp)->ndev) {
-		if (ret != -ENODATA && *ifp)
+		if (ret != -ENODATA && *ifp && (*ifp)->ndev)
 			(*ifp)->ndev->stats.rx_errors++;
 		brcmu_pkt_buf_free_skb(skb);
 		return -ENODATA;
-- 
2.18.1

