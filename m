Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5688520578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HuzPxW17";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kBKbNs90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHXT16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:27:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:38462 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgHXT1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:27:55 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8B7EC0086;
        Mon, 24 Aug 2020 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598297274; bh=V8s0eg8lg56YOnAlF4yjoKsoVHAmYbB7hA/vZhmh84o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HuzPxW17/vCRgctDp8h4HhXQF1eGg844MYms9t+Gh7uzGAUABUZAnzgG4jaXnaYzk
         XWq1OwQHsNmrA2c7cpjjWaV80c9S21Em4UODPFv1bCJNuMCEDAjZ5moriGOVxjphyc
         XMSV3jDjgI8Ln3ZGcDNgvl42T2MG2GYslg+C02DJHDW5WPHw3TOg4mJbvaXvdqHwhm
         BP/jbPm1G2IkAO4JpMlUUnVxZnGatcfXfMAV/e4tbzgpo6XSUlkvhLtv99MfZfR31Y
         KTA5VH2SwURXDZTro8z9NP5GvhdcTFZyX6IurMQpJUsmfS2uje6Vx/eZA0b+sfSrJO
         wmxfxWS4dBdiQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4163CA005A;
        Mon, 24 Aug 2020 19:27:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D0140800DD;
        Mon, 24 Aug 2020 19:27:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="kBKbNs90";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwZCiLeiYE7ZhyMO8eSbfiMb0RPls3jVLW7adrzU7vFqS2lOfWVHZ2XhZKItg3R0BoIDRV3L8ntfbYy0HWFPpIDa8wiXcGijA/GUWT2/vZ73Yn/iHOlhtr4ssJ6aAj+0+sCTTdB3v2zt0FJymbvYkewsqHjcDJvn7ryrrmXH24JJyAKsClL2gKt8j28VBieLLUuvRkd3kqPGRSJIIHzwpIS3dT1aRJeNGN2i6yHT2DmcvQF+y6nbsdTKftqXR8aq+lMlaqXTu52TtUqZXlWkN4gtOHfnXUFzKxcQkfrVIlVRQ8SmqfSDFVMyK6ti4lbssIAuXkqEfrwFDsmhD3w36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8s0eg8lg56YOnAlF4yjoKsoVHAmYbB7hA/vZhmh84o=;
 b=jNibe60EBsdcHFZ5M/JdfetLQLqJ1uLwS4M66Y96+Pp7j4t37mu7OGwseubxbj/xgWnI2R/Ai/Mas1cDeVXAkybMtlNqGccVrFdVV1IKRCZNNc3GgMO/wpaaTsGJlP12q7GupTfjhW6VjWhmOOz1660F+FRjPbQZGtt9yuuT83zTuHx8f1IwT5V9SAK4BlxTIhK+gXg6OAHaDNd14JCInSBO0SeGJxJDsdG/KcJqe6nkr7eCVkjB8u7kPpkpb5wSVQkcHRsg0odrQtL7yFq/AMJ1Kq4hORBLuG0uFFbBZYnPPqIpXkIQ1+2KMN8cE0plsyWWrby6dYzHvtxgwXqRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8s0eg8lg56YOnAlF4yjoKsoVHAmYbB7hA/vZhmh84o=;
 b=kBKbNs90wtcTFXiXiPNRfYyFVykM03FTIo6PzUjSp9Fsfm1uxm706jfNLFgTFBwyB2cGvNJl+hRERVwJquS5Zm70JIeHzahFNChAeKJX3cZe0MyQiy8N17LRijwwiq7YnCKkUWmidtQ4HrZGk7l84JJM+STS+r+SIwfq0JDKLzw=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 19:27:44 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 19:27:44 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ofer Levi <oferle@mellanox.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: {standard input}:5973: Error: operand out of range (512 is not
 between -512 and 511)
Thread-Topic: {standard input}:5973: Error: operand out of range (512 is not
 between -512 and 511)
Thread-Index: AQHWef0l0UaEhGbt3ESFttATwdb/VqlHksAAgAASjIA=
Date:   Mon, 24 Aug 2020 19:27:44 +0000
Message-ID: <2c666b4f-d88d-d301-0652-ed021d86de71@synopsys.com>
References: <202008241018.RkyIlLKd%lkp@intel.com>
 <20200824095831.5lpkmkafelnvlpi2@linutronix.de>
 <28384fea-4a07-c57d-04b0-f44f1c70adc2@synopsys.com>
