Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443DDC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C420754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCUL4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:56:48 -0400
Received: from m177126.mail.qiye.163.com ([123.58.177.126]:23277 "EHLO
        m177126.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:56:47 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2020 07:56:39 EDT
Received: from vivo.com (wm-5 [127.0.0.1])
        by m177126.mail.qiye.163.com (Hmail) with ESMTP id 5D2B718218B;
        Sat, 21 Mar 2020 19:50:17 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APoAZgAaCEiRpKG6PlzreaqE.1.1584791417367.Hmail.hankecai@vivo.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, kernel@vivo.com
Subject: =?UTF-8?B?W1BBVENIXSBydGM6IHBtOHh4eDogY2xlYXIgYWxhcm0gcmVnaXN0ZXIgd2hlbiBhbGFybSBpcyBub3QgZW5hYmxlZA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
MIME-Version: 1.0
Received: from hankecai@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 21 Mar 2020 19:50:17 +0800 (GMT+08:00)
From:   =?UTF-8?B?6Z+p56eR5omN?= <hankecai@vivo.com>
Date:   Sat, 21 Mar 2020 19:50:17 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVNS0lCQkJNQ0xKQk9DSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzorFDohHDoaOD4SKQswPE0rFwEJ
        HhoKPlVKVUpOQ09MQkpPSkxPSU5VMxYaEhdVExoVEB4YGhI7DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        TkpVTE9VSUlNWVdZCAFZQUhKS083Bg++
X-HM-Tid: 0a70fcedf22c6458kurs5d2b718218b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2xlYXIgYWxhcm0gcmVnaXN0ZXIgd2hlbiBhbGFybSBpcyBub3QgZW5hYmxlZCBvdGhlcndpc2Ug
dGhlIGNvbnN1bWVyCm1heSBzdGlsbCBzdGFydCBhbGFybSB0aW1lciBpZiBpdCBmaW5kIHRoZSBh
bGFybSByZWdpc3RlciBpcyBub3QgemVyby4KClNpZ25lZC1vZmYtYnk6IGhhbmtlY2FpIDxoYW5r
ZWNhaUB2aXZvLmNvbT4KLS0tCiBkcml2ZXJzL3J0Yy9ydGMtcG04eHh4LmMgfCAxMSArKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3J0Yy9ydGMtcG04eHh4LmMgYi9kcml2ZXJzL3J0Yy9ydGMtcG04eHh4LmMKaW5kZXggMDdl
YTFiZTNhYmI5Li4zZmE1NDE2YWQ5MGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcnRjL3J0Yy1wbTh4
eHguYworKysgYi9kcml2ZXJzL3J0Yy9ydGMtcG04eHh4LmMKQEAgLTMwMSw2ICszMDEsNyBAQCBz
dGF0aWMgaW50IHBtOHh4eF9ydGNfYWxhcm1faXJxX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHVuc2lnbmVkIGludCBlbmFibGUpCiAJc3RydWN0IHBtOHh4eF9ydGMgKnJ0Y19kZCA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOwogCWNvbnN0IHN0cnVjdCBwbTh4eHhfcnRjX3JlZ3MgKnJlZ3MgPSBy
dGNfZGQtPnJlZ3M7CiAJdW5zaWduZWQgaW50IGN0cmxfcmVnOworCXU4IHZhbHVlW05VTV84X0JJ
VF9SVENfUkVHU10gPSB7MH07CiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmcnRjX2RkLT5jdHJsX3Jl
Z19sb2NrLCBpcnFfZmxhZ3MpOwogCkBAIC0zMTksNiArMzIwLDE2IEBAIHN0YXRpYyBpbnQgcG04
eHh4X3J0Y19hbGFybV9pcnFfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50
IGVuYWJsZSkKIAkJZ290byBydGNfcndfZmFpbDsKIAl9CiAKKwkvKiBDbGVhciBBbGFybSByZWdp
c3RlciAqLworCWlmICghZW5hYmxlKSB7CisJCXJjID0gcmVnbWFwX2J1bGtfd3JpdGUocnRjX2Rk
LT5yZWdtYXAsIHJlZ3MtPmFsYXJtX3J3LCB2YWx1ZSwKKwkJCQlzaXplb2YodmFsdWUpKTsKKwkJ
aWYgKHJjKSB7CisJCQlkZXZfZXJyKGRldiwgIkNsZWFyIFJUQyBBTEFSTSByZWdpc3RlciBmYWls
ZWRcbiIpOworCQkJZ290byBydGNfcndfZmFpbDsKKwkJfQorCX0KKwogcnRjX3J3X2ZhaWw6CiAJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcnRjX2RkLT5jdHJsX3JlZ19sb2NrLCBpcnFfZmxhZ3Mp
OwogCXJldHVybiByYzsKLS0gCjIuMjEuMAoKDQoNCg==
