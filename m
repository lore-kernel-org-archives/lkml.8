Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D649C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F581208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="CVesOMH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBTNxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:53:24 -0500
Received: from m13-14.163.com ([220.181.13.14]:26039 "EHLO m13-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgBTNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ov3dT
        EDft4sBKwcLEyBErDye1Kz7z5ZfrfsnZyDbnhg=; b=CVesOMH4mZ/ktKcVFSb1F
        Q5sKXdDzudH3PsQg9Mk/uO3E+OgXwUvpcDtQAL95Qu/ob8Ej4q01/Xvcv6BJvQuy
        jmYPBg1KCqvNWlpqKX2qCNPo7vGCiz4PvyR9tW+8sjWR/kJZCLpa8/HCYA0JNoMx
        c/8NzhINdPWSHeTWmGG4As=
Received: from jasoncyx$163.com ( [117.175.140.135] ) by
 ajax-webmail-wmsvr14 (Coremail) ; Thu, 20 Feb 2020 21:53:18 +0800 (CST)
X-Originating-IP: [117.175.140.135]
Date:   Thu, 20 Feb 2020 21:53:18 +0800 (CST)
From:   =?GBK?B?s8Lfruf0?= <jasoncyx@163.com>
To:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org
Subject: [Ask for Help]LBR usage in kernel
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3dad7270.821a.17062dfcb99.Coremail.jasoncyx@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DsGowADX3tZPj05eWT+OAQ--.36887W
X-CM-SenderInfo: pmdv00xf10qiywtou0bp/xtbBSQDP91aD56fEkwABsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZXhwZXJ0cywKICAgIFdlIHdhbnQgdG8gdHJ5IHRvIHJldHJlaXZlIGNhbGxjaGFpbnMgb2Yg
c29tZSBwZXJmIGV2ZW50cyBmcm9tIExCUiByYXRoZXIgdGhhbiBmcmFtZSBzdGFja3MsIGFzIHRo
ZSBpbmZvcm1hdGlvbiBpbiBmcmFtZSBzdGFja3Mgd291bGQgYmUgb3B0aW1pemVkIGJ5IGNvbXBp
bGVyLiBBZnRlciBpbnZlc3RpZ2F0aW5nIHRoZSB1c2FnZSBvZiBMQlIgaW4ga2VybmVsLCB3ZSBm
b3VuZCB0aGF0IExCUiBjYW4gb25seSBvcGVyYXRlZCB2aWEgSW50ZWwgUE1VLCB0aGF0IG1lYW5z
IGZvciBub3cgb25seSBjYWxsY2hhaW5zIG9mIGhhcmR3YXJlIGV2ZW50cyBjYW4gYmUgcmV0cmll
dmVkIGZyb20gTEJSLiBJcyB0aGF0IGNvcnJlY3Q/IAogICAgSWYgeWVzLCBJIHdvbmRlciBpZiBj
YWxsY2hhaW5zIG9mIG90aGVyIHBlcmYgZXZlbnRzKGVnLiB0cmFjZXBvaW50LCBzb2Z0d2FyZSBl
dmVudHMpIGNhbiBiZSByZXRyaWV2ZWQgZnJvbSBMQlI/IE9yIG9ubHkgY2FsbGNoYWlucyBvZiBl
dmVudHMgb24gUE1VIGNhbiBiZSByZXRyaWV2ZWQgZnJvbSBMQlIgYXMgdGhlcmUgYXJlIHNvbWUg
aGFyZHdhcmUgcmVzdHJpY3Rpb25zPwoKVGhhbmtzIGZvciBhbnkgaGVscCB5b3UgY2FuIG9mZmVy
IQoKQmVzdCBSZWdhcmRzLApZaXhpIENoZW4K
