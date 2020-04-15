Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281DDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F12020784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441432AbgDOSUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:20:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:32355 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441375AbgDOSTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
IronPort-SDR: WwyccE4QvVkAR1VelEovus5aThHjGsdcxEaPFiyG9kajSKh+2ee9jsRODr8qVjwv97Ptz9eaVt
 nwiILlYcRQKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 11:19:48 -0700
IronPort-SDR: n+XuIFVH0I8zD1eGMSJvmpb2pD26TdunC5YJfZP8Yn4vHYEa/iRs+QQHt3CV1qvTpG/nZbHcqR
 RxP8T0x9r6vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="454016835"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 11:19:48 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 11:19:48 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.39]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 11:19:48 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     x86 <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Thread-Topic: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Thread-Index: AQHWEwtD/L1uEGEe4ki2sOCfiE22MKh6fgOg
Date:   Wed, 15 Apr 2020 18:19:47 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5E6485@ORSMSX115.amr.corp.intel.com>
References: <20200214222720.13168-4-tony.luck@intel.com>
 <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
In-Reply-To: <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tY2UuaCBiL2FyY2gveDg2
L2luY2x1ZGUvdWFwaS9hc20vbWNlLmgNCj4gaW5kZXggOTU1YzJhMi4uNWI1OWQ4MCAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tY2UuaA0KPiArKysgYi9hcmNoL3g4
Ni9pbmNsdWRlL3VhcGkvYXNtL21jZS5oDQo+IEBAIC0zNSw2ICszNSw3IEBAIHN0cnVjdCBtY2Ug
ew0KPiAJX191NjQgaXBpZDsJCS8qIE1DQV9JUElEIE1TUjogb25seSB2YWxpZCBvbiBTTUNBIHN5
c3RlbXMgKi8NCj4gCV9fdTY0IHBwaW47CQkvKiBQcm90ZWN0ZWQgUHJvY2Vzc29yIEludmVudG9y
eSBOdW1iZXIgKi8NCj4gCV9fdTMyIG1pY3JvY29kZTsJLyogTWljcm9jb2RlIHJldmlzaW9uICov
DQo+ICsJX191NjQga2ZsYWdzOwkJLyogSW50ZXJuYWwga2VybmVsIHVzZS4gU2VlIGJlbG93ICov
DQogPiB9Ow0KIA0KTWlub3Igbml0LiBZb3UgbW92ZWQgdGhlICNkZWZpbmVzIGZvciB0aGUga2Zs
YWdzIGJpdHMgdG8gaW50ZXJuYWwuaCAod2hpY2gNCndhcyBhIGdvb2QgdGhpbmcpLCBidXQgbGVm
dCB0aGUgIlNlZSBiZWxvdyIgY29tbWVudCBoZXJlLg0KDQotVG9ueQ0K
