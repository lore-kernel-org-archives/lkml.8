Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A2CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9485420786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="XMwrHK4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGEKdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:33:45 -0400
Received: from mail-eopbgr60112.outbound.protection.outlook.com ([40.107.6.112]:60228
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbgGEKdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 06:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgnP8vgE4cqOjdnjzxBGvi1YcByUWyhloE9cwheQXQgh3Ruj9SxMDVtDIh2ydtVTzHfgEW+p/kDPS2W2LooQUpQvkzxhbp8AwU9OPwGpWCvLeCbawX7kqyjOslD0PkVEDkqBfj2Bjfh8euchX6qSZwm5jVn7lpS1DiQg/pUunLmQpCIMza/IA3p7uq6iSvVZryxuYZnNZro17jiGULAjKgv6drE8E5C9SIE2MMVLMXjwPQoyekKxhPxKdmAkK+lB1mViTE+Xr65GTfZpKqo0AynCuLgqaaUiFXqags9DSQgBeOOEao6uHb0CfhMAujbpAGir3g9Oifq5YCErYgixcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQFQu07tTYFf3HPBC8o4JFj2MmetAJ1FZ4esCCtbEXg=;
 b=iNHEovVYD8kIQGCPUa1wONgjdzyE0TaMxV9r6IOz6WxJ9ja6PB/nEO3eW9pqPEuytAn46M+9NJX5Os8JwSFcB5PFqs2DY3xppOwxu0rtPDPVVVkkL+apGLVgCBAsok8ZkH19ydu+eAqDnvwKY0nSS7BqbbTndPXl9vAIt1Ul+l6NRc8/4DnAPaUT3x9jpV8YO0dRj5nUcQ1sfqc8mfi5iqUerMXLwZe9Ayol0iyTK4z5nmORodn4wk5H32VROhoQi9ENbsrjNuVS1xrJ3toBrjzfSMtCentS2KS/uZvu8azoQNjKOxowOAtm80dWgJGgfNhahorWFc12qAjD+qgxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQFQu07tTYFf3HPBC8o4JFj2MmetAJ1FZ4esCCtbEXg=;
 b=XMwrHK4psW8+HV7HoPjdpadg+bSGvqfM12EN9GMkkSRM/Pfs2Q2IjKVVVWfHebNfTGF/06HSTbdpmiYs6Ad59l+pLtvcWx+Q1F7q+28x/IGfIvcr360txmvEErtp4VTHIcwClVg2sIStyTXTf9kgSOtjULi3YS3tbjLJA+kIW6o=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM4PR0201MB2179.eurprd02.prod.outlook.com (2603:10a6:200:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Sun, 5 Jul
 2020 10:33:41 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 10:33:41 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] habanalabs: block WREG_BULK packet on PDMA
Thread-Topic: [PATCH 1/2] habanalabs: block WREG_BULK packet on PDMA
Thread-Index: AQHWUkpABPsgrZ1TkEaTQseD2ND4Kaj4wz3Q
Date:   Sun, 5 Jul 2020 10:33:41 +0000
Message-ID: <AM0PR02MB552333DB1C4C6EAA0C752AFEB8680@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200704212951.20062-1-oded.gabbay@gmail.com>
In-Reply-To: <20200704212951.20062-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [94.230.83.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc00a45-e365-446e-7de7-08d820cee2c5
x-ms-traffictypediagnostic: AM4PR0201MB2179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR0201MB21792877148D0E1837A30933B8680@AM4PR0201MB2179.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 045584D28C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qmh+1CHKAVxgSfO/St+6m2zG6biRV+IIICBGYLo4YDaufcoSoFlR/ZMzqSn0MElp1mv4/X+XTJux8YMK17wlC4pDwpGmjWHv9QM18vAyWioqLtcE6Q+7W5DuZWFYUimtvUPyUT0vNkz3eztg5eUa9OBfAyl46lx3yucbQz52W8y3H8MCrNA53PNc6g4HeaIwNlSBA4nBTwmID5zvCU1c4p6S62wwO6QfiHTrqf/28Yvx4cD1WcqCX7z6mgzwCFheWmm0StPb4d2Y+zPNSHlHwdgyHgZ3R51KZdOYlt2yUCmxryxQ5o8FZaNLnw99w9j892ZvuPVlTvuz2hF9YK6IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39840400004)(376002)(136003)(346002)(478600001)(316002)(110136005)(8676002)(9686003)(86362001)(26005)(33656002)(53546011)(5660300002)(6506007)(52536014)(4744005)(2906002)(66446008)(66556008)(6636002)(66476007)(64756008)(55016002)(66946007)(8936002)(71200400001)(4326008)(186003)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oOtVx6JdSEeIWxxHyf0/q9qdlAKeqXfF0kimcHB98knm2qabmcURSHzK5+YCq/acYCdfs4IJ2V6TrhzHnz/L0SCWBKMX6acHEyeKXm4LIM7/kfsaDVuKYeJscP8KtVOQORbePVs4G1D0yoVcc41z3siekNnKtMC+On9gS1V6TFGayjg/e9hhMGPnSsDwU/vpXlnmG3YjSY5NXVCGrrqTJY/pDElVA6A/XyyhSESDqPfmVtK+Z1936Z6sDeDqbkA80waZKmF3JAjW0o11VQnLC324XLSsoD+37wgEXOoiIfl14MBQ3Krn3lXRPLijnajJsVyz9elyEwb6EEDH/jB033q55oJEsoHpTfP+Hyb7c2apMx3BJ2nBgv+ntarbZ2CBShA7/GUmYiiVNqyCm07Ic/UYlGWtbChSfw2aw6xmEbk+nsAl6kn+MShDFrSn7f9+083/eVwPDzTJT5tFs8sJaRZmKKmHt2bPWPjOc8nGhXA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc00a45-e365-446e-7de7-08d820cee2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2020 10:33:41.2370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUs4IvztGBIFT4pJ2V4DkJtsNkOoqMmpUT3oZKUzTrUliRyS3kUClH6b9kTgxsZzk6m/szIZaHoZc7Kj5ZXchQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0201MB2179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgNSwgMjAyMCBhdCAwMDozMCBBTSwgT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IFdSRUdfQlVMSyBpcyBhIHNwZWNpYWwgcGFja2V0IHRoYXQg
aGFzIGEgdmFyaWFibGUgbGVuZ3RoLiBUaGVyZWZvcmUsIHdlIGNhbid0DQo+IHBhcnNlIGl0IHdo
ZW4gdmFsaWRhdGluZyBDQnMgdGhhdCBnbyB0byB0aGUgUENJIERNQSBxdWV1ZS4gSW4gY2FzZSB0
aGUgdXNlcg0KPiBuZWVkcyB0byB1c2UgaXQsIGl0IGNhbiBwdXQgbXVsdGlwbGUgV1JFRzMyIHBh
Y2tldHMgaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdh
YmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNocGlnZWxtYW4gPG9zaHBpZ2Vs
bWFuQGhhYmFuYS5haT4NCg==
