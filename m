Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEB20706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JOr+j8WE";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bSlNysyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFZPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:11:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32004 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFZPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:11:07 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QF8dch007716;
        Fri, 26 Jun 2020 08:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=kBP4cziVR83/nRHZPE+ym9U8TprozCSBmna/9dt95KU=;
 b=JOr+j8WEP800xtX0Rbxn5ahA8vOkbU8PfR8zKPklvd+fgjjmYs6MqviUPYD/17VqrcCW
 j7OQAKJWwkFPlZaJ/6xRzjhqsYyyH3W7GOzrCupJ98jNeEf7NO3XX0VflnCkRrwCI956
 jFUURPdfKRmk5Sebrfc9Jwd5HyrMPfoYriHrv10I7IwBmC88faT45XPpmppMbSuYsuXZ
 uEsEoWfpRVZndeHIgPzfzYXZf7/1qOLEMa3s7QEAGIH//ZzHH6IFtWrhBmA9HnxzomFe
 mwT+ij5BXAV4u33JlhcUGGVvYQnvyipbkthqofaWpvZ2y2x5ymwrAeOn6bPnLvOUqWzA Rw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31uur5u9aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 08:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxtMmvum5Tw+95UvhdC4l6c2Sk68lHwYIGduUMu/CdQNfZpeh80CkbvaR9zDN6T0YYdJgnE7fw758+bHbr9TVJyrdNpj7DhHwrvbzcg0bQGR+lacOtUZdNs+WtuVTn9neSc6e5VEXY2pIrsa47AYXi4F2iXryjut7pAf5T+3bXudhcHurzCHqyMDWi/K4+2aI3xUSdM4nrWLKbnq4f3OyP6FcDOslnRn0CrzI9WJVAEMKoPo7aSleYgHhTaxfYwpwY13TOCatq39GzEpM++czSt+h0kaosgnW3eWgFRW3FyWC+1dZdIX28ltnqBdPvTo/982u8Lq2bNZlhJmHfdtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBP4cziVR83/nRHZPE+ym9U8TprozCSBmna/9dt95KU=;
 b=iJsVnd4yCi7ka3H53DrJMCNMb6Q9vSQna77QQYrchhUxG4YcHT3NIW6wBOddrIiDQdOKiCx/IZsatj9NUHdCSDR/nIPUasCcFNhvaSqs9jFOblYHP0P8B2ZH03CY48vx2S79VqszcRKrYnndo4SvkTqbBZpnTtIx7XYRPwFKfy0o5wxrMVZsxBaUmjTjzCAQqN2kCaFyC5yhcalHwQLrdIF6a9RMJ/G+1AlSNMNFX9pO1g/46GgDz590CufFpsxCD0JlXy5vRtnt6CooezIkqb8MnR64QvD6clkqJtuLHf81cnItqgFgCa/99DyXDZixGiEmFPYBc0RzKhY2L2ubWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBP4cziVR83/nRHZPE+ym9U8TprozCSBmna/9dt95KU=;
 b=bSlNysytqUYvmOIrkO6qwI4JX6QxJbrV9MWCGrD6LZI2tOPKQ+RAlidTkEl//Q3Ep5TDrITWIXh5Ifkah4qnMeCemJV9FtDEcB2r2Kmm3HBYIj6bQ5HX0VvGaeswZsN+wZMjRHUFnphTGuDcUtzLvfTBOnuJFUd0efCUgIwtdqc=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7324.namprd07.prod.outlook.com (2603:10b6:5:215::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Fri, 26 Jun 2020 15:10:32 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699%7]) with mapi id 15.20.3109.033; Fri, 26 Jun 2020
 15:10:32 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Thread-Topic: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Thread-Index: AQHWS3YeujIotZUd8kOCCktMnZwmq6jqxmUAgAAx8KA=
