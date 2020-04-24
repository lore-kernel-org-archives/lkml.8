Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B10C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCFE2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDXXxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:53:06 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FEEC09B049;
        Fri, 24 Apr 2020 16:53:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E2DA14F4EEA4;
        Fri, 24 Apr 2020 16:53:05 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:53:04 -0700 (PDT)
Message-Id: <20200424.165304.2022999573149534624.davem@davemloft.net>
To:     gshan@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netanel@amazon.com, akiyano@amazon.com, gtzalik@amazon.com,
        saeedb@amazon.com, zorik@amazon.com
Subject: Re: [PATCH] net/ena: Fix build warning in ena_xdp_set()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200424000146.6188-1-gshan@redhat.com>
References: <20200424000146.6188-1-gshan@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Apr 2020 16:53:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCkRhdGU6IEZyaSwgMjQgQXByIDIw
MjAgMTA6MDE6NDYgKzEwMDANCg0KPiBUaGlzIGZpeGVzIHRoZSBmb2xsb3dpbmcgYnVpbGQgd2Fy
bmluZyBpbiBlbmFfeGRwX3NldCgpDQo+IA0KPiAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9p
bmNsdWRlL25ldC9pbmV0X3NvY2suaDoxOSwNCj4gICAgICAgZnJvbSAuL2luY2x1ZGUvbmV0L2lw
Lmg6MjcsDQo+ICAgICAgIGZyb20gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFf
bmV0ZGV2LmM6NDY6DQo+ICAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX25l
dGRldi5jOiBJbiBmdW5jdGlvbiAgICAgICAgIFwNCj4gICAgoWVuYV94ZHBfc2V0ojogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9uZXRkZXYuYzo1NTc6Njogd2FybmluZzog
ICAgICBcDQo+ICAgIGZvcm1hdCChJWx1oiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlIKFs
b25nIHVuc2lnbmVkIGludKIsIGJ1dCBhcmd1bWVudCA0ICAgICAgXA0KPiAgICBoYXMgdHlwZSCh
aW50oiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ICAgIFstV2Zvcm1hdD1dICJGYWlsZWQgdG8gc2V0IHhkcCBwcm9ncmFtLCB0aGUgY3VycmVu
dCBNVFUgKCVkKSBpcyAgIFwNCj4gICAgbGFyZ2VyIHRoYW4gdGhlIG1heGltdW0gYWxsb3dlZCBN
VFUgKCVsdSkgd2hpbGUgeGRwIGlzIG9uIiwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdhdmluIFNo
YW4gPGdzaGFuQHJlZGhhdC5jb20+DQoNClRoZSB0eXBlIG9mIHRoZSBhcmd1bWVudCBpcyBjb25m
aWd1cmF0aW9uIGRlcGVuZGVudCwgdGhpcyBpcyBiZWNhdXNlDQpzb21ldGltZXMgb25lIG9mIHRo
ZSB0ZXJtcyB0byBkZWZpbmUgRU5BX1hEUF9NQVhfTVRVIGlzIFBBR0VfU0laRSBhbmQNCnNvbWV0
aW1lcyBpdCBpcyBTWl8xNksuICBBbmQgdGhpcyBkZXRlcm1pbmVzIHdoZXRoZXIgaXQgZXZhbHVh
dGVzIHRvDQphIGxvbmcgb3Igbm90Lg0KDQpTbyB5b3VyIHBhdGNoIHdpbGwganVzdCBjYXVzZSB3
YXJuaW5ncyBpbiBvdGhlciBjb25maWd1cmF0aW9ucy4NCg0KQSBiZXR0ZXIgZml4IGlzIHRoZXJl
Zm9yZSBuZWNlc3NhcnkuDQo=
