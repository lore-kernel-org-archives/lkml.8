Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A06C11D15
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1E524673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgBTSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:00:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgBTSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:00:40 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 78581104D1AAA;
        Thu, 20 Feb 2020 10:00:40 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:00:40 -0800 (PST)
Message-Id: <20200220.100040.1301502135805556784.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, glider@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ip6_gre: Distribute switch variables for
 initialization
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200220062307.68986-1-keescook@chromium.org>
References: <20200220062307.68986-1-keescook@chromium.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Feb 2020 10:00:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQpEYXRlOiBXZWQsIDE5IEZl
YiAyMDIwIDIyOjIzOjA3IC0wODAwDQoNCj4gVmFyaWFibGVzIGRlY2xhcmVkIGluIGEgc3dpdGNo
IHN0YXRlbWVudCBiZWZvcmUgYW55IGNhc2Ugc3RhdGVtZW50cw0KPiBjYW5ub3QgYmUgYXV0b21h
dGljYWxseSBpbml0aWFsaXplZCB3aXRoIGNvbXBpbGVyIGluc3RydW1lbnRhdGlvbiAoYXMNCj4g
dGhleSBhcmUgbm90IHBhcnQgb2YgYW55IGV4ZWN1dGlvbiBmbG93KS4gV2l0aCBHQ0MncyBwcm9w
b3NlZCBhdXRvbWF0aWMNCj4gc3RhY2sgdmFyaWFibGUgaW5pdGlhbGl6YXRpb24gZmVhdHVyZSwg
dGhpcyB0cmlnZ2VycyBhIHdhcm5pbmcgKGFuZCB0aGV5DQo+IGRvbid0IGdldCBpbml0aWFsaXpl
ZCkuIENsYW5nJ3MgYXV0b21hdGljIHN0YWNrIHZhcmlhYmxlIGluaXRpYWxpemF0aW9uDQo+ICh2
aWEgQ09ORklHX0lOSVRfU1RBQ0tfQUxMPXkpIGRvZXNuJ3QgdGhyb3cgYSB3YXJuaW5nLCBidXQg
aXQgYWxzbw0KPiBkb2Vzbid0IGluaXRpYWxpemUgc3VjaCB2YXJpYWJsZXNbMV0uIE5vdGUgdGhh
dCB0aGVzZSB3YXJuaW5ncyAob3Igc2lsZW50DQo+IHNraXBwaW5nKSBoYXBwZW4gYmVmb3JlIHRo
ZSBkZWFkLXN0b3JlIGVsaW1pbmF0aW9uIG9wdGltaXphdGlvbiBwaGFzZSwNCj4gc28gZXZlbiB3
aGVuIHRoZSBhdXRvbWF0aWMgaW5pdGlhbGl6YXRpb25zIGFyZSBsYXRlciBlbGlkZWQgaW4gZmF2
b3Igb2YNCj4gZGlyZWN0IGluaXRpYWxpemF0aW9ucywgdGhlIHdhcm5pbmdzIHJlbWFpbi4NCj4g
DQo+IFRvIGF2b2lkIHRoZXNlIHByb2JsZW1zLCBtb3ZlIHN1Y2ggdmFyaWFibGVzIGludG8gdGhl
ICJjYXNlIiB3aGVyZQ0KPiB0aGV5J3JlIHVzZWQgb3IgbGlmdCB0aGVtIHVwIGludG8gdGhlIG1h
aW4gZnVuY3Rpb24gYm9keS4NCj4gDQo+IG5ldC9pcHY2L2lwNl9ncmUuYzogSW4gZnVuY3Rpb24g
oWlwNmdyZV9lcnKiOg0KPiBuZXQvaXB2Ni9pcDZfZ3JlLmM6NDQwOjMyOiB3YXJuaW5nOiBzdGF0
ZW1lbnQgd2lsbCBuZXZlciBiZSBleGVjdXRlZCBbLVdzd2l0Y2gtdW5yZWFjaGFibGVdDQo+ICAg
NDQwIHwgICBzdHJ1Y3QgaXB2Nl90bHZfdG5sX2VuY19saW0gKnRlbDsNCj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+DQo+IA0KPiBuZXQvaXB2Ni9pcDZfdHVubmVs
LmM6IEluIGZ1bmN0aW9uIKFpcDZfdG5sX2VycqI6DQo+IG5ldC9pcHY2L2lwNl90dW5uZWwuYzo1
MjA6MzI6IHdhcm5pbmc6IHN0YXRlbWVudCB3aWxsIG5ldmVyIGJlIGV4ZWN1dGVkIFstV3N3aXRj
aC11bnJlYWNoYWJsZV0NCj4gICA1MjAgfCAgIHN0cnVjdCBpcHY2X3Rsdl90bmxfZW5jX2xpbSAq
dGVsOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn4NCj4gDQo+
IFsxXSBodHRwczovL2J1Z3MubGx2bS5vcmcvc2hvd19idWcuY2dpP2lkPTQ0OTE2DQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCg0KQXBwbGll
ZC4NCg==
