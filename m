Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D87C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C7A22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwfCkHiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgG3D1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG3D1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:27:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C352CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:27:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so14252097pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAwanaBh/g8SjyCF66Oh7kkXlY0ljlytzRLB3xpaxAQ=;
        b=WwfCkHiHKhrFKEuK3iBT93GceFrVkzz0g3zn8mRx7dg/jkd8ItPxPY+x6ZGivO2yET
         U5Q1Oxp+9yGd8lkJZS61YBYYvWA3ueWHTnBoof7UK9Pso5dXfa9ScakApH7yCFU4Eu+1
         ldGSMXpl7SQS+59I5zCGXX6jHiMLifa1m2P4XzItzuwKOsf7GsqVq5d3f3hg3P6oe1Wr
         eYsu5ZYg2FTGMGMZ5146JiyKqE7cFCmsVw7igih8XAPMejx9U9rJW82V5brLrcSGiQT8
         N4m4AfFpf+OrT3J0XBN+WaasogDFLGaoHDe14aO72Q6tn0gIXYV3El6jP9O3u4Pw/bq1
         VJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAwanaBh/g8SjyCF66Oh7kkXlY0ljlytzRLB3xpaxAQ=;
        b=W7tW9zWIijfTlEjeOGQ96Ns2sAuwPrCQBmBm+/8djimB5T1eT+BDvbA4PDx9lac+ND
         g76s+c7CuETtWCU0T8ZAm3S9azjw7JvU5uaZ3g1OJmWA89KS/O2ayRNXug4FkVi876kJ
         P4axMTupQKTC7pa+fTdSpyjwDNCYe+va2PYqVIZXSdlFKplGKoxxY2/wYoaOKKRpm7N/
         /WNYVm9sT776TPcigpL4C7NkRJ9BYui2wJTafR9fp5pyad3fz3EiCnpAM2RQQU62v+VW
         vuDa7VFg6Mfixy29RM7Z7587x5A4WdeLSJC7jFTCQGUjFnSFx9DpTg7uQeOibKtsgv9D
         /Img==
X-Gm-Message-State: AOAM531Ln7tM37yzZU4llEpN1Tcq54Sc7/aztRXF9S/YYbzR+/86Gk/K
        q2bQaJmWeCkAfg8Li9ZTOk5UdnfRsCc=
X-Google-Smtp-Source: ABdhPJw4ghy+Sz4YLvGxKK/Bl5/ZSNjGzvfmoaCh1n5F4gQ9xfmQDf7Tn1lLrJtkUC+BA9UV9m769A==
X-Received: by 2002:a05:6a00:158b:: with SMTP id u11mr1186063pfk.92.1596079637350;
        Wed, 29 Jul 2020 20:27:17 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id ml8sm3565836pjb.47.2020.07.29.20.27.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 20:27:16 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     stefanr@s5r6.in-berlin.de, linux1394-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, gustavo@embeddedor.com,
        zhaoqianli@xiaomi.com
Subject: [PATCH] firewire: firewire-cdev.h: Avoid the use of one-element array
Date:   Thu, 30 Jul 2020 11:27:00 +0800
Message-Id: <1596079620-20023-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code should
always use “flexible array members”[1] for these cases. The older style of
one-element or zero-length arrays should no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://github.com/KSPP/linux/issues/21

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
 include/uapi/linux/firewire-cdev.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 7e5b5c1..487de87f 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -118,7 +118,7 @@ struct fw_cdev_event_response {
 	__u32 type;
 	__u32 rcode;
 	__u32 length;
-	__u32 data[0];
+	__u32 data[];
 };
 
 /**
@@ -142,7 +142,7 @@ struct fw_cdev_event_request {
 	__u64 offset;
 	__u32 handle;
 	__u32 length;
-	__u32 data[0];
+	__u32 data[];
 };
 
 /**
@@ -205,7 +205,7 @@ struct fw_cdev_event_request2 {
 	__u32 generation;
 	__u32 handle;
 	__u32 length;
-	__u32 data[0];
+	__u32 data[];
 };
 
 /**
@@ -344,7 +344,7 @@ struct fw_cdev_event_iso_resource {
  * @data:	Incoming data
  *
  * If @type is %FW_CDEV_EVENT_PHY_PACKET_SENT, @length is 0 and @data empty,
- * except in case of a ping packet:  Then, @length is 4, and @data[0] is the
+ * except in case of a ping packet:  Then, @length is 4, and @data[] is the
  * ping time in 49.152MHz clocks if @rcode is %RCODE_COMPLETE.
  *
  * If @type is %FW_CDEV_EVENT_PHY_PACKET_RECEIVED, @length is 8 and @data
@@ -355,7 +355,7 @@ struct fw_cdev_event_phy_packet {
 	__u32 type;
 	__u32 rcode;
 	__u32 length;
-	__u32 data[0];
+	__u32 data[];
 };
 
 /**
-- 
2.7.4

