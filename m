Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB5C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC68D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBKHUI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:20:08 -0500
Received: from mail-ma1ind01hn2085.outbound.protection.outlook.com ([52.103.200.85]:31038
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbgBKHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:20:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHrapA8tmORwt6Ws5qdIKW5wLn83TRxV5XTYTXi04uR2YX/4ugA0ap6UpzBFcl0tejS+GWZGLHaXHpxyzg8U4uf4ez8AXNBjlTJ2CQzD6ByNZLi9d0SC1ygNPKouG63uDHdMx8rkUOohC4wLTVgcWU9ObzrX2+9HP8Q+Va4jmu2TA5VdnTr/+QlL4iu2ze0JX12wcjHKCgWNP3JFq7XT0M4ovjyLgA8dMV6kQ11ugqy2JCAAa4rGcYTKTXv3uDZTc3fmerhI3LR0hilm4lAds5kTc1L3muUiHzEYrz77YSM2knu/eAp1ufXE41dlXWL0oh0n/AB6SkaYWXT3RuG9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqJENiPSFxfm5dNInRGodfcfiiYCSpueUcdne185ukw=;
 b=TFNHMPwrz5+MeXZr6Iefkp2aPmwYszUKza4v/OqcTedyqQxgqaVgNCi0hkphgGPaoRYj+w8UAMtyl/BYiEiwDY+62o3EFstWZZHAMEz9RbiGBF4mrpetaveT2og6s5BjYeFn0wf5Y17svz/EluGKGVBFdBuXVD9L1uqbsS220kB3VXV3BDyZN3CnnoQ7poHGrGzaZZ0C7pNSqFeTMxupijRW31R1mFtINC2bwEDRxFG4DbryOBErb81mGhZypK/UdYb9+afpRqeMnYQbu0V/l7bNGRVKUIOdL1f5WpcorOwhHrW5QbJalywBRAsXIyV4lUwDFL17Db7cUV3KvrUnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=universaldigitaledata.com; dmarc=pass action=none
 header.from=universaldigitaledata.com; dkim=pass
 header.d=universaldigitaledata.com; arc=none
Received: from BMXPR01MB0741.INDPRD01.PROD.OUTLOOK.COM (10.174.215.150) by
 BMXPR01MB3350.INDPRD01.PROD.OUTLOOK.COM (20.179.241.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 07:20:05 +0000
Received: from BMXPR01MB0741.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f452:44da:855:f243]) by BMXPR01MB0741.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f452:44da:855:f243%12]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 07:20:05 +0000
Received: from dellPC (106.51.31.26) by MA1PR01CA0137.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::31) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.24 via Frontend Transport; Tue, 11 Feb 2020 07:20:02 +0000
From:   Jessica Nicholas <jessica.nicholas@universaldigitaledata.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Visitors List Embedded World 2020
Thread-Topic: Visitors List Embedded World 2020
Thread-Index: AdXgq6xympZ/TnTZTryoitZba43PBQ==
Date:   Tue, 11 Feb 2020 07:20:02 +0000
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAAcpiMWtUmhItmOqoPKBgt3CgAAAEAAAAHQVoy3eywBBjxQDXl80FAABAAAAAA==@universaldigitaledata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::31) To BMXPR01MB0741.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jessica.nicholas@universaldigitaledata.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Microsoft Outlook 15.0
x-originating-ip: [106.51.31.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e3a3df-3d1d-4961-e789-08d7aec2cfab
x-ms-traffictypediagnostic: BMXPR01MB3350:
x-microsoft-antispam-prvs: <BMXPR01MB33501789AAEE20EF8A19229380180@BMXPR01MB3350.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(366004)(199004)(189003)(86362001)(8676002)(81156014)(81166006)(16526019)(71200400001)(6496006)(52116002)(38610400001)(186003)(586005)(6916009)(55236004)(8936002)(26005)(44832011)(2616005)(4744005)(956004)(508600001)(1006002)(2906002)(5660300002)(6486002)(66946007)(66476007)(66446008)(36756003)(64756008)(66556008)(32030200002);DIR:OUT;SFP:1501;SCL:5;SRVR:BMXPR01MB3350;H:BMXPR01MB0741.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: universaldigitaledata.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6stDbZhy1KIvdhqVNNdMmeZ4L2NVvqqRdz8jXsBipT/oRKl+2s3aZfBeaesgDPd8AL0bbwlzjzCmGTxTPkGMpGpYmDjZawbF1pnC1ZTPGnPzacuw1bjV4nWvL8mLgf+SsgGCZYiHZ4tVjucF/klt4Oxul7ThpRijGcnUG7LoP/CHav9BgAyxDkunwfgL50nrg7JF4G/BnMZtlOoY/A7fGIlzgAS8XdRhwc4+xvO3KhJvg15RbTHzogerz0uPID8+D4tFJAu7VHVlVKSmGuyUX10bbG7gKwVo1VI9vK1VPYqgv79UNAsJBdhiyVAweAhaPNiVAR3wOoh2JGdF7Ou4D1V9yEDgQCGyi6Y13KDIEpshMq+P/1hyTLpae0YlZ+MFcdL1eRD3quRQMi6fI1Cn28zzphC7CjrWOKlrq8UbCfbveGD3ak6Sf+zwXXd1jEJwWlOgXpQ9xI0Lix8868noRW6RJvOeDeDFPdKXpBsF9xmPhjJ0+VqP/CqOblDI7vnQCCBwm2ujgwhugKg+E2ICAciKUACG/nACA2KP9w4wtFCSdnHoIhV4GenRW8MZNi4JkhyBD2vPmvxzyl32ppmRbuxHOnxTbKO6bI3HEn91G/BD3QBhO9usXZ85Ggn1BD9n4+0qvUDTT9rSaCgG9HawVg==
x-ms-exchange-antispam-messagedata: a5nQfoj5S9zoFOalb0zZC7GnlUCGa6le0TaJjwqnchcBb92WBOZN3ow+uAw339iI+YWUxehs8CCra0+e7BvNLjKeqrJQy65ghJfJad9dE8RtVy/Hod14OevKGF/YfAf1PwNdq8zeL3Q7U+fgbl4NBA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA715850D1C99448AD0408E16A4837BD@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: universaldigitaledata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e3a3df-3d1d-4961-e789-08d7aec2cfab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 07:20:02.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1bb3990-870d-4842-b2e3-88f92e8fd504
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXH9g9aA3ff4RpJnoTztNto3/bDzAitHy5PhjGaaGLq67ZVxK6UIbUstENTW+j8a+y69Gdoi4S2KKapy+QXawQrJSInX3/GCRvixy7Qj/JeA8l88f4+6g0uszyVhiiXFpoMuO+IeIEFF6tofzKiDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB3350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Good Day to you,

I am just following up to see if you are interested in buying visitor list
for Embedded World 2020, 25-29 Feb 2020, Nuremberg, Germany

Please let me know so that I can provide price and other details. 

I am looking forward to hear from you 

Regards,
Jessica Nicholas -Business Analyst

If you're not interested kindly reply with the subject line "Opt-Out".

