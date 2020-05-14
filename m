Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24786C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045A020675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zb+i9c+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgENI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:27:32 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:64495 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgENI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589444851; x=1620980851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7xsqNwaGHpAYSArUjwjrpqw3gf/0fWcjVYiUuC87Wac=;
  b=Zb+i9c+SOBSAxozk6FMT6KlB0WMHcHJIIN83cfPqV+JggQdzqJUycylK
   cGcop39RLOuRdVU7Q2CH+WWt94NPDOYc0/87NQepRRfPXgDKuAsrTj3+3
   us2Bi82xRpz+zY3flZulioNxb6T3kb2MmNHth2rixEgNOeNlagFZg5AYh
   4=;
IronPort-SDR: CGCaPNk8qW+Mgkf3uFa9WXwSHSbvMwIEmtwccSknNUvVfNYKeHDP0E1KpXJK5Ops9vEHP4fWsu
 45HYRnamFd0w==
X-IronPort-AV: E=Sophos;i="5.73,390,1583193600"; 
   d="scan'208";a="43318329"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 May 2020 08:27:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 451821A0AD7;
        Thu, 14 May 2020 08:27:30 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 08:25:39 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 08:25:39 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 14 May 2020 08:25:39 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v6 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Thread-Topic: [PATCH v6 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Thread-Index: AQHWKclA0qirAUKPqUm5zPJyF+/GwA==
Date:   Thu, 14 May 2020 08:25:39 +0000
Message-ID: <7bafa0a7481ce65748d8179e1bbdf3b50144c497.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
         <20200510014803.12190-2-sblbir@amazon.com>
         <87k11g2b6w.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k11g2b6w.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.215]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46122E1A7883464BAC7AC0CFDDCFACAA@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE1OjUzICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiANCj4gQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4gd3JpdGVzOg0KPiA+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9sMWRfZmx1c2guYw0KPiA+IEBAIC0wLDAgKzEsMzYgQEAN
Cj4gDQo+IExhY2tzDQo+IA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQ0KPiANCg0KQWdyZWVkLCBpdCBzaG91bGQgbWF0Y2ggdGhlIGxpY2Vuc2UgaW4gYXJjaC94
ODYva3ZtL3ZteC92bXguYw0KDQpUaGFua3MsDQpCYWxiaXINCg==
