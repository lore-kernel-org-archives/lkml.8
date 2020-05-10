Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DDC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8151C2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaKWpi7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJMU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:20:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726863AbgEJMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589113256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My/9Ka+fMo2mmwGpwA6FKhk0hvGr1IXdpelI6We2e1Q=;
        b=ZaKWpi7MxTpnNbgNPyrJZWtYtwOag1TzoYY94MtRBDn2EIYMoogpDEJRaOZA2YWEPooTMd
        gMacfSBQfZW0vwiOs+EHPvqyVP9SsIAF/FpMV8lYV+JNvsKvOjGOnGwpxzciggH54+XNVO
        M7BGkpy5V5ifmlXXTObAnp7nsw/mPz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-J5xJ-RD_PPuyWvzgGSMYjA-1; Sun, 10 May 2020 08:20:53 -0400
X-MC-Unique: J5xJ-RD_PPuyWvzgGSMYjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD082107ACCD;
        Sun, 10 May 2020 12:20:51 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2DF36AD10;
        Sun, 10 May 2020 12:20:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: intel-vbtn: Detect switch position before registering the input-device
Date:   Sun, 10 May 2020 14:20:47 +0200
Message-Id: <20200510122047.123613-2-hdegoede@redhat.com>
In-Reply-To: <20200510122047.123613-1-hdegoede@redhat.com>
References: <20200510122047.123613-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the initial state of input-device switches must be done before
registering the input-device.

Otherwise the initial state will get send out as an event as soon
as input_sync() gets called.

E.g. when undocking a tablet using intel-vbtn to report SW_TABLET_MODE
and SW_DOCK before this commit we would get (evemu-record output):

E: 0.000001 0005 0005 0001	# EV_SW / SW_DOCK              1
E: 0.000001 0000 0000 0000	# ------------ SYN_REPORT (0) ---------- +0ms
E: 0.000109 0005 0005 0000	# EV_SW / SW_DOCK              0
E: 0.000109 0000 0000 0000	# ------------ SYN_REPORT (0) ---------- +0ms
E: 0.000133 0005 0001 0001	# EV_SW / SW_TABLET_MODE       1
E: 0.000133 0000 0000 0000	# ------------ SYN_REPORT (0) ---------- +0ms

The first SW_DOCK=1 report is spurious, setting the initial switch
state before registering the input-device fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel-vbtn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 29984154f8e4..ef92c1c3adbd 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -111,6 +111,9 @@ static int intel_vbtn_input_setup(struct platform_device *device)
 	priv->input_dev->name = "Intel Virtual Button driver";
 	priv->input_dev->id.bustype = BUS_HOST;
 
+	if (priv->has_switches)
+		detect_tablet_mode(device);
+
 	return input_register_device(priv->input_dev);
 }
 
@@ -217,9 +220,6 @@ static int intel_vbtn_probe(struct platform_device *device)
 		return err;
 	}
 
-	if (priv->has_switches)
-		detect_tablet_mode(device);
-
 	status = acpi_install_notify_handler(handle,
 					     ACPI_DEVICE_NOTIFY,
 					     notify_handler,
-- 
2.26.0

