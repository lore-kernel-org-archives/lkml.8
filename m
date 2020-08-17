Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA44C2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpPab2cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbgHQSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391234AbgHQSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:38:40 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F2EC061344
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:38:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 129so11294904pfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fgr4lPs0or0iB5fosHxX2pUdsKpC2fZEoB73rKcd/Pw=;
        b=gpPab2cfyT6hCpRcW9yoitZQ1bivgwHZ2ranIeUCOGVWqqdJJGkzeAsDn0bzKfK7Pv
         1W4MAPW358Iw9HfcGsyY/MRlsoG1jAhst1mLKAxeiA3WkvVoCFW5l1RI3PxvKiiyJJBv
         kJcZ0AfIMQzp3c8hLX8+a0afCnLugujKAGoq6Ie/0tf0eg12Noc2Jr6Cz8fPst3LhdMC
         uvUQ5MfTFeRx7HoqNz+SCpcO7hNipmNDmKul8Y2G6P1xpHJG7tg6dKMFun424z7UB1k2
         MbkGXjyU9qSymtGtHAtFaZfZLwooQK5Jtuffs1oqDB3ihKpPWVMwd1udcf54pBbB9e7M
         0ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fgr4lPs0or0iB5fosHxX2pUdsKpC2fZEoB73rKcd/Pw=;
        b=gkluRPCdG2WzwTUaRabNGyeiMSuZPGWocyfpOHm4EEAe/MC3MnTohmcX9Es3nxoLp6
         8aySSQekSTqfCBeTOrTJzdhxZh9V9gvtmz6rBkQKaZRnQpy0pUjWp/yFC3OsKtW3V2KH
         3u+l3X5TbUqGSGRMxXhzBAmuCMZ5WVH1ELga9NZTlOvAb+BAO20ib3lH9IoWl/3Wpy5u
         VQRfqXMqVYoo1YBcIzmuL1Ke7dhPf+QyXZ0nLmOia973UIF44vYUxUhmpNB0Q/ZW/Srn
         /g57lD7V17uGx8Us24ojRUTotdX4i0W8Y0QlNSBVIpFl8t7qe6KOPY8V+Wvrd9ZP4qfC
         GSVA==
X-Gm-Message-State: AOAM533k4CpKoPdGQ2V2+8kVTCrA4LjfdqjbS8/uOjawbmtm522K23rp
        CpnyOwDXWuzBBRkYkOJKa281hl8ZjB4=
X-Google-Smtp-Source: ABdhPJx7JMQgnHKmRP+uG+1UdYLjI4cM9KQFTz6ra+2WZ/MkSR53JhDoU90OXmzlexcksXGhfm7i98cnzmw=
X-Received: by 2002:a05:6a00:81:: with SMTP id c1mr12660793pfj.189.1597689518510;
 Mon, 17 Aug 2020 11:38:38 -0700 (PDT)
Date:   Mon, 17 Aug 2020 11:38:28 -0700
In-Reply-To: <20200817183828.1895015-1-badhri@google.com>
Message-Id: <20200817183828.1895015-2-badhri@google.com>
Mime-Version: 1.0
References: <20200817183828.1895015-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 2/2 v4] usb: typec: pd: Fix formatting in pd.h header
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing spaces with tabs for PD_T_* constants.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Change history:
-First version at v3. Keeping the version number same as the parent.

Changes since v3:
-Added Reviewed-by tags

---
 include/linux/usb/pd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 1df895e4680b..f842e4589bd2 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -471,9 +471,10 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_VCONN_SOURCE_ON	100
 #define PD_T_SINK_REQUEST	100	/* 100 ms minimum */
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
-#define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
-#define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SRCSWAPSTDBY	625	/* Maximum of 650ms */
+#define PD_T_NEWSRC		250	/* Maximum of 275ms */
 #define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
+#define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
@@ -484,5 +485,4 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
 
-#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
 #endif /* __LINUX_USB_PD_H */
-- 
2.28.0.236.gb10cc79966-goog

