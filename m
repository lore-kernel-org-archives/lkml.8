Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEB220842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnG4WngD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbgF2Tn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbgF2Tmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761EC031412
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:16:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so17309071wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58F1k7MrrA18PHt4ShpVauKdd7W9Jl9sr1t9KkeMq+c=;
        b=MnG4WngDq/kPxIpHMQd2gytgkwlS4KclFS+YUiaFm97BDEufADDKaF62Xb1Eo9jQWK
         FHuCGjoDZ4yPEoFLc+PzT19zJikxKd01woAFUE9liu5zRCVCcdLXSge/w1rT7fmuKygB
         V3JaprlTrLMf1t35eL1X2Xn5b4C4ibDM83o0ZfRdd192EcpUSb0ciB9dSHkjQ6VoPfjS
         sJVdsCHDwdYv5fKDvPas6fbC44xThBbtFMmjxm08D8B1V+arp310dozdpp17Ncl+4EWb
         aZUxV1lZmoEQIG65XR8QGgYYkq+yqoGMuE0OX2LFZOLcw9aYcSo66zkhxEnMjgiwC0um
         Vthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58F1k7MrrA18PHt4ShpVauKdd7W9Jl9sr1t9KkeMq+c=;
        b=AMR+e3MPG751q01MVp7uSZpN4hcGLEbxyaTl5OniMm74GWIT95CEWYOhi39MHvPPBW
         yPRMvtxUTewjDFoR7ZknrIjp9Fu9pu/mXxStyK6nOxYPA3rVXEcPZ+Njx4wRvSyFurbJ
         7xCbOsOwI64cwLhWmF5/CZHicvg3ywmmeBSfRIgnDHaLdbO5SMlAEjfjhHEBjLyJe30R
         ss2HNQ5D8Vok7XnrL7sstjjqslWqEkBfplvRMaGXyFjrp9jQNrwNeqsOXRDt42SpOJHl
         Y9rqRIr+4nD2x3WLgJSIhdTi3wTRVtesSuE8vZRkPNfmd0MZxWRFnLVpbqp8e9oUZKuI
         p+0A==
X-Gm-Message-State: AOAM533BZmlJSUNaPkK74ESqPJuQByD0Se6CGDSxBZOLjtOqoYs8MkIb
        ugh0H8fSLNMCbzHV6ecc84k=
X-Google-Smtp-Source: ABdhPJydWWJdG3LfLZ7/i2qfqcBv41OMVwGGy7Y+ls3W8Je2UKVCAd4E5xgMyAr3duDTShaXi6mc7w==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr18108462wrx.106.1593451011421;
        Mon, 29 Jun 2020 10:16:51 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-176.178.011.pools.vodafone-ip.de. [178.11.230.176])
        by smtp.gmail.com with ESMTPSA id n14sm432728wro.81.2020.06.29.10.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:16:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, hdegoede@redhat.com,
        florian.c.schilhabel@googlemail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8712: remove some ieee80211 constants from wifi.h
Date:   Mon, 29 Jun 2020 19:14:05 +0200
Message-Id: <20200629171405.7711-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629171405.7711-1-straube.linux@gmail.com>
References: <20200629171405.7711-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL and
IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA are not used in the driver
code and, if ever needed, available from 'include/linux/ieee80211.h'.
Remove them from wifi.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8712/wifi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index befb2f9b40ad..66e0634f07ba 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -451,10 +451,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 #define GetOrderBit(pbuf)	(((*(__le16 *)(pbuf)) & \
 				le16_to_cpu(_ORDER_)) != 0)
 
-/* 802.11 BAR control masks */
-#define IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL     0x0000
-#define IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA  0x0004
-
 /*
  * struct rtl_ieee80211_ht_cap - HT capabilities
  *
-- 
2.27.0

