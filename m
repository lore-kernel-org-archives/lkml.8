Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E5CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C37F206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVDDhxKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgFOPvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:51:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C42C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:51:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so12926205qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UZX8kJypcdRudMNk/yqbaAULEa0GgrvTWFiLapF3ppA=;
        b=DVDDhxKs97v0ViamvyVPQYvxNI6G3AiiEkqEkaNtVLehAmYCt2hw+tc3mMBY+Obc3I
         LWGBmnOCFM9eB8TtD5JBgur/ruQUBqK8oTs5uLVkFv4sgtROn0+nGkINdeeq3+ShM0aL
         vb1r8h+eWwicGifbUzslOtBmPi5T3jLgRYZBsBwKsTN1thCfrgMcNYjFFKCjfV2Rff9L
         zxzKdJVprjOs7YvPqflFUzRFsZmSrDixXUHXNzL/oY1dmw7Sh+xxbWM+zDOVwGlcSJ5b
         up6heqv130fjS6GpULbXaiAc1Qogjgc22coehZQjo8zOHrVYb/f9YApyV9JlXvOPaKk5
         GgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UZX8kJypcdRudMNk/yqbaAULEa0GgrvTWFiLapF3ppA=;
        b=U5+RkaWL74lX25A64ROA5Bg9x6j8pBLU5gm5AhAohL8S+5WpLWodUNLvXDm8aY/Nmr
         dw9pLA9M9N6w9Hh490uSEjnTqS/ZC4oTqUeVhP27M/enXu1k7VqWR+qZQn/4FNN9DE+a
         glPistGffZZY6iHF5owedwYrstBALbMTe6OqsfASJjP2E6Fnlkiz1b0Qg47TJqiFBw/y
         R1VsscajBEu1Ca4eHGkhbTG7x7VaYicyQTsfpWqg2ySrc+aXywe+iTBjo0bBZrvJY5KX
         k0m80gGqbBQvU6Tkjta+qFpb7+hK3a5QNZNOrS/1G1obocbku56tWIvNHHtRkmap2MTq
         FHDw==
X-Gm-Message-State: AOAM532P4sQkvLZIcIrFgTi8YfICucyP1sVRyXFCRjZCAVekA5HK21If
        c0Aj1s+pjoJ3doqktOBScd4=
X-Google-Smtp-Source: ABdhPJxeANHNcEmoNUON065BVtaY13iweUtSN3b5/pyVk0um5hUk+YbDa/1H7SefqtxjGZYmmC6NRg==
X-Received: by 2002:ac8:6f1a:: with SMTP id g26mr16013226qtv.121.1592236294418;
        Mon, 15 Jun 2020 08:51:34 -0700 (PDT)
Received: from sevic69 ([186.151.118.242])
        by smtp.gmail.com with ESMTPSA id x186sm10173492qkd.125.2020.06.15.08.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:51:33 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:51:31 -0600
From:   Sebastian Arriola <sebdeveloper6952@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Subject: [PATCH] staging: rtl8712: Remove unnecesary else after return
 statement.
Message-ID: <20200615155131.GA4563@sevic69>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: else is not generally useful after a break or return
490: FILE: drivers/staging/rtl8712/rtl8712_recv.c:490:
			return false;
		else

Signed-off-by: Sebastian Arriola <sebdeveloper6952@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 116773943a2e..4cd391a7193a 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -487,8 +487,7 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
 			plist = plist->next;
 		else if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
 			return false;
-		else
-			break;
+		break;
 	}
 	list_del_init(&(prframe->u.hdr.list));
 	list_add_tail(&(prframe->u.hdr.list), plist);
-- 
2.25.1

