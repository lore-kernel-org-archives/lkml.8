Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7CB2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HX3AwE4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgCFJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:17:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725927AbgCFJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583486253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JCiUybcIy9EYc3DUqneg1/PUNFvInwnkceZaoY4UhKA=;
        b=HX3AwE4e7cKoc7vV8GZtFwTkZaZQ5Dssbq4OldXsWC1seMeJ1DbN/1qG+wTiQQVqQ9ldwL
        taIAT+ALxJHf9r1DQNoAJvgXj/P2UroVPfKTiEilE/Ys6r2Hs47JvnnPVKr73MxI9IQ9U4
        vtmaNQ+sjkEAJcPFofaimQWmloquchI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-IPnFd5sDPOeISb1VflHBFQ-1; Fri, 06 Mar 2020 04:17:29 -0500
X-MC-Unique: IPnFd5sDPOeISb1VflHBFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890DA107ACC9;
        Fri,  6 Mar 2020 09:17:28 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A35935C21B;
        Fri,  6 Mar 2020 09:17:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH] platform/x86: GPD pocket fan: Fix error message when temp-limits are out of range
Date:   Fri,  6 Mar 2020 10:17:24 +0100
Message-Id: <20200306091724.55347-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1f27dbd8265d ("platform/x86: GPD pocket fan: Allow somewhat
lower/higher temperature limits") changed the module-param sanity check
to accept temperature limits between 20 and 90 degrees celcius.

But the error message printed when the module params are outside this
range was not updated. This commit updates the error message to match
the new min and max value for the temp-limits.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/gpd-pocket-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86=
/gpd-pocket-fan.c
index b471b86c28fe..5b516e4c2bfb 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -128,7 +128,7 @@ static int gpd_pocket_fan_probe(struct platform_devic=
e *pdev)
=20
 	for (i =3D 0; i < ARRAY_SIZE(temp_limits); i++) {
 		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
-			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and=
 70000)\n",
+			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 20000 and=
 90000)\n",
 				temp_limits[i]);
 			temp_limits[0] =3D TEMP_LIMIT0_DEFAULT;
 			temp_limits[1] =3D TEMP_LIMIT1_DEFAULT;
--=20
2.25.1

