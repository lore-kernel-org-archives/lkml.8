Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BCBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E42C20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cp/TT+Gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFJEoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:44:34 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:59617
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgFJEod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPWTsHLy87anLw1EhBIUgALzNyob+FcJcf0ybUtqt+ZOkCn1lpW1g59e2K6cyJ2LRm06/77fiE94zd2wNKuAEP0tVQIxs/xVSBm6EeBpCLKJbEkT+qbbabsOFvt/PvtacC0T8kXXZA5g7cwShHbc8tT1o/iUpcsPsIfJVMa7uDSi/i7aXuBletXr6HtBlZeVBBAAY9oiOUQ8Xwb2XGtwxxZJs7h3RFXwA5jBIGew0bnXrbYgwzcirfh6fP24eC5nAO1pq0LKOMzPavAkv4HfdfZL4eo68gUqM0lHqWCwHLEhJsaYAltYaeodkRnSuiH5xyqx6xxB8imIQLpwBwRVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oltITg7nLZNREILYo5nYtOgdOky/5qcF0IGDvgmzmM=;
 b=T9n0hPo1bFPtUeMUQuzi4sx8+IRjzWR9EW0u5Bn8iVKDHWkCUQx/s7aXK6eFH8ClDgSpmAf2ltaGMqFf3dHIrs8etwLnCDXPMgnJnDmZNKtppttr5ICv0wtHTq8u7uKKOVYNHVYIOTqtqJ/8VCqh8fFlYuOwa3Uzy/Qrn/YUQ1CGoZ/q3U4/EDkhzxBbBUp0EAao7w3xMgx4Khvoi65aVlZK5LBKqjok8hB0eNNkJOHHI4TJyaUyyjlX2Wp+/4BdrOef2pwtUagfbc0UEHCcGIm0QqaKgQq/qyxd/C9Tp0o9d7mtNDrrOlz2RUoBWpiauxVemOSVHF0wjXxBWWbp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oltITg7nLZNREILYo5nYtOgdOky/5qcF0IGDvgmzmM=;
 b=cp/TT+Gy7vudzYN0jl6MgsjqI4M9/tLtcSlfZtxk0JU74F2fYefnV5yfVhkCQBXv2JaZ6Oy92AYHyPYLxJIp4t0af5uoFaATDB0s+o4VjLYj+x0IQ1Ze6F9QPAheE1IahkQtq76UwBOhXFsQYUufx1h4lZqrVm7GpWpIABS5bw4=
