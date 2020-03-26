Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A59C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8376F20409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="scJE1cpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgCZLqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:46:49 -0400
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:23905
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbgCZLqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:46:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjz3zNmsWlTEqnb/EBtrM1aLX3eQI3cydPq6M3scmfJcYRyvQJCupgkSMLEtQBfSv/yJ117XoLH4y41JRUPmAF8HIeDz8r4GLU/vhAzEwXqoXvdIvYKWfTarg1rz6DWLibX5XoN+qvrHF5F+o4TqOU6IColCH/Qd85GvxKS9mUH1zfJTOPdt3qNOdbIygQ1nDnM2h2++bQ6QTuPpa/Ea593vtk6p2T1a/gHT02jG4dRsfDvtEHeY/nOpsjRD01P4M1Xf6hAqg5mIOkKmRTUG3eaE9DNxhBUGrNOF6vsXC6qI3iD4firIU7GLVball1ge3Ax01nwFJKBTGUglvGogeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBPw6vdnMsiwIaCr9J7hxVgHYJt6zmC3nffZOvDowp4=;
 b=PREiaBodv1xcJfAxwoQa0AcLc75wNStcRAyDPz3ce3MQfve/jjh0Uhtsvwgq+HfM5z+jaiXUAsz/IRNDpyHAoM2TA6ifFgu/indZMCizYGZNODeflAwTwI9J/DZoGf7kAJ7/zQgA0wylSEIH5bHH7EIAD0ECF1buQ8k7TIX+QpTX3zpOnCh553eC1BM1Obe8yYcuk8BuFUk6MugKjMr4ru5E3WVhTywD/5ieA6xmgwWLtljcABcvhghO4aadi2qzG6RcY79E90jABBDncP6B0LE6IGZgqLNsOrEg0fZCBVRTrx8R8Jqz53K/Bx25Ay96s2KkXXdVTqF6T7xz/6EPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBPw6vdnMsiwIaCr9J7hxVgHYJt6zmC3nffZOvDowp4=;
 b=scJE1cpfXgQOTeNngtYOvKBua3ARmVKEXesSOr9pq489vhFpW4NhCT7oYWW0k6QDR5R/qD/hfWufeil3Tsl/hrbA4s3sAz0XjWhbcupEzwGwO2L5CU+qEBcopN6yUW2t90PXtiL0aN8tYyLXX/E03kDx+b49JWAfxx/+Qt5ZwiM=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (52.135.57.84) by
 AM7PR04MB6853.eurprd04.prod.outlook.com (10.141.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Thu, 26 Mar 2020 11:46:42 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 11:46:42 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Colin King <colin.king@canonical.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: make signed 1 bit bitfields unsigned
Thread-Topic: [PATCH] usb: cdns3: make signed 1 bit bitfields unsigned
Thread-Index: AQHWAqQFXOczHDS/p0iYhU6YMSQfIqhaw0CA
Date:   Thu, 26 Mar 2020 11:46:42 +0000
Message-ID: <20200326114703.GC23632@b29397-desktop>
References: <20200325125041.94769-1-colin.king@canonical.com>
In-Reply-To: <20200325125041.94769-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f893a442-286b-4d5a-6fb2-08d7d17b5a83
x-ms-traffictypediagnostic: AM7PR04MB6853:
x-microsoft-antispam-prvs: <AM7PR04MB6853E8043741DED5534299C88BCF0@AM7PR04MB6853.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:352;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(76116006)(53546011)(6916009)(6506007)(33656002)(86362001)(5660300002)(316002)(2906002)(478600001)(26005)(1076003)(71200400001)(8676002)(66556008)(66946007)(186003)(6486002)(8936002)(33716001)(81156014)(81166006)(44832011)(66446008)(66476007)(54906003)(9686003)(4326008)(64756008)(91956017)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB6853;H:AM7PR04MB7157.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+9EuTN77OGaVWktdIOOJ9kS0W4aS+jRpPfXN4QUZ4f9VviJJDlgge9jV4BOP0+mBFGGqfzz8xY6KbAT9CNSH3AK7vqKmrvkQTxeaUhP0h9AfNQLYKeyAUECk1pUil1EuFwOBHyQN+P6JYVSa5oxPCHVawmEFSNfQi+6/VjsuxYM3cl6FkJM9u8rHRzpeMG4L6Ib+qp7ymNHCNBsUYo0KVCNbDzPNw4FcJRWeZdSwoArzs7GJxRQIhf7gCpDCYOk9XX/5Pc3igrCa/NjSCImAissJjLNkV7vIdPHFVJ3kf0kXESPKgz1Gv9POpZ67qpNQfhtJPDxLUCyxMEET9lEPQOVn1taMHh2a7NIJYGItWqCHYXXinzyeu4pEUYB4SxJdYfrTKvRTbNwmAJHvYwMpdwfNLAsNcIxsa27alVJAX8XaF2H3R+V3a4urEQsbyD0
x-ms-exchange-antispam-messagedata: FFXQl1VD4ne2da2+AYtvNpbnJ5fD9sbp6f5aFmv0voNq+/TGlqxEshhNuHuVmCgrNrr+sA4Ei2kAk1OFq0iOj7jsI4wiOpFvI8MkTdajU6QreBOoZxCfCRkDDNBGJ3TDW+rRmmPODR8PLbp7vmwxYw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4712C137F84924F9E05ABE16AEEDF66@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f893a442-286b-4d5a-6fb2-08d7d17b5a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 11:46:42.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5se5mloSlSgbqNOPV12Wz7XOn2URI/J1PyACocPMT3mjfspJun7pyKPVMtFoi7/as37eaL9yAIz7NNu6HpJLGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-25 12:50:41, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The signed 1 bit bitfields should be unsigned, so make them unsigned.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 4 ++--
>  drivers/usb/cdns3/gadget.h   | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index c6a79ca15858..5685ba11480b 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -52,8 +52,8 @@ enum modestrap_mode { USBSS_MODESTRAP_MODE_NONE,
>  struct cdns_ti {
>  	struct device *dev;
>  	void __iomem *usbss;
> -	int usb2_only:1;
> -	int vbus_divider:1;
> +	unsigned usb2_only:1;
> +	unsigned vbus_divider:1;
>  	struct clk *usb2_refclk;
>  	struct clk *lpm_clk;
>  };
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> index f003a7801872..bf2828e4df2c 100644
> --- a/drivers/usb/cdns3/gadget.h
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -1199,7 +1199,7 @@ struct cdns3_aligned_buf {
>  	void			*buf;
>  	dma_addr_t		dma;
>  	u32			size;
> -	int			in_use:1;
> +	unsigned		in_use:1;
>  	struct list_head	list;
>  };
> =20
> @@ -1308,8 +1308,8 @@ struct cdns3_device {
>  	unsigned			u2_allowed:1;
>  	unsigned			is_selfpowered:1;
>  	unsigned			setup_pending:1;
> -	int				hw_configured_flag:1;
> -	int				wake_up_flag:1;
> +	unsigned			hw_configured_flag:1;
> +	unsigned			wake_up_flag:1;
>  	unsigned			status_completion_no_call:1;
>  	unsigned			using_streams:1;
>  	int				out_mem_is_allocated;
> --=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
