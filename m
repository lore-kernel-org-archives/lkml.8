Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4615D206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bmw.de header.i=@bmw.de header.b="akxE4hW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJHp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:45:26 -0400
Received: from esa8.hc324-48.eu.iphmx.com ([207.54.65.242]:15547 "EHLO
        esa8.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgGJHpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:45:25 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 03:45:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1594367125; x=1625903125;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4anTFowj6nyOOCc6Fyupfke88Hd9RoAkZP80jASBHNQ=;
  b=akxE4hW7ul7BT9IhOyjxjU5Vrc2ElmTFwOpcYnPwmUy2qEtZk0EaUJU9
   1rNgtiujAL2TjT0Sw0SR9WCIT2s+Cm9rpI+SNj6OEuTmD9VpTAlZlJKre
   5lg+57pmjsMWwuqb8ugMRgEkdueIqrX9seL1EMHklp9n+O6/CK/wHxcZb
   c=;
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa8.hc324-48.eu.iphmx.com with ESMTP/TLS; 10 Jul 2020 09:38:17 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw5.muc with ESMTP/TLS;
 10 Jul 2020 09:38:17 +0200
Received: from smucm07l.bmwgroup.net (HELO smucm07l.europe.bmw.corp) ([160.48.96.36])
 by esabb1.muc with ESMTP/TLS; 10 Jul 2020 09:38:17 +0200
Received: from smucm07j.europe.bmw.corp (160.48.96.34) by smucm07l.europe.bmw.corp
 (160.48.96.36) with Microsoft SMTP Server (TLS;
 Fri, 10 Jul 2020 09:38:16 +0200
Received: from smucm07j.europe.bmw.corp ([160.48.96.34]) by
 smucm07j.europe.bmw.corp ([160.48.96.34]) with mapi id 15.00.1497.006; Fri,
 10 Jul 2020 09:38:17 +0200
From:   <Lukas.Bulwahn@bmw.de>
To:     <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-safety@lists.elisa.tech>
CC:     <kstewart@linuxfoundation.org>
Subject: Re: [ANNOUNCE][CFP] Kernel Dependability & Assurance Micro Conference
 - LPC 2020
Thread-Topic: [ANNOUNCE][CFP] Kernel Dependability & Assurance Micro
 Conference - LPC 2020
Thread-Index: AdZWjRJsi0MIvBmIRC2BlTf9pwPmsQ==
Date:   Fri, 10 Jul 2020 07:38:17 +0000
Message-ID: <ffa8e704c3794d6b932b73cba37381d2@smucm07j.europe.bmw.corp>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm9ib2R5IHJlYWxseSBzdWJzY3JpYmVkIHRvIGxpbnV4LXNhZmV0eUBsaXN0cy5lbGlzYS50ZWNo
Lg0KDQpJIGd1ZXNzIHlvdSBuZWVkIHRvIHNlbmQgdGhhdCB0byBkZXZlbEBsaXN0cy5lbGlzYS50
ZWNoLg0KDQpMdWthcw0KDQo=
