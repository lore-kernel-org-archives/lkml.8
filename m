Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0CCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB78C20578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlwRO3/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHXQyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgHXQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:54:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA393C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 09:54:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md23so12055519ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=0uKjMYWuYAujWnSg0hg9hJ906KGrfrt9C0Xq2qVWWBw=;
        b=tlwRO3/avN3/y8Dt5oXbOA4sQqC8uIkMaJoX9i8TcBOe1PhxrRaaRmEjq3IMypQomS
         B+GSbOO3zZjwBbFKfQuueICivw6uHcQsWxSMinXJBo/K+tyCPaou8QXGf5lxEVjA+wwB
         Mgl6lL93uVspCjb6n9xmMDC3OIl9b0lHBJ7TXAyjoDbG+Tnqk6LcPpJn89KA7ZlzDy79
         8GhYyqeUttiUv3G+4wLM+dfGNVxsulK7VbKegXLG3jbeftXX6pgSkChoPZLDh+gArLbR
         2f8E+OswgHPpwDuv19HC703WQZpHZxUj0MAN5eZ+Y+t/xwXL5DamLGp5xhfp+Fz0B7aZ
         RHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=0uKjMYWuYAujWnSg0hg9hJ906KGrfrt9C0Xq2qVWWBw=;
        b=L11i6uwCuMyQ8zxcHT6OsMDkq/1YCUippXU2eNJmfNfEl5pbyIERlayhMfdaPrM/wL
         urI+uDXlTHPFauLJVJ4+gR1BIRvO5SLwT++RR85FLuZE1+gqLX1QGXVvowlfewheAcrK
         ZvW17G36pFjdE8cDi8d4l+Gw3wSMeJ9erYUgAIrimSpHHbZW/IqWWTWc2UfKb4KsiBvG
         wyGhQzHIZJ4oGcqtNJKG/Keyw3ufVyDKYKIOSxcT0UtXYsob/hhgNu030y973UorHFOC
         aZgw3ibw2fWqJX4/3r4yq1A8iQXidIHVecn7HyOSRoyMj9xohxhw/6w4pzYfMIW21P3G
         jwXQ==
X-Gm-Message-State: AOAM531zlc8jEDBp4gnySnFA8FdBqWkKodBJvrf28g6ge0eXmrwIYLtO
        4zLFmyVpVcherZFZd+ns8eX63+5ayEn2cw==
X-Google-Smtp-Source: ABdhPJzKJcQdHcx+JPKfNsV1KM+gdAwAQLmmRMW40KpcWPv8KtJVxxVucvB/UQbVh7aZBWk8dl0OGA==
X-Received: by 2002:a17:906:3390:: with SMTP id v16mr6229139eja.106.1598288038253;
        Mon, 24 Aug 2020 09:53:58 -0700 (PDT)
Received: from steffpad (p200300e34f08686ed692311cd92fa27d.dip0.t-ipconnect.de. [2003:e3:4f08:686e:d692:311c:d92f:a27d])
        by smtp.gmail.com with ESMTPSA id p16sm10563359ejw.110.2020.08.24.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:57 -0700 (PDT)
Date:   Mon, 24 Aug 2020 18:53:56 +0200
From:   Steff Richards <steff.richards.the.third@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: fix alignment to match open parentheses
Message-ID: <20200824165356.GA5204@steffpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indent a number of arguments so that they align with the opening
parentheses of the function calls. Issues found by checkpatch.

Signed-off-by: Steff Richards <steff.richards.the.third@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index a8860d2aee68..a908ff301707 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -228,8 +228,8 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *msgp)
 		__le16 wordbuf[17];
 
 		result = hfa384x_drvr_setconfig16(hw,
-					HFA384x_RID_CNFROAMINGMODE,
-					HFA384x_ROAMMODE_HOSTSCAN_HOSTROAM);
+						  HFA384x_RID_CNFROAMINGMODE,
+						  HFA384x_ROAMMODE_HOSTSCAN_HOSTROAM);
 		if (result) {
 			netdev_err(wlandev->netdev,
 				   "setconfig(ROAMINGMODE) failed. result=%d\n",
@@ -275,8 +275,8 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *msgp)
 		}
 		/* ibss options */
 		result = hfa384x_drvr_setconfig16(hw,
-					HFA384x_RID_CREATEIBSS,
-					HFA384x_CREATEIBSS_JOINCREATEIBSS);
+						  HFA384x_RID_CREATEIBSS,
+						  HFA384x_CREATEIBSS_JOINCREATEIBSS);
 		if (result) {
 			netdev_err(wlandev->netdev,
 				   "Failed to set CREATEIBSS.\n");
@@ -1167,8 +1167,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 		if (hw->presniff_port_type != 0) {
 			word = hw->presniff_port_type;
 			result = hfa384x_drvr_setconfig16(hw,
-						  HFA384x_RID_CNFPORTTYPE,
-						  word);
+							  HFA384x_RID_CNFPORTTYPE,
+							  word);
 			if (result) {
 				netdev_dbg
 				    (wlandev->netdev,
@@ -1209,8 +1209,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 				}
 				/* Save the wepflags state */
 				result = hfa384x_drvr_getconfig16(hw,
-						  HFA384x_RID_CNFWEPFLAGS,
-						  &hw->presniff_wepflags);
+								  HFA384x_RID_CNFWEPFLAGS,
+								  &hw->presniff_wepflags);
 				if (result) {
 					netdev_dbg
 					(wlandev->netdev,
@@ -1259,8 +1259,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 			/* Set the port type to pIbss */
 			word = HFA384x_PORTTYPE_PSUEDOIBSS;
 			result = hfa384x_drvr_setconfig16(hw,
-						  HFA384x_RID_CNFPORTTYPE,
-						  word);
+							  HFA384x_RID_CNFPORTTYPE,
+							  word);
 			if (result) {
 				netdev_dbg
 				    (wlandev->netdev,
@@ -1276,8 +1276,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 				    HFA384x_WEPFLAGS_DISABLE_RXCRYPT;
 				result =
 				    hfa384x_drvr_setconfig16(hw,
-						     HFA384x_RID_CNFWEPFLAGS,
-						     word);
+							     HFA384x_RID_CNFWEPFLAGS,
+							     word);
 			}
 
 			if (result) {
-- 
2.25.1

