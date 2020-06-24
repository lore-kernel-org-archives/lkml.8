Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD03206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aSZwJ24D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404310AbgFXPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:08:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57014 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390817AbgFXPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:08:37 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OEt93L010328;
        Wed, 24 Jun 2020 17:08:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Cu4nJcdjPPiXb+n9YzK3G3D0pd94rG3fyGCZHC0HXdU=;
 b=aSZwJ24DpUjFZhrkHkWOa1/MEMhBLZcaESz0n0A0LYGLkrYGTtSp9nsVZO2Zq5S6PIAl
 tqyrFHJLTI36HFsQznZsq+/mZJsV9vm1dEAXPnj+DAfSGOgGLVV2i/YHxDziQS3ue1tE
 2/tBAfSPPmTt8M9h+ZooVyP2dMpLGA77//FaQUcCfbrScsb8Gfl5UqARSf53mcOOBnTc
 4fpceT1xIVdROqbFzg8+I/ARBnBjO/URtsh+eWKHnA2+lH9FAGlTDy8xc5rlURMYtRvl
 +QV8ngb4Q1NIk8Ggm769qCmWH/CzS5oAukuCKd3EZN/WS1D+tSnOH72+DR8Z0c8cBsjo LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31uuuccr50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 17:08:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F47710002A;
        Wed, 24 Jun 2020 17:08:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF46520D8D2;
        Wed, 24 Jun 2020 17:08:22 +0200 (CEST)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Jun
 2020 17:08:22 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Wed, 24 Jun 2020 17:08:22 +0200
From:   Yannick FERTRE <yannick.fertre@st.com>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi.c: remove unused header file
Thread-Topic: [PATCH] drm/bridge: dw-mipi-dsi.c: remove unused header file
Thread-Index: AQHWCbwe7FvpTwh4cUii/3igo3RUm6joPZmA
Date:   Wed, 24 Jun 2020 15:08:22 +0000
Message-ID: <669d5484-b1e5-dd5c-b4e5-f3b5a8b436b4@st.com>
References: <171ff1fb3918664a570dc8f2f34b446612505f76.1585832665.git.angelo.ribeiro@synopsys.com>
In-Reply-To: <171ff1fb3918664a570dc8f2f34b446612505f76.1585832665.git.angelo.ribeiro@synopsys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F4842D5A8AC36458A785A495C391551@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_08:2020-06-24,2020-06-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5nZWxvLA0KdGhhbmsgZm9yIHBhdGNoLg0KDQpSZXZpZXdlZC1ieTogWWFubmljayBG
ZXJ0cmUgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCg0KDQoNCk9uIDQvMy8yMCAzOjMwIFBNLCBB
bmdlbG8gUmliZWlybyB3cm90ZToNCj4gZHctbWlwaS1kc2kgZG9lcyBub3QgdXNlIGFueSBkZWZp
bml0aW9uIGZyb20gZHJtX3Byb2JlX2hlbHBlci4NCj4gDQo+IENvdmVyaXR5IG91dHB1dDoNCj4g
RXZlbnQgdW5uZWNlc3NhcnlfaGVhZGVyOg0KPiBJbmNsdWRpbmcgLi4uL2luY2x1ZGUvZHJtL2Ry
bV9wcm9iZV9oZWxwZXIuaCBkb2VzIG5vdCBwcm92aWRlIGFueQ0KPiBuZWVkZWQgc3ltYm9scy4N
Cj4gDQo+IENjOiBHdXN0YXZvIFBpbWVudGVsIDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNv
bT4NCj4gQ2M6IEpvYW8gUGludG8gPGpwaW50b0BzeW5vcHN5cy5jb20+DQo+IENjOiBKb3NlIEFi
cmV1IDxqb3NlLmFicmV1QHN5bm9wc3lzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvIFJp
YmVpcm8gPGFuZ2Vsby5yaWJlaXJvQHN5bm9wc3lzLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jIHwgMSAtDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5
bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4gaW5kZXggMDI0YWNhZC4uNTgyNjM1ZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYw0KPiBAQCAt
MjcsNyArMjcsNiBAQA0KPiAgICNpbmNsdWRlIDxkcm0vZHJtX21vZGVzLmg+DQo+ICAgI2luY2x1
ZGUgPGRybS9kcm1fb2YuaD4NCj4gICAjaW5jbHVkZSA8ZHJtL2RybV9wcmludC5oPg0KPiAtI2lu
Y2x1ZGUgPGRybS9kcm1fcHJvYmVfaGVscGVyLmg+DQo+ICAgDQo+ICAgI2RlZmluZSBIV1ZFUl8x
MzEJCQkweDMxMzMzMTAwCS8qIElQIHZlcnNpb24gMS4zMSAqLw0KPiAgIA0KPiA=
