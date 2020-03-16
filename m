Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F0DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B90B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="BhYE/0MM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgCPMyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:54:08 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:39081 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730878AbgCPMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1584363245; x=1615899245;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=J/iGnR7YmZY9KTs8LrY/4ZVX7F3aL4si4N4VK/NPNYk=;
  b=BhYE/0MMy7vb9217mvfVnTKKGaVHZCwZUmDovz/A2jFUNrxEiiVraZUJ
   A6ibdCAZSBXIBLiBG50uf42+8i3zqdPEAifvI5Hpfwx13k3abXDHfHOcs
   5KRTeb/tKwFqQpKjOSy/TD3n+E6bm4j2kshsJiqdT3zdfFPsLTMI0+Uu1
   eRUmoCswKGCNso9HYnpLLwcYdYKWcGBvtY8snc944zib4oT8UGWgfTyRy
   /NOL8uXIkTr/vYjWmxTs0pvw7ENQ6nAhCnzo5AQxATK8j1Cy1FU3pnBmq
   k+st57YtOv9R+z+5Fb8wUWPCu+oUrROmlaVYzLIpNI8Wz8NlNwUuxlcxi
   w==;
IronPort-SDR: /ffvDTvBI0g2FnUoyrmfvRA988PHKIEOsmKEKGKDrOt6PCcK5nUr8/hsgcS6FS0CvZqVs20ks1
 dIoehy3CFc4g==
From:   Denis Osterland-Heim <denis.osterland@diehl.com>
To:     "dmurphy@ti.com" <dmurphy@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] leds: pwm: add support for default-state device
Thread-Topic: [PATCH v3 0/3] leds: pwm: add support for default-state device
Thread-Index: AQHV+5H28xMtkJy33E69SJJPDStMgQ==
Date:   Mon, 16 Mar 2020 12:54:00 +0000
Message-ID: <20200316124851.6303-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: PkB65aL1SqtESF35r/jQn8w7kzMrMJ/nFfGPiwdQWaH+CQj/jWPKj2h1ZtogVvvP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
 - s/set/sets/
 - remove leds_pwm.h
 - rebase on atomic PWM API
 - separate patch for devicetree changes
 - PWM default state defines instead of GPIO reuse
 - apply elegant if, else if schema

 .../devicetree/bindings/leds/leds-pwm.txt          |  2 +
 drivers/leds/leds-pwm.c                            | 49 ++++++++++++++++=
++++--
 include/linux/leds_pwm.h                           | 22 ----------
 3 files changed, 48 insertions(+), 25 deletions(-)

Message-Id: 20200310123126.4709-1-Denis.Osterland@diehl.com




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
