Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C9C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5F320675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxPeMDRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDELYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:24:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56044 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDELYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:24:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so11719298wmg.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=761FVsLf1WZqMCx3Uyo0mar5wqNw8CpImTKcEmKb6o0=;
        b=BxPeMDRkaf6PV4ZZYTcPCrFRoEyw8UohGWfnErLsYUsMvIPx0N+CNyXtnw+y8S56oE
         DbErryeZfH/4szYhgyeuyGBE4/dwV9tlF3YrfcgjeR7JKQFuAQGUJG08mheRBF8USYgs
         Z1GbVHtqDj8NHWZKci0CZDkdGEhRm0SIEzTrPdlCgLpKe9+D1r81E/NwAdTYUt5b1Hk7
         en8ld2FeLce6JcSK6O0ziK9UYxlJ/VxtCGcEcCup7u7IwgFUIWisfyew3/YcYhs/bQTM
         Ylv2PxXFxfGiJkHjW2Tle1RdND7RynnSrdoZjMFn7S8uLijmXvbexiX8/WHX4mCP/1Wh
         0pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=761FVsLf1WZqMCx3Uyo0mar5wqNw8CpImTKcEmKb6o0=;
        b=BL41PWCBcvXbB7HpMkVkD0ArdFrBNc0liaG4QWeIe7KF6oAs3ZBXWWC9Abh0C/4ZFs
         kBDxI4Z9rLKYsjHKUj8yM8JbI55If3x5weZkA+JNFwXdjl9K0T3FeYrXtYR7sa54hXAZ
         mXjpnwKmi9p2kmuFok4VC09yLYIK8YGJNk4H5qlbipWTe0XnXxbAD4XMI1EX7RzptNZn
         qQi0+nHDxSRiBiJUY9QAijEqcHp79XLNyV/z8NuiRKWdGRK0K3dQpbZahS5OpOjnI8am
         kcKuo8oWyxLOWqiVt7M0sm4zvOj5Pw9wHOdk5KQQCO1U/xhS4YOGsk2zefaGcCq6TAoh
         4ESg==
X-Gm-Message-State: AGi0PuZi5djX1cQ4siIGoY7qkPl4t4/EkMc6iLw/ASHArIzv0fJDQwbg
        wtVqZr0SrdzTY3UeF5LnY99ouRi8
X-Google-Smtp-Source: APiQypKFVZnlt8BOJF/VxUVuJgeqNPiecJvPVutCSc3JIFVX3WBIrDDxSKtzKBiAQWsUnVBFKG9k7g==
X-Received: by 2002:a1c:ac88:: with SMTP id v130mr17961701wme.34.1586085853595;
        Sun, 05 Apr 2020 04:24:13 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-143-158.002.204.pools.vodafone-ip.de. [2.204.143.158])
        by smtp.gmail.com with ESMTPSA id b15sm20365012wru.70.2020.04.05.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 04:24:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove unnecessary variable
Date:   Sun,  5 Apr 2020 13:22:30 +0200
Message-Id: <20200405112230.31975-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405112230.31975-1-straube.linux@gmail.com>
References: <20200405112230.31975-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'bStopBlinking' is used in if tests immediately after its
value is set. Use the conditions for setting 'bStopBlinking' diretly in
the subsequent if tests and remove the variable. Slightly reduces
object file size by 16 bytes (gcc 9.2.1 x86_64).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index 91b0029d1179..32dccae186ca 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -90,7 +90,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == RTW_LED_ON) {
@@ -128,9 +127,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		break;
 	case LED_BLINK_SCAN:
 		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
+		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
@@ -164,9 +161,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		break;
 	case LED_BLINK_TXRX:
 		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
+		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
@@ -207,12 +202,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
-		if (pLed->BlinkingLedState == RTW_LED_ON)
-			bStopBlinking = false;
-		else
-			bStopBlinking = true;
-
-		if (bStopBlinking) {
+		if (pLed->BlinkingLedState != RTW_LED_ON) {
 			pLed->bLedLinkBlinkInProgress = true;
 			pLed->CurrLedState = LED_BLINK_NORMAL;
 			if (pLed->bLedOn)
-- 
2.26.0

