Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF802C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC29420724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVQUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:20:06 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21148 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584893980; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DZhT7QcMsVCckzXZOLRQ3984T1C+38WnkzoXMsU8C45RD6dxECEjDUSktBkPi7ICxZT+ubTRzxrKYK58qgi9NFMKlbMaxjlLszntATqTYcPaASBR41yO2sREOgdQJkjdrB0pHAfGckc5ieOekOdLZcpTZvQOgiBUUSrX4rz7nIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1584893980; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=z7XeL46bn9R30GQpe8zVpwWx3R1YusoTAwb6Rurk8T4=; 
        b=V/V0UvZOL+PZstZfV8rSm0e+AOQtWzRsX/tInw1YtfXhrS1X/V0kc3wR/0xTrmJ0VULTbrDLkWfliB27mLd6MXdHvlvlKrCYk3Hz5PqKKWK9bjuDIN+Se4IFOoNze7z6S3egvKmu/kR6jArLA/O6Wh+XIAZw+pUanXkveqPTOzU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=no-reply@patchew.org;
        dmarc=pass header.from=<no-reply@patchew.org> header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by mx.zohomail.com
        with SMTPS id 15848939779888.568040257689745; Sun, 22 Mar 2020 09:19:37 -0700 (PDT)
In-Reply-To: <1584893097-12317-2-git-send-email-teawater@gmail.com>
Subject: Re: [PATCH for QEMU v2] virtio-balloon: Add option cont-pages to set VIRTIO_BALLOON_VQ_INFLATE_CONT
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <158489397580.31203.13708294319950127355@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From:   no-reply@patchew.org
To:     teawater@gmail.com
Cc:     mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
        mojha@codeaurora.org, pagupta@redhat.com, aquini@redhat.com,
        namit@vmware.com, david@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, teawaterz@linux.alibaba.com,
        teawater@gmail.com
Date:   Sun, 22 Mar 2020 09:19:37 -0700 (PDT)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg0ODkzMDk3LTEyMzE3LTIt
Z2l0LXNlbmQtZW1haWwtdGVhd2F0ZXJAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggZm9yIFFFTVUgdjJdIHZpcnRp
by1iYWxsb29uOiBBZGQgb3B0aW9uIGNvbnQtcGFnZXMgdG8gc2V0IFZJUlRJT19CQUxMT09OX1ZR
X0lORkxBVEVfQ09OVApNZXNzYWdlLWlkOiAxNTg0ODkzMDk3LTEyMzE3LTItZ2l0LXNlbmQtZW1h
aWwtdGVhd2F0ZXJAZ21haWwuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyMDZkMWZkIHZpcnRpby1i
YWxsb29uOiBBZGQgb3B0aW9uIGNvbnQtcGFnZXMgdG8gc2V0IFZJUlRJT19CQUxMT09OX1ZRX0lO
RkxBVEVfQ09OVAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IHRyYWlsaW5nIHdoaXRlc3Bh
Y2UKIzM2OiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWJhbGxvb24uYzo2OToKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFBhcnRpYWxseUJhbGxvb25lZFBhZ2UgKnBicCwgJAoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMTUgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDIwNmQx
ZmQ4NWEyMyAodmlydGlvLWJhbGxvb246IEFkZCBvcHRpb24gY29udC1wYWdlcyB0byBzZXQgVklS
VElPX0JBTExPT05fVlFfSU5GTEFURV9DT05UKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg0ODkz
MDk3LTEyMzE3LTItZ2l0LXNlbmQtZW1haWwtdGVhd2F0ZXJAZ21haWwuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