Received: from DB8PR04MB7162.eurprd04.prod.outlook.com (2603:10a6:10:12c::13)
 by DB8PR04MB6585.eurprd04.prod.outlook.com (2603:10a6:10:103::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 04:44:22 +0000
Received: from DB8PR04MB7162.eurprd04.prod.outlook.com
 ([fe80::f0c8:301c:ac45:5ba9]) by DB8PR04MB7162.eurprd04.prod.outlook.com
 ([fe80::f0c8:301c:ac45:5ba9%7]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 04:44:22 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bart Van Assche <bvanassche@acm.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Justin Hsieh <justinhsieh@google.com>,
        Hakieyin Hsieh <hakieyin@gmail.com>
Subject: Re: [PATCH] usb/gadget/function: introduce Built-in CDROM support
Thread-Topic: [PATCH] usb/gadget/function: introduce Built-in CDROM support
Thread-Index: AQHWPs9uyeBNKYlTkUGbGwgcbN1ORqjRRhwA
Date:   Wed, 10 Jun 2020 04:44:22 +0000
Message-ID: <20200610044446.GA8540@b29397-desktop>
References: <ejh@nvidia.com> <mchehab+samsung@kernel.org>
 <benh@kernel.crashing.org>
 <1591756349-17865-1-git-send-email-macpaul.lin@mediatek.com>
In-Reply-To: <1591756349-17865-1-git-send-email-macpaul.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b33682ac-0f69-417b-632a-08d80cf8f1e7
x-ms-traffictypediagnostic: DB8PR04MB6585:
x-microsoft-antispam-prvs: <DB8PR04MB65851621E67BDB962EF7B40D8B830@DB8PR04MB6585.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +6Po5wV/Day/bT2yNtSSwqFdR2Oa9df92QaMxfNF6UQTzF2KqT2L/r//Dk1FYlI8KKjgxXjrdjdc4P040ZOTeGBCq54h9rvTS2FASklYn8HWoCCeWk7iePP7Zf0D9nv/vjXgNo5oH9LSk4mD3xDNHsRJ4NKfOqkdxksSyMgqlTDAtWLlpOrnOh3e6aECthRxLz0QZq2yNQdJqTpv7H/62CeQ519xHluMhz9b5v3W898htpWHgT2Niu7ZZgxsb1K1U3z4Ao6QWs5DnF1buJyinOSbY/bszLZq+4Gz9VNGDCe7wBVo1FNujBexhCpKcUag69M2T3yXY27eQZTFXU5gk0KU6BM3An6sHgDGRJ/n0H+iDENEMMHiAvCTim0HTRNX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7162.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(1076003)(83380400001)(86362001)(33656002)(478600001)(44832011)(8676002)(4326008)(7416002)(33716001)(8936002)(316002)(6506007)(64756008)(186003)(54906003)(9686003)(5660300002)(6512007)(71200400001)(26005)(2906002)(66946007)(66556008)(53546011)(6486002)(66476007)(6916009)(76116006)(91956017)(66446008)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ThUREbbLX+Zy8AN5dZ7hOuOyx4Z5O7Msk1X4kCKPXAPrEYkH3Xdji6wSu/a/SSQwsC+7CtChyhc+OU2vmv6ry2WcV7KNmLvnExea7HajO7Ksu5HyWKFoNwxzBX1fVo9H2nIU0vG5XkI1XpTj/PaY1tGhrNSnrxmBrvEPaPQbWLVxsEm39pa9HXvbZWgve1c3yg72dmtR/b8wmsLz0yqRfoHmOpQSGKXG5iQhkzEZM/snDmxRZtR2aIoJ8GifX6DeawdDuWT0Puc8ZCMWhHEPA5fbUq5JCwH+EnscSTyQ9GxPaiVN2+bi7MLxhUnHD1syeNlNen5me2Vlk/hTlUnByFz5yoSACMOeBSoYYk81T/WOLemNLdTwcOK8n3F+/0tgMA3RJFGfQvstkh09/6WXzbhdC0cdZzp4OCmbNhWRTxGikTGD8IaU5kC0g16OdRYEYlPLDblOB5hHCwbvoMR+G5BhWieyny1wSbU3iCHGq7Gx4WuAKfaK/QIC3aH1RcEP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07BA7B64689EFC45860B31D1ACDF78B1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33682ac-0f69-417b-632a-08d80cf8f1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 04:44:22.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEWxnmrEEx63WwG+SZII2AVk+7UAGjJWy79YjAW7yY+kiJbPzREP+MMQZlaASG9zdEgiqpVATkb4/ssoLriilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-10 10:32:29, Macpaul Lin wrote:
> Introduce Built-In CDROM (BICR) support.
> This feature depends on USB_CONFIGFS_MASS_STORAGE option.
>=20
> 1. Some settings and new function is introduced for BICR.
> 2. Some work around for adapting Android settings is intorduced as well.

%s/intorduced/introduced

> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -315,6 +315,9 @@ struct fsg_common {
>  	void			*private_data;
> =20
>  	char inquiry_string[INQUIRY_STRING_LEN];
> +
> +	/* For build-in CDROM */
> +	u8 bicr;
>  };
> =20
>  struct fsg_dev {
> @@ -369,6 +372,10 @@ static void set_bulk_out_req_length(struct fsg_commo=
n *common,
>  	if (rem > 0)
>  		length +=3D common->bulk_out_maxpacket - rem;
>  	bh->outreq->length =3D length;
> +
> +	/* some USB 2.0 hardware requires this setting */
> +	if (IS_ENABLED(USB_CONFIGFS_BICR))
> +		bh->outreq->short_not_ok =3D 1;
>  }

Why not use fsg_common.bicr instead of MACRO?

Peter
> =20
> =20
> @@ -527,7 +534,16 @@ static int fsg_setup(struct usb_function *f,
>  				w_length !=3D 1)
>  			return -EDOM;
>  		VDBG(fsg, "get max LUN\n");
> -		*(u8 *)req->buf =3D _fsg_common_get_max_lun(fsg->common);
> +		if (IS_ENABLED(USB_CONFIGFS_BICR) && fsg->common->bicr) {
> +			/*
> +			 * When Built-In CDROM is enabled,
> +			 * we share only one LUN.
> +			 */
> +			*(u8 *)req->buf =3D 0;
> +		} else {
> +			*(u8 *)req->buf =3D _fsg_common_get_max_lun(fsg->common);
> +		}
> +		INFO(fsg, "get max LUN =3D %d\n", *(u8 *)req->buf);
> =20
>  		/* Respond with data/status */
>  		req->length =3D min((u16)1, w_length);
> @@ -1329,7 +1345,7 @@ static int do_start_stop(struct fsg_common *common)
>  	}
> =20
>  	/* Are we allowed to unload the media? */
> -	if (curlun->prevent_medium_removal) {
> +	if (!curlun->nofua && curlun->prevent_medium_removal) {
>  		LDBG(curlun, "unload attempt prevented\n");
>  		curlun->sense_data =3D SS_MEDIUM_REMOVAL_PREVENTED;
>  		return -EINVAL;
> @@ -2692,6 +2708,7 @@ int fsg_common_set_cdev(struct fsg_common *common,
>  	common->ep0 =3D cdev->gadget->ep0;
>  	common->ep0req =3D cdev->req;
>  	common->cdev =3D cdev;
> +	common->bicr =3D 0;
> =20
>  	us =3D usb_gstrings_attach(cdev, fsg_strings_array,
>  				 ARRAY_SIZE(fsg_strings));
> @@ -2895,6 +2912,33 @@ static void fsg_common_release(struct fsg_common *=
common)
>  		kfree(common);
>  }
> =20
> +#ifdef USB_CONFIGFS_BICR
> +ssize_t fsg_bicr_show(struct fsg_common *common, char *buf)
> +{
> +	return sprintf(buf, "%d\n", common->bicr);
> +}
> +
> +ssize_t fsg_bicr_store(struct fsg_common *common, const char *buf, size_=
t size)
> +{
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &common->bicr);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* Set Lun[0] is a CDROM when enable bicr.*/
> +	if (!strcmp(buf, "1"))
> +		common->luns[0]->cdrom =3D 1;
> +	else {
> +		common->luns[0]->cdrom =3D 0;
> +		common->luns[0]->blkbits =3D 0;
> +		common->luns[0]->blksize =3D 0;
> +		common->luns[0]->num_sectors =3D 0;
> +	}
> +
> +	return size;
> +}
> +#endif
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> @@ -3463,6 +3507,7 @@ void fsg_config_from_params(struct fsg_config *cfg,
>  		lun->ro =3D !!params->ro[i];
>  		lun->cdrom =3D !!params->cdrom[i];
>  		lun->removable =3D !!params->removable[i];
> +		lun->nofua =3D !!params->nofua[i];
>  		lun->filename =3D
>  			params->file_count > i && params->file[i][0]
>  			? params->file[i]
> diff --git a/drivers/usb/gadget/function/f_mass_storage.h b/drivers/usb/g=
adget/function/f_mass_storage.h
> index 3b8c4ce2a40a..7097e2ea5cc9 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.h
> +++ b/drivers/usb/gadget/function/f_mass_storage.h
> @@ -140,5 +140,8 @@ void fsg_common_set_inquiry_string(struct fsg_common =
*common, const char *vn,
>  void fsg_config_from_params(struct fsg_config *cfg,
>  			    const struct fsg_module_parameters *params,
>  			    unsigned int fsg_num_buffers);
> -
> +#ifdef CONFIG_USB_CONFIGFS_BICR
> +ssize_t fsg_bicr_show(struct fsg_common *common, char *buf);
> +ssize_t fsg_bicr_store(struct fsg_common *common, const char *buf, size_=
t size);
> +#endif
>  #endif /* USB_F_MASS_STORAGE_H */
> diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/g=
adget/function/storage_common.c
> index f7e6c42558eb..8fe96eeddf35 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -441,6 +441,29 @@ ssize_t fsg_store_file(struct fsg_lun *curlun, struc=
t rw_semaphore *filesem,
>  		return -EBUSY;				/* "Door is locked" */
>  	}
> =20
> +	pr_notice("%s file=3D%s, count=3D%d, curlun->cdrom=3D%d\n",
> +			__func__, buf, (int)count, curlun->cdrom);
> +
> +	/*
> +	 * WORKAROUND for Android:
> +	 *   VOLD would clean the file path after switching to bicr.
> +	 *   So when the lun is being a CD-ROM a.k.a. BICR.
> +	 *   Don't clean the file path to empty.
> +	 */
> +	if (curlun->cdrom =3D=3D 1 && count =3D=3D 1)
> +		return count;
> +
> +	/*
> +	 * WORKAROUND: Should be closed the fsg lun for virtual cd-rom,
> +	 * when switch to other usb functions.
> +	 * Use the special keyword "off", because the init can
> +	 * not parse the char '\n' in rc file and write into the sysfs.
> +	 */
> +	if (count =3D=3D 3 &&
> +			buf[0] =3D=3D 'o' && buf[1] =3D=3D 'f' && buf[2] =3D=3D 'f' &&
> +			fsg_lun_is_open(curlun))
> +		((char *) buf)[0] =3D 0;
> +
>  	/* Remove a trailing newline */
>  	if (count > 0 && buf[count-1] =3D=3D '\n')
>  		((char *) buf)[count-1] =3D 0;		/* Ugh! */
> --=20
> 2.18.0

--=20

Thanks,
Peter Chen=
