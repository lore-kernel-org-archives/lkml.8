Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B38C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174D220708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="GJWajk9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgGIIxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:53:49 -0400
Received: from mail-eopbgr1410099.outbound.protection.outlook.com ([40.107.141.99]:33312
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgGIIxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdNB10erpxFy9nnwh13C5rEB0K/U/afI9crTAgzyLvsH+VjZ/zLmzG2k7uh1EWmhfpp6WMUjfnaOYPiUCapuGDOsJhMGFCjKDSLtro+gfZkCm201Y8UFP/+w5i/m5jWtKf8RmEp0lSed9JLyIkqSUA1LWuRQmgt1htEL6HyLR8csESYwNbxdoDBaLmnHz6gqgJzZQP231JZX+u9zfWd+cTvdhaz5dvRaFqE0gjPzQJNDTAnkDmfSkjbizsexTDx1539i/wnvw4pXEBb7wJA034qHB80tP8Ru24YUm4slpzRAw2254bXU11kOG3RUZdU8961ADpXgCHXo11kFUtu8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WPKPWD2RmlVxwpereyp2qTT/tOyrKAqrGe7rheHyt4=;
 b=PKzF6P4GleO8gws9TjfDF68WP/S9qa3lu+do2n8y3AG36gCUmIF7sQNXMWT1wKGRUN7Je2IE1z1Z/4jRNu95CXSy8mr9j1Ta7hTxKbUv1o+OtHqeFB41tJNa5D45W1LcU7TjlT5P+G9K/QP+HBx8iXTHO42lrzkTGaQhkCNnzcHCLm3CvjbHErVjn6R1Ugy2y69E6jjzcVIP20seesX60vU45R4RIYgkMKpdrF/9/GSC/gOp2Bh359+dF5IatN5lKJNPHWtIqspjwr6mnZSfQkS6OfDk/5FEW97+i38uMVONXW7EBAwdmUwa7S5CRuLGcEqpA2YkOuklvDRUHWrcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WPKPWD2RmlVxwpereyp2qTT/tOyrKAqrGe7rheHyt4=;
 b=GJWajk9APX5Yxk1oYF5DZ0IryyeE5FiJwPVktkrtTXKPA+Q3VFTiYA378Xz0vXKievV3G02wBBa+xbew1/oHs+e8x2fPATG2Gif+ptNanOkBFror0h4aW5Drcf9Al6RmFhmWtz8cfseIgnaKXkzL8cp8rqJ9HvzpVfBczWWesUM=
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com (2603:1096:604:4b::15)
 by OSBPR01MB3864.jpnprd01.prod.outlook.com (2603:1096:604:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 08:53:45 +0000
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240]) by OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240%5]) with mapi id 15.20.3153.029; Thu, 9 Jul 2020
 08:53:45 +0000
From:   Dien Pham <dien.pham.ry@renesas.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates
 sorted
Thread-Topic: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates
 sorted
Thread-Index: AQHWVRf8HB43xR4TjUalzDhTy/IIAKj+40VwgAALF4CAAAG5sA==
Date:   Thu, 9 Jul 2020 08:53:44 +0000
Message-ID: <OSBPR01MB402413D62446CFC9FE2B18E9D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
References: <20200708110725.18017-1-sudeep.holla@arm.com>
 <OSBPR01MB4024648DB0F2C680892B442FD1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
 <20200709083808.GB31544@bogus>
