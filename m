Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B17C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF5924688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GAmPCODl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgB0PzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:55:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:43099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgB0PzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582818906;
        bh=uz3K9c2PLjXXAjs7VIHhAKs/DKNEOPy9W/ZUL2a3dYM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GAmPCODlUofoGf1zXNSSse0Eep6DLrspmPNZXPE45vZoCvH6GQyQ2pz0CIQALoS6+
         a9XxElpeULgiiH1Py9TkOIZS/KKHOjUqZbJJgsjtK5adm6vm5Tl2e7JNsuZEdGeaJq
         9+t9hjVlq6IjF+buwOw0wIvT2sVbEVuPjdKY3YR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.148]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1jd80k0lSO-00h3y4; Thu, 27
 Feb 2020 16:55:06 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: zii,rave-sp: Fix a typo ("onborad")
Date:   Thu, 27 Feb 2020 16:55:00 +0100
Message-Id: <20200227155500.13594-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TAnyNNRRa0UrUguVmUQWAyzZu2q1PADVFm+uOtEAljT4RXqDRmc
 oNOW+7yIHE+HsZGIOgorTjVEBnO/1XsRwzpZkKdZHYg2+pOTiLIQakPdajwyn9dlBO+TwQB
 pTmtONZUw1FCYLWM2hPtXTANC4J9CVjBlDshlRu1PhgUiRe1Mb8IUuKQujCb8EpbnNI8wQ4
 Fcx991Q1Qpxdc1OpnwWsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/WtQ1vt0gRI=:5XQk1RqrG5NEZyzAvoJnf6
 HxFg9y9MdH/pyEvoNiaGAsJDwxIEWoaGM7w2XgGrzhjC9NxPG5ffh8pdbkGQrpJRJSL618qhF
 WwcNb8wH6G6ygKZ7hMnzNSQ76Ye/Xijt9/UlohMjlK1C+8vt8NUiIu0XES2Vs1An+YtyrAdSy
 A3+cxApRzxA0rmHcZ7UXGOgTCPRpPod5LcxEvt6xSa7sjMHQsBxRjuAogXKbBP0Pap8Ju7W/B
 RNrRApwFDg6Iv8aBPbU0TDXT+4zJqY7XBaiCkBcbUezwHH27SdGvy2QJ3HEW60La0UuTy5KbQ
 tFNgGm+vh9rWe1bpB+n4rspiBP0/QQy592U6HCiblaD6+L7RY/3aqtfSg8VDvazJgJPCGSq1w
 qRr8ssh971HseoisakhWIOEZL3M7gUYmrheHgfDLQzru2BXemv/I9O6CMtupgCBbqin7YP9qV
 Itgn8e4OSX5AKrNEwlZiN9RtxsTCSfKJpZ1+ufbLaOX8LNCxpggswWY8KQSBtw3S0AOAcW1U4
 l3tLlhOLyOo/fKnhqgaW+27khhO5dcT/0HjQ2QzBXgm94yMMWQSyS6p2jRVT1T5Z8nGxzLgUv
 oJWJcIMcfY3Nbe6qGlgNokuYui0sJAk3GY+nEo39J0GsVse6jKyjWwfgs+kOEt3ysWu9XzCd3
 fVT5y/fUrpPjqgc8Ws03jM2oHmqfHCrH0mx1yPC9lD4lIH2R8ysHwE7bj2oEDLeBq6h/jqjnL
 raAgAkmiLNY1La3FOMtRQLSJKjl8KfXRMEKZ51cpzjDleqPxmp9NmEmzaH2PgMlbzSuy+cZin
 c0NIoW5CWkHKBA+zgMZiX65g9toHPZ8dwwIyN+okbMU2ftx/AGh5QXTGrMOJe6byXtb3+znTv
 8NNh9Z/ff1OKr7mnGd2CGeX8kqdlMjmMtDYF6vvHess6dtcTihFLm2G6GqK8Ug1el4PZwFmoU
 1Ek4VDh8umEj4SbhsmedFOWwdl/+Ms6KnowBBKmnagxZe1pnfDciX7EK2lVJCRayfe8uapMR6
 wrPr5xoZMKtytfgelkI1R2qXeGbFdD3H7f7jnMHSKJ8NceCgp97HqSAZiQmphlGzGwqvSzAoh
 vshUyTWoEVZ5rDuIYs34mxmZimVSlHIpCTfHeGYo99ghgG6BuPjoUUYw/4OOF89dBMStcu/1Y
 FSTXwNrulWs/qpNReIYfvqt6pm7qfAyEo0mujJ3onBTxb5wEg87cIrGxj5FytivzY3KujMR7j
 vVJJx33SQC9S5EPC6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/mfd/zii,rave-sp.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/zii,rave-sp.txt b/Docum=
entation/devicetree/bindings/mfd/zii,rave-sp.txt
index 088eff9ddb78..e0f901edc063 100644
=2D-- a/Documentation/devicetree/bindings/mfd/zii,rave-sp.txt
+++ b/Documentation/devicetree/bindings/mfd/zii,rave-sp.txt
@@ -20,7 +20,7 @@ RAVE SP consists of the following sub-devices:
 Device				 Description
 ------				 -----------
 rave-sp-wdt			: Watchdog
-rave-sp-nvmem			: Interface to onborad EEPROM
+rave-sp-nvmem			: Interface to onboard EEPROM
 rave-sp-backlight		: Display backlight
 rave-sp-hwmon			: Interface to onboard hardware sensors
 rave-sp-leds			: Interface to onboard LEDs
=2D-
2.20.1

