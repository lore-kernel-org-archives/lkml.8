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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D942BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC82E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGLqUwJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbgF2TnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbgF2Tmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3DC031411
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:16:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so17308999wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjj43rB6y1HIR70lh4W6BkNz4kpzs/8/avBfXYS2KVQ=;
        b=DGLqUwJF7JNmCO4+oz4CqxQoCeQferLTave4aukz0NXq7xqXbkR+WNMEiBUEGaq4DF
         IUVksEKfcuX4qgVjp7Pis4gXQ0G70+b12TpGhF2tExWQgCvnMW0HlUTnKCANFO18lhC7
         rsqQ5pEAkLgJDxRT1wmB+b59YiP6tZS2l1R95JoKyr81qNPKQW7nZv8f3Pt3nDK7CL8t
         S7y7kaXiTM/cGz2yPINdrzrRE47YH/m8ugW2ifuJYfm25TsgrzWON3ON50uGAO4ni13U
         FoJ8QLW+GHE40rsobCJxFBhBuBVohF43n56B1NUk+hhxjLKDG0nvDIKlNp7sxHeQFlir
         2qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjj43rB6y1HIR70lh4W6BkNz4kpzs/8/avBfXYS2KVQ=;
        b=XP2fgplg6jrGgJvj8DKEMuvg5bREsL9NVxy4yxhzzxvB0PfywrOw+Lxg6TQsPPVQe7
         Ibsvm4iN5jiZePMBIVqa8YO4BMqwXCDnrEOq1fsSJBai+E332oGRyUDAPEtpN3IyCVqe
         1R3zM7dLrxTxbXSjGmDZu5AOXb2RTaE4dlIeRr9NH+EFFuiwzLnJcFUUCxL8rvgaQkoT
         hq3m/DtRQqwZcKew70cf3SlnA6UKZM8xt5HUd1DkuViGmIJEcKKK/z7GmyFf93Uywbpt
         fRMa3Zda4oVgNekfPXvh8wyk8VTKcFCJvJIVh7nI7x26pXOFBwqPvAgqvPOVMTnl2GFJ
         BPKg==
X-Gm-Message-State: AOAM531BZ4+g8sO1Oy5hP6JxxEfyv6ECRJxQAaVXU+BIdTtoBBD9AjhC
        aNXCGy/PM1GTiLCBMTKzmAk=
X-Google-Smtp-Source: ABdhPJyMZ9oWhKaPvA5+S+FE3PPIaQa8rJXfKOfDpcYuuZiaa6XtQkmScybvpHhgfugQ/OC9eTjO7g==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr19149973wrw.29.1593451010130;
        Mon, 29 Jun 2020 10:16:50 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-176.178.011.pools.vodafone-ip.de. [178.11.230.176])
        by smtp.gmail.com with ESMTPSA id n14sm432728wro.81.2020.06.29.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:16:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, hdegoede@redhat.com,
        florian.c.schilhabel@googlemail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: remove some ieee80211 constants from wifi.h
Date:   Mon, 29 Jun 2020 19:14:04 +0200
Message-Id: <20200629171405.7711-2-straube.linux@gmail.com>
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
 drivers/staging/rtl8723bs/include/wifi.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 88a6e982ce01..f75df547a946 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -657,11 +657,6 @@ struct rtw_ieee80211_bar {
 	__le16 start_seq_num;
 } __attribute__((packed));
 
-/* 802.11 BAR control masks */
-#define IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL     0x0000
-#define IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA  0x0004
-
-
  /**
  * struct rtw_ieee80211_ht_cap - HT capabilities
  *
-- 
2.27.0

