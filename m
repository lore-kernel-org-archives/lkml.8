Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72BA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="AX/QIrgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGMFpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:45:39 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:16159 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgGMFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1594619135; x=1626155135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7cW/YOJXUx2PIiwmm/PI3I7DknzDgEvfBng6cd6jKWw=;
  b=AX/QIrgikYaHJFxASCxcx3RtmqioW7TzAu6aksq3JWtOCpsoSkQcN8o8
   qfQ5cTBAwCvqWUMSplukHH7fiSDsh/P4OLRnACD/T5vimcgJtFNxiHOgl
   7EVgXca5xtqO+IjfPezqe7pn/yd7KsQNtMZsmBPgq89VPekEyuBv3TyoK
   hMvSPYbHDuF7DPaTScM3P/Jcc98MpEESbH0ec5575pcr+U5vpRzs8VfB1
   z2NxEh3A7JJr21z/hHhNDjhYZowbEt7Hd3cBQsEeRxybWUIeKqtjpbjIu
   DCe5Tqz3M1qCY7pgjDbjow69XGSL2zO+YvP2KdH+rGqq0C2MZafTO9TYT
   Q==;
IronPort-SDR: bg80K5TqI9tLYD0QW4HMUH6kvelFBXiPFM1O6aWKx6bBG82n0PhEavia4qaf2WnjZdYx9wsFGg
 fEf9KYKxNT0Q==
X-IronPort-AV: E=Sophos;i="5.75,346,1589234400"; 
   d="scan'208";a="64193337"
From:   Denis Osterland-Heim <denis.osterland@diehl.com>
To:     "dmurphy@ti.com" <dmurphy@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis Osterland-Heim <denis.osterland@diehl.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v6 2/2] leds: pwm: add reference to common leds for
 default-state
Thread-Topic: [PATCH v6 2/2] leds: pwm: add reference to common leds for
 default-state
Thread-Index: AQHWWNjSvxKdnghAx02VQ0imS9FJCQ==
Date:   Mon, 13 Jul 2020 05:45:31 +0000
Message-ID: <20200713054259.7608-3-Denis.Osterland@diehl.com>
References: <20200713054259.7608-1-Denis.Osterland@diehl.com>
In-Reply-To: <20200713054259.7608-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc9DxUHFKa5QuXnUaA65Gx6zvbScgxME0GmNfjkqzTgl2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default-state is now supported for PWM leds.

Signed-off-by: Denis Osterland-Heim <Denis.Osterland@diehl.com>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/leds/leds-pwm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Docume=
ntation/devicetree/bindings/leds/leds-pwm.txt
index 6c6583c35f2f..d0f489680594 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.txt
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.txt
@@ -19,6 +19,8 @@ LED sub-node properties:
   see Documentation/devicetree/bindings/leds/common.txt
 - linux,default-trigger :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
+- default-state : (optional)
+  see Documentation/devicetree/bindings/leds/common.yaml
=20
 Example:
=20
--=20
2.27.0



Diehl Connectivity Solutions GmbH
Gesch=E4ftsf=FChrung: Horst Leonberger
Sitz der Gesellschaft: N=FCrnberg - Registergericht: Amtsgericht
N=FCrnberg: HRB 32315
_________________________________________________________________________=
__________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-M=
ail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhal=
ten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung=
 und/oder Publikation dieser E-Mail ist strengstens untersagt.
- Informationen zum Datenschutz, insbesondere zu Ihren Rechten, erhalten =
Sie unter https://www.diehl.com/group/de/transparenz-und-informationspfli=
chten/

The contents of the above mentioned e-mail is not legally binding. This e=
-mail contains confidential and/or legally protected information. Please =
inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, dis=
closure, alteration, distribution and/or publication of this e-mail is st=
rictly prohibited.=20
- For general information on data protection and your respective rights p=
lease visit https://www.diehl.com/group/en/transparency-and-information-o=
bligations/
