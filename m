Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F0C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31F02074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TWi018zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgIES6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:58:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:55755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgIES6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 14:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599332291;
        bh=TkGpYY/6EDgbnT0a86RTNRITMYLHSTqyXnL8bd4MYVE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TWi018zmRaGxDuFFnRdTpepmlB9utag3EC8fYqtyNC7efAwWSWjXCp2IuXbj9UxNL
         gisl3Grszl47F79vNKsiiQdXndGkMFdo1AS7EPJoQQKimtny0PZGf0DIPOFexszmpy
         sFozM4+7mFIfczM3SAChteehJFmrp0yOwN4QJfq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1kaRXf0aky-014BUq; Sat, 05
 Sep 2020 20:58:11 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: ab8500: Remove weird Unicode characters
Date:   Sat,  5 Sep 2020 20:58:03 +0200
Message-Id: <20200905185803.1293715-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6qh5LM/YWGtSyC3mtaQUaFkSpy1jhmsE3oYG9+6DYdST1F+Eor
 rYcJ6Gdc6YyH647QK7qoJK5Ge+C/jhwxNabb9ZVd4q23rLge9Yj9eXQb5XCpCO6ajICO5Op
 vyM622Oa5XM69cYdBmQG286r0I7crSK0dMYnH+dkOIiD9XJhCPFY+TGuFwgOrm012CPJ3ms
 1WLdGyETlS5WVF0MJeF6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wg01hww6n3o=:lHta6WGavXuPpIZE9eshi/
 BOYGc7vinGYFivnQhCKZad7SBFcept97KWonFlZGwj8vuYthd5094U+ep8rIY139eA9xT+0rf
 GGupnLB2n0NTg493e1gBPFQb3dprsSsh+Tva1xRIqYV9ZVJ6o8bJXngV1nRhVbKfrIL4civ/e
 QYAE4wrAuDPEFHy7n9ti2H0/WfUxp55YRC8fHdksI6s5D6NxufkEfGoUbSwh6a+b4t9THq3LU
 0BZyyNzyOiZ7m1aLYetyK3WXGSGGGQPWiQ+YNQOESWIOTw1ryA6bxM+OJ+OBQDdkFOyiH3g2Y
 h29dg8iBRuOCQvhYMc+nvXVbEbtMQdtv7u+/NaAZeMA8qXF0SiFB2s8nN0hVdDmGxDPj0DKoW
 9/A1MrbRuD8Y6OtHqK5GC9U45PWF0NB0QvXDEnoYrEFUL0ClG5Z+iSs0cRk7+f25eh0RqsvSS
 DKwkoMG2j50rqyvvZFqwimxGExYtT7uH9XlpwGcyhjCeOn1s5KJZHOxXTnvT+v4iKZ2pHUqFJ
 OWElqTVvwIlMi1O03A+dDWHVBq/KAapmiHYfXfkZ/+rhTv2CV4Xkd21QRsBmsHP0m8/udsK7I
 Rb9y6Ww2fYLZDeCMWMYUoehb/vERo/DVR09ZUS6WMvarJfSRdK0iIb/tHIQ9cQBItjfuc28ZI
 b3Oih0wKMjlomb4SVV6gq2Rr0ouQHoV7Fp9sfckrc93VcXE6vluh66Pf8iH5QSfYPE5Ns1qQE
 spZMfhxPTgEOpAZeST/dzQre1HuuBPQ2AZC+0LlYQGl6eiqsfAqrOcqsWnCy9Ujev8oDOs/c8
 aLtpRJfYq/hOcJIAzklo9zq4a1EjitpPbHdJ598fwiV/DMkWZ33X4QUYhYHD8WPVTOqL+r+7W
 Wx3y9NI54a8ZEwLeJg8FTDmr1mr0W7s3qey2yzkNlV8QkrWQw9Ai9qCzSZsJ8UwFxjAzSIzvY
 a2rRz1XtbBWkhOkGW5B4Dm0/5QzfmndiZixpSgItU4BGBLeJSo18S71+qLrnC0ntmzgCQ9YpC
 sKfbVoqqpHeybBbduHYUD2njQJn9FPLyehIzCtZDwthH/psRRKzmcVtg6M/Nzt69+g21YHH70
 kZpVUVcd68v9ROt4LtSEVUZ2z3kfXrevgq4ST3YWQswAEZJqSrT7s5uAOB9ceFO4ykhvHSzAE
 pMaw+rO4W0QtzBikly1ZMMNntPJjlul3cK23FDnBxXIq0LmaqJLs+/wpT+7SoH1LRNkytKPHJ
 dwy6j1qHm3Qh7ECWTGQIXeTz1c4MuSkk5vjEhng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are stray Unicode quotation marks (U+201C	DOUBLE TURNED COMMA
QUOTATION MARK) in the file. Remove them, as they don't serve a purpose.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/mfd/ab8500.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentat=
ion/devicetree/bindings/mfd/ab8500.txt
index 5c6eabeed3413..d2a6e835c2575 100644
=2D-- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -31,8 +31,8 @@ ab8500-btemp		 :			: vtvout       : Battery Temperature
 			 : BAT_CTRL_INDB        :              : Battery Removal Indicator
 			 : BTEMP_LOW            :              : Btemp < BtempLow, if battery =
temperature is lower than -10=C2=B0C
 			 : BTEMP_LOW_MEDIUM     :              : BtempLow < Btemp < BtempMediu=
m,if battery temperature is between -10 and 0=C2=B0C
-			 : BTEMP_MEDIUM_HIGH    :	       : BtempMedium < Btemp < BtempHigh,if =
battery temperature is between 0=C2=B0C and=E2=80=9CMaxTemp
-			 : BTEMP_HIGH           :              : Btemp > BtempHigh, if battery=
 temperature is higher than =E2=80=9CMaxTemp
+			 : BTEMP_MEDIUM_HIGH    :	       : BtempMedium < Btemp < BtempHigh,if =
battery temperature is between 0=C2=B0C and MaxTemp
+			 : BTEMP_HIGH           :              : Btemp > BtempHigh, if battery=
 temperature is higher than MaxTemp
 ab8500-charger		 :			: vddadc       : Charger interface
 			 : MAIN_CH_UNPLUG_DET	:	       : main charger unplug detection managem=
ent (not in 8505)
 			 : MAIN_CHARGE_PLUG_DET	:	       : main charger plug detection managem=
ent (not in 8505)
=2D-
2.28.0