In-Reply-To: <20200709083808.GB31544@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [210.245.28.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eca35f25-77e7-4757-b661-08d823e5965c
x-ms-traffictypediagnostic: OSBPR01MB3864:
x-microsoft-antispam-prvs: <OSBPR01MB386455DAF4BBBE3A05DA22D0D1640@OSBPR01MB3864.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:157;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PotR5PnpgVdpuKomZ9W6fzMlbx2/Nwmf8PQgwQF4YSHXP1lJJ7SVJz8VA2koD/5Oa1vSEVlCdNEPibSbXHMU+VqXGszI/VI02apCVuZgB+P8vz6kU/twY+TGrHdA5ayIk8Yquy5Qz0He4bVC6JVoq35RZjMDwwt89Dd+OTXYVwzTIZbMJLWxUpiOifvpFUmBEWqF40w8O+W7DyryEnr0lUYfJMaJmVOIQb61McQQ1pHURGDECdZiM6n0HRwwEqQdNHHhWt6iUGIpMTbLsnmy6miP0x7mgU0oiOjMlbQDLqNqq0q6odDhjbu7gYE31j2LcV/qhwA+B7mc4YmG/j8iAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(6916009)(33656002)(4326008)(478600001)(9686003)(86362001)(83380400001)(55016002)(7696005)(54906003)(52536014)(6506007)(71200400001)(186003)(5660300002)(26005)(76116006)(8676002)(66946007)(66556008)(66476007)(316002)(64756008)(66446008)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Abl5Y118PA+ei6wtfRXk7QNThSwGqpxHvGkgK5/Vfxa1X3tiBM1gh0DsgASRVZw58W+QqOpZU0vjKGbw6Y9NhJJ3P9nH/iPLXGRN312ftEeRzKyTqxl3bF6Xza/ReVSf1Hj5K8ktu83kghA7Vgnb7M+ntH4aa2K8HrXj7+MhkffSs9Hd4VeFC92Rni1nWqaItlsD5I+i0kz7IfoqLrD3naaJh+USjQfcpPU1LdhZNkoIsBpDscTBPMUJBL8s5/UiQFQn5NwuVawHpX2W0sXU/N7cLvQQ0CzwuM90RkLoMv/cu92k4B8WcVYTkl9hn+DQtx3ZEi+9WsIeQz00kOhwZKVIReIZqTsyAWzdmLvMA/bQ6XVT7PkiRJDH333tFyM3jo4K+WTRZDgdXIXHH71UZEsw9/BWJ9JRWysYq/gqoFYMS2m5eU9VU1yOModMPxuUYNGc+SD7FJexevxhu1cFOqhc9WS3k5xawe191O64hXU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca35f25-77e7-4757-b661-08d823e5965c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 08:53:44.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34pMhbKUhZDLYsPr5iGmjArxnw/gL3mnFmuegAo/6O9L/VAC/aUuo1qiphZYubWRtOmEM6Nto13y3q0z7bh0ABozClLsDMcpc3VNJ7/aMX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sudeep-san,

> > >+}
> > >+
> > > static int
> > > scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 c=
lk_id,
> > > 			      struct scmi_clock_info *clk) @@ -184,8 +193,10 @@=20
> > >scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 cl=
k_id,
> > > 		 */
> > > 	} while (num_returned && num_remaining);
> > >
> > >-	if (rate_discrete)
> > >+	if (rate_discrete) {
> > > 		clk->list.num_rates =3D tot_rate_cnt;
> > >+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
> >
> > About warning of above line, I think it relates to below snip of code:
> >                 if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
> >                         dev_err(handle->dev, "No. of rates > MAX_NUM_RA=
TES");
> >                         break;
> >                 }
> >
>=20
> I don't understand your comment and relation to above warning.

I'd like to mention about below warning.

>drivers/firmware/arm_scmi/clock.c: In function 'scmi_clock_protocol_init':
>drivers/firmware/arm_scmi/clock.c:197:3: warning: 'rate' may be used unini=
tialized in this function [-Wmaybe-uninitialized]
>  sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);

The warning for line
> > >+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);

But, I think that it is affected by 'break' of below line. And for fixing t=
his warning, I think we should fix inside this 'if' block.
> >                 if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
> >                         dev_err(handle->dev, "No. of rates > MAX_NUM_RA=
TES");
> >                         break;
> >                 }

Best regard,
DIEN Pham
