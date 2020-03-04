Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5671C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAA820848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rSSVdt4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgCDMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:49:36 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:7847
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbgCDMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu9daGW0EFps3KFqrbFSw0cFEhqlVEJNIL9CmjCK/wmpWpdr0RnpIl6pBgyQVE1ag1ISk1khv3lprF+1IDBVomRDTPXLTg67BxygcLfODXpMZFb3FV3CtZW1hsPoG3KPpvWee2lcm6ICbnd6lGgFh4GD34tRjECWzpLZw9YHBJzjEg1o0UuhXd3ErbD+LccZVd9I1LvMwm0TrOoJtsodBmbd9Bsdhd0hfLUT4b8MgkY3tT13SMv5iB6hZa2CHD/zV9Yi5qImJE9zOXmmUOe6y22Pqe0YN8xxGb/BK9OZOHkWnPj6DNTGVae4Nq1s1L3rWNRtDzzP2ENyhfZXwcct8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izSysmV41v0lruO8f3RecODel0Mjyb8422Wv+tsZVU8=;
 b=ea9FP2z9gf0/Dvy5Pg7+O7G1yujFRf5qo8MpkwfoV8Hkj/NaJlMCsu+h+yzOgN0/ULmBuz60RpS3TIdrLS645nCU3UevGcnfC+OYsuEWM7Il6BolZm02RSjiAfbX0WnFTNERajUPXp53yasOEO2ONmXXlmCj3GqEjNCT2FocJn+pLpyUZsNlXwO1nAmM4i8E6BWhiSNEO7ssM3+3y/taS6Ln1oLBymW733ecD8Dk0J5wQ4a0YFBWoeyB1EfXetS/gF3qpfNZRsO5Hm3/UFOTuvawhiy0zMDoigpdN7E8fytBPhQWzCs/IkdVJKNrHNZlonHgQnpff9iK38RW9YAKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izSysmV41v0lruO8f3RecODel0Mjyb8422Wv+tsZVU8=;
 b=rSSVdt4EOspOTnBKxpOlp2v5WBi6gFcalLI864BhrNjyN5/aD0wy9Vpeg/vP0TTmlGFR8tUFEdqraxhGu+aVgdN/qHB1rDB+nkFqT4SfRhaFn18OMqWBvWcrGR72aUhYgcjCL9lbKWV4WBK0cVUD5kAChcG1o0tsP8HQZ3Kn78Y=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4017.eurprd04.prod.outlook.com (52.134.92.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 12:49:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 12:49:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Thread-Topic: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Thread-Index: AQHV8QFMuMBBDfh8hE244PoeMX235qg4QIWAgAAijkA=
Date:   Wed, 4 Mar 2020 12:49:32 +0000
Message-ID: <AM0PR04MB4481A6DB7339C22A848DAFC988E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
 <20200304103954.GA25004@bogus>
In-Reply-To: <20200304103954.GA25004@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1b6151c-f74c-4916-b52c-08d7c03a7c8e
x-ms-traffictypediagnostic: AM0PR04MB4017:|AM0PR04MB4017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4017BCE219C93DBFF293A25F88E50@AM0PR04MB4017.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(26005)(478600001)(186003)(9686003)(81166006)(8936002)(86362001)(8676002)(55016002)(44832011)(54906003)(81156014)(6916009)(4326008)(5660300002)(33656002)(2906002)(52536014)(71200400001)(66446008)(6506007)(66476007)(316002)(76116006)(66556008)(7696005)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4017;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vb64GoVjyKgnLmn4frqHUOeN0YqqaRMWaEaThazqlQF+Ob7LWvveFWDprvHoG54Ef/9254brp7o6Sk5X/B70mJ/bBcHkOsTTp8DV9Cc8mwX2OgdYIUXfRretBiDP8p9993rSO0jjIWZEHJEkWUNZ64xiQbYNM1xQwWPbmc+JxqBsdDtuJcq5pQIlVDqgSBmrRPpHb1gUMLcUvktpHdfBeUCGa90U1ZyqGY9FzyQi24E1PGAKvNKgc91UcxDNR2CdCoMQZef+qJ43qmL+XfnfP3OlqF9LdN5KabxnQ9h98iGuOk4wV3875ufjDE0vLWeoFBz2XThmQLwRk9QkE19YUIDuFapT0ljvoezv9VpJ46ES08ef5maqgIhigODLCJviFxHIS6VxXPAJCTRlR7EWylT9uH4uyHwxf0fvWrfpbBCjWcXtc6xWw8mCjDgwQ5s3
x-ms-exchange-antispam-messagedata: Eiu6a6g8FAI+Svltq5WOaUc56SMvqXK1CU93ppHZgk96yJ4cTfbp6UHzix7pU1aLDFsfvK6SsJG7VlxAkY5cSG5sM8NLhjw9RlzRhmv2F2EW84ODlRISu3m2eYHAcECgIUUCyQPCx5DF3gYRLlJO6Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b6151c-f74c-4916-b52c-08d7c03a7c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 12:49:32.4848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCLdcQihNE+XA8iZypW+6N+mrN1fcfkdV3CfE8aQWBe6GIhxj9qVVkQGNuD0keoc+az/Q46euosIo6OKSU8u5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
>=20
> On Tue, Mar 03, 2020 at 10:06:59AM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Take arm,smc-id as the 1st arg, leave the other args as zero for now.
> > There is no Rx, only Tx because of smc/hvc not support Rx.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> [...]
>=20
> > +static int smc_send_message(struct scmi_chan_info *cinfo,
> > +			    struct scmi_xfer *xfer)
> > +{
> > +	struct scmi_smc *scmi_info =3D cinfo->transport_info;
> > +	struct arm_smccc_res res;
> > +
> > +	shmem_tx_prepare(scmi_info->shmem, xfer);
>=20
> How do we protect another thread/process on another CPU going and
> modifying the same shmem with another request ? We may need notion of
> channel with associated shmem and it is protected with some lock.

This is valid concern. But I think if shmem is shared bwteen protocols,
the access to shmem should be protected in=20
drivers/firmware/arm_scmi/driver.c: scmi_do_xfer,
because send_message and fetch_response both touches shmem

The mailbox transport also has the issue you mentioned, I think.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep
