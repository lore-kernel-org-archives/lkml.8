Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F49C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A75206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bMgExa5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgG0Mzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:55:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29484 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728387AbgG0Mzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:55:45 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RCb6Fo013340;
        Mon, 27 Jul 2020 14:55:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=mjY/7dksrDC7M4Ud2YDvD9iqbnxWCHmQNoGB5GRnp2M=;
 b=bMgExa5ztW937ye1ZcAy14vLwvQA+T0FDcWOyldE4Ee+O+rx6KLOtd/1W9f6ebDxkn1U
 st+MEnKYNB4Khb3BAKF91tFIshx8+JyOOERJth7f+BKjSVx1OGyn0SRmrPokUIfGU+0t
 wonz8gwJcgwlOpoZa1R+vX/doMX4vGmrxqUUxiflw5+m7EfeYbT/4qswjVtkyMH8JLBR
 re2Yjdi5dPsseWdAvg75nJqhV2XUKKBtqjzBbqktITMVU8uF/vX53xg15ZzR4789JnCv
 f1qVMbP5hZf26Pd2Am81CQtKClTVee9e/VmyE4UmdU8cu94oZRPQf0MTHTSjg6xsnH97 Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32g9v99cqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 14:55:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6226710002A;
        Mon, 27 Jul 2020 14:55:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D2EA2BF9B4;
        Mon, 27 Jul 2020 14:55:30 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 14:55:29 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 27 Jul 2020 14:55:29 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 4/7] usb: dwc3: convert to
 devm_platform_ioremap_resource_byname
Thread-Topic: [PATCH 4/7] usb: dwc3: convert to
 devm_platform_ioremap_resource_byname
Thread-Index: AQHWX/0W9J7PYecCTkOfnceP/F29OqkbSOeA
Date:   Mon, 27 Jul 2020 12:55:29 +0000
Message-ID: <7e8ab37e-d94b-ac7d-3642-b82329c653cd@st.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
 <1595404275-8449-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1595404275-8449-4-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66DBBCCCBDA2664D99A68A00CFC169EC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bmZlbmcNCg0KT24gNy8yMi8yMCA5OjUxIEFNLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
IFVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCkgdG8gc2ltcGxpZnkg
Y29kZQ0KPg0KPiBDYzogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMgfCA0ICsrLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtc3QuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1z
dC5jDQo+IGluZGV4IGM2ODI0MjAuLmU3MzNiZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZHdjMy1zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jDQo+IEBA
IC0yMDYsOCArMjA2LDggQEAgc3RhdGljIGludCBzdF9kd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKCFkd2MzX2RhdGEpDQo+ICAJCXJldHVybiAtRU5PTUVN
Ow0KPiAgDQo+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgInJlZy1nbHVlIik7DQo+IC0JZHdjM19kYXRhLT5nbHVlX2Jhc2UgPSBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiArCWR3YzNfZGF0YS0+Z2x1ZV9iYXNlID0N
Cj4gKwkJZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAicmVnLWds
dWUiKTsNCj4gIAlpZiAoSVNfRVJSKGR3YzNfZGF0YS0+Z2x1ZV9iYXNlKSkNCj4gIAkJcmV0dXJu
IFBUUl9FUlIoZHdjM19kYXRhLT5nbHVlX2Jhc2UpOw0KPiAgDQoNClJldmlld2VkLWJ5OiBQYXRy
aWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw0KDQpQYXRyaWNl
DQo=
