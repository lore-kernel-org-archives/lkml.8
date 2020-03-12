Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB5C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE722071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qF34li1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCLJjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:39:22 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:39298
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbgCLJjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:39:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dup/R+OGPYlgrXO2L35RYWWqReHmL+CBTtzsXhrldatBID8YkvQGJAITAYjnA5EMIek4eGMJqO42ovRx0TWXRkvP7/iBSsBZxT524H7Y2+24JGnG7wEipx01HBm78Y6k+09ZbMcn8MPQ/i869KX9I6AmQofVDVZ3typkL4/82O09lReywGYQ3iISKkfv0RimLZlFLF+jJZTpVY84+Yo+O5YIidmuX0r9j7TYUoPzRJ5tLFB3eSe951dpOwGEu51WF1ZXTcDbhdSEt909Ah2zT03coKxtcOMK3R2Nya5QZTXntBwQ4uxa4EEMt6gR14meULl0vG9YuP17FjDuBZv+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRFdPejQLwGTMKiznfPHWuQAOKuKVH/W1TOCfX7AlFc=;
 b=RhH7JXC51BLc7AddynwzrnChf7hDGuy3RzxujcnGqL9RMh45WYSE9M7YDhRkdSL4Gw4kRLEFbc+EfXqYdI37zhjNP2ngGN+cjAfSljFFfMMPXrUhlYaGfsAiINd2TUYkLspbj1B3Y2TBrGF/K/h44CnZesfbk0HC8ZgMv7TeMjPCsFhHWwgjsqjXABMjHRzpyH3g5QU1oJYHMORtCIVMABZq8oTq9PXnftsT5GlludBLRgKuVGLCUbp/j1vGZwGvKBnAiGer0+tTZ+Aw3avd6XwSPJ8LYhMFmT039tTxs1tdsm7OyI3ijk8CYyFtgsOJ/s3L+HXB5Iq5mdqyl4j9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRFdPejQLwGTMKiznfPHWuQAOKuKVH/W1TOCfX7AlFc=;
 b=qF34li1UtfEqsExBUdip3fdshdmrzG64NTwziVXmXvQvctQABAZyiBw8rt7otzdVom1LcNdjv35PE46UtA16ydeF/90efBPBfBwx63zu1dQhn2RnK+bu6xl9rEuaYpW6RE7RT8NJ83QcEo/MUe1tOU01rCPC2rGTioYPeEmvAyo=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6989.eurprd04.prod.outlook.com (52.133.245.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 09:39:18 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:39:18 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Andrey Konovalov <andreyknvl@google.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 3/3] usb: core: kcov: collect coverage from usb
 complete callback
Thread-Topic: [PATCH v2 3/3] usb: core: kcov: collect coverage from usb
 complete callback
Thread-Index: AQHV9kBk+9Olkm/+Q0G93rqDG1Hx5ahEt7UA
Date:   Thu, 12 Mar 2020 09:39:18 +0000
Message-ID: <20200312093920.GD14625@b29397-desktop>
References: <cover.1583778264.git.andreyknvl@google.com>
 <32bce32c8b88c2f88cd0a8acfcdb5d3a6e894632.1583778264.git.andreyknvl@google.com>
In-Reply-To: <32bce32c8b88c2f88cd0a8acfcdb5d3a6e894632.1583778264.git.andreyknvl@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23bfa394-3280-4c26-b793-08d7c6693c5b
x-ms-traffictypediagnostic: VI1PR04MB6989:
x-microsoft-antispam-prvs: <VI1PR04MB6989474010577D1ACD5B03838BFD0@VI1PR04MB6989.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(81166006)(33656002)(6506007)(53546011)(26005)(8676002)(71200400001)(478600001)(8936002)(76116006)(64756008)(66446008)(6916009)(91956017)(66556008)(186003)(66476007)(66946007)(1076003)(44832011)(4326008)(6486002)(81156014)(54906003)(86362001)(33716001)(2906002)(6512007)(316002)(5660300002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6989;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMR+53pAMUYDEqLa2DaBxgFlZ8/NUMmDpEZK2ZDm30SXovyPpSUnaq2F843x1pTGpeclpbyHqnVj69G0XYM/M8j5tPajs+UinnMh8ZXCR2eX9MRg1JZyoVNVhHXJAct+CTSdKuoEoThO3hhS2CKdIWiPS8xsJZvxF10gYKloAx2anQE/s7kCJmNxY4h5Dy15AENoWjbTuvjf+8lx3QsB56gsWTIh/7SeyisvyMO/eLcO+2Ecq2zALNX9C5i8vPhCXdQ0bpE452l3Mf/LlgM9cCvzY29prHczVVer9j++cgKKJl2ygE6OLWobY0297lBOLsHN8AzOx8kcg9eDa4x1VUwcdrujh82XdMhIIWjTjFm/hU7lmCJjTALhAmw1yLMC6tjQV0jo9i1FhC0j+CGjfIk71hthuRB2vMetyBkocJGsvSdiuJ2XdzaYINLYR7Gz
x-ms-exchange-antispam-messagedata: tMoj06oxrrMgN6yuAKf1twlz9G4NbVIGQ9/G6G/A5lz9qq0ponJKc/MBL31onAAODzq3Q5i+kcSV3HjsTFdKVwlknvC/G4A6uSHgdfbCea0UiGQ8FF/wctzjidBzPkrl/iVLPt5QZeB4S1msrdiLXQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0AC0996DECA194E9F7804286B5464E9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bfa394-3280-4c26-b793-08d7c6693c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 09:39:18.2174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4X7SH65rutSxQRXDrd16OpFU9p2loxlHV+4Gu4hHvhLMkIC4jS20jJino/sNQmnQmeD6WpCkEFwsA9L81JtNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-09 19:27:06, Andrey Konovalov wrote:
> This patch adds kcov_remote_start/stop() callbacks around the urb
> complete() callback that is executed in softirq context when dummy_hcd
> is in use. As the result, kcov can be used to collect coverage from those
> those callbacks, which is used to facilitate coverage-guided fuzzing with

Typo, One more "those"

Peter

> syzkaller.
>=20
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/usb/core/hcd.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index aa45840d8273..de624c47e190 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -31,6 +31,7 @@
>  #include <linux/types.h>
>  #include <linux/genalloc.h>
>  #include <linux/io.h>
> +#include <linux/kcov.h>
> =20
>  #include <linux/phy/phy.h>
>  #include <linux/usb.h>
> @@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
> =20
>  	/* pass ownership to the completion handler */
>  	urb->status =3D status;
> +	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
>  	urb->complete(urb);
> +	kcov_remote_stop();
> =20
>  	usb_anchor_resume_wakeups(anchor);
>  	atomic_dec(&urb->use_count);
> --=20
> 2.25.1.481.gfbce0eb801-goog
>=20

--=20

Thanks,
Peter Chen=
