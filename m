Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385BC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053B1208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="TitZxSaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBWTcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:32:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51681 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:32:09 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so3159460pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 11:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ycAvVlhM3IO/JQS62drEKBmRbhPxXEBTGHsInI3waLg=;
        b=TitZxSaBobT9tPfdZrNZvIHxzF+BBxBy5IunhWGvp860IEAs8/nzK+TLG0fYoK0DBg
         jrP956ZuTjKZW97+ovKYFsGK5VDKGYnjfMPdWbhINqHoy/rAc27Nwbnp3kxqn0jT26tN
         kvdb8ZOxcAVE6d42mGTSe5nic07NoBjLsKyJlbBzjO9Uiy5uPbFnd1WAFHuXqjxAYhGa
         FBUGcFj6W5GPK6jSKvXEWZYlj5pvMQhy7yrBtxdemhU2n2CY8uwSzVZYLXKBw/yLYGu7
         Pi/CWxphvgdaT/iyQ90ut1Qog5Xc+o8HJZw9ovLD/29AqdmYvcxO1Vxl0dijKwY9goFU
         ut3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ycAvVlhM3IO/JQS62drEKBmRbhPxXEBTGHsInI3waLg=;
        b=Y+a2cQopZn24Q3Jimf+RIrC0ikgVn4WxtFlP2fW+aVQETDmPme6gPCvsdkkDJ0m0oW
         T11J+9b6IQXQwOr3ijBIOLxFLQiLz81XxBEFfPPn9QsO8CSl4/jBNWacTGcTDqoEbUbi
         l9Ape8ft/582v707VbuKGvw9EwWt9DBdqOo3p55GZ1SsLb8R/Ot8FwnzGrZks4lGDA6K
         9yt+aUOYtV6E5ofa3ZFpdGIB8GoU0FTyW1maLOXfjd/7tzqwkM+XAvAFJbLgIcdzl+ZC
         OPDgCX1YnolN2XQCOFEHjTVjecuWbUp9AiwvCB3qgbKYp40oxrubDT0rhbqD0KiYKS2D
         3new==
X-Gm-Message-State: APjAAAX+vJ0xY16OikZgrltK01jW8mKbB2L/gyH//o+DYhYGOT4dDkIL
        AZDOhQ3ueKAt8MAr7d0obsvqvA==
X-Google-Smtp-Source: APXvYqxJR0Ts6qfEF5vjfPugyC9xbDtHJaUVC5LSOBYdcnYOK7L0K+xJCiO6VWQOXsAOy6mA4Ngfkw==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr15959661pjb.47.1582486328414;
        Sun, 23 Feb 2020 11:32:08 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id p4sm9667513pgh.14.2020.02.23.11.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 11:32:07 -0800 (PST)
Date:   Mon, 24 Feb 2020 01:02:01 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: match parentheses alignment
Message-ID: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match next line with open parentheses by giving appropriate tabs.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/wfx/data_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index 20f4740734f2..815fde0913f5 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -300,8 +300,8 @@ static void wfx_tx_manage_pm(struct wfx_vif *wvif, struct ieee80211_hdr *hdr,
 }
 
 static u8 wfx_tx_get_raw_link_id(struct wfx_vif *wvif,
-				      struct ieee80211_sta *sta,
-				      struct ieee80211_hdr *hdr)
+				 struct ieee80211_sta *sta,
+				 struct ieee80211_hdr *hdr)
 {
 	struct wfx_sta_priv *sta_priv =
 		sta ? (struct wfx_sta_priv *) &sta->drv_priv : NULL;
@@ -368,7 +368,7 @@ static void wfx_tx_fixup_rates(struct ieee80211_tx_rate *rates)
 }
 
 static u8 wfx_tx_get_rate_id(struct wfx_vif *wvif,
-				  struct ieee80211_tx_info *tx_info)
+			     struct ieee80211_tx_info *tx_info)
 {
 	bool tx_policy_renew = false;
 	u8 rate_id;
-- 
2.17.1

