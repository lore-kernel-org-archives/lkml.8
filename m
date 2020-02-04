Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0EDC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E6121582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580857284;
	bh=TscEwCGrJfk8nmOKrVfU8NkJhiw3fKGZsMsnV9nMQ74=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eMqJhGXTdm0nOhEOZ24xycDV2BetexcFZo7Ota2WCSBJYEvgctZm+6V5kHGcHklYW
	 gwo0qc8ZyaooMBLGvm0xgm9xCvFeONFdjWvCxZGvo1jS3YbKMWUCKPXM5Yte/RKxNn
	 iblGQEHY/2TB/5kX2uyLuLNIA9u8fv53pEbCJezY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBDXBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:01:23 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50859 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgBDXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:01:23 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so91961pjb.0;
        Tue, 04 Feb 2020 15:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2ogUhcETgyZrfpUeKlCnyr0e1cCASv1/pIpN8mrzTw=;
        b=ZdprRkijdmA5DFXtvCouv0JBJ1jW1Pa4KkU++Xr90YvgFQS4683KK4uDKZE3cQwk1w
         8o4Ua9ajjtmgutDz7jj1Z/Q0mQS8Lq9XxRi6kAF3CZyS/IYw6yFe1+T6wGYtBesiirar
         OzlOYGsA/I1YNiVROrb89PhjclYogTU8WMxnsnHTLqo6azpZYeybLe54m8goiHAU3Eff
         C7z3XrHeZaFs67s36aiwWN2uiErFx8odrvxG+rBVAxl7eFsvS+z8g1vRvxqMfj1WmvNx
         hl7KUiOeJ7F+fovDm7+KW8xGoHHlpX4jDazLXRqX8SUdxWHQnLFrfT8bN/Jx2uQyYzS+
         KlNg==
X-Gm-Message-State: APjAAAWv1152xyRihHHjcVCrTQxLmHTLaPBP6OhOXCixz3XSsjD5Jm9s
        9XQ/ereWn0BGq7YAGNcgHT8lG/7G378=
X-Google-Smtp-Source: APXvYqz15TdBALzoPut4mWMZyx+cVQGcVHC9dYLt1u+GbpYVc3BPFP7q8E4863hbWSpAz5wmROszLg==
X-Received: by 2002:a17:902:9a8c:: with SMTP id w12mr31653717plp.149.1580857282051;
        Tue, 04 Feb 2020 15:01:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id b188sm24295650pfb.56.2020.02.04.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 15:01:21 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        mst@redhat.com, hkallweit1@gmail.com, davem@davemloft.net,
        morats@google.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] net: ethernet: dec: tulip: Fix length mask in receive length calculation
Date:   Tue,  4 Feb 2020 15:01:18 -0800
Message-Id: <20200204230118.7877-1-mdf@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The receive frame length calculation uses a wrong mask to calculate the
length of the received frames.

Per spec table 4-1 the length is contained in the FL (Frame Length)
field in bits 30:16.

This didn't show up as an issue so far since frames were limited to
1500 bytes which falls within the 11 bit window.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/dec/tulip/de2104x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index d305d1b24b0a..42b798a3fad4 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -417,7 +417,10 @@ static void de_rx (struct de_private *de)
 		if (status & DescOwn)
 			break;
 
-		len = ((status >> 16) & 0x7ff) - 4;
+		/* the length is actually a 15 bit value here according
+		 * to Table 4-1 in the DE2104x spec so mask is 0x7fff
+		 */
+		len = ((status >> 16) & 0x7fff) - 4;
 		mapping = de->rx_skb[rx_tail].mapping;
 
 		if (unlikely(drop)) {
-- 
2.25.0

