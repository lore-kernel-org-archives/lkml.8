Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E31920774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hgn0caVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgHKJbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:31:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34590 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728397AbgHKJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:31:10 -0400
X-UUID: 7086c5b2896f4757a1a776ce389d0053-20200811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LWDEjtdpEZqIYB3lBtQtiTu+w5fRLhiQKXt5bfWHeOk=;
        b=hgn0caVL0H9yorhFgwrm9TR6ii6nQFW45cj/ReZcDNUDCVHkN4IJpwoFkRZTYYKlEXCeC3t61efCk0PBpGhNAHPzZehtsqpOgq4t0BkZqjFnAslSVnAb1o7nEFjbDvmGYOByEH6/9IaYLRuj78lgmtH2dViukh9fpbyq8gobDQk=;
X-UUID: 7086c5b2896f4757a1a776ce389d0053-20200811
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 593388462; Tue, 11 Aug 2020 17:31:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Aug 2020 17:31:06 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Aug 2020 17:31:06 +0800
Message-ID: <1597138267.20627.28.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/5] clk: mediatek: Add configurable enable control
 to mtk_pll_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 11 Aug 2020 17:31:07 +0800
In-Reply-To: <CANMq1KDRwwFvR2v6ykpvV6Y72L+Ym+4NcZF0F7wYq2znKy4sqw@mail.gmail.com>
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com>
         <1596012277-8448-5-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KCG1xUan5-=DBZewvTqmUH=p7=nxy0Va=pdYBhAfYhhjQ@mail.gmail.com>
         <1597128205.20627.14.camel@mtksdaap41>
         <CANMq1KDRwwFvR2v6ykpvV6Y72L+Ym+4NcZF0F7wYq2znKy4sqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C318D15809A2BCF17A1D3E5347528148A4B325AC6D742D76ADABC327B94E44312000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTExIGF0IDE1OjI4ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFR1ZSwgQXVnIDExLCAyMDIwIGF0IDI6NDMgUE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gWy4uLl0NCj4gPiA+ID4gKyAgICAgICB3cml0ZWwociwg
cGxsLT5lbl9hZGRyKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICByID0gcmVhZGwocGxsLT5w
d3JfYWRkcikgfCBDT04wX0lTT19FTjsNCj4gPiA+ID4gICAgICAgICB3cml0ZWwociwgcGxsLT5w
d3JfYWRkcik7DQo+ID4gPiA+IEBAIC0zMjcsNiArMzI3LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xr
ICptdGtfY2xrX3JlZ2lzdGVyX3BsbChjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgcGxsLT50dW5lcl9hZGRyID0gYmFzZSArIGRhdGEtPnR1
bmVyX3JlZzsNCj4gPiA+ID4gICAgICAgICBpZiAoZGF0YS0+dHVuZXJfZW5fcmVnKQ0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgcGxsLT50dW5lcl9lbl9hZGRyID0gYmFzZSArIGRhdGEtPnR1bmVy
X2VuX3JlZzsNCj4gPiA+ID4gKyAgICAgICBpZiAoZGF0YS0+ZW5fcmVnKQ0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgcGxsLT5lbl9hZGRyID0gYmFzZSArIGRhdGEtPmVuX3JlZzsNCj4gPiA+ID4g
KyAgICAgICBlbHNlDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBwbGwtPmVuX2FkZHIgPSBwbGwt
PmJhc2VfYWRkciArIFJFR19DT04wOw0KPiA+ID4NCj4gPiA+IERvbid0IHlvdSBuZWVkIHRvIHNl
dCBwbGwtPmRhdGEtPnBsbF9lbl9iaXQgdG8gQ09OMF9CQVNFX0VOIGhlcmU/DQo+ID4gPiAod2hp
Y2ggcHJvYmFibHkgbWVhbnMgdGhhdCB5b3UgbmVlZCB0byBhZGQgYSBwbGwtPmVuX2JpdCBmaWVs
ZCB0bw0KPiA+ID4gc3RydWN0IG10a19jbGtfcGxsKQ0KPiA+ID4NCj4gPg0KPiA+IEJlY2F1c2Ug
YWxsIG10a19jbGtfcGxsIGRhdGEgYXJlIHN0YXRpYyB2YXJpYWJsZXMsIGVuX2JpdCB3b3VsZCBi
ZSAwIGlmDQo+ID4gTk8gdmFsdWUgYXNzaWduZWQuDQo+IA0KPiBXb3csIHlvdSdyZSByaWdodCwg
YnV0IHRoaXMgaXMgYSBsaXR0bGUgYml0IHN1YnRsZS4gSSB3b25kZXIgaWYgaXQncw0KPiB3b3J0
aCBhZGRpbmcgYSBzbWFsbCBjb21tZW50PyAoZWl0aGVyIGhlcmUgb3IgaW4gc3RydWN0IG10a19w
bGxfZGF0YSkNCg0KT0ssIEknbGwgYWRkIGNvbW1lbnQgZm9yIGVuX2JpdA0KDQo=

