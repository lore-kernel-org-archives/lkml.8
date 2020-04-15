Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7896206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MVQTeuUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505520AbgDOGEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:04:08 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:15770 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505511AbgDOGEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586930645; x=1618466645;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=vo7FtSAbHTkgsQBUAl2b+FgTFbTWEI+5B2iTKhgmGaE=;
  b=MVQTeuUdfbjLkY0O03wvpxxkEOzPFDN3M4JOL6Jq4AqTzLqCnM0Fm5TT
   VN7RHAYZVSQkXis19dd79wc/NqrswX/3m3QNJhVhV4hP25CfvH7NHVrqC
   LhqXQl+LoeLDvRFCyJyeO6WNRQcO//rKtwPlmt0orr7TjnEuAV2FkHleQ
   A=;
IronPort-SDR: Aa07IlyWRlsWXio1w2M42d2bjscJIdNwIUDSbEIw/dMx/ln7nzRNggZwWmP3uve9KElggHjLNl
 LPS3Csq7qoUA==
X-IronPort-AV: E=Sophos;i="5.72,385,1580774400"; 
   d="scan'208";a="38536260"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 15 Apr 2020 06:04:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 03F8DA1C7A;
        Wed, 15 Apr 2020 06:04:02 +0000 (UTC)
Received: from EX13D21UWB004.ant.amazon.com (10.43.161.221) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Apr 2020 06:04:02 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13D21UWB004.ant.amazon.com (10.43.161.221) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Apr 2020 06:04:02 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.006;
 Wed, 15 Apr 2020 06:04:02 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>
Subject: SPCR and default serial port
Thread-Topic: SPCR and default serial port
Thread-Index: AQHWEuup9z+CZYI400aS50hjuGqC1g==
Date:   Wed, 15 Apr 2020 06:04:02 +0000
Message-ID: <364e0ff5da091ed7faa0232302b6181ac30000de.camel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.52]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F89CA603CC095347924E79173E5820EB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgIQ0KDQpUb2RheSwgYXJtNjQgYWxsb3dzIHRoZSBzZXJpYWwgcG9ydCBzcGVjaWZpZWQgaW4g
QUNQSSBTUENSIHRhYmxlIHRvIGJlDQpzZWxlY3RlZCBhcyBhIGRlZmF1bHQgY29uc29sZSwgYnV0
IHg4NiBkb2Vzbid0IChzZWNvbmQgYXJndW1lbnQgdG8NCmFjcGlfcGFyc2Vfc3BjcikuDQoNCkkg
dW5kZXJzdGFuZCB3aGlsZSB3ZSBtaWdodCBoYXZlIGJlZW4gd29ycmllZCBvZiBicmVha2luZyBl
eGlzdGluZw0Kc2V0dXBzIGJhY2sgdGhlbiBidXQgc2hvdWxkIHdlIHJlLXRoaW5rIHRoaXMsIG1h
eWJlIHZpYSBhIENPTkZJRyBvcHRpb24NCj8NCg0KSXQgbWFrZXMgYSBsb3Qgb2Ygc2Vuc2UgdG8g
aGF2ZSBmaXJtd2FyZSB0ZWxsIHVzIHdoaWNoIG9mIHRoZQ0KcG90ZW50aWFsbHkgbWFueSBzZXJp
YWwgcG9ydCBpbiBhIHN5c3RlbSBpcyBvdXIgYWN0aXZlIGNvbnNvbGUsIGFsb25nDQp3aXRoIGl0
cyBjb25maWd1cmF0aW9uLi4uDQoNClRoaXMgYWxzbyBzaG91bGRuJ3QgY2F1c2UgcHJvYmxlbSBv
biBzeXN0ZW1zIHRoYXQgYWxyZWFkeSBzcGVjaWZ5IGENCmNvbnNvbGUgZXhwbGljaXRseSBvbiB0
aGUgY29tbWFuZCBsaW5lLg0KDQpBbnkgb3BpbmlvbiA/DQoNCkNoZWVycywNCkJlbi4NCg0K
