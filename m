Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC414C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E8E21D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxfPyiq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDRIgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgDRIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:36:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0CBC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:36:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so4436022ljp.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/6//M0ZzMZYaNauz99M15j4KPCmpQuIwWItAHuzh60=;
        b=NxfPyiq4iJXOVjnaTadZFBInGPBNrnbwZ79ocfZASYenBByQJX7OwzgXw/uWkRFsuF
         YVlkYkSzm0Aq1f/HP+qpg0pWKrV7fpCWwjrruh0jDKc1wom8NtWA139shgTnJIdPrr02
         Z4c77VP9R6gGMx/rVVzVTw1Y7XJTHk69h39PG2HsiuDiQj6Mvt5UYdDsRUwCB1y8ruQC
         F4ltdwb0/b9dIzlIoR/RpK5mjt60xe8Ss/KIOOb9nZjmyZifgVpzVNmVLU6tSj+7LPF0
         hNlooU8F7cYFvLCpmSBlOyFbriJABQsUB6dGdSGw+UFc+y7DKIbcYckY+gXwEXbQc/em
         2KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/6//M0ZzMZYaNauz99M15j4KPCmpQuIwWItAHuzh60=;
        b=SrNB2ESpIbrbcwhtUXzqocErNqSR4Kq+lTWsH/u4hlvABrM5xhcNNvnnDrMSrnaOZr
         Jq9aMicP76rS8Q5vX51HHalwn5gsGxzoiwxwM+YicXTmwPXbgtpORtW9UfRL459s2CTo
         2N0G0KQuWNKeq+JeELhuE/lnxni6RbN4ZCEaMuYjf/ewq9GvLFJSgTfWliDXg8rxj8RS
         gL8r6+Rj3zfsGqluBwkc5EZ+0IEhbVPIZdg/NKh9+1fWWMOVzGKlGFXPxdV51YiGY4xh
         EAG1hNG8jIotbgqIK58ooGygKATmaWt+pb3naUJg7GeXHpp6/mF8Iox4YS6GvCHDt7RC
         cPUg==
X-Gm-Message-State: AGi0PuboSVVVAxV64QtJocCsDZvGBDehOtzCOIaTDdCVj6sK86naOaif
        23PwDluQjM6DuOXgWOnGtQcA+FNy
X-Google-Smtp-Source: APiQypIthhBFvflX4gjyM6Gsi3RoSgfX3rp14yMBdfeREtXfa2h5ZEY36SPuub64uRymEDGdJ8qx5Q==
X-Received: by 2002:a2e:330e:: with SMTP id d14mr4338860ljc.153.1587198996062;
        Sat, 18 Apr 2020 01:36:36 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id j14sm19484204lfm.73.2020.04.18.01.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:36:35 -0700 (PDT)
Received: (nullmailer pid 3769 invoked by uid 1000);
        Sat, 18 Apr 2020 08:41:14 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:r8188eu: avoid skb_clone for amsdu to msdu conversion
Date:   Sat, 18 Apr 2020 11:41:12 +0300
Message-Id: <20200418084112.3723-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb clones use same data buffer, so tail of one skb is corrupted by beginning of next skb.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index d4278361e002..a036ef104198 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1525,21 +1525,14 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 		/* Allocate new skb for releasing to upper layer */
 		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
-		if (sub_skb) {
-			skb_reserve(sub_skb, 12);
-			skb_put_data(sub_skb, pdata, nSubframe_Length);
-		} else {
-			sub_skb = skb_clone(prframe->pkt, GFP_ATOMIC);
-			if (sub_skb) {
-				sub_skb->data = pdata;
-				sub_skb->len = nSubframe_Length;
-				skb_set_tail_pointer(sub_skb, nSubframe_Length);
-			} else {
-				DBG_88E("skb_clone() Fail!!! , nr_subframes=%d\n", nr_subframes);
-				break;
-			}
+		if (!sub_skb) {
+			DBG_88E("dev_alloc_skb() Fail!!! , nr_subframes=%d\n", nr_subframes);
+			break;
 		}
 
+		skb_reserve(sub_skb, 12);
+		skb_put_data(sub_skb, pdata, nSubframe_Length);
+
 		subframes[nr_subframes++] = sub_skb;
 
 		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-- 
2.24.1

