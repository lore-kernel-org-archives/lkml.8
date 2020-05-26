Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D489C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5250A207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zvh6RMXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgEZROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:14:35 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52135 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgEZROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590513269; x=1622049269;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p+U5sgQgRH2a90fBzGLnq59NnA4TUSn/4Dnggthl1QU=;
  b=Zvh6RMXrr7s9wOpuwMtUnqUKGkpYXaL2nOBwOzF+jPx7BSpyoQxJuE6U
   jGTKndvzKaG1iqtRtHEeva/sNih3k100pqwZpKpauYmQEO3+9hS0r7w+J
   LekDmXIvkB2kV1Bu3YAEiB3yqwwiN9Tlg777LfwlXNjbsaxVK7cX9gLGN
   Q=;
IronPort-SDR: EBdX58sbqL9s8ihd3qAxGGfSc7neSPvP3Mm1Kv1g2IqiR4AKTeoOacOXUULoWj6vcVhvXxIC4s
 dVs/9F8YzUIQ==
X-IronPort-AV: E=Sophos;i="5.73,437,1583193600"; 
   d="scan'208";a="32376374"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 26 May 2020 17:01:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id A7385A20DF;
        Tue, 26 May 2020 17:01:53 +0000 (UTC)
Received: from EX13D16EUB001.ant.amazon.com (10.43.166.28) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 17:01:52 +0000
Received: from 38f9d34ed3b1.ant.amazon.com (10.43.161.82) by
 EX13D16EUB001.ant.amazon.com (10.43.166.28) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 17:01:44 +0000
Subject: Re: [PATCH v3 02/18] nitro_enclaves: Define the PCI device interface
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        "Alexander Graf" <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Stefan Hajnoczi" <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        "Uwe Dannowski" <uwed@amazon.de>, <kvm@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>
References: <20200525221334.62966-1-andraprs@amazon.com>
 <20200525221334.62966-3-andraprs@amazon.com>
 <20200526064455.GA2580530@kroah.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Message-ID: <bd25183c-3b2d-7671-f699-78988a39a633@amazon.com>
Date:   Tue, 26 May 2020 20:01:36 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526064455.GA2580530@kroah.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D36UWA003.ant.amazon.com (10.43.160.237) To
 EX13D16EUB001.ant.amazon.com (10.43.166.28)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyNi8wNS8yMDIwIDA5OjQ0LCBHcmVnIEtIIHdyb3RlOgo+IE9uIFR1ZSwgTWF5IDI2LCAy
MDIwIGF0IDAxOjEzOjE4QU0gKzAzMDAsIEFuZHJhIFBhcmFzY2hpdiB3cm90ZToKPj4gK3N0cnVj
dCBlbmNsYXZlX2dldF9zbG90X3JlcSB7Cj4+ICsJLyogQ29udGV4dCBJRCAoQ0lEKSBmb3IgdGhl
IGVuY2xhdmUgdnNvY2sgZGV2aWNlLiAqLwo+PiArCXU2NCBlbmNsYXZlX2NpZDsKPj4gK30gX19h
dHRyaWJ1dGVfXyAoKF9fcGFja2VkX18pKTsKPiBDYW4geW91IHJlYWxseSAicGFjayIgYSBzaW5n
bGUgbWVtYmVyIHN0cnVjdHVyZT8KPgo+IEFueXdheSwgd2UgaGF2ZSBiZXR0ZXIgd2F5cyB0byBz
cGVjaWZ5IHRoaXMgaW5zdGVhZCBvZiB0aGUgInJhdyIKPiBfX2F0dHJpYnV0ZV9fIG9wdGlvbi4g
IEJ1dCBmaXJzdCBzZWUgaWYgeW91IHJlYWxseSBuZWVkIGFueSBvZiB0aGVzZSwgYXQKPiBmaXJz
dCBnbGFuY2UsIEkgZG8gbm90IHRoaW5rIHlvdSBkbyBhdCBhbGwsIGFuZCB0aGV5IGNhbiBhbGwg
YmUgcmVtb3ZlZC4KClRoZXJlIGFyZSBhIGNvdXBsZSBvZiBkYXRhIHN0cnVjdHVyZXMgd2l0aCBt
b3JlIHRoYW4gb25lIG1lbWJlciBhbmQgCm11bHRpcGxlIGZpZWxkIHNpemVzLiBBbmQgZm9yIHRo
ZSBvbmVzIHRoYXQgYXJlIG5vdCwgZ2F0aGVyZWQgYXMgCmZlZWRiYWNrIGZyb20gcHJldmlvdXMg
cm91bmRzIG9mIHJldmlldyB0aGF0IHNob3VsZCBjb25zaWRlciBhZGRpbmcgYSAKImZsYWdzIiBm
aWVsZCBpbiB0aGVyZSBmb3IgZnVydGhlciBleHRlbnNpYmlsaXR5LgoKSSBjYW4gbW9kaWZ5IHRv
IGhhdmUgIl9fcGFja2VkIiBpbnN0ZWFkIG9mIHRoZSBhdHRyaWJ1dGUgY2FsbG91dC4KClRoYW5r
cywKQW5kcmEKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciAoUm9tYW5pYSkgUy5SLkwuIHJl
Z2lzdGVyZWQgb2ZmaWNlOiAyN0EgU2YuIExhemFyIFN0cmVldCwgVUJDNSwgZmxvb3IgMiwgSWFz
aSwgSWFzaSBDb3VudHksIDcwMDA0NSwgUm9tYW5pYS4gUmVnaXN0ZXJlZCBpbiBSb21hbmlhLiBS
ZWdpc3RyYXRpb24gbnVtYmVyIEoyMi8yNjIxLzIwMDUuCg==

