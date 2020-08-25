Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CF5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177CE20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QAgFheRz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GM8htT9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHYG0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:26:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58518 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726940AbgHYG0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:26:11 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6Fd4v005133;
        Mon, 24 Aug 2020 23:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=lBz0XOb321J7P0BbNcOdb9IXXaa4R3qtIlZdhLwwnfU=;
 b=QAgFheRzDikSjLXevV5Jc8KZy5oAlhxn8ZRsqIoF9PhcL9N8LpOxwcqkZ3u/zH9fKvM+
 mJggVblLewlYPBS75xGbbtejsUdTfGYCsNMKEBg6Y4Eg1Q4Sfi01pW4JELj2OKkiGKOF
 hBp5wdzE/cREcwaTbwv0yu8cxhEoABlrQY3NDF2CHxhHGjEt1IaxOUqHpHBbJctwx0pL
 eqYrEKdLsCRV8Hc0NdPBoFXkvSqFI17tazE26obzVWYYpCoWDYq5TMLNo2ah9eNa8/rx
 HXfFEfaqYHziZ+DivOq2wNCkXGKV+rMmFcCN7udzvepYlVugPFILWtIIU2zk4KvjmVkR bA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxx1s9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 23:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhmJzfO5Z1xK3+yYCpk+SAAgJQMPqV5XPJjCDZ3voD/CGWbbdB/4IcBlPmUmE2zBitNwHVaGk68ADjasBDIQoC3T3KEstUgArsrwpAy6aBLwuHNMUTvfbT+OpcRh+cT8z0HcGJC9nOZKb5q3sQ/PGSmHsVGVasORLTYH3Lr+Yzr1j33d5yXPlJzQAw1zmmmaxnegXiVwiYLKE6OOvh3oo4Q0S6QUv5DM8wqBDm79CkOniPfmW9FeZed4kDBk6nq9OMw1NQv9B+nUEju5SraIENM9qDQ/Eg2E3LoGwzIpUCqkZ1hl/9/TPPGTfIqAWNA1yAi+/mlDdJllh6pNTe+5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBz0XOb321J7P0BbNcOdb9IXXaa4R3qtIlZdhLwwnfU=;
 b=FVRPu/bgAgdgXI4TmjGoxxK2UukTRK7dtFKoHZvQqBRgtA8mk+Y5J3uOWWudA7OvYVhti6uxMF8Ie12HJc0pTdSbc06YSrj40wcirAnjPAzb0ih+0cONlzeCq1boTdYWfaMo3ePecVkNnXU3mIRo59MC90nt7Vcw2ED7Af/9iHAMcC3h8tvWL5Yjt8Vhf9lfOJwo2nkRXDXA1uzciWQ0dlM0Oja5zzspFlFCnvrUDhOQ3ivqqZEktcxBytWQciqm8kkfEaK+kWDSP2L94fkDXaH/I5eA6O2MAW8qma2GmpMoesgrF3MO5lAkLSFbcjzZ2ilpYsSZ8PFgpDdkUsR2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBz0XOb321J7P0BbNcOdb9IXXaa4R3qtIlZdhLwwnfU=;
 b=GM8htT9QogBui3I9UK5X4WRzWys5K82PhoOLQsVOK6BnHeQWK/uxNOIrvDmZVrOuCowT1J5OMRemUSvOv0VMiOUgLk1SkDzQi7T9hqXUKrigDVVEqMB6xU6M4PEqREZ2x/uCPf8qqY1yCyV8gfp7xw5EpZ/HjPnnq78XVl3RcqI=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM6PR07MB5915.namprd07.prod.outlook.com (2603:10b6:5:181::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Tue, 25 Aug 2020 06:26:01 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::fcc9:65c7:8aed:f107]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::fcc9:65c7:8aed:f107%12]) with mapi id 15.20.3305.026; Tue, 25 Aug
 2020 06:26:01 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>
