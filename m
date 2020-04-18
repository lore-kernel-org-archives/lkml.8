Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BCA214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDRBia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:38:30 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:52580 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDRBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:38:29 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 21:38:29 EDT
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 49E441A1744;
        Sat, 18 Apr 2020 09:32:54 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ALcAggApCIauiL91uBghEaoS.3.1587173574288.Hmail.bernard@vivo.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0ga21hbGxvY19pbmRleCBvcHRpbWl6YXRpb24oYWRkIGttYWxsb2MgbWF4IHNpemUgY2hlY2sp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <alpine.DEB.2.21.2004171556170.29874@www.lameter.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 18 Apr 2020 09:32:54 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Sat, 18 Apr 2020 09:32:54 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVOS0JLS0tIS0pITUpLQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSUNDTkxCT0hIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Nxg6HBw6CzgyGg4SN0JKDjkcEz4aFChVSFVKTkNMSkxITkxNSENOVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT09NSjcG
X-HM-Tid: 0a718aeac6a493b4kuws49e441a1744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBDaHJpc3RvcGhlciBMYW1ldGVyIDxjbEBsaW51eC5jb20+CkRhdGU6IDIwMjAtMDQt
MTcgMjM6NTk6MDAKVG86ICBCZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+CkNjOiAgUGVr
a2EgRW5iZXJnIDxwZW5iZXJnQGtlcm5lbC5vcmc+LERhdmlkIFJpZW50amVzIDxyaWVudGplc0Bn
b29nbGUuY29tPixKb29uc29vIEtpbSA8aWFtam9vbnNvby5raW1AbGdlLmNvbT4sQW5kcmV3IE1v
cnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4sbGludXgtbW1Aa3ZhY2sub3JnLGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsa2VybmVsQHZpdm8uY29tClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGttYWxsb2NfaW5kZXggb3B0aW1pemF0aW9uKGFkZCBrbWFsbG9jIG1heCBzaXplIGNoZWNr
KT5PbiBGcmksIDE3IEFwciAyMDIwLCBCZXJuYXJkIFpoYW8gd3JvdGU6Cj4KPj4ga21hbGxvYyBz
aXplIHNob3VsZCBuZXZlciBleGNlZWQgS01BTExPQ19NQVhfU0laRS4KPj4ga21hbGxvY19pbmRl
eCByZWFsaXNlIGlmIHNpemUgaXMgZXhjZWVkIEtNQUxMT0NfTUFYX1NJWkUsIGUuZyA2NE0sCj4+
IGttYWxsb2NfaW5kZXgganVzdCByZXR1cm4gaW5kZXggMjYsIGJ1dCBuZXZlciBjaGVjayB3aXRo
IE9TYHMgbWF4Cj4+IGttYWxsb2MgY29uZmlnIEtNQUxMT0NfTUFYX1NJWkUuIFRoaXMgaW5kZXhg
cyBrbWFsbG9jIGNhY2hlcyBtYXliZQo+PiBub3QgY3JlYXRlIGluIGZ1bmN0aW9uIGNyZWF0ZV9r
bWFsbG9jX2NhY2hlcy4KPj4gV2UgY2FuIHRocm93IGFuIHdhcm5pbmdpbmZvIGluIGttYWxsb2Mg
YXQgdGhlIGJlZ2lubmluZywgaW5zdGVhZCBvZgo+PiBiZWluZyBndWFyYW50ZWVkIGJ5IHRoZSBi
dWRkeSBhbGxvYyBiZWhpbmQuCj4KPmttYWxsb2NfaW5kZXgoMCBhbHJlYWR5IGJ1Z3MgaWYgdGhl
IGFsbG9jYXRpb24gaXMgbW9yZSB0aGFuIDY0TQo+Cj4KPi4uLgo+Cj4gICBpZiAoc2l6ZSA8PSAg
NjQgKiAxMDI0ICogMTAyNCkgcmV0dXJuIDI2Owo+ICAgICAgICBCVUcoKTsKPgo+Cj5Zb3UgY291
bGQgbW9kaWZ5IHRoYXQgdG8gY2hlY2sgZm9yIEtNQUxMT0NfTUFYX1NJWkUgd2l0aCBzb21lIG1v
cmUKPmNvbmRpdGlvbmFscyBidXQgdGhlbiBrbWFsbG9jX2luZGV4KSBpcyB3cml0dGVuIHNvIHRo
YXQgdGhlIGNvbXBpbGVyIGdldHMKPmNvbnN0YW50IGZvbGRpbmcgcmlnaHQuCj4KPklmIHlvdSBo
YXZlIGEgcGF0Y2ggbGlrZSB0aGF0IHRoZW4gcGxlYXNlIHZlcmlmeSB0aGF0IGFsbCBjIGNvbXBp
bGVycyBpbgo+dXNlIHBlcmZvcm0gY29ycmVjdCBjb25zdGFudCBmb2xkaW5nIGFuZCBkbyBub3Qg
YWRkIHVubmVjZXNzYXJ5IGNvZGUuCj4KPgoKU29ycnkgZm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5n
LgpXaGF0IEkgbWVhbnQgd2FzIHRoYXQgdGhlIOKAnGlm4oCdaW4ga21hbGxvY19pbmRleCBzaG91
bGQgYmUgY29uc2lzdGVudCAKd2l0aCBLTUFMTE9DX01BWF9TSVpFLiBGb3IgZXhhbXBsZSwgaWYg
dGhlIE1BWF9aT05FT1JERVIgY29uZmlndXJlZCAKYnkgdGhlIGtlcm5lbCBpcyAxMSwgd2hpY2gg
aXMgNE0sIHRoZW4gc2l6ZSA+NE0gc2hvdWxkIHRyaWdnZXIgQlVHKCkuIElmIHRoZSAKY29uZmln
dXJhdGlvbiBpcyBzbWFsbGVyLCBlLmcgTUFYX1pPTkVPUkRFUiBpcyA5LCAxTSwgdGhlbiB0aGUg
c2l6ZSA+IDFNIApzaG91bGQgYmUgQlVHLiAKQnV0IHRoZSBjdXJyZW50IGNvZGUgaXMgbm90LCBr
bWFsbG9jX2luZGV4IHdpbGwgb25seSBiZSBCVUcoKSB3aGVuIGl0IGV4Y2VlZHMgNjRNLgoKCg0K
DQo=
