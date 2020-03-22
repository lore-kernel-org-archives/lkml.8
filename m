Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF4C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771372072D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFBT/z8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCVU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:58:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37094 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:58:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id h72so4222422pfe.4;
        Sun, 22 Mar 2020 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMLZ0a9yOMPWblnaLAzqlRWLtf88wPfDqhG37gOQNuk=;
        b=WFBT/z8CFtQm6phPQKTIUyucFaGdgTlt1q6FYa2RgS53JvXz3p8S+h1i3stjYASVn+
         IaMp0ZiEGCAd/XY8zXCGaENsX5ZyCV4WZQCz4K8qVKVbBgDHKH2+GXULD6qVYgktwk1e
         /+If0+yG1z25xHA+4XFIF2ee5sIX8Oz1G2OmY8xgb+90tuQn/PnMAMNdMewXnQ8Xn8z0
         MQ/mLP5yWjV2D4py9QTxuPLxAbElOpQFT97xH9tH+9v3/XTNvZs7zhuBYJLa8d4hvsNl
         3wtkDaPynNmxQ9cz1LaMO7+3A/FzpeDJf+CBRsNMcTQjECIqVL2QOfSnmo+oqhy8d++o
         qVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMLZ0a9yOMPWblnaLAzqlRWLtf88wPfDqhG37gOQNuk=;
        b=e+O5ix/KtfgzLPq9attDSiuoOQoqy22xY8b38qqWGU6YV0s46LNwJ/kp/0dCF+S89Y
         nLc2GqesMkZNaqyLE5eGsZdB3f4UseBpioGnTEmMDUKgTYsrp/1v2bWBcoFmsZA67lAh
         yI1FH2QEL0GCLjd5iejOKW+rYHX3LgRz2atYpIkxrBWWNUjwxi4VpcgIGWbfD2vcOZQ6
         dH4yfwv7iqHeXQllrZSQOjR0WAgHicFaOgxhdHfuuK3m5Jv2UuWNWVtG0oMx+NdUrScZ
         P5+a5MFaOL6vkWP7bigdEKfELFFIFDLQr61VxnopQFkq0+Kw69kvbkevTgQfTzfnuawC
         G1gQ==
X-Gm-Message-State: ANhLgQ3f+B2RiJiwUmMwwl6mGqzDTLFiPvMz3xWNAahnOOKA+RMc0AXh
        ou19RTVrhlUcWKPvffgAvubkhyes
X-Google-Smtp-Source: ADFU+vubUoT94x3ckJ7qc7+kP0RGJgWfhd+AumkXJVpebYPtdxAW+Bexws6df+e+JF8xmM39zWZo9Q==
X-Received: by 2002:a63:30c4:: with SMTP id w187mr19493066pgw.239.1584910733300;
        Sun, 22 Mar 2020 13:58:53 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id f127sm11105342pfa.112.2020.03.22.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 13:58:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     mbizon@freebox.fr, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: Fix duplicate frames flooded by learning
Date:   Sun, 22 Mar 2020 13:58:50 -0700
Message-Id: <20200322205850.3528-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both the switch and the bridge are learning about new addresses,
switch ports attached to the bridge would see duplicate ARP frames
because both entities would attempt to send them.

Fixes: 5037d532b83d ("net: dsa: add Broadcom tag RX/TX handler")
Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/tag_brcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 9c3114179690..9169b63a89e3 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -140,6 +140,8 @@ static struct sk_buff *brcm_tag_rcv_ll(struct sk_buff *skb,
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, BRCM_TAG_LEN);
 
+	skb->offload_fwd_mark = 1;
+
 	return skb;
 }
 #endif
-- 
2.19.1