Date:   Fri, 26 Jun 2020 15:10:32 +0000
Message-ID: <DM6PR07MB5529E239FBA41BDDB52CAFC4DD930@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com> <20200626114057.GD2571@kadam>
In-Reply-To: <20200626114057.GD2571@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmM0MWMyNTktYjdiZi0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJjNDFjMjVhLWI3YmYtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNjI0NiIgdD0iMTMyMzc2NTc4MzA4MDE0NDM4IiBoPSJJL3QwM29OZG9kMlhMdmUrSklIcGl3MWtyWDA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b58b5b8-7867-453a-68f8-08d819e3123d
x-ms-traffictypediagnostic: DM6PR07MB7324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB7324DB55E7A10518CF740B01DD930@DM6PR07MB7324.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PIuQDmTIkwxfhyDquEbXbR2gk532YoVkaU6BAF1QFWsa59ryv1v5l8xZkTgiXbt0FkdiwpgJVyps0B9/RybxyePN/LB84PB/TjbQij1NCddsEajOzErp4gB2Vunsr8LDSM9MdnAXc6rgqH6Gva+n9K1OXf5vNRqwb+HM3vQx7jaLCf7L9CU0oFfe1h7fYpbmHEsjmWa8dbNiOqwVdl01kc162LwHQrKupzASKzDQ1TUPcUDBdZVZH851RQy5ubiHG8UTkANZv6KYUBfEDuKw870joThaT2+F3xfBt9ndUNmTL0Ww4QDehULc/6fwDJxVpo9VN5pQKix7KdEdiYp4XVBItrwWsCBjA6MoFmfyqUd4g7FbPqAMxpXEapHTdY9l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(36092001)(8936002)(52536014)(5660300002)(71200400001)(7696005)(6916009)(478600001)(8676002)(26005)(6506007)(7416002)(316002)(83380400001)(55016002)(33656002)(54906003)(66946007)(76116006)(9686003)(107886003)(2906002)(4326008)(186003)(66446008)(66476007)(64756008)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: P9AJXwsEyDD01g0nq1S6MNgzw/udFqClkGEmh/kvWS5bYWFotwujdJnIP745wNdq40erBsD8Bt1VigfgXszjwnNjIZ1oj9qri64M16Y1e/gREuXp7TCceka53TWw9ZlicswjVkAIPlLFQjQBmZ5JcaYwcmBZkR6QQNbnF1K2nhFNF8+9vwfWaY2LKEY8lPmXgQM3f0mZqGVpSi/tUTj3Dkto5mcHxKIyG7JmZnsTi3wCHLbOy3LLqWxBAEufX6rwq/4M9Fqt39AtGTTankSrJ0OF3u1Qut7LteSbLmA0pL+gg2rJXHfPHZczBN+jlGQ0Ln3fd0tSyvEsxbJp3N5uG7bYCfD8ZEUGo3Xtt+4Cr+jpevNr9obEq7peQYytzI/eAyJjBsdH+cAw9I1gyXjoAdECmFfQFIDMDXyjcabi1SsGsJnfet0cz4QN/bPF1srdKHtMYRBDIE+XiUVUv1S0dsSNqHZR7SP4hY+hq8wWzIPt1CYgdaLarTN4Ln2A0PPP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b58b5b8-7867-453a-68f8-08d819e3123d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 15:10:32.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aWsxF77644pgL/BjSd7UZ5vkzFnOgiKVSCWj+OQ3ePQZYGYHh+iJWjASVHay3HMiPme83ENGBRuFY7/QzarD6cfDBl8Se7QYN1s2wLByEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7324
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_08:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=556 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Fri, Jun 26, 2020 at 06:54:47AM +0200, Pawel Laszczak wrote:
>> +static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *func;
>> +
>> +	/*
>> +	 * Gets the second function.
>> +	 * It's little tricky, but this platform has two function.
>> +	 * The fist keeps resources for Host/Device while the second
>> +	 * keeps resources for DRD/OTG.
>> +	 */
>> +	func =3D pci_get_device(pdev->vendor, pdev->device, NULL);
>> +	if (unlikely(!func))
>
>Delete all likely/unlikely annotations.  Likely and unlikely annotations
>make the code less readable.  We are willing to sacrifice readability on
>fast paths.
>
>They're only supposed to be used where they're supported by benchmarking.
>Probably it's pretty tricky to benchmark probe.  The other rule of thumb
>is don't add them to drivers.  Another thing to consider is that this
>error path is probably obvious enough for the compiler to figure out
>without help.

