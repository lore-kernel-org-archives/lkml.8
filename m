Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9752071A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="qZd2diU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgF3CyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:54:02 -0400
Received: from m13108.mail.163.com ([220.181.13.108]:45484 "EHLO
        m13108.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgF3CyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:54:01 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 22:53:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=6gLY3
        mHZi5XRWyoECaoZOioTJl4rydBDxBXDwPYDuY8=; b=qZd2diU3AUDoU5Qr8VADB
        PlDeDfnom4/4n6Re2Pp7UqoftZ+qUy4X/s7enVnRF163DidSO3dGk1MRnbYOxAVT
        zwz0b4oJ+RY8TjxMEnj1qLrsbBz1xdTCUKqLhyPgsnyXxsdl6HuxH0r6KAKlNBBN
        wwKDp9pITY59mlwP9WDIIs=
Received: from sh_def$163.com ( [14.18.249.243] ) by ajax-webmail-wmsvr108
 (Coremail) ; Tue, 30 Jun 2020 10:37:43 +0800 (CST)
X-Originating-IP: [14.18.249.243]
Date:   Tue, 30 Jun 2020 10:37:43 +0800 (CST)
From:   =?GBK?B?y9W71A==?= <sh_def@163.com>
To:     "David Rientjes" <rientjes@google.com>
Cc:     "Mike Rapoport" <rppt@kernel.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re:Re:Re: [PATCH] mm: remove the redundancy code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <alpine.DEB.2.22.394.2006291905000.1118534@chino.kir.corp.google.com>
References: <20200629173047.GA38128@ubuntu>
 <alpine.DEB.2.22.394.2006291149040.1030250@chino.kir.corp.google.com>
 <20200629202429.GG1492837@kernel.org>
 <3f4b9136.1440.17302f60674.Coremail.sh_def@163.com>
 <alpine.DEB.2.22.394.2006291905000.1118534@chino.kir.corp.google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7f0c652d.19a2.17303165991.Coremail.sh_def@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bMGowACnyTB3pfpe0_Y6AA--.44669W
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiOR9TX1XltcgaFQABsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBkaWQgbm90IGZpbmQgYnVnIGhlcmUsIGFuZCBpIHdhcyBqdXN0IGNvbmZ1c2VkIHdoZW4gSSBz
YXcgdGhlIGNvZGUuPGJyLz5UaGFua3MuCkF0IDIwMjAtMDYtMzAgMTA6MDY6NTUsICJEYXZpZCBS
aWVudGplcyIgPHJpZW50amVzQGdvb2dsZS5jb20+IHdyb3RlOgo+T24gVHVlLCAzMCBKdW4gMjAy
MCwgy9W71CB3cm90ZToNCj4NCj4+IEkgYW0gc29ycnkgdGhhdCBpIGRpZCBub3QgY29uc2lkZXIg
dGhlIG1lbW9yeSBob3RwbHVnIGNhc2UsDQo+PiBhbmQgaSB0aGluayB3ZSBzaG91bGQgYWRkIGEg
bmV3IHBhcmFtIHRvIGRpc3Rpbmd1aXNoIHR3byBkaWZmZXJlbnQgY2FzZXMuDQo+PiANCj4NCj5O
byBuZWVkLCB3ZSBjYW4gc2ltcGx5IGNvbnRpbnVlIHNldHRpbmcgem9uZS0+em9uZV9zdGFydF9w
Zm4gdW5sZXNzIHRoZXJlIA0KPmlzIGEgYnVnIHRvIGJlIGZpeGVkIChhbmQsIGlmIHNvLCBwbGVh
c2Ugc2VuZCBhIGJ1ZyByZXBvcnQpLiAgUmVtb3ZpbmcgaXQgDQo+d291bGQgbm90IGltcHJvdmUg
YW55dGhpbmcgYW5kIHdvdWxkIG9ubHkgaW5jcmVhc2Ugcmlzay4NCg==
