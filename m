Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41101C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2041F20707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/u7sKIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgEaLBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 07:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEaLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:01:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24179C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 04:01:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z13so4559601ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZeH+3Xs1eLtvVZLC2Ghqmx2t9Qj5bzcPEiLkSrbQKo=;
        b=V/u7sKIVbzwoHQ9wVIOeSooJyWzb2QQiXYzSXNcQSYKkQGygOrAZ4WD8l4SMuhA0T4
         iwgXniwTuKtDnd7H/mys4Oc2Es3xUMpCC5L5yIZUz9diJzpsx+DjBpNQ/hScwgLaJNBD
         +vR8fOTzeRAOyM7BNUz9LKKeXiGnYLWxmBBwHIjuY3pSYh7C6r8EwdBcf4nngl19VVmz
         IoXxH7YaLF3t/DfJksXz2H6oHRujIn5wcM6Rpnx7Uf6vmbXzAptpfI7d1oM16lq9HwQz
         mhOfSibt2JaZeaz6DEyCLiWD3bS3WDdgbUzuaB9krSODilv42Nc+ghMFbsi3JbkjHflp
         +2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZeH+3Xs1eLtvVZLC2Ghqmx2t9Qj5bzcPEiLkSrbQKo=;
        b=opVB1LpGh7B15BrikARZ1mI28bOBJhqHyUjy9m1m1DS1hCVK6I65Qv/L2Ip8P7lrbc
         TX36Cj9HBah9Ry2T0cX4+dlLcnZuCtmP4D7JJx+7sn9xMawjbRL2hjensoggaGUA6CUj
         ZNT65bVPiRSXi03LZPdtxB5+ZTt8xse5zTmPmEAJT9sZDmXvV9ytSmS1jLY8Of3LFLcA
         TtlFH4haPKKqwXkFShrXzfDYsOZKq32U2gvmfCAG7yaTXbgZYUrW7YhNXPUKXpzdJvAs
         bWaDaxPf3Mar1O6/BnHDfPIleSKNWJD+/2lR9PEjonCn/b6aYQPw/zplQ61ozycjzsv/
         FG+A==
X-Gm-Message-State: AOAM531C5b8sv1J1Puw9bu+PMvLrba3T1rMLgYbac0r9/j8tMuUzODM5
        O7xFwq1TL0njBEaNAabKxPE=
X-Google-Smtp-Source: ABdhPJygGsmq6Jk3FZc9+rIZXhBtmE1ah0pzyVZVjtfXWDp8SR5j9Io1znGSGbdOOIvoCYKLqaRNaw==
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr8251413ljo.456.1590922909639;
        Sun, 31 May 2020 04:01:49 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id z5sm3148776ljm.64.2020.05.31.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 04:01:49 -0700 (PDT)
Received: (nullmailer pid 9364 invoked by uid 1000);
        Sun, 31 May 2020 11:06:18 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Cristiane Naves <cristianenavescardoso09@gmail.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:rtl8712: avoid skb_clone after skb allocation fail
Date:   Sun, 31 May 2020 14:05:47 +0300
Message-Id: <20200531110548.9318-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb allocated when out of memory is likely to be discarded
during subsequent processing.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 29 ++++++++++----------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 116773943a2e..570030be3077 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -1037,24 +1037,17 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 		 */
 		alloc_sz += 6;
 		pkt_copy = netdev_alloc_skb(padapter->pnetdev, alloc_sz);
-		if (pkt_copy) {
-			precvframe->u.hdr.pkt = pkt_copy;
-			skb_reserve(pkt_copy, 4 - ((addr_t)(pkt_copy->data)
-				    % 4));
-			skb_reserve(pkt_copy, shift_sz);
-			memcpy(pkt_copy->data, pbuf, tmp_len);
-			precvframe->u.hdr.rx_head = precvframe->u.hdr.rx_data =
-				 precvframe->u.hdr.rx_tail = pkt_copy->data;
-			precvframe->u.hdr.rx_end = pkt_copy->data + alloc_sz;
-		} else {
-			precvframe->u.hdr.pkt = skb_clone(pskb, GFP_ATOMIC);
-			if (!precvframe->u.hdr.pkt)
-				return;
-			precvframe->u.hdr.rx_head = pbuf;
-			precvframe->u.hdr.rx_data = pbuf;
-			precvframe->u.hdr.rx_tail = pbuf;
-			precvframe->u.hdr.rx_end = pbuf + alloc_sz;
-		}
+		if (!pkt_copy)
+			return;
+
+		precvframe->u.hdr.pkt = pkt_copy;
+		skb_reserve(pkt_copy, 4 - ((addr_t)(pkt_copy->data) % 4));
+		skb_reserve(pkt_copy, shift_sz);
+		memcpy(pkt_copy->data, pbuf, tmp_len);
+		precvframe->u.hdr.rx_head = precvframe->u.hdr.rx_data =
+			precvframe->u.hdr.rx_tail = pkt_copy->data;
+		precvframe->u.hdr.rx_end = pkt_copy->data + alloc_sz;
+
 		recvframe_put(precvframe, tmp_len);
 		recvframe_pull(precvframe, drvinfo_sz + RXDESC_SIZE);
 		/* because the endian issue, driver avoid reference to the
-- 
2.26.2

