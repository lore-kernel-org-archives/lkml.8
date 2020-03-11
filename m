Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFCC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1F92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgCKHBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:01:37 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:15446 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:01:37 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 03:01:34 EDT
Received: from vivo.com (wm-5 [127.0.0.1])
        by m177126.mail.qiye.163.com (Hmail) with ESMTP id 2186A182EA3;
        Wed, 11 Mar 2020 14:52:49 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ALsA-QB3CCyH77MiU4gx3arM.1.1583909569099.Hmail.hankecai@vivo.com>
To:     catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com,
        Dave.Martin@arm.com, broonie@kernel.org,
        amurray@thegoodpenguin.co.uk, jeremy.linton@arm.com,
        tglx@linutronix.de
Cc:     trivial@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Subject: =?UTF-8?B?W1BBVENIXSBhcm02NDogcmVtb3ZlIHJlZHVuZGFudCBibGFuayBmb3IgJz0nIG9wZXJhdG9y?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
MIME-Version: 1.0
Received: from hankecai@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 11 Mar 2020 14:52:49 +0800 (GMT+08:00)
From:   =?UTF-8?B?6Z+p56eR5omN?= <hankecai@vivo.com>
Date:   Wed, 11 Mar 2020 14:52:49 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVIQ0xCQkJOSE9NS01CSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo3CDpWKjlIODgCM0xMNhIuTxwD
        SBoJNlVKVUpOQ0hCS0JOTUJOSUhVMxYaEhdVExoVEB4YGhI7DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        TkpVTE9VSUlNWVdZCAFZQUlNQkk3Bg++
X-HM-Tid: 0a70c85e02856458kurs2186a182ea3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmVtb3ZlIHJlZHVuZGFudCBibGFuayBmb3IgJz0nIG9wZXJhdG9yLCBpdCBtYXkgYmUgbW9yZSBl
bGVnYW50LgoKU2lnbmVkLW9mZi1ieTogaGFua2VjYWkgPGhhbmtlY2FpQHZpdm8uY29tPgotLS0K
IGFyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2Vy
bmVsL2NwdWZlYXR1cmUuYyBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwppbmRleCAw
YjY3MTU2MjVjZjYuLmNlNjBkMTAxMmJmYSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwv
Y3B1ZmVhdHVyZS5jCisrKyBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwpAQCAtNTUx
LDcgKzU1MSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbml0X2NwdV9mdHJfcmVnKHUzMiBzeXNf
cmVnLCB1NjQgbmV3KQogCiAJQlVHX09OKCFyZWcpOwogCi0JZm9yIChmdHJwICA9IHJlZy0+ZnRy
X2JpdHM7IGZ0cnAtPndpZHRoOyBmdHJwKyspIHsKKwlmb3IgKGZ0cnAgPSByZWctPmZ0cl9iaXRz
OyBmdHJwLT53aWR0aDsgZnRycCsrKSB7CiAJCXU2NCBmdHJfbWFzayA9IGFybTY0X2Z0cl9tYXNr
KGZ0cnApOwogCQlzNjQgZnRyX25ldyA9IGFybTY0X2Z0cl92YWx1ZShmdHJwLCBuZXcpOwogCi0t
IAoyLjIxLjAKDQoNCg==