CC:     Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v5] i3c: master: fix for SETDASA and DAA process
Thread-Topic: [PATCH v5] i3c: master: fix for SETDASA and DAA process
Thread-Index: AQHWeqfy8Aj90hsiv0WwsilA8lhg3qlIW8sQ
Date:   Tue, 25 Aug 2020 06:26:01 +0000
Message-ID: <DM5PR07MB3196F4A961B0603C883A686DC1570@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1598336468-9564-1-git-send-email-pthombar@cadence.com>
In-Reply-To: <1598336468-9564-1-git-send-email-pthombar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kNjI1ZjU3Yy1lNjliLTExZWEtODYwMS0wMDUwNTZjMDAwMDhcYW1lLXRlc3RcZDYyNWY1N2UtZTY5Yi0xMWVhLTg2MDEtMDA1MDU2YzAwMDA4Ym9keS50eHQiIHN6PSI4ODAzIiB0PSIxMzI0MjgxMDM1ODU1MDkyNjMiIGg9InpBK2E0QmJrYXExYVhaWDNVWk9sNGpGTzhwTT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 508b9625-0378-4825-170c-08d848bfbc9a
x-ms-traffictypediagnostic: DM6PR07MB5915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB591578A4B7D84FCBB8EB4104C1570@DM6PR07MB5915.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KyyxDNNtCi9JPWtSBL/qMeKOL1ZS1/ZmTQmUYP3gEmoZYINBJ3sZsMyBf7QWiAr90uu8X+CnYJnSF0bS85cTDoNwu2+D9RglJSNbQLQOcyCdpgMOFTdlWROynkgA2IJrNP1WtgJJCZr0OqGYoHg+/bv0yi7+UJv+ap3sxkyApbtG6wA/kW2gf8CfDmhQ13cQ0PwqzaL8ZPW6szq97WKUXpUovFUZmrgCA9VOtADo+BDb7n3umv2jXH9OpDhZcRi3iAgZNsUQGFsK7ELYA5r4z5DwdPEXh3MfBHS/CxKtegt/qIFaqMXrGWKJQNF2O5Bk1aqclmM3yJ9PSNAi9ihtZXC8KirQnfk5NYiVOs55HE94+aogQtVdnzS+FMlfFIJy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(36092001)(76116006)(5660300002)(52536014)(83380400001)(478600001)(86362001)(55016002)(186003)(26005)(71200400001)(9686003)(8936002)(7696005)(6506007)(55236004)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(316002)(2906002)(4326008)(33656002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +qW+B/dNw7bcICPWo0KY33t/uNKziY7WBtfNZorEQ3qgQ9V9v6aAeWdDyIE6gVfdS9+N4PNxx3Hr6XfxRhSmJEG7gV7zNwVx3XIxEgrJmvf7LvMW0ClMtnSjID78bGziBe6KEJJw3OV5mBUwPfGGRXPrkbE/4n4i+9DTnJsP6U+r5L4NcQQyEBV9V3+xkyq6jE1ZdkdHjmtIKtjvmCvQoGtlGx/A4YhtJ76tOn6iKnAke3mcSoXKzEV/ysfRENGZj6vrDCtMdlON12e7bSiMscVExhJeVtIrEvUbT9tEBUiYqhydDw/OB+zA3V1DjPcT+9bfsJnxSIHicyHJ97mK+VD7yfOK05znOhdYTfQfy+cZPlNXSZWI//frWIdK+4VbLADzmxgcnTRG6WVBduG5SkjWbbtnUTqZ7tlIAa0SNdCYGLNeyFNJ0UMZqpnDCyDXOPT319mlEcOMDZZVKg3we1DYmb1AtHqrjD/wK4LJnQNQIpWm+MvRisEx3UV5D/oxfy4Oe/vMpvcOrKLdvm1JlGjPoILuD7Ntq+MSF7b6wXMJ27JrU4FMrvXiw1HRvDaj8QRnPrOAfI6tv8i78O3KJQqdof/t9ufwIe75NMMVA0urau/cqi/eOfO9u73vFolmmahtN+yCZtykdviSl0PMuQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508b9625-0378-4825-170c-08d848bfbc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 06:26:01.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJIcfX6sjFUF9V0ZSONCw25jvav0xddanR9/nhnwC6guJoDJGuZHQ28vauNAWFII7Beh96OSHHVtafsyP6Wa7sktF9bSNBdpfxtvvovEfyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5915
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch.

Regards,
Parshuram Thombare

>-----Original Message-----
>From: Parshuram Thombare <pthombar@cadence.com>
>Sent: Tuesday, August 25, 2020 11:51 AM
>To: bbrezillon@kernel.org; vitor.soares@synopsys.com
>Cc: Przemyslaw Gaj <pgaj@cadence.com>; linux-i3c@lists.infradead.org; linu=
x-
>kernel@vger.kernel.org; Milind Parab <mparab@cadence.com>;
>praneeth@ti.com; Parshuram Raju Thombare <pthombar@cadence.com>
>Subject: [PATCH v5] i3c: master: fix for SETDASA and DAA process
>
>This patch fixes the following issue.
>Controller slots blocked for the devices with only static_addr
>or init_dyn_addr may limit the number of I3C devices
>on the bus which gets dynamic address in DAA. So
>instead of attaching all the devices with static_addr,
>now we only attach the devices which successfully
>complete SETDASA. Similarly, for the devices with only
>init_dyn_addr, init_dyn_addr are reserved, and after DAA
>i3c_master_add_i3c_dev_locked() will try to set the requested
>dynamic address.
>
>Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
>---
>Changes between v4 and v5 are:
>1. Modifications in comments and labels.
>
>Changes between v3 and v4 are:
>1. Code rectoring and removed Fixes tag.
>
>Changes between v2 and v3 are:
>1. Keeping init_dyn_addr reserved.
>2. Code refactoring and changes in comments.
>
>Changes between v1 and v2 are:
>1. Added boardinfo attach fix.
>2. Removed reattach issue related fix.
>3. Reserve init_dyn_addr initially, so that it will not
>   be used in DAA and  attempt can be made to set those
>   firmware requested dynamic address after DAA.
>---
> drivers/i3c/master.c |  128 +++++++++++++++++++++++++++++----------------=
----
> 1 files changed, 76 insertions(+), 52 deletions(-)
>
>diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>index 3d995f2..ccf9b4e 100644
>--- a/drivers/i3c/master.c
>+++ b/drivers/i3c/master.c
>@@ -1367,7 +1367,9 @@ static int i3c_master_reattach_i3c_dev(struct
>i3c_dev_desc *dev,
> 	enum i3c_addr_slot_status status;
> 	int ret;
>
>-	if (dev->info.dyn_addr !=3D old_dyn_addr) {
>+	if (dev->info.dyn_addr !=3D old_dyn_addr &&
>+	    (!dev->boardinfo ||
>+	     dev->info.dyn_addr !=3D dev->boardinfo->init_dyn_addr)) {
> 		status =3D i3c_bus_get_addr_slot_status(&master->bus,
> 						      dev->info.dyn_addr);
> 		if (status !=3D I3C_ADDR_SLOT_FREE)
>@@ -1426,33 +1428,49 @@ static void i3c_master_detach_i2c_dev(struct
>i2c_dev_desc *dev)
> 		master->ops->detach_i2c_dev(dev);
> }
>
>-static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
>+static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *mas=
ter,
>+					  struct i3c_dev_boardinfo *boardinfo)
> {
>-	struct i3c_master_controller *master =3D i3c_dev_get_master(dev);
>+	struct i3c_device_info info =3D {
>+		.static_addr =3D boardinfo->static_addr,
>+	};
>+	struct i3c_dev_desc *i3cdev;
> 	int ret;
>
>-	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
>-	    !dev->boardinfo->static_addr)
>-		return;
>+	i3cdev =3D i3c_master_alloc_i3c_dev(master, &info);
>+	if (IS_ERR(i3cdev))
>+		return -ENOMEM;
>+
>+	i3cdev->boardinfo =3D boardinfo;
>
>-	ret =3D i3c_master_setdasa_locked(master, dev->info.static_addr,
>-					dev->boardinfo->init_dyn_addr);
>+	ret =3D i3c_master_attach_i3c_dev(master, i3cdev);
> 	if (ret)
>-		return;
>+		goto err_free_dev;
>+
>+	ret =3D i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
>+					i3cdev->boardinfo->init_dyn_addr);
>+	if (ret)
>+		goto err_detach_dev;
>
>-	dev->info.dyn_addr =3D dev->boardinfo->init_dyn_addr;
>-	ret =3D i3c_master_reattach_i3c_dev(dev, 0);
>+	i3cdev->info.dyn_addr =3D i3cdev->boardinfo->init_dyn_addr;
>+	ret =3D i3c_master_reattach_i3c_dev(i3cdev, 0);
> 	if (ret)
> 		goto err_rstdaa;
>
>-	ret =3D i3c_master_retrieve_dev_info(dev);
>+	ret =3D i3c_master_retrieve_dev_info(i3cdev);
> 	if (ret)
> 		goto err_rstdaa;
>
>-	return;
>+	return 0;
>
> err_rstdaa:
>-	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
>+	i3c_master_rstdaa_locked(master, i3cdev->boardinfo->init_dyn_addr);
>+err_detach_dev:
>+	i3c_master_detach_i3c_dev(i3cdev);
>+err_free_dev:
>+	i3c_master_free_i3c_dev(i3cdev);
>+
>+	return ret;
> }
>
> static void
>@@ -1619,8 +1637,8 @@ static void i3c_master_detach_free_devs(struct
>i3c_master_controller *master)
>  * This function is following all initialisation steps described in the I=
3C
>  * specification:
>  *
>- * 1. Attach I2C and statically defined I3C devs to the master so that th=
e
>- *    master can fill its internal device table appropriately
>+ * 1. Attach I2C devs to the master so that the master can fill its inter=
nal
>+ *    device table appropriately
>  *
>  * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
>  *    the master controller. That's usually where the bus mode is selecte=
d
>@@ -1632,11 +1650,14 @@ static void i3c_master_detach_free_devs(struct
>i3c_master_controller *master)
>  *
>  * 4. Disable all slave events.
>  *
>- * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for I=
3C
>- *    devices that have a static address
>+ * 5. Reserve address slots for I3C devices with init_dyn_addr. And if de=
vices
>+ *    also have static_addr, try to pre-assign dynamic addresses requeste=
d by
>+ *    the FW with SETDASA and attach corresponding statically defined I3C
>+ *    devices to the master.
>  *
>  * 6. Do a DAA (Dynamic Address Assignment) to assign dynamic addresses t=
o all
>- *    remaining I3C devices
>+ *    remaining I3C devices and attach them to the master if the dynamic =
address
>+ *    assignment succeeds
>  *
>  * Once this is done, all I3C and I2C devices should be usable.
>  *
>@@ -1647,7 +1668,6 @@ static int i3c_master_bus_init(struct
>i3c_master_controller *master)
> 	enum i3c_addr_slot_status status;
> 	struct i2c_dev_boardinfo *i2cboardinfo;
> 	struct i3c_dev_boardinfo *i3cboardinfo;
>-	struct i3c_dev_desc *i3cdev;
> 	struct i2c_dev_desc *i2cdev;
> 	int ret;
>
>@@ -1679,34 +1699,6 @@ static int i3c_master_bus_init(struct
>i3c_master_controller *master)
> 			goto err_detach_devs;
> 		}
> 	}
>-	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
>-		struct i3c_device_info info =3D {
>-			.static_addr =3D i3cboardinfo->static_addr,
>-		};
>-
>-		if (i3cboardinfo->init_dyn_addr) {
>-			status =3D i3c_bus_get_addr_slot_status(&master->bus,
>-						i3cboardinfo->init_dyn_addr);
>-			if (status !=3D I3C_ADDR_SLOT_FREE) {
>-				ret =3D -EBUSY;
>-				goto err_detach_devs;
>-			}
>-		}
>-
>-		i3cdev =3D i3c_master_alloc_i3c_dev(master, &info);
>-		if (IS_ERR(i3cdev)) {
>-			ret =3D PTR_ERR(i3cdev);
>-			goto err_detach_devs;
>-		}
>-
>-		i3cdev->boardinfo =3D i3cboardinfo;
>-
>-		ret =3D i3c_master_attach_i3c_dev(master, i3cdev);
>-		if (ret) {
>-			i3c_master_free_i3c_dev(i3cdev);
>-			goto err_detach_devs;
>-		}
>-	}
>
> 	/*
> 	 * Now execute the controller specific ->bus_init() routine, which
>@@ -1743,11 +1735,43 @@ static int i3c_master_bus_init(struct
>i3c_master_controller *master)
> 		goto err_bus_cleanup;
>
> 	/*
>-	 * Pre-assign dynamic address and retrieve device information if
>-	 * needed.
>+	 * Reserve init_dyn_addr first, and then try to pre-assign dynamic
>+	 * address and retrieve device information if needed.
>+	 * In case pre-assign dynamic address fails, setting dynamic address to
>+	 * the requested init_dyn_addr is retried after DAA is done in
>+	 * i3c_master_add_i3c_dev_locked().
> 	 */
>-	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
>-		i3c_master_pre_assign_dyn_addr(i3cdev);
>+	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
>+
>+		/*
>+		 * We don't reserve a dynamic address for devices that
>+		 * don't explicitly request one.
>+		 */
>+		if (!i3cboardinfo->init_dyn_addr)
>+			continue;
>+
>+		ret =3D i3c_bus_get_addr_slot_status(&master->bus,
>+						   i3cboardinfo->init_dyn_addr);
>+		if (ret !=3D I3C_ADDR_SLOT_FREE) {
>+			ret =3D -EBUSY;
>+			goto err_rstdaa;
>+		}
>+
>+		i3c_bus_set_addr_slot_status(&master->bus,
>+					     i3cboardinfo->init_dyn_addr,
>+					     I3C_ADDR_SLOT_I3C_DEV);
>+
>+		/*
>+		 * Only try to create/attach devices that have a static
>+		 * address. Other devices will be created/attached when
>+		 * DAA happens, and the requested dynamic address will
>+		 * be set using SETNEWDA once those devices become
>+		 * addressable.
>+		 */
>+
>+		if (i3cboardinfo->static_addr)
>+			i3c_master_early_i3c_dev_add(master, i3cboardinfo);
>+	}
>
> 	ret =3D i3c_master_do_daa(master);
> 	if (ret)
>--
>1.7.1

