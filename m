Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65342C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44527221E2
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSmjNsJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHHMoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:44:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48261 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgHHMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596890676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9h9ZRBSgLKwsEPPqnesDzr/SoiUJ6W6mBpiTXRfYxB0=;
        b=OSmjNsJAuQLXYw5RBrUjZdhsLBRLtwKxKgXazQiYco2m5A1P1zGJ1zMi2IPICwlFQ9w3Wr
        ff5GR26VHuWqWQHdU2ES1lVrqeuLMXKo/uMXBpWqzkBcDIVlKYcdXtdIXsmx/CyrDTVvsG
        PdzFzakj8QD08/a9iFXfc96t3yl1XQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-ZWv-xOiUP46XP_ncPtwt4g-1; Sat, 08 Aug 2020 08:44:23 -0400
X-MC-Unique: ZWv-xOiUP46XP_ncPtwt4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F4B1DE0;
        Sat,  8 Aug 2020 12:44:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52ABE610F3;
        Sat,  8 Aug 2020 12:44:16 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 38EBC97520;
        Sat,  8 Aug 2020 12:44:16 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: drivers/virtio/virtio_mem.c:1031 virtio_mem_mb_plug_any_sb() error: uninitialized symbol 'rc'.
Date:   Sat, 8 Aug 2020 08:44:15 -0400 (EDT)
Message-Id: <77F03240-61B0-437C-BBC0-84E081FA92EF@redhat.com>
References: <202008081921.lHEnQxg2%lkp@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
In-Reply-To: <202008081921.lHEnQxg2%lkp@intel.com>
To:     kernel test robot <lkp@intel.com>
Thread-Topic: drivers/virtio/virtio_mem.c:1031 virtio_mem_mb_plug_any_sb() error: uninitialized symbol 'rc'.
Thread-Index: e9uuOeaAqi7HbRn3eCrmMN0t1BeyPA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gQW0gMDguMDguMjAyMCB1bSAxMzozOSBzY2hyaWViIGtlcm5lbCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPjoNCj4gDQo+IO+7v3RyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IG1hc3Rlcg0KPiBoZWFk
OiAgIDQ0OWRjOGM5NzA4OWE2ZTA5ZmIyZGFjNGQ5MmIxYjdhYzBlYjdjMWUNCj4gY29tbWl0OiA1
ZjFmNzliYmM5ZTI2ZmE5NDEyZmE5NTIyZjk1N2JiOGYwMzBjNDQyIHZpcnRpby1tZW06IFBhcmF2
aXJ0dWFsaXplZCBtZW1vcnkgaG90cGx1Zw0KPiBkYXRlOiAgIDkgd2Vla3MgYWdvDQo+IGNvbmZp
ZzogeDg2XzY0LXJhbmRjb25maWctbTAwMS0yMDIwMDgwOCAoYXR0YWNoZWQgYXMgLmNvbmZpZykN
Cj4gY29tcGlsZXI6IGdjYy05IChEZWJpYW4gOS4zLjAtMTUpIDkuMy4wDQo+IA0KPiBJZiB5b3Ug
Zml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQo+
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQoNCldh
cyB0aGVyZSBhIGRlbGF5IGluIHNlbmRpbmcgdGhlc2Ugb3V0PyBUaGUgZml4IGJ5IERhbiBpcyBs
b25nIHVwc3RyZWFtOiAxYzNkNjlhYjUzNDgNCg0KPiBOZXcgc21hdGNoIHdhcm5pbmdzOg0KPiBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmM6MTAzMSB2aXJ0aW9fbWVtX21iX3BsdWdfYW55X3Ni
KCkgZXJyb3I6IHVuaW5pdGlhbGl6ZWQgc3ltYm9sICdyYycuDQo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmM6MTYwNyBjYWxjdWxhdGVf
YmFuZHdpZHRoKCkgd2FybjogRnVuY3Rpb24gdG9vIGhhaXJ5LiAgTm8gbW9yZSBtZXJnZXMuDQo+
IA0KPiBPbGQgc21hdGNoIHdhcm5pbmdzOg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jOjMzODcgYndfY2FsY3MoKSB3YXJuOiBpbmNv
bnNpc3RlbnQgaW5kZW50aW5nDQo+IA0KPiB2aW0gKy9yYyArMTAzMSBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fbWVtLmMNCj4gDQo+ICAgOTc4ICAgIA0KPiAgIDk3OSAgICAvKg0KPiAgIDk4MCAgICAg
KiBUcnkgdG8gcGx1ZyB0aGUgZGVzaXJlZCBudW1iZXIgb2Ygc3ViYmxvY2tzIG9mIGEgbWVtb3J5
IGJsb2NrIHRoYXQNCj4gICA5ODEgICAgICogaXMgYWxyZWFkeSBhZGRlZCB0byBMaW51eC4NCj4g
ICA5ODIgICAgICoNCj4gICA5ODMgICAgICogV2lsbCBtb2RpZnkgdGhlIHN0YXRlIG9mIHRoZSBt
ZW1vcnkgYmxvY2suDQo+ICAgOTg0ICAgICAqDQo+ICAgOTg1ICAgICAqIE5vdGU6IENhbiBmYWls
IGFmdGVyIHNvbWUgc3ViYmxvY2tzIHdlcmUgc3VjY2Vzc2Z1bGx5IHBsdWdnZWQuDQo+ICAgOTg2
ICAgICAqLw0KPiAgIDk4NyAgICBzdGF0aWMgaW50IHZpcnRpb19tZW1fbWJfcGx1Z19hbnlfc2Io
c3RydWN0IHZpcnRpb19tZW0gKnZtLCB1bnNpZ25lZCBsb25nIG1iX2lkLA0KPiAgIDk4OCAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqbmJfc2IsIGJvb2wgb25saW5lKQ0KPiAgIDk4
OSAgICB7DQo+ICAgOTkwICAgICAgICB1bnNpZ25lZCBsb25nIHBmbiwgbnJfcGFnZXM7DQo+ICAg
OTkxICAgICAgICBpbnQgc2JfaWQsIGNvdW50Ow0KPiAgIDk5MiAgICAgICAgaW50IHJjOw0KPiAg
IDk5MyAgICANCj4gICA5OTQgICAgICAgIGlmIChXQVJOX09OX09OQ0UoISpuYl9zYikpDQo+ICAg
OTk1ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgOTk2ICAgIA0KPiAgIDk5NyAgICAg
ICAgd2hpbGUgKCpuYl9zYikgew0KPiAgIDk5OCAgICAgICAgICAgIHNiX2lkID0gdmlydGlvX21l
bV9tYl9maXJzdF91bnBsdWdnZWRfc2Iodm0sIG1iX2lkKTsNCj4gICA5OTkgICAgICAgICAgICBp
ZiAoc2JfaWQgPj0gdm0tPm5iX3NiX3Blcl9tYikNCj4gIDEwMDAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ICAxMDAxICAgICAgICAgICAgY291bnQgPSAxOw0KPiAgMTAwMiAgICAgICAgICAgIHdo
aWxlIChjb3VudCA8ICpuYl9zYiAmJg0KPiAgMTAwMyAgICAgICAgICAgICAgICAgICBzYl9pZCAr
IGNvdW50IDwgdm0tPm5iX3NiX3Blcl9tYiAmJg0KPiAgMTAwNCAgICAgICAgICAgICAgICAgICAh
dmlydGlvX21lbV9tYl90ZXN0X3NiX3BsdWdnZWQodm0sIG1iX2lkLCBzYl9pZCArIGNvdW50LA0K
PiAgMTAwNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxKSkNCj4gIDEwMDYgICAg
ICAgICAgICAgICAgY291bnQrKzsNCj4gIDEwMDcgICAgDQo+ICAxMDA4ICAgICAgICAgICAgcmMg
PSB2aXJ0aW9fbWVtX21iX3BsdWdfc2Iodm0sIG1iX2lkLCBzYl9pZCwgY291bnQpOw0KPiAgMTAw
OSAgICAgICAgICAgIGlmIChyYykNCj4gIDEwMTAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0K
PiAgMTAxMSAgICAgICAgICAgICpuYl9zYiAtPSBjb3VudDsNCj4gIDEwMTIgICAgICAgICAgICBp
ZiAoIW9ubGluZSkNCj4gIDEwMTMgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAxMDE0ICAg
IA0KPiAgMTAxNSAgICAgICAgICAgIC8qIGZha2Utb25saW5lIHRoZSBwYWdlcyBpZiB0aGUgbWVt
b3J5IGJsb2NrIGlzIG9ubGluZSAqLw0KPiAgMTAxNiAgICAgICAgICAgIHBmbiA9IFBGTl9ET1dO
KHZpcnRpb19tZW1fbWJfaWRfdG9fcGh5cyhtYl9pZCkgKw0KPiAgMTAxNyAgICAgICAgICAgICAg
ICAgICAgICAgc2JfaWQgKiB2bS0+c3ViYmxvY2tfc2l6ZSk7DQo+ICAxMDE4ICAgICAgICAgICAg
bnJfcGFnZXMgPSBQRk5fRE9XTihjb3VudCAqIHZtLT5zdWJibG9ja19zaXplKTsNCj4gIDEwMTkg
ICAgICAgICAgICB2aXJ0aW9fbWVtX2Zha2Vfb25saW5lKHBmbiwgbnJfcGFnZXMpOw0KPiAgMTAy
MCAgICAgICAgfQ0KPiAgMTAyMSAgICANCj4gIDEwMjIgICAgICAgIGlmICh2aXJ0aW9fbWVtX21i
X3Rlc3Rfc2JfcGx1Z2dlZCh2bSwgbWJfaWQsIDAsIHZtLT5uYl9zYl9wZXJfbWIpKSB7DQo+ICAx
MDIzICAgICAgICAgICAgaWYgKG9ubGluZSkNCj4gIDEwMjQgICAgICAgICAgICAgICAgdmlydGlv
X21lbV9tYl9zZXRfc3RhdGUodm0sIG1iX2lkLA0KPiAgMTAyNSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBWSVJUSU9fTUVNX01CX1NUQVRFX09OTElORSk7DQo+ICAxMDI2ICAgICAgICAgICAg
ZWxzZQ0KPiAgMTAyNyAgICAgICAgICAgICAgICB2aXJ0aW9fbWVtX21iX3NldF9zdGF0ZSh2bSwg
bWJfaWQsDQo+ICAxMDI4ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19NRU1fTUJf
U1RBVEVfT0ZGTElORSk7DQo+ICAxMDI5ICAgICAgICB9DQo+ICAxMDMwICAgIA0KPj4gMTAzMSAg
ICAgICAgcmV0dXJuIHJjOw0KPiAgMTAzMiAgICB9DQo+ICAxMDMzICAgIA0KPiANCj4gLS0tDQo+
IDAtREFZIENJIEtlcm5lbCBUZXN0IFNlcnZpY2UsIEludGVsIENvcnBvcmF0aW9uDQo+IGh0dHBz
Oi8vbGlzdHMuMDEub3JnL2h5cGVya2l0dHkvbGlzdC9rYnVpbGQtYWxsQGxpc3RzLjAxLm9yZw0K
PiA8LmNvbmZpZy5nej4NCg==

