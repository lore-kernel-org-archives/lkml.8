Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8BAC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D4A206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=estab.onmicrosoft.com header.i=@estab.onmicrosoft.com header.b="NiCD9ksG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD2HgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:36:01 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:28913
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbgD2HgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:36:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmHKSWylvqXKCk8M5RAUUbD9jCWMskJk62StaJdrNzMm6I+Ff4dAG8hSyxR7rjHszQ2YgVKuSyUN1VoKDlb6RliyeNFl9lbKdxPLKS0sGwYyvwsmKeKhHSixIdgEVNbDN7rHxQnmfF7fUK5Jtatz34jUm4jGLsVXWZDHZ9pnWQJ5fJpwMqirX7CmeSG5lDEFKQukmgzujX4WWJJX735obavLbPTb5PSF6Us4ECVFJ9b5MTdIlPKB9xm+TYqkufl6hppV2LhfaJqtJuRUZq/yUY/8JMvPiy670/XLSvH674ARJahqQVrv8yVyM8p8JGSK9aSDo+2hr2M8jpt0edZIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDGps9Y1mmTlcIHS8uPvkoB6frxnFDjF+2BMXhsuVmk=;
 b=Wck2BLxEM1uS22bEw6NFcxed+cjn/aYqBmh5fbe2yILLRLCOM3d3T6clNsZLWZkWzLVejHk389B3Bvupz95bIcaaB7LBUMZUsKr1Snv+92mTB3AZ41rtcUPl7QF3nyxw9VKPwAvSIyZFRSjkOBdwgEKTB3Dc7cfX1zjM/+SWOTNys0E3rdVakb1cZxDNDU1dOQgnlPDRtiiIcXqKJBDUzmnz9dCGxdsyeA0LMAH4q12s2Y/wFfZilhFnWnmp9t02dECctFR6aT1uhgDrQ5cb24eROl0neNRte4ZeTjsJg+i1F/QTrOou2tfIJ/2Pa9uxz8TZHbHzO8yC5WFoYKXgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDGps9Y1mmTlcIHS8uPvkoB6frxnFDjF+2BMXhsuVmk=;
 b=NiCD9ksGM9j1eyppJiCKPigqctwt063wyxMaWTYBh6++COFpd+cy9Q60pKcSrn0+R/tOGIIXMIkhoyBD9GQf7aoXc3G4V3u+3nwfxrn7NkubvAotctkIDe6ANgvj/RUHqihUJqcZLmskMmnRO2ma+ww0Ti1FV4HY2gU+w9wk3LA=
Received: from HE1P189MB0476.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:5c::11) by
 HE1SPR01MB05.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:5c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Wed, 29 Apr 2020 07:35:57 +0000
