Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886AC433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06E220658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="P7aCLf3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgGOLKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:10:32 -0400
Received: from m1546.mail.126.com ([220.181.15.46]:1088 "EHLO
        m1546.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgGOLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=l+5iM
        3D5BnZ7Ni0vfl5SLJydG/G2uh+bEcSaCcktys4=; b=P7aCLf3QDNRvyuYSKbNhk
        ijQm42qzc2bYSDhSR4CQm0/iNRuBbm2TnirFPzChQAdU5XuA2MckMhBWLRDOxSFs
        cGy3e2aiO7kE2eWxgc9MDFT7blCAekQe4zDuLm0RFC4EckMmmziyaaXslHuchMom
        XO6CNBy4sIdKJNNtAdH7BM=
Received: from zhixu001$126.com ( [209.8.147.252] ) by ajax-webmail-wmsvr46
 (Coremail) ; Wed, 15 Jul 2020 18:38:55 +0800 (CST)
X-Originating-IP: [209.8.147.252]
Date:   Wed, 15 Jul 2020 18:38:55 +0800 (CST)
From:   Zhao <zhixu001@126.com>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Rob Springer" <rspringer@google.com>,
        "Todd Poynor" <toddpoynor@google.com>,
        "Ben Chan" <benchan@chromium.org>, "Richard Yeh" <rcy@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Joe Perches" <joe@perches.com>
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 126com
In-Reply-To: <20200617191002.GP4151@kadam>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200617191002.GP4151@kadam>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <782deb83.5bf6.173520e4cef.Coremail.zhixu001@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LsqowAB3zgXA3A5fkwrRAA--.31047W
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiZwBifF16eYfrGQAAsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMC0wNi0xOCAwMzoxMDowMiwgIkRhbiBDYXJwZW50ZXIiIDxkYW4uY2FycGVudGVyQG9y
YWNsZS5jb20+IHdyb3RlOgo+T24gVGh1LCBKdW4gMTgsIDIwMjAgYXQgMTI6MTE6MjdBTSArMDgw
MCwgWmhpeHUgWmhhbyB3cm90ZToKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9nYXNr
ZXQvZ2Fza2V0X2NvcmUuYyBiL2RyaXZlcnMvc3RhZ2luZy9nYXNrZXQvZ2Fza2V0X2NvcmUuYwo+
PiBpbmRleCA2NzMyNWZiYWY3NjAuLjI4ZGFiMzAyMTgzYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9zdGFnaW5nL2dhc2tldC9nYXNrZXRfY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9n
YXNrZXQvZ2Fza2V0X2NvcmUuYwo+PiBAQCAtMjYxLDYgKzI2MSw3IEBAIHN0YXRpYyBpbnQgZ2Fz
a2V0X21hcF9wY2lfYmFyKHN0cnVjdCBnYXNrZXRfZGV2ICpnYXNrZXRfZGV2LCBpbnQgYmFyX251
bSkKPj4gIAljb25zdCBzdHJ1Y3QgZ2Fza2V0X2RyaXZlcl9kZXNjICpkcml2ZXJfZGVzYyA9Cj4+
ICAJCWludGVybmFsX2Rlc2MtPmRyaXZlcl9kZXNjOwo+PiAgCXVsb25nIGRlc2NfYnl0ZXMgPSBk
cml2ZXJfZGVzYy0+YmFyX2Rlc2NyaXB0aW9uc1tiYXJfbnVtXS5zaXplOwo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xgo+R2V0IHJpZCBvZiB0aGlzIGFzIHdlbGwgKGJlbG93KS4KPgo+PiArCXN0cnVjdCBnYXNrZXRf
YmFyX2RhdGEgKmRhdGE7Cj4+ICAJaW50IHJldDsKPj4gIAo+PiAgCWlmIChkZXNjX2J5dGVzID09
IDApCj4+IEBAIC0yNzAsMzEgKzI3MSwzMiBAQCBzdGF0aWMgaW50IGdhc2tldF9tYXBfcGNpX2Jh
cihzdHJ1Y3QgZ2Fza2V0X2RldiAqZ2Fza2V0X2RldiwgaW50IGJhcl9udW0pCj4+ICAJCS8qIG5v
dCBQQ0k6IHNraXAgdGhpcyBlbnRyeSAqLwo+PiAgCQlyZXR1cm4gMDsKPj4gIAl9Cj4+ICsKPj4g
KwlkYXRhID0gJmdhc2tldF9kZXYtPmJhcl9kYXRhW2Jhcl9udW1dOwo+Cj5JdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gZG8gdGhpcyBpbiB0aGUgZGVjbGFyYXRpb24gYmxvY2sgc28geW91IGNhbiBjaGFu
Z2UKPnRoZSBlYXJsaWVyIHR3byB1c2VzIGluIHRoaXMgZnVuY3Rpb246Cj4KPisJc3RydWN0IGdh
c2tldF9iYXJfZGF0YSAqZGF0YSA9ICZnYXNrZXRfZGV2LT5iYXJfZGF0YVtiYXJfbnVtXTsKPi0J
dWxvbmcgZGVzY19ieXRlcyA9IGRyaXZlcl9kZXNjLT5iYXJfZGVzY3JpcHRpb25zW2Jhcl9udW1d
LnNpemU7Cj4rCXVsb25nIGRlc2NfYnl0ZXMgPSBkYXRhLT5zaXplOwo+Cj4uLi4KPgo+LQlpZiAo
ZHJpdmVyX2Rlc2MtPmJhcl9kZXNjcmlwdGlvbnNbYmFyX251bV0udHlwZSAhPSBQQ0lfQkFSKSB7
Cj4rCWlmIChkYXRhLT50eXBlICE9IFBDSV9CQVIpIHsKPgo+cmVnYXJkcywKPmRhbiBjYXJwZW50
ZXIKClRoaXMgaXNzdWUgaGFzIGJlZW4gcmVzb2x2ZWQgaW4gIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyMDA2MTgxNDAzMjcuR1M0MTUxQGthZGFtLwoKWmhpeHUK
