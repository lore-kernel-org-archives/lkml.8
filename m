Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26084C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84532080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cw72+zmt";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PLmI2kzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEJKno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 06:43:44 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26780 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgEJKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 06:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589107420; x=1620643420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xZugeM8/n/YbVFO26h/R1ewPoOJ1uy2AY/hH4fIeCBI=;
  b=cw72+zmtizj1V5guXTXpMkSP4djXV5jOUJfrOBQAg4ZCITdlqdmCvqhQ
   l6K/iHmTr3raUoDJpw9Pu2AOPoR6teJHjfu/oUWY6bOoQ++suTtelja0c
   9IxNA28c+CQHThtSlRNEsiyZNuQqdAyF1F22S/gHzbBulpyPtbAFSpD+G
   WpRZLjI0UFr29KHSMkrEt6J/vUneFUpaXlWBa/RmpEo6F+bR5sx6tDGn7
   HCUr/oUQ73H+nGN7WmeOW1HLKqrrQadtZ2zXdLJO6X880n2ptmmU5q8ol
   ArLlTT57DrsWVHSZw/9MOsGkaoZtmRX/twYT5fzH4y7kZCDEqXSmaooWO
   w==;
IronPort-SDR: bWPL3/hQ8j8fexYACHh9eH+UYEc86To7sOcEoDGl3iPB9KARqxvTsOXU1k0H19kpeSxd++fkUr
 kUaDjoYuyotgiM7FEtJRrcCfgDohSj8/VdDcAgAtlY0TXZ8/yVvfDyIc0nIboinGyMW+SWJOKv
 nOodcNLK5rIgdl3t0teHZXvhbLv1yAbVfBwGSzMBgOvq6vqyC1AsJ9Cnk1qV8rwlYliOP20EaE
 F6t4dB/vvWWrF/UqKs4BCkJIoh2WxnhZs0ohj3WuNjoQ6uoAZSRTjg10uGQVN+6VVR23K3QAsZ
 Uc8=