Ok, I will remove unlikely.
>
>> +		return NULL;
>> +
>> +	if (func->devfn =3D=3D pdev->devfn) {
>> +		func =3D pci_get_device(pdev->vendor, pdev->device, func);
>> +		if (unlikely(!func))
>> +			return NULL;
>> +	}
>> +
>> +	return func;
>> +}
>> +
>> +static int cdnsp_pci_probe(struct pci_dev *pdev,
>> +			   const struct pci_device_id *id)
>> +{
>> +	struct platform_device_info plat_info;
>> +	struct cdnsp_wrap *wrap;
>> +	struct resource *res;
>> +	struct pci_dev *func;
>> +	int err;
>> +
>> +	/*
>> +	 * For GADGET/HOST PCI (devfn) function number is 0,
>> +	 * for OTG PCI (devfn) function number is 1.
>> +	 */
>> +	if (!id || (pdev->devfn !=3D PCI_DEV_FN_HOST_DEVICE &&
>> +		    pdev->devfn !=3D PCI_DEV_FN_OTG))
>> +		return -EINVAL;
>> +
>> +	func =3D cdnsp_get_second_fun(pdev);
>> +	if (unlikely(!func))
>> +		return -EINVAL;
>> +
>> +	if (func->class =3D=3D PCI_CLASS_SERIAL_USB_XHCI ||
>> +	    pdev->class =3D=3D PCI_CLASS_SERIAL_USB_XHCI)
>> +		return -EINVAL;
>
>
>Do we need call pci_put_device(func) before returning?

We don't need.
Such function doesn't exist.

>
>		ret =3D -EINVAL;
>		goto put_pci;
>
>> +
>> +	err =3D pcim_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
>> +		return err;
>
>		goto put_pci;
>
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	if (pci_is_enabled(func)) {
>> +		wrap =3D pci_get_drvdata(func);
>> +	} else {
>> +		wrap =3D kzalloc(sizeof(*wrap), GFP_KERNEL);
>> +		if (!wrap) {
>> +			pci_disable_device(pdev);
>> +			return -ENOMEM;
>
>goto disable_pci;
>
>> +		}
>> +	}
>> +
>> +	res =3D wrap->dev_res;
>> +
>> +	/* For GADGET device function number is 0. */
>> +	if (pdev->devfn =3D=3D 0) {
>> +		/* Function 0: host(BAR_0) + device(BAR_1).*/
>> +		dev_dbg(&pdev->dev, "Initialize Device resources\n");
>> +		res[RES_DEV_ID].start =3D pci_resource_start(pdev, PCI_BAR_DEV);
>> +		res[RES_DEV_ID].end =3D   pci_resource_end(pdev, PCI_BAR_DEV);
>> +		res[RES_DEV_ID].name =3D "dev";
>> +		res[RES_DEV_ID].flags =3D IORESOURCE_MEM;
>> +		dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
>> +			&res[RES_DEV_ID].start);
>> +
>> +		res[RES_HOST_ID].start =3D pci_resource_start(pdev, PCI_BAR_HOST);
>> +		res[RES_HOST_ID].end =3D pci_resource_end(pdev, PCI_BAR_HOST);
>> +		res[RES_HOST_ID].name =3D "xhci";
>> +		res[RES_HOST_ID].flags =3D IORESOURCE_MEM;
>> +		dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
>> +			&res[RES_HOST_ID].start);
>> +
>> +		/* Interrupt for XHCI, */
>> +		wrap->dev_res[RES_IRQ_HOST_ID].start =3D pdev->irq;
>> +		wrap->dev_res[RES_IRQ_HOST_ID].name =3D "host";
>> +		wrap->dev_res[RES_IRQ_HOST_ID].flags =3D IORESOURCE_IRQ;
>> +
>> +		/* Interrupt device. It's the same as for HOST. */
>> +		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].start =3D pdev->irq;
>> +		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].name =3D "peripheral";
>> +		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].flags =3D IORESOURCE_IRQ;
>> +	} else {
>> +		res[RES_DRD_ID].start =3D pci_resource_start(pdev, PCI_BAR_OTG);
>> +		res[RES_DRD_ID].end =3D   pci_resource_end(pdev, PCI_BAR_OTG);
>> +		res[RES_DRD_ID].name =3D "otg";
>> +		res[RES_DRD_ID].flags =3D IORESOURCE_MEM;
>> +		dev_dbg(&pdev->dev, "CDNSP-DRD physical base addr: %pa\n",
>> +			&res[RES_DRD_ID].start);
>> +
>> +		/* Interrupt for OTG/DRD. */
>> +		wrap->dev_res[RES_IRQ_OTG_ID].start =3D pdev->irq;
>> +		wrap->dev_res[RES_IRQ_OTG_ID].name =3D "otg";
>> +		wrap->dev_res[RES_IRQ_OTG_ID].flags =3D IORESOURCE_IRQ;
>> +	}
>> +
>> +	if (pci_is_enabled(func)) {
>> +		/* Set up platform device info. */
>> +		memset(&plat_info, 0, sizeof(plat_info));
>> +		plat_info.parent =3D &pdev->dev;
>> +		plat_info.fwnode =3D pdev->dev.fwnode;
>> +		plat_info.name =3D PLAT_DRIVER_NAME;
>> +		plat_info.id =3D pdev->devfn;
>> +		wrap->devfn  =3D pdev->devfn;
>> +		plat_info.res =3D wrap->dev_res;
>> +		plat_info.num_res =3D ARRAY_SIZE(wrap->dev_res);
>> +		plat_info.dma_mask =3D pdev->dma_mask;
>> +		/* Register platform device. */
>> +		wrap->plat_dev =3D platform_device_register_full(&plat_info);
>> +		if (IS_ERR(wrap->plat_dev)) {
>> +			pci_disable_device(pdev);
>> +			err =3D PTR_ERR(wrap->plat_dev);
>> +			kfree(wrap);
>
>		err =3D PTR_ERR(wrap->plat_dev);
>		goto free_wrap;
>
>Except, do we really want to kfree(wrap)?  It looks like it came from
>pci_get_drvdata().
>
>> +			return err;
>> +		}
>> +	}
>> +
>> +	pci_set_drvdata(pdev, wrap);
>> +	return err;
>
>free_wrap:
>	if (!pci_is_enabled(func))
>		kfree(wrap);
>disable_pci:
>	pci_disable_device(pdev);

This is ok for me.

>put_pci:
>	pci_put_device(func);
>
>> +}
>> +
>> +static void cdnsp_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct cdnsp_wrap *wrap;
>> +	struct pci_dev *func;
>> +
>> +	func =3D cdnsp_get_second_fun(pdev);
>> +
>> +	wrap =3D (struct cdnsp_wrap *)pci_get_drvdata(pdev);
>> +	if (wrap->devfn =3D=3D pdev->devfn)
>> +		platform_device_unregister(wrap->plat_dev);
>> +
>> +	if (!pci_is_enabled(func))
>> +		kfree(wrap);
>
>pci_put_device(func);
>
>> +}
>> +
>
>regards,
>dan carpenter

thanks Dan
regards,
pawel

