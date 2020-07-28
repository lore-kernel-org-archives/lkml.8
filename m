Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABBCC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8543B20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hD9NBGeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgG1GGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:06:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38353 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727840AbgG1GGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:06:17 -0400
X-UUID: 92432d80c5c1495f8494ee613d605977-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=E83uOZs7DyeB7TR4C1odBEb7LAe+3RMTV23poiVNiis=;
        b=hD9NBGeERDNT/0RgLm5PJPVE/yMeq0D+F8sAF1qePLx6EfmdnE9D1JCMlkQ6SO6b/rJ9syRmRu1pUaE4NI08CfZGoTbELoepiGEEMgIeBbwOgTqpqYWtlpAWza4y9yz2yOHVt7GRXUe5HtdfxZIM0MYc/AuLTRyYvp/tzcP0q9c=;
X-UUID: 92432d80c5c1495f8494ee613d605977-20200728
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 349812538; Tue, 28 Jul 2020 14:06:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Jul
 2020 14:06:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 14:06:05 +0800
Message-ID: <1595916343.21478.4.camel@mhfsdcap03>
Subject: Re: [PATCH 10/11] usb: mtu3: clear dual mode of u3port when disable
 device
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Tue, 28 Jul 2020 14:05:43 +0800
In-Reply-To: <e30483ff-e66a-1cba-e166-a1fe590c2f03@gmail.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
         <1595834101-13094-10-git-send-email-chunfeng.yun@mediatek.com>
         <e30483ff-e66a-1cba-e166-a1fe590c2f03@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTI3IGF0IDExOjA3ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMjcuMDcuMjAyMCAxMDoxNCwgQ2h1bmZlbmcgWXVuIHdyb3Rl
Og0KPiANCj4gPiBJZiBub3QgY2xlYXIgdTNwb3J0J3MgZHVhbCBtb2RlIHdoZW4gZGlzYWJsZSBk
ZXZpY2UsIHRoZSBJUA0KPiANCj4gICAgIElmIHdlIGRvbid0IGNsZWFyIC4uLiB3aGVuIGRpc2Fi
bGluZyAuLi4/DQo+IA0KPiA+IHdpbGwgZmFpbCB0byBlbnRlciBzbGVlcCBtb2RlIHdoZW4gc3Vz
cGVuZC4NCk9rLCB0aGFua3MgYSBsb3QNCg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5m
ZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gWy4uLl0NCj4gDQo+IE1CUiwg
U2VyZ2VpDQoNCg==

