Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41119C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEB420758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=footclan-ninja.20150623.gappssmtp.com header.i=@footclan-ninja.20150623.gappssmtp.com header.b="C07mdIPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETLdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:33:38 -0400
Received: from mail-vs1-xe61.google.com (mail-vs1-xe61.google.com [IPv6:2607:f8b0:4864:20::e61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0378AC05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:33:36 -0700 (PDT)
Received: by mail-vs1-xe61.google.com with SMTP id u79so1613238vsu.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=footclan-ninja.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/ac2SaHHPe23aQybxirdwZDUTCApkczJdZwYl+fN8E=;
        b=C07mdIPZd8txhfFv6idlqagpEMKGITPX6yQo9EBE6MLBAPN/AjzG3TKiltGTpmC32/
         Yr79nmOW8lYtfbm3M1ZRHU11lRfXDlCM65Z86vSEZcVibOPl+nCTtKBgh9F/1+2Xl78P
         EZWCoXWqWqsCbzq25V/GQndnXt+hvNeqnvQHSY+2Ts6zDyjmBNNtSl0s9IlAt8WnBTFN
         PYisqSi6kG1vBmPrI6K6ybh6ePr517FjmyS0aTlIr+wo774U3opWBls3Bum4AzzwXpJn
         u3oCA1p2eJzUo0FP1Z/rqUy5bZelt0zEP1Tpgo1YjGiz1bpHjG+38Npdsa2aJv8oTzM/
         CEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/ac2SaHHPe23aQybxirdwZDUTCApkczJdZwYl+fN8E=;
        b=Et3IfvUFZ/+RPwuVpQtovDORhKr0Y3dco0sk/qCsEwt1yxxavKVDKQFH6thOMOzpMX
         ERq7RLpKM7cFPAhTJ+tezBExVwB4JOmXiGdWiup/oOVj+RuMJNEAV5VmJsE02pktG6q5
         GOyGsArzwWwo6Ov5JAc+5XmCYChnR7O/H4ee1HeopotpPgbxY9txx5E8sWnRh4knpAD3
         9GY+RGmwq57mu4XTEri1hy+HMFyAPcIy96XT6+J2NHBhqDwuAH5GnkU9PgrVC7VXm4lR
         3KMGZVRtlW7XHXPj7F5DPyNTl3LA0JPDraSNHUKOtGczrNjNmvEEVI4O73788Yo+kvzn
         TPlQ==
X-Gm-Message-State: AOAM531zgZF2Sy2vs3QP3Y4hlUiOAoxyiWiaoy+N2exLIfFvIlB+pn/K
        7flwSP/4oFVy/6gFAc92ce13oaYxtPXSu7yclftpLRlOO+U4Rg==
X-Google-Smtp-Source: ABdhPJwAb+JstEdpvktOlEmxSiHdZ284xxf3MlUVpKackA/Bois9z0hs1Tsfiq0uP62wU/JT5NJM7XzpVpJ3
X-Received: by 2002:a05:6102:1043:: with SMTP id h3mr3047743vsq.229.1589974416017;
        Wed, 20 May 2020 04:33:36 -0700 (PDT)
Received: from localhost.localdomain (pa49-180-69-106.pa.nsw.optusnet.com.au. [49.180.69.106])
        by smtp-relay.gmail.com with ESMTPS id h13sm217126vka.13.2020.05.20.04.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:33:36 -0700 (PDT)
X-Relaying-Domain: footclan.ninja
From:   Matt Jolly <Kangie@footclan.ninja>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Jolly <Kangie@footclan.ninja>
Subject: [PATCH] USB: serial: qcserial: Add DW5816e QDL support
Date:   Wed, 20 May 2020 21:32:58 +1000
Message-Id: <20200520113258.5496-1-Kangie@footclan.ninja>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Dell Wireless 5816e Download Mode (AKA boot & hold mode /
QDL download mode) to drivers/usb/serial/qcserial.c

This is required to update device firmware.

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
---
 drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index ce0401d3137f..d80ccf58a638 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -173,6 +173,7 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
 	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
+	{DEVICE_SWI(0x413c, 0x81cb)),	/* Dell Wireless 5816e QDL */
 	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
 	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
-- 
2.26.2