Received: from HE1P189MB0476.EURP189.PROD.OUTLOOK.COM
 ([fe80::d008:ff63:d459:6436]) by HE1P189MB0476.EURP189.PROD.OUTLOOK.COM
 ([fe80::d008:ff63:d459:6436%4]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 07:35:57 +0000
From:   Lars Ekman G <lars.g.ekman@est.tech>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ECMP is not flow-based for forwarded traffic >5.4.x
Thread-Topic: ECMP is not flow-based for forwarded traffic >5.4.x
Thread-Index: AQHWHfjRfgMpuanyg06Y4Yr0dHd/TA==
Date:   Wed, 29 Apr 2020 07:35:57 +0000
Message-ID: <HE1P189MB04763C235689B8D0498C2C4DABAD0@HE1P189MB0476.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=est.tech;
x-originating-ip: [78.82.61.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bce3917b-d748-4647-0c66-08d7ec0ff51e
x-ms-traffictypediagnostic: HE1SPR01MB05:
x-microsoft-antispam-prvs: <HE1SPR01MB05B7FBBB4F6A51D99973FAABAD0@HE1SPR01MB05.EURP189.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GA9VIOp9jN2q4NfYNhlw4EaBZQFnYyTmbTtppOHGtfYKkHUdKVuHBUPwD1cSgd4WkosT1lyGOnyHHUq6wwHSwuS3r7a8wI6c8wcE7SCSGjwP/Ann3iY7EQ+500vPLmHdgJZgBkN7tGjh8GwnKX5bWr9DqJ9H6FXFLVbrfdh1afauiSOFPzIaK+tGV3/1j4s9qF+rGrr262Fu+KY9Grk+8d38ue6BeNqJKmiOjsEVatui/tkcvrMpVIAETv6qRiiCjiJENe5nVLdYOlclGvRS+tn15XTqj/TsZkpq+VAagph0DfMP5ckuM3IY3HVPBNGKz+ZQgJzmDC/wXJYzAthn+MAQUEPKp5fnwFrM3bQxdkLJh3wd119/Di1nL4O2IILu8PrW4ACPa3ryAt9B/5Ap61bHZRtKBOPiwh+2FM0kxyr4Q4wvPp/KMGFP7a4R3S3Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P189MB0476.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(396003)(376002)(366004)(33656002)(8676002)(7696005)(186003)(6506007)(2906002)(8936002)(26005)(9686003)(55016002)(71200400001)(508600001)(6916009)(86362001)(76116006)(52536014)(4744005)(66946007)(66446008)(316002)(66476007)(66556008)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HFxAlS52FtJhQ2hEMYG1qC+zXItll9TI/zVPh7FaIdcIYYVF8MTMwwh3abMfe4X1tRLcZzACHPVs4jtlUk4YcaT/L3Cf02A5bfeeivWDxUIJXQ1BkjrkWqiRb2N2Rfbnu47EmfIBTvXL/5QMzOuwjwlM/Tpph7xuyqBNHzWOqaenmQwQnqhQ9/qdkjDvNYrsgphOAgLDVRfig8hfE169gDZDcuPa+zLkzECOaSM1VCuWSKpnOU08wIDxZSIAta8IGQuDiRJS0mIzs79atNFGxZfwH/40pr4Ip/fXo7jvKswHg1ztcrV8SlzAhVTcftHyudK3cjWPBgs4e1KM94xAKsG7798cV4PZXaA/C8B4YjR7a3m5erFQBvLbWHhMQOc8qmaNAUKM7XNiqI5rr0CS7XKwYf69rA/SwaNH+NAI6PQzJYTUJdagqHCISLalcmCOOstdhSLjURVeRheBhKtJuJaFjbM+KdOwi2zDkGL4MItjPBYCylpjCY+C4jQShXt7UVSI87Y91et9RRBqF6zQCNOVR/c16JOMbBJJw/+A4S1OGMvagJhYj/xaD2CQftuIkg2+pGSLEeLzt9ChTe3z3LxA62Nq0Z/7IefHrb8SJTZbeWvjAFCgskuCItMbOzl4fVEFY/5o+ZGyBaeNlresovVbO7UtvjEZz6Nwe0fhYD1Lc5xrs2els9BxDdjuCvLbQi3jtX8S8GxWDXlk1JisVuxELuNahf+akQrVtBMxz+hJHkO/Xf2iw9atC14SPEVvZZE6jc2t8D4S3Jc/7p9q+T6L7nt++6XuTqt2QCqiW9Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: bce3917b-d748-4647-0c66-08d7ec0ff51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 07:35:57.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vV8R5u5iT2ISJF8zOZEK6Bh7/5mq7XsQy9DqtTYq9FOkcx8JdBclylyR0aJu/DAzAStNktqefQ72As4h8OrwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1SPR01MB05
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
From somewhere between 5.4.35 and 5.5.7 flow-based ECMP for forwarded traff=
ic has stopped working.=0A=
The fault is still present in 5.6.4 and t is present both for ipv4 and ipv6=
.=0A=
=0A=
Ecmp is setup with (or corresponding ipv6);=0A=
=0A=
        ip route add 10.0.0.0/24 \=0A=
                nexthop via 192.168.1.1 \=0A=
                nexthop via 192.168.1.2 \=0A=
                nexthop via 192.168.1.3 \=0A=
                nexthop via 192.168.1.4=0A=
=0A=
Packets are routed flow-based from the machine where this route is set (loc=
al works), but traffic forwarded through this=0A=
machine is distributed packet-based. This is used as a primitive load-balan=
cer and TCP connections fails.=0A=
=0A=
Forwarded traffic is distributed flow-based in 5.4.35 and everything works.=
 I might have missed some new config=0A=
setting in 5.5.x. Sysctls;=0A=
=0A=
# cat /proc/sys/net/ipv4/fib_multipath_hash_policy=0A=
1=0A=
# cat /proc/sys/net/ipv6/fib_multipath_hash_policy=0A=
0=0A=
=0A=
=0A=
Best Regards,=0A=
Lars Ekman=0A=
