Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA7C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5F320752
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="X5FsH/oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgECNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:31:44 -0400
Received: from mail-eopbgr20095.outbound.protection.outlook.com ([40.107.2.95]:59089
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728503AbgECNbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:31:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOCGudASMRw1fYFuvqQrlyzL7h9CVBj4fDP8c7fPj24BipxhVSsPlRMsVhMTGu1tr45drb3g4M19SRFcRm7j7KV6cGlq3Lr7BzqLYzmeWHnQi/oWV/RYLbgTCh+z4zjnwM77Ix4NJ3imS10XE8Qzs4af2QQHp4YHEMkXAvKJLsu5kc/eOjjln+NfFF2Uy4FfgGk18OPCJZFodhl3yIyfMYKlHAlt2F3XuG8omw8z+CMGMrsKj6+MHize4H3edEO6WJof0+raJJft5LqWBFcHcA3/twfyML/ULAD20Dkv26mkUVJYB5rZw84s9vYIXGK51mpL5pPjrBgHIEj81oRY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl+EXMB/t3D3ouDkeqzHj+hC/FUjmB1aSM+GmzXlmNY=;
 b=oFIcZBUeP6M0wmTe4q+ERtZqQkS43RDMDUTZxVYRzLKeegyt+j9SAmow5WtjNEOmsYDEMadx8VLKysH6lm5SV5sj/Y7M9IivhZOS/4QzLbCQPJnPWBK1lzB43IwGc9VKpAIlYwtxnCUjF814XAPoz2yt9y1v3HKdSGDrBKl5TI6W2DutgBleldLmMDSpU46QUVg4YjyttEVQbzP3oVHAB+Kcm18telTZX4TGNSu6dXLntt7M2A8eXEIOIcPTukniQ/t6PGyLwZ2PuAH5IE0Dlcr8KYbxxJZuF8qOgS33dIigZIcHT254gUqhddQblXzpWG8jAw0ZA0FClGCyUem9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl+EXMB/t3D3ouDkeqzHj+hC/FUjmB1aSM+GmzXlmNY=;
 b=X5FsH/oRhTruy3rUThRZxhMqY/sl0t02bfLN2fptbOpjGDP5ItHpGs1A2kLtCawbamX7be0RGJB4A4qEpb5wG2RskAsCqv7mEcT2/l4TAiJdB0gXMgcJz0+cdAOwrqjBELuqpqvhtCzdWgTJyMpwdkYNijYazvye+o1UArr03Q4=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5964.eurprd02.prod.outlook.com (2603:10a6:10:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sun, 3 May
 2020 13:31:39 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 13:31:39 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: add missing MODULE_DEVICE_TABLE
Thread-Topic: [PATCH] habanalabs: add missing MODULE_DEVICE_TABLE
Thread-Index: AQHWIU4MAeE3Irf4DkqNm+iiUTpfzKiWWzSA
Date:   Sun, 3 May 2020 13:31:38 +0000
Message-ID: <DB8PR02MB54686A083C296BE75AE01B69D2A90@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200503142919.14863-1-oded.gabbay@gmail.com>
In-Reply-To: <20200503142919.14863-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [93.172.156.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8dfc53b-614f-4194-a463-08d7ef664f4f
x-ms-traffictypediagnostic: DB8PR02MB5964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5964406CF8F2666CE9889A8ED2A90@DB8PR02MB5964.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0392679D18
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYdxf/qnFItdJyxh/eQQsNb11cZT35Fq8Kvd5EqKaS3OUKX41s9TPYc3u6u1ocvRqtpUzY8kRZ222CF7WWO0e2YRyUUUVhAx9F6rc4Ilv2WHCaecN55Q4skKYW0gy94wioSU8bWPAa22wqTfvDGPxXuhtl1Tv+XCt9nV39h0O8ibzpCupHu7hMbMCYQ1GkvCQ/a1RIWrVF5FsHxwvwqO43g8NbhlMg5S33qizeAMExQWApPpHpYwJ10dlUD/hY3kJAsg/A00a+QpfC8esZl0GaRPCa9GqcDuNhC0tjldE/dsOfuLcrqxFHb3OYqXuiUH6as55egV9V7Zer7cTKoYyeDw+v6pGE6UteEidT6kzm5X6vDOgjMSNpm7V6gsgYGX+U4YZ49dprOlqFSidPScnddTJeq0h1zwBds4wyFcHzvsMnAAC22sfnWt1lW1bI1D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39850400004)(396003)(366004)(376002)(136003)(2906002)(186003)(86362001)(478600001)(5660300002)(53546011)(8676002)(55016002)(8936002)(6506007)(26005)(33656002)(7696005)(316002)(4326008)(66556008)(64756008)(66446008)(66476007)(52536014)(66946007)(110136005)(71200400001)(558084003)(6636002)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gj+SsliCMEtr9p10ix9NM0SowC36tKx/q/fUSTnyly+jvDI9aXNdhITt5OA4spH8WH1ACPqEcHk6vkr1I5n95ri319D2vgyH+adgTzgy4G/O5n3omFewweWxwaR6hVQLXa4tAQvnIyYQAbRYR1XIpCf5LKzpCcS3UEOJJ6vTFYePGeEi6tn4O4Dsx5mquFcJTY0lasD7/UNxoure+XZetZo6SrL2AJ0aQMpuBUmRuX0x36qESOgGGJzLw8Fh4pak9Pphh67PksuXijgkn9qkjc9p41FwhJgHDXL9Lf8zZpMpIUud+rnXioazoqfvor0SNxbBbdEVNh+Bk+OuiCSP/DJoHUHYb7yCqFTPaasdzXlpbtc75aOw5WKZaWXzyRF+zTcyMw8bzsxYg6QxOGnd0gTVVQiDW4ZaaZnw2FiWQlheAZEJz1k/xWJZYwKaBxLrsdzIpnaqtNrnqXdstCUBF1DzDhP2Irqs123Cl0ItAYE9Vgzm4HGuj6RcZuNwpiGKYj5xlIS546RTsNX3I/fvTCzIWaHRxe+l8+piL5zFj5qxua9zz1O6w28LcJPljxKxyBoiEeCh+fXIhVIKm+N3EIVWew+5CqOrQeCZNv5N9c/fYJA7mYUjYkBVtJGDj07G9S8G1ikdvw4ufb9L3E3q5p3zZDWBjb1HBIceE/7FTGGLp9lnDP0vAiJ5umZH6nPQDP/FOkO+yIhpo8RPlB45BIUhCYvglSSjYlfuYywfGBjjDGb543+Vw/TSKSrmmmvP2rmRrK2gv91tDorerPmSlocvyJ9XPiJAv1vI4aKfu68=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dfc53b-614f-4194-a463-08d7ef664f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2020 13:31:38.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3LGC0uMAPe9eiilKHQaAHcyuJbdrZqoKM9PtOPvCAJa4qEn/plsydqAcQ9S5aPPBG1qpuz20A/xwEz4vWLUJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 16:24, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> PCI drivers should use this define to declare their PCI ID table.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

