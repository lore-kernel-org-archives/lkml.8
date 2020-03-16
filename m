Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D413C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BBC20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IVFLh0VC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgCPHqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:46:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11495 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729940AbgCPHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:46:35 -0400
X-UUID: 54d369bbfe7f4beba454c45da2ddc979-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BlXDFmnnqorVgQpulgg7ck1YZ6kA0CFS6J6lD1RPe/M=;
        b=IVFLh0VCB+aMcNA9+LrG31fTNQM1aqh7VfjWgnLRb2dOFhJQn/vurbsCUI+pBxJgWwDg/2WLooF83pi4DO5NQ3JTON6pj8aGtJSSNw4eIY50bIYKbM7dvQ7rWhcb5eTN3RWtrVAnMrlTPFFRgq9f9Nf94JlhkS6IJSe5kJTotAU=;
X-UUID: 54d369bbfe7f4beba454c45da2ddc979-20200316
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 108033686; Mon, 16 Mar 2020 15:46:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 15:45:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 15:43:32 +0800
Message-ID: <1584344790.29731.1.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] dt-bindings: cpu: Add a support cpu type for
 cortex-a75
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 16 Mar 2020 15:46:30 +0800
In-Reply-To: <f1b8239a-a68f-bd50-585e-26109850a1fc@gmail.com>
References: <1584284885-20836-1-git-send-email-hanks.chen@mediatek.com>
         <f1b8239a-a68f-bd50-585e-26109850a1fc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTE1IGF0IDE5OjQ0ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+IA0KPiBPbiAxNS8wMy8yMDIwIDE2OjA4LCBI
YW5rcyBDaGVuIHdyb3RlOg0KPiA+IFtEZXRhaWxdDQo+IA0KPiBUaGlzIGxpbmUgaXMgbm90IG5l
ZWRlZC4NCmdvdCBpdCwgd2lsbCBmaXggaXQuIFRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQo+IA0K
PiA+IEFkZCBhcm0gY3B1IHR5cGUgY29ydGV4LWE3NS4NCj4gPiANCj4gPiBDaGFuZ2UtSWQ6IEky
YjA1OTQ4OTE1YWNmYTZhMDRhMGI4ZmE4ODY4NGExMmI2ZDVjMmNhDQo+IA0KPiBObyBDaGFuZ2Ut
SWQgaW4gdXBzdHJlYW0ga2VybmVsIHBhdGNoZXMgcGxlYXNlLg0KPiANCmdvdCBpdCwgd2lsbCBm
aXggaXQuIFRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFua3Mg
Q2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sIHwgICAgMSArDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQo+ID4gaW5kZXggYzIzYzI0Zi4uNTFi
NzVmNyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2NwdXMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vY3B1cy55YW1sDQo+ID4gQEAgLTEyOCw2ICsxMjgsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+
ICAgICAgICAtIGFybSxjb3J0ZXgtYTU3DQo+ID4gICAgICAgIC0gYXJtLGNvcnRleC1hNzINCj4g
PiAgICAgICAgLSBhcm0sY29ydGV4LWE3Mw0KPiA+ICsgICAgICAtIGFybSxjb3J0ZXgtYTc1DQo+
ID4gICAgICAgIC0gYXJtLGNvcnRleC1tMA0KPiA+ICAgICAgICAtIGFybSxjb3J0ZXgtbTArDQo+
ID4gICAgICAgIC0gYXJtLGNvcnRleC1tMQ0KPiA+IA0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBs
aXN0DQo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

