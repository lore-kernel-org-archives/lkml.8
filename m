Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B9BC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1FC206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgCOEGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:06:35 -0400
Received: from m176148.mail.qiye.163.com ([59.111.176.148]:57439 "EHLO
        m176148.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCOEGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:06:35 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 00:06:34 EDT
Received: from vivo.com (wm-8.qy.internal [127.0.0.1])
        by m176148.mail.qiye.163.com (Hmail) with ESMTP id 1403C1A3D78;
        Sun, 15 Mar 2020 12:01:19 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AOoADQCXCJCLyVN7qh-tYqrl.1.1584244879067.Hmail.hankecai@vivo.com>
To:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, kernel@vivo.com
Subject: =?UTF-8?B?W1BBVENIXSBhcm02NDogZml4IHNwZWxsaW5nIG1pc3Rha2UgImNhIG5vdCIgLT4gImNhbm5vdCI=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
MIME-Version: 1.0
Received: from hankecai@vivo.com( [58.251.74.227) ] by ajax-webmail ( [127.0.0.1] ) ; Sun, 15 Mar 2020 12:01:19 +0800 (GMT+08:00)
From:   =?UTF-8?B?6Z+p56eR5omN?= <hankecai@vivo.com>
Date:   Sun, 15 Mar 2020 12:01:19 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVOS0xCQkJDQkxLS0hKTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo0FDo*KjgjODE4NwItNUwKE1YP
        IgoJF1VKVUpOQ09JT09DTEJKSEJVMxYaEhdVExoVEB4YGhI7DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        TkpVTE9VSUlMWVdZCAFZQUlNSE83Bg++
X-HM-Tid: 0a70dc5a6ef29394kuws1403c1a3d78
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIHRoZSBjb21tZW50LCBGaXggaXQuCgpTaWdu
ZWQtb2ZmLWJ5OiBoYW5rZWNhaSA8aGFua2VjYWlAYmJrdGVsLmNvbT4KLS0tCiBhcmNoL2FybTY0
L2xpYi9zdHJjbXAuUyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbGliL3N0cmNtcC5TIGIvYXJjaC9h
cm02NC9saWIvc3RyY21wLlMKaW5kZXggNDc2NzU0MGQxYjk0Li40ZTc5NTY2NzI2YzggMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtNjQvbGliL3N0cmNtcC5TCisrKyBiL2FyY2gvYXJtNjQvbGliL3N0cmNt
cC5TCkBAIC0xODYsNyArMTg2LDcgQEAgQ1BVX0xFKCByZXYJZGF0YTIsIGRhdGEyICkKIAkqIGFz
IGNhcnJ5LXByb3BhZ2F0aW9uIGNhbiBjb3JydXB0IHRoZSB1cHBlciBiaXRzIGlmIHRoZSB0cmFp
bGluZwogCSogYnl0ZXMgaW4gdGhlIHN0cmluZyBjb250YWluIDB4MDEuCiAJKiBIb3dldmVyLCBp
ZiB0aGVyZSBpcyBubyBOVUwgYnl0ZSBpbiB0aGUgZHdvcmQsIHdlIGNhbiBnZW5lcmF0ZQotCSog
dGhlIHJlc3VsdCBkaXJlY3RseS4gIFdlIGNhIG5vdCBqdXN0IHN1YnRyYWN0IHRoZSBieXRlcyBh
cyB0aGUKKwkqIHRoZSByZXN1bHQgZGlyZWN0bHkuICBXZSBjYW5ub3QganVzdCBzdWJ0cmFjdCB0
aGUgYnl0ZXMgYXMgdGhlCiAJKiBNU0IgbWlnaHQgYmUgc2lnbmlmaWNhbnQuCiAJKi8KIENQVV9C
RSggY2JuegloYXNfbnVsLCAxZiApCi0tIAoyLjIxLjAKCg0KDQo=
