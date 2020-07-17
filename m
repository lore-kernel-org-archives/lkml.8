Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E841C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4625820739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bJFqZtro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGQD7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:59:24 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:44804
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgGQD7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE0omw7mGGASxzK6laTG+u6aaI2VoNCRB57IMzzb2XZ2IZiznhHandjQkH0BeTXXMfhIHHvlFRvKuCFUjP4syIvKtnJLBQyLOIYMuUeQOUVVUCXSdLCYOrTFd7cquGJh0M8t44nl1UcyTSpInQ42jzYFKaF6BAW7/JgfG8SZLhpEa3W1Nhn8DGkTWeZPnzQsqXxSfNrY2ApGd4vFayfCe/Z7/uZ+LsS99MBUcM1roZxv86SRKmbbv7WuY9C+olgMzwdrRmo1nFWT00fD4VcP/kkTwNcoMnfVfqFAN9Sropew64cr8kUCgNId/pOyZFtfERN+AlaBaEt9hx2QUNdWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ZasUN1Kp5ouNmgcNx0femEWEfNgHYOjPoCasX/nF0=;
 b=byDM5sE/F3aHGMeDYoj93Fl7gJSzvE5Jyxkxo38w1VlI6AHLN+RyCgeUiap4bMrwLkdhG38B7bXdbh/7UM/6R4Ed6nh/28qF7n8de6XKRQ3/+KD6rJOo/KxPhDdf0sPqepQC4+UFT+ikEAkuV+55/3CDXrVdSzUfHUd409/aJluyo3vUKNBappxJKe6p02RISXDUVdPoOWz0LwWzwU4JycSDGK9dpvL6lES8bt+XkZO/GKpl7nHIRI8WjU6VqEaDGUIy/mOEhLdgIfYnngl2gS7RkzkDLwDF3IemG4F5VNaem14WEH/Yn01XfD+DsebAJc7R74wkLqwM7E1VEewWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ZasUN1Kp5ouNmgcNx0femEWEfNgHYOjPoCasX/nF0=;
 b=bJFqZtrojxJyYUdr/n8KSqKZl8g8ZFfMvTaNKwnP6RIhhNI3UQTNk8st0OldcHA04Vv6YLG8hbLUkIbbSBLbyK0kKGGe3LFT1RFkg2/DTGJGAq3xdPfGKepyglXDlWmqeqHe2gC5IvuyhzonCGkc+GMJhoihQVFiMnUnytul/ew=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR0402MB2851.eurprd04.prod.outlook.com (2603:10a6:203:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 17 Jul
 2020 03:59:20 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 03:59:20 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: gadget: udc: Flush pending work also in error path
Thread-Topic: [PATCH] usb: gadget: udc: Flush pending work also in error path
Thread-Index: AQHWW2gRyaXWYCsNREqGl03uUDVrwakLJniA
Date:   Fri, 17 Jul 2020 03:59:20 +0000
Message-ID: <20200717035917.GB17070@b29397-desktop>
References: <CGME20200716115546eucas1p1deb159dd37bc1211f4579d4d85f9af92@eucas1p1.samsung.com>
 <20200716115525.27519-1-m.szyprowski@samsung.com>
In-Reply-To: <20200716115525.27519-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee87b898-4e9c-4c8c-4cf9-08d82a05c8b5
x-ms-traffictypediagnostic: AM5PR0402MB2851:
x-microsoft-antispam-prvs: <AM5PR0402MB285141B88244D69BA26DBF048B7C0@AM5PR0402MB2851.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8EKt8R5sBWhM/2PglC9VBk6UwaagBK7xmRV5Bm1rLziHh6HkKsKqMIokkJJcEJayqik5y0YfBpeeKKyqcS4tt+aG8aLwivNVwizYjz3NKlUGj/BR7sHcoLWS1iF/OebRiQCqucr1y7YfrzkwuKzMVi5ir81llw8tnda+us9wpJECnl2ja+0+uXsafhLcJ7Vz6D4s/GYfSBLK5IMBfhz1HgVOIzIcY28xj6vu+wSF4Y3MTSMWlLxG8XvMfGdEKnQcoQTok9A3/K5ANmzE1UBzgDE8JeO3YoU5y64xPSPM75p8/zUi3ukNs8PfQYUlXiUk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(5660300002)(478600001)(316002)(66946007)(91956017)(44832011)(186003)(6512007)(66556008)(64756008)(66476007)(66446008)(53546011)(45080400002)(6506007)(26005)(54906003)(76116006)(9686003)(83380400001)(4326008)(33716001)(33656002)(8676002)(2906002)(8936002)(86362001)(71200400001)(1076003)(6916009)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yyiJUJVhh96I/+OMiwD3eDB5BIPPBUgVUftV3imKJFJsUtkS8aK2ptG/3VIrnd97jsx7Yw7kGAZtVRF9ZunhIc0dyWS0CkHJIO0rmuaiXJjDCJwd/aEtI5V6cgyB935sqs/b1fKDHy8+YrSPwxwHpt05eEkDxJO67TO2FWTA55ef/RZAfjZ3dA/6t+22+BWLk9380wKJbuDLfu3pEfspvI7M8xlzQZPxcip1oLUhR2JwxNmtAuvG8xuCSU/yxbA+5EWJNJRq462K30OGRb7QJAJHA7gVvHsLbvyIeCIS3B++Vz5bDOINPSPIUKEhtvsjXXXk00QXNJgOmCA8qXCHlLUzI/4lgMjBUBIf4yNc/a68ZH6d9l6NCylkX7L7DXjKioq+rWOKgK34byZRFjHGj8O99YSakRFjMJqMYn5745faak/DurZm60pEXzyqfA0IOl04bw399e20maqBosw6K3fBOcKwquFTxxC0+q8d6AA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90CE83E6B24B604199B26379EC68C3A6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee87b898-4e9c-4c8c-4cf9-08d82a05c8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 03:59:20.2268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wGJQnsqJcji7TIHVu6Chj2XLKI32uPabYgtu9C/giQVj1NGuEkS7fZTdFnFTJTrMqOOvGvDP7t19pKsOee+Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-16 13:55:25, Marek Szyprowski wrote:
> When binding an UDC driver to the pending gadget fails in
> check_pending_gadget_drivers(), the usb_add_gadget_udc_release() function
> ends without waiting for the usb_gadget_state_work to finish, what in
> turn might cause the whole struct usb_gadget being freed by the caller
> before the usb_gadget_state_work being executed.
>=20
> This can be observed on some boards with USB Mass Storage gadget
> compiled-in and kernel booted without the needed module parameters:
>=20
> dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter besl=3D1
> dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter g_np_tx_fifo_si=
ze=3D1024
> dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
> Mass Storage Function, version: 2009/09/11
> LUN: removable file: (no medium)
> no file given for LUN0
> g_mass_storage 12480000.hsotg: failed to start g_mass_storage: -22
> dwc2: probe of 12480000.hsotg failed with error -22
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
004
> pgd =3D (ptrval)
> [00000004] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 88 Comm: kworker/1:2 Not tainted 5.8.0-rc5-next-20200715-0006=
2-gc5bb489ae825-dirty #8792
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue:  0x0 (rcu_gp)
> PC is at process_one_work+0x44/0x7dc
> ...
> Process kworker/1:2 (pid: 88, stack limit =3D 0x(ptrval))
> Stack: (0xed9f1f00 to 0xed9f2000)
> ...
> [<c0148590>] (process_one_work) from [<c0148d6c>] (worker_thread+0x44/0x5=
1c)
> [<c0148d6c>] (worker_thread) from [<c01500c0>] (kthread+0x158/0x1a0)
> [<c01500c0>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> Exception stack(0xed9f1fb0 to 0xed9f1ff8)
> ...
> ---[ end trace 5033c1326a62e5f3 ]---
> note: kworker/1:2[88] exited with preempt_count 1
>=20
> Fix this by flushing pending work in error path.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/gadget/udc/core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.=
c
> index c33ad8a333ad..4f82bcd31fd3 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1230,6 +1230,7 @@ int usb_add_gadget_udc_release(struct device *paren=
t, struct usb_gadget *gadget,
>  	return 0;
> =20
>   err_del_udc:
> +	flush_work(&gadget->work);
>  	device_del(&udc->dev);
> =20
>   err_unlist_udc:
> --=20
> 2.17.1
>=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
