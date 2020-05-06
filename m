Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6681C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD5D20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zi8HNhSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgEFHvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:51:25 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:60132
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728280AbgEFHvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1NSzTetUY4EIHos+47/RitOwtkfE/ZztdQXNaQZNRg/WXgHR75NpbqMF++Fiy1PvQBk67H0YpSUztR+kKEqqWZBqyQJN4mHMu7+m1dHXoJGw7sSPK4wy+KmKoTd0PCq3LPj1V2Yhsn0oLbkBPARePXSw+fqfG9sSpy7ykZr3ZaSC5qZrSmDGDGX8dXEk0OxYEPrHa4kiKHyNVcO39SQUoDAqdg17p7Yxc4RB7riJbPeF6v1f6Wgm1/GCnhRcXdEW9OhICVoG1N+yhQe6VoJRkz8HfQiU+jbVwCyuxlu+vYI4ITtv0LPJOoalMajM6lodT5BdS9NH/ttdefgSM4vtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJQWaaBo4mW5VUiK7kyMhVuoNI9j8TtU6veieTHh8k=;
 b=E9yc5m/8mNZrsdqXtaOQAFl/0ojpZVnI7aDcbsPb7raAaPzgKoRAaYDlcqbzcMU+W3qfH4ruZCr+mZmH/GaKXSrPD7KnZEOro5r+d5+ISaZVa8ukKuJnvwV76qAWRaKUFIB8eUd/Vm8V0DyDu+vb9F78fwh52iTSL2XnxLYoPspt7RO+T9Fgn22yZtRfns/lDh+Feb9LwtJUyWe/3YXvd5NoA2cD2tIiCyLlRPsFxRB+z+gFfVqFGpDtZr4nURvWN6vCwzJUFWgDE5Dp64HdKsYF+JhtMlKzrXJscymVChYrJBy6BMu2AWlNr5nfgvpa3iYxXJSa6qVO670EPJB8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJQWaaBo4mW5VUiK7kyMhVuoNI9j8TtU6veieTHh8k=;
 b=Zi8HNhSmnKG5k7pIqP+t9uD9H3FhpKR/6LWwJomJmajz7uQSlTFu5IqImhjSz1bgizSIzowv+Nf/fSqYAjJdN8WWTTH7xbStpMsYnfZN9zumL4+y/X9SPXvkcjS9RKE8gFdSL+lRNFs8q6yGwfX21sUv9rocPTYov+TlKiIZgXY=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB7190.eurprd04.prod.outlook.com (2603:10a6:20b:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 07:51:18 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792%9]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 07:51:18 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "git@thegavinli.com" <git@thegavinli.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH v2] usb: usbfs: correct kernel->user page attribute
 mismatch
Thread-Topic: [PATCH v2] usb: usbfs: correct kernel->user page attribute
 mismatch
