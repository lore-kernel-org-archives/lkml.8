Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E4C43332
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 06:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768D20774
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 06:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="iOEwvZ52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgCVGUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:20:42 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com ([40.107.21.121]:53377
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgCVGUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 02:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAYaYqtql5yNZUROc59FWIWgbiXdBeKHFqJDILY4PPnFGm6Lw3pucMRQMYnefzUTJIRnLncwKcuN9qkDeYNRe5qRBin46PyAEzeePvKT2MPmN4g7h0BkyyUcKKpHr/kFhnY4223jJyArFrE8RC+O78v4bodjEKho2V79js4oQPbUVDMCf7wqd150CJmWK0OhCGktjezL3A0TOfgYJ6nOyQP2HdvjQSqEoQFvzvAMoA2PWX7adVds997ti9qUWTpUUQ5lsnvHXo4D+6MVDFtfE+QLDZDKSBtuBsxaX/l7107wPH9oBI/z8aW+wAZOXqshxHPdg/zyojit9BKaOPju5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAg4PtFqt5GztW4ryPTTL3H/UGLwF63XiOu9E2gjyx8=;
 b=aKEpThamknWl23CTdoeYQQieqT0tb3nMSkiqKrrxoMoDW4VuRagxOnbqWl8fSJjqEQCabhyigBgOLmMszKWI7gGidhdKuM1+4b2Hh04NmEyVRm7nA5RpaUloabrZgm7byVeCTr0/oq32cHhdGeK21yB+cWyTGFezVH1lXKW5X8w1XMg4AKRjXyf20TYoZmoIsXE6Ie5pJF6mHQcnVbMW6P8o1X1ppk28aNlmzBOKo41XEUCJ2hnE+ONOt0uF1trTLffVqDXkwb3XNhZiJSnbJuUeq6c+fRmx2RiRXYB4p66KpMZGTp44ftQ4mrtu62Vb+oqCl9TsUyccYYvmf5sLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAg4PtFqt5GztW4ryPTTL3H/UGLwF63XiOu9E2gjyx8=;
 b=iOEwvZ52ZcnPODznpIJAboa5ZLzLxtbixP+T83SLjLmtivV/jcp7gj1AgU8ieQwBQcn/GsL+n0xakQDtSSOzoeSiP/cHeCAa78xkDKvLvVPQ5V7aNW4FTCZP+tLZ91fRYTm2vf8lc79XdJLMz2qf2qHt5wJnvdpQ9c6j3lKfEgA=
Received: from AM6PR02MB5526.eurprd02.prod.outlook.com (10.255.121.28) by
 AM6PR02MB4215.eurprd02.prod.outlook.com (20.177.116.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Sun, 22 Mar 2020 06:20:39 +0000
Received: from AM6PR02MB5526.eurprd02.prod.outlook.com
 ([fe80::9143:5e1a:334c:eb1a]) by AM6PR02MB5526.eurprd02.prod.outlook.com
 ([fe80::9143:5e1a:334c:eb1a%3]) with mapi id 15.20.2835.021; Sun, 22 Mar 2020
 06:20:38 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: show unsupported message for GAUDI
Thread-Topic: [PATCH] habanalabs: show unsupported message for GAUDI
Thread-Index: AQHV/19AvO5kjK3fIki2LQR0+8W+mKhUI8CQ
Date:   Sun, 22 Mar 2020 06:20:38 +0000
Message-ID: <AM6PR02MB55263D19CEEDC4EEAB07BC4EB8F30@AM6PR02MB5526.eurprd02.prod.outlook.com>
References: <20200321090059.21960-1-oded.gabbay@gmail.com>
In-Reply-To: <20200321090059.21960-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.14.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3c85480-db3f-469d-bc8a-08d7ce29240a
x-ms-traffictypediagnostic: AM6PR02MB4215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR02MB42159DAF19BFF0241B36C831B8F30@AM6PR02MB4215.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(346002)(376002)(199004)(15650500001)(4326008)(478600001)(2906002)(81166006)(86362001)(110136005)(8676002)(52536014)(316002)(33656002)(81156014)(55016002)(7696005)(71200400001)(66556008)(76116006)(9686003)(53546011)(8936002)(6636002)(66946007)(6506007)(5660300002)(64756008)(186003)(26005)(66476007)(558084003)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4215;H:AM6PR02MB5526.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6hQx2eVIH87lzdSEGNjzxvwP7Sa7d6Afx23PnKjIo49F+M5GEUuZ7n7x0Nu3X9NnLvtrMVs70vud1uffmn+aoWDBcaTFFgmMpm7BHMkO85j4VNRzW5LhUv4/xy1DumnoaGZVd/Fg+uObr+SQESGj83bI7Wm+4hGemR1l8V5sdqI8cKcku1Im92zlEtgUVnqa09fOskS3MaV379lR1VuTIWSEvrpxYrybPA/9HRZxRfbx2+QPb3GZ1oIFxiMaHxy5gsbO0u47P08uPjHYtELRicgiKe79n8hdLtwhA87iF60CzZ4gjvqXvO9IhwEh4PcLpuC1ZQVY4nUcx62StpJAn5uz2Eaj1eWpp3i+c7M71BK9q+yWYNE1bHCmv5ztkl2YYGLxvJ3plDSDcQ4PF8IuFmEBnB62F3AiVz3MmmRxJSnNXk5ITd8rO3pIGO8BNZW
x-ms-exchange-antispam-messagedata: Ygl0ObdoWpYDeHm+0VSvf//3ili4AWsD7umi4YsNerQCwB13VigGTd02u3i4LvxBBbB+F5UgCPy8X5CXjErZ87H19MXkyWmHtf8EKetUXdlN5+Rfv1DZAuI9V3/2d3SuIFpwJtKIXBwiapVGWs9f8w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c85480-db3f-469d-bc8a-08d7ce29240a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 06:20:38.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOispkiX4zkALg10T0VejM0vqg0BW0fCuMD7SuGeDjpUfdoZVVF00xmq5oTBlRD/grWRrod+2E1zXOMFANtwJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMjEsIDIwMjAgYXQgMTE6MDEgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBJZiBhIEdBVURJIGRldmljZSBpcyBwcmVzZW50IGluIHRo
ZSBzeXN0ZW0sIGRpc3BsYXkgYW4gZXJyb3INCj4gbWVzc2FnZSB0aGF0IGl0IGlzIG5vdCBzdXBw
b3J0ZWQgYnkgdGhlIGN1cnJlbnQga2VybmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBH
YWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdl
bG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