In-Reply-To: <28384fea-4a07-c57d-04b0-f44f1c70adc2@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:83a0:2f8b:62c8:4c97:a7a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 034dc284-ded0-4508-7b4e-08d84863c6e1
x-ms-traffictypediagnostic: BY5PR12MB4082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB408292FA83FC08768050E744B6560@BY5PR12MB4082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxO1lnwf7RjR+Cu0mtbjVaRM0Sj8cy4Sl8oE/XdHCgYcdsvC7sA+RTeT3uU6mGer+aOsXTejAw5DDNvg15aeBOfOf5LDLHKRHpET8HM/CKrOHtjXiu8jYfgE5yOlUPFhaImxO47PRCiReiNdMngB9qSIRg0tS3OSIVA+A9ZiUt1M6XQV9tfmBVxzHrQPQTOazy3g1kdGKqdX+HMqb4yJM5U/mfqx3cdQXjgI9kRYueevOTQXek6fJDVZ9ERYEijLpg6IYZ42QwWlWIPKjhkBFTxotNnXryq0sHA6/xnsUNVQ8UVl8sA3Je4WQ1vs7y5+ee3csNcpPsKQcz86QuHzJ4s0KGsdM/CisVRX/1ucI2k8C7O5N6WO17jFg4sPUtMi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(66446008)(76116006)(36756003)(6512007)(31696002)(71200400001)(66476007)(66946007)(107886003)(31686004)(316002)(66556008)(2906002)(8936002)(64756008)(2616005)(5660300002)(478600001)(4326008)(6486002)(110136005)(4744005)(54906003)(86362001)(186003)(6506007)(53546011)(8676002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UE4OmO2jwSNDWGhLwJH0L4oHf3ZI+MJTxIWwSOqmt+6TtoLR8gNhUyC1sTYoGV6kLGWjPSuTYcokENE+Op60yARshbwOqzxmlNHKjzDOp7QWRoQCMeLvYBjCJJTesfjW3TDjblpLXx9pPJRW2qQZ7ZDSI99/LJ7M5fpqpVR1njF7gckMkrLvxzbIHBpelDXr1uOeGzsiE1VsjDLGkhj0YiYjYUD94MBHU1HTsGgn4CP6izle1mPWwKQUuXLgno8PayoCq3GKMh579En1hwXhLEF/YSZzRW90LsvWuXeM7qLLabdpSxDj4i410g+vVGIgrh28s0kLLiPzkCLSyCdLbILWTxctQQ6lS6UNlEpapKMQO92gdTb9WasFhnIxJIvefsVoU3XpEEXRN0tzacQm5UMpL2Dkdxdzjd5SovKKlPf+0Typ95BkYwiUXS5cIHEaqhPuex+emCBzeg5yRGtlcDKlL6X9QghIMbi9vdYSWlhEiSgKUQYcnMwiuSiZYiPOfzr0ZW3WkKBv/WXwkgFY5cQ/hlmolGf8onJPdpkRgmSME6W/j8kPHNe9FCAijpNpf4wpr+R5B3tbqoh41HZoH7Qn5YKMyZQhhhrw2lF34ivhQXi3sJDIRQpRiW2j7z+1DIh7HQnhpOW4Ncn3OAj/sOzaB9MBm9DkZIvsK5+6tx1t4hBqddgSqjpmxFb3h0qTAw1QZ8GsldL4YdRV33/mqA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F0989418D43B346A033381DE09C2C85@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034dc284-ded0-4508-7b4e-08d84863c6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 19:27:44.7154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsctOXPyqDLs3PE0tFUpkuNKfN71kEPU5VX1aFFwx+diU9QTX1TFTE2/9MC3hX3fQl9/YRtMqCOY5jMpZpPtzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yNC8yMCAxMToyMSBBTSwgVmluZWV0IEd1cHRhIHdyb3RlOg0KPj4gYW5kIHRoZSBhc3Nl
bWJsZXIgZG9lcyBub3QgbGlrZSB0aGF0Lg0KPj4gQWZ0ZXIgdGhlIHJlbW92YWwgQ09ORklHX0FS
Q19QTEFUX0VaTlBTIEkgZ290IHRvIHN0YWdlIDI6DQo+PiB8ZHJpdmVycy9pcnFjaGlwL2lycS1l
em5wcy5jOjgwOjE2OiBlcnJvcjogJ0NUT1BfQVVYX0lBQ0snIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKQ0KPj4gfCAgIDgwIHwgIHdyaXRlX2F1eF9yZWcoQ1RPUF9BVVhf
SUFDSywgMSA8PCBpcnEpOw0KPj4NCj4gSW5kZWVkIHRoaXMgaXMgYSBwcm9ibGVtIEkgY2FuIHJl
cHJvZHVjZS4gRW5hYmxpbmcgQ09ORklHX0VaTlBTX0dJQyBvbiBhIG5vbg0KPiBBUkM3MDAgYnVp
bGQgY2F1c2VzIHRoZSBpc3N1ZTogdGhlIGN0b3AgaGVhZGVyIGlzIGluc2lkZSBwbGF0Zm9ybSBj
b2RlDQo+IChhcmNoL2FyYy9wbGF0LWV6bnBzL2luY2x1ZGUvcGxhdC9jdG9wLmgpIHdoaWNoIG9i
dmlvdXNseSBmYWlscyBpZiBub3QgYnVpbGRpbmcNCj4gZm9yIEFSQy4NCj4gDQo+IE15IHNvbHV0
aW9uIGlzIHRvIG1vdmUgY3RvcC5oIHRvIGluY2x1ZGUvc29jL25wcy9wbGF0Ly4NCg0KVGhpcyBp
cyB0dXJuaW5nIG91dCB0byBiZSByYXQncyBuZXN0LiBUaGF0IGhlYWRlciB3aGVuIG1vdmVkIGNh
dXNlcyBvdGhlciBpc3N1ZXMuDQpJIGRvbid0IGhhdmUgdGltZSB0byBjbGVhbiB1cCBhbGwgdGhl
IG1lc3Mgc28gSSdsbCBqdXN0IGZpeCBpdCB1cCBieSBkb2luZyB0aGUNCm1pbmltYWwgY2hhbmdl
Lg0KDQotVmluZWV0DQo=