Thread-Index: AQHWIlCQKCNSJB0Ze0OFrgpi79LmXKiasbyA
Date:   Wed, 6 May 2020 07:51:18 +0000
Message-ID: <20200506075143.GC30237@b29397-desktop>
References: <20200504201348.1183246-1-jeremy.linton@arm.com>
In-Reply-To: <20200504201348.1183246-1-jeremy.linton@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 642030e4-2dd5-4d28-1e3e-08d7f19242db
x-ms-traffictypediagnostic: AM7PR04MB7190:
x-microsoft-antispam-prvs: <AM7PR04MB7190B1D95C0D19F9CADC5D638BA40@AM7PR04MB7190.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tm99XNnGQ6iVV0fwDayLqalTHqfInibtNagJgNzhZdqYAqUTbnRQZ2utagixzrKcApr9h2e8sz+t1BvETUeyH3TCS9kSy7tI18nMJMU+dOdWp00HDGqAHzJp522z2ygwMCheZQZHXr7v+iy9bxC729BLEZZHikcEhPYb1vuredTy4r3DQk2teGHcM71iYVWufvTgkMwJwyf3NmpIpc/u+yzD8zkcN+TUZW8QoeRpq+bncaSENx7SDA0rMbz5dHqJR/oj9g/mS6fifHzOyvcsv9nEI+HDM9Mj6vjYK6lsiSgur/H1minvCjGE1TVKK9Zp3qKM+Vslbz/VwHLIzbWQPbSO3r880RsKQalna08NXJ5wk4oOQFtmVMpMKfVsYAMDdlGKaHM8NeQZbKW8U5RUaDh+9+Dn70nsFdMgr32MoY6U9MtxnYoLK6LPUTy7r24G7DEUEeh8AYw4G70k2uu1How33TJuVsPuIAZbqT+0AXzcKk8EsLMNl0Z66G8VQdFrcyx4CFGQLxsuG8tkFvSJRrSb6e8hD+wMe9P+XUcNFEEFLMoEMpIf4/H9CIr0DgRN+dUTG1QlUHmtPZy6N2YL4WOMHoorvzU7eoAPSDzt75s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(33430700001)(4326008)(66446008)(1076003)(44832011)(64756008)(26005)(7416002)(186003)(76116006)(33656002)(91956017)(316002)(66946007)(6916009)(54906003)(71200400001)(66556008)(53546011)(8936002)(6512007)(66476007)(45080400002)(5660300002)(9686003)(33440700001)(8676002)(478600001)(6486002)(86362001)(33716001)(2906002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mqMFodWAZjnSgFhsz9F+UitckepftOqGoeQM+wGbHBcqqYHLDC+mVCcp1fayRX3m/2u8pQDeieF56pUy05NXDjfc8KYFu3iu2C+QxNKRCZt8EPZHd9DiAjmN/Eb6yDNY9nPKbf4WAcNgf2pm0C1Id/EEs1QP+N8C573tK3gszcVpydyZZYTPcvDys/hz7kb47mDE1WxAxNHodoJQEfvvmtecmS1XavppFtJwTi+KmI9/BnsVTzWbB2KzbzjtGC+GuvxpktZEbWMg0EDTFQQqvIwnTELaNrb3gcXEphvU+XnH3UtAvVaZ4oQ/z3zYkHee86VF6ir7CVeJ8KWe2MHGB0YZWfZ5pPu42HJYi3ZPV7Cf8mczJ1IFyPen7tHxLft+iXr6zk44AQ2+FFtZkaChC4V/2Uy3jsGOolGlF8/sGz7IofnVO0XCLlnFKOcXhr6sQLyMPxrpO3cd4i03pDJOd+7tW0Hq14EyUA9e/WPI7+Gydjs2F3DWchY2hlyoGRnE0c5T40RXiki+W6lTZLYaxpdoiE50Bpfy8Ne5UuENanCfW7DC2CO72ctXu1WuxR418NYajBi5y1/IldB4tLgqF5ERKAlxs+liUyFBM7026NWRnfvUweyzH747m+1SCNoYC8dUBCHTSOvRwFLvzigBSMr8GZcOZ9jq3I4JFZeHaqXMU6LoB8rtGNOvZhi2oL55Otjjx1fBRpUXTu+EH+bMQb+ZC2Ike0eBRNmTOAuIN52RrIA7RQxQGiVvgw/wt7FDajzTQhkpg4TxTADqcQbZmOhnM+dRf04CbvImyzP6zmw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D04C5076955E44790E54A8BFA0EB3D7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642030e4-2dd5-4d28-1e3e-08d7f19242db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 07:51:18.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCeRC0I0LSk9B2gUjx4U7d2V9TpJLm8gbq8wdegALMiNREK4tlWFk/jhIURvDSGyZgS9hs8YEjP8udzWYbpBFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-04 15:13:48, Jeremy Linton wrote:
> On some architectures (e.g. arm64) requests for
> IO coherent memory may use non-cachable attributes if
> the relevant device isn't cache coherent. If these
> pages are then remapped into userspace as cacheable,
> they may not be coherent with the non-cacheable mappings.
>=20
> In particular this happens with libusb, when it attempts
> to create zero-copy buffers for use by rtl-sdr
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
ub.com%2Fosmocom%2Frtl-sdr%2F&amp;data=3D02%7C01%7Cpeter.chen%40nxp.com%7Cb=
088a6f1a4d5462d65e808d7f067b1b2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%=
7C637242200467457447&amp;sdata=3DnPbLuHBIWqKSc0h4UGqRBv7W7wcQ0SYwq51ggLVcBV=
s%3D&amp;reserved=3D0). On low end arm
> devices with non-coherent USB ports, the application will
> be unexpectedly killed, while continuing to work fine on
> arm machines with coherent USB controllers.
>=20
> This bug has been discovered/reported a few times over
> the last few years. In the case of rtl-sdr a compile time
> option to enable/disable zero copy was implemented to
> work around it.
>=20
> Rather than relaying on application specific workarounds,
> dma_mmap_coherent() can be used instead of remap_pfn_range().
> The page cache/etc attributes will then be correctly set in
> userspace to match the kernel mapping.
>=20
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
> v1->v2:
> 	Update commit message and change to dma_mmap_coherent()
> 	from dma_mmap_attr(,,,0) which are the same.
>=20
>  drivers/usb/core/devio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 6833c918abce..b9db9812d6c5 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -217,6 +217,7 @@ static int usbdev_mmap(struct file *file, struct vm_a=
rea_struct *vma)
>  {
>  	struct usb_memory *usbm =3D NULL;
>  	struct usb_dev_state *ps =3D file->private_data;
> +	struct usb_hcd *hcd =3D bus_to_hcd(ps->dev->bus);
>  	size_t size =3D vma->vm_end - vma->vm_start;
>  	void *mem;
>  	unsigned long flags;
> @@ -250,9 +251,7 @@ static int usbdev_mmap(struct file *file, struct vm_a=
rea_struct *vma)
>  	usbm->vma_use_count =3D 1;
>  	INIT_LIST_HEAD(&usbm->memlist);
> =20
> -	if (remap_pfn_range(vma, vma->vm_start,
> -			virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> -			size, vma->vm_page_prot) < 0) {
> +	if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle, size)) {
>  		dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
>  		return -EAGAIN;
>  	}
> --=20
> 2.24.1
>=20

Tested at NXP imx8qm (ARM64) platform, it fixes mmap issue for using
libusb.

I am not sure if it covers all use cases at hcd_buffer_alloc.

--=20

Thanks,
Peter Chen=