X-IronPort-AV: E=Sophos;i="5.73,375,1583218800"; 
   d="scan'208";a="72961495"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2020 03:43:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 10 May 2020 03:43:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 10 May 2020 03:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icZlDWu/44TWfYCUUvZCTTy4h1PnwfOLF2xxxe9aWtsxSQbEU3JRsVbyobV5VJiwHamvf9+p+2vJLBXgisMMd0qOyZaCCE6gKB4nLwraQEgxy5VbzffhMJ1K2ZfOLt7omJi4eMz2ZIfEdwfJsZrxSO2X2i/LCgl0p6hu7Bk48/84ElZHkyn5c1UPGbgndli+nS+le0NfMOm+KFA+DdgZtgVkvjl69FxhiRiXxwby+98QwmZOv0P/brGVR8DwqxP3s4Pe/6WhVpBK9/ETJhgbirC7e/bwICBktoJLF8MpqsZAaNxINUnbmYKdPCb3e8hdRA+RpzXVWM2XR24tEvQZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfD3oDzIxbd97j6RMXpmMcZpeaAqsnJsJqDK1Etg/Qo=;
 b=jPuaxqoa7V3xFRdrI5z0vVW4kbJgv+ty/lV9pawAkl1FP4c/TJ7vCNwC2be6ttXk1PYTrsS7mpFr54oMeQwP4SrFrUzDWxD+XpvRkOKGLQTjETAo+JJ7hbPRtFfyhembCo8o6sE3ctuQG5lzlaoYkbmON8M6MsHGaN1o6OlHJq7ZO3T8fIDlmaNe8izZgvQkmpx8sSR76Aaq65U8nEXKFc+1r/JjvGWrPV6bUCS2r6axCDqMmkuEJjeVYl7S2RlXlKh9CyWpJoFusRfEK81SvavNtrZALWzVCRjP5Nuatm8umjvR8E17eNMOxoxX3STEEdMnxs6nH8wYVC0hIbylFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfD3oDzIxbd97j6RMXpmMcZpeaAqsnJsJqDK1Etg/Qo=;
 b=PLmI2kzZ0BwoG0NTAn1AMpnwUl9IFO5H4tkmiapCRTWXnw8F9i6AN+J2/3eINQz2oKy/KegL+zMlnCavknrxv75bzDnEDOhh3sd1RNwD2uR1odoVUb6gpyydLrqX1aIt7H8gsiForc5mTe2WvyP7R2h5dJcYlYd9jkeBZPk3FDY=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (52.132.254.205) by
 BY5PR11MB4369.namprd11.prod.outlook.com (52.132.255.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Sun, 10 May 2020 10:43:37 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2958.035; Sun, 10 May 2020
 10:43:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <danielwa@cisco.com>
CC:     <xe-linux-external@cisco.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Thread-Topic: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Thread-Index: AQHWJrfbDyLqorcjbUikOW2Luyi/yw==
Date:   Sun, 10 May 2020 10:43:36 +0000
Message-ID: <27176656.kDElnbHIDG@192.168.0.120>
References: <20200507162047.30788-1-danielwa@cisco.com>
In-Reply-To: <20200507162047.30788-1-danielwa@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb269575-d07d-4f12-ee0c-08d7f4cefe8e
x-ms-traffictypediagnostic: BY5PR11MB4369:
x-microsoft-antispam-prvs: <BY5PR11MB4369D7C77F1848F04F94035DF0A00@BY5PR11MB4369.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 039975700A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRhsvDYpJwdvzsfayYxRkYS43rCnbqviX9THGeT8ofvLJcM0OFfOb+FuKRBp4Hzcl5gA5bWjqPXCKyEuHn+tLBlcesyeQxR9cmTwKM8G0mdn0NNkA8MoMWpS/P2EYYFaH/vGPc6BHhNRihVMuDA3TYpfgESUfv+mHFqjmLTzdCVo5YxDh6XXnaudKjb1v+FKNhmqEQyKxbizbBpUbg8Jni9M63zFmzMmImXyzIz2uM4ln37Xf+uGYVwWGz4egldqWy8MnOZcUqIdDflSt2c9+o/SmRrtHCTW0XL4C15yk4IbrdZoBke62KgB53HHD1rl5lD1ErzjlTRhujpaB/GdciwOv5MgWfA4cknnVBXb8c8yXE8OLSzMXJLHy6eu29TtsJrGhzkvnTCeNBhThC9grgnB2yiohpVWuaVNA3cX1hq1w7/edRaMj4zPz44vL5X/Qrs0i27h6z87jWW88aLvj6JNaiyZgFyNwMMB8tsI2gw8ULiGqYE3SlgH3uJkcQM2ubwBdVj9rVcIwub1Arv8Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39850400004)(396003)(376002)(366004)(33430700001)(14286002)(76116006)(316002)(64756008)(54906003)(66476007)(86362001)(8676002)(6916009)(4326008)(186003)(66556008)(5660300002)(66446008)(26005)(66946007)(6506007)(53546011)(71200400001)(2906002)(478600001)(6512007)(33440700001)(9686003)(6486002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BJV5kOBuM888STA5C3WwQJeHFENsG8ZwSz4oPrqMMv7e9HsAYaOJgZRmPXh8kq4Ow8MEoXoE+d7tg50CdOsMlEU+FxdT8pVIoxQ64GcJoPK1QpD4F4GQ6JRXq6q44t+S4IhWW0SiCK33ZeE69Wo7drVpQwScuByg42YT1KhxTyLNhIDo9YdTUPPfJOWuui7yj1yx5+UTxppBeDUNEnEYo5XpVxwxb64n9WVNVRoNYi3cOAUOiRySSohkidDhxd51WuOxpZov9n/lMfQdCOFQdppb35V49nbdngKfEutefgXZpKpx+ISVIi9ujC0S/B584LuPJ8BTGNTdzO+ghUc5jvayUP0OxwlTFVMPifMuVw+4JicgFswn2nEd1enKSlnbkdzjqC5aq67A0Exvu26RAc2p8c/8UoAlhF6qyLFP/Fy/iIJ/N2ctiFlMmSpvnFYwLHb812Ke7kfI+12C51iQbwEfd3QEwryVUzO0c9qssME=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19D37A7124EA794F8496FE49201C746B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb269575-d07d-4f12-ee0c-08d7f4cefe8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2020 10:43:36.6375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sk9mfRXOLfpPSOtJy9BvuWTQXFhgabn65VM4dUPkT6lLow8M1++9WkHdRh2lsaxHCx11XyqpjXxURHKr50GpQqjCeCkDkWaopRGIvtqPOy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

On Thursday, May 7, 2020 7:20:47 PM EEST Daniel Walker wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Some chips have 4B opcodes, but there is no way to know if they have
> them. This device tree option allows platform owners to force enable 4b
> opcodes when they know their chips support it even when it can be
> automatically identified.

I would like to detect this at run-time if possible. Maybe we can distingui=
sh=20
between the flavors of your flash by inspecting BFPT[16], bit 29. I'm plann=
ing=20
to parse the 16th dword of BFPT. What does your flash return after applying=
=20
the following patch?

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index f6038d3a3684..99f0ce57c7d0 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -457,6 +457,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
        /* Fix endianness of the BFPT DWORDs. */
        le32_to_cpu_array(bfpt.dwords, BFPT_DWORD_MAX);
=20
+       for(i =3D 0; i < BFPT_DWORD_MAX; i++)
+               dev_err(nor->dev, "bfpt.dwords[%d] =3D %08x\n",
+                       i + 1, bfpt.dwords[i]);
+
        /* Number of address bytes. */
        switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK=
) {
        case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
@@ -972,6 +976,9 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
        /* Fix endianness of the 4BAIT DWORDs. */
        le32_to_cpu_array(dwords, SFDP_4BAIT_DWORD_MAX);
=20
+       for(i =3D 0; i < SFDP_4BAIT_DWORD_MAX; i++)
+               dev_err(nor->dev, "4bait[%d] =3D %08x\n", i, dwords[i]);
+
        /*
         * Compute the subset of (Fast) Read commands for which the 4-byte
         * version is supported.


