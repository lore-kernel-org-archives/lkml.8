Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D4AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3620753
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="Y5HDBaZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgDUNJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:09:50 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:14126 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgDUNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1587474585; x=1619010585;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dNouq8P4h83qrFsJ0OVMkP2Kk0i4yZxCNLawG9px0j0=;
  b=Y5HDBaZXYKmzqlbOu0zEG9EV1vJZNcnxlDjlok/6JiZP0PnIj1ylx9ra
   krfEMel5jsnWvKJ8YkYQlBv78NLprZ+bsOvC1dbNVU+DAT0Z9yJg+rD2b
   ahSgXdQx9RQfwGG2GTEBsiaURcLKeu8NvguPbr7ZspAm+HD0ZJtJkmDxN
   Zw3PE6bMpGzxAdcrpmccs0vLyvS302hybw0l5uWeIlxXR0Z3yyN+735ki
   vnYHsD7Pt1eC5VfJXlDUPGthM24kfj6gXO9k9otBp3e0H2yMOrzPqHivR
   L4zqG5lAj+cGAQliSuTmy+aRiL9FWhXhR2dQzmyJWQluooIdVgyEHOt17
   g==;
IronPort-SDR: SGtB/O3rNBjn3SkNaQ2AkqgvJ7yWD80hr9y/2Ctgsyv2YCqB8gKWV152A+/GODfG8vttwIxe0E
 R0urYKm6AWHA==
From:   Denis Osterland-Heim <denis.osterland@diehl.com>
To:     "dmurphy@ti.com" <dmurphy@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/3] leds: pwm: add support for default-state device
Thread-Topic: [PATCH v5 0/3] leds: pwm: add support for default-state device
Thread-Index: AQHWF94OKub50N+FUUWHYPVgR3DQ1w==
Date:   Tue, 21 Apr 2020 13:09:14 +0000
Message-ID: <20200421130644.16059-1-Denis.Osterland@diehl.com>
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
X-GBS-PROC: 415AWy8o668fDtCxszluzxR0EV1g3oFecZUMcrkyjQ16UfvnX2kr9ZyGQgsST9yP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 -> v5: tested the rebase to v5.7-rc1 based for-next

 .../devicetree/bindings/leds/leds-pwm.txt          |  2 +
 drivers/leds/leds-pwm.c                            | 60 ++++++++++++++++=
+++---
 2 files changed, 56 insertions(+), 6 deletions(-)

Message-ID: <20200321081321.15614-1-Denis.Osterland@diehl.com>




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
