Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A4CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373AB20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UGqgqs1i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v74dQNXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHVes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:34:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63499 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591652086; x=1623188086;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+qQYbtRrDqBSlEKJqfZ3XJq64r6Dre27swE46ZRd9Qs=;
  b=UGqgqs1iZwMYwpAFoVZu40u5z10x46aMdHP9erSgk7eYOOwrxn1WIl3p
   3b661hk9rXTpMjTMUOElHM3YyhIVVFyW1HPMG9ccmjIGP4k00M+D7hYXc
   CD5ACP1El22ktVtbso7OQYOQv9NYMAx5nRPB/lj+X4yxKSCtBsqyF9aRh
   T9Awhd2N653z4iQCvAvsWddzc/5+L0Fl/o78kA3mYyBAIQ+IJerpB9eMz
   XxyUNLQV4ngDxBHVG5/Awd7pn+dkZeKCcknnf8ZkumbWN++ydDJJPL/nR
   TZVoyPCOLSdwsBNAx7EiN84LjscpMTB+ITgiFUXzJh0lLYxj4XzFUUS0K
   w==;
IronPort-SDR: IZgnMQ2IYp+3CH8obAPcfIVXD5/6GPYRokN9hdaLl3qIKpljU0piCRJJZzBT72ma4zgrKW8X5W
 OjSW3xFwUNjjlxHLzn6UPYtgmfC84V3DuirDVjn0JT7jwkLVLsn0pjSZGpcEttKp/EVKnTpb1/
 ZrKaJlpO97dafnL7EBnF2zeOpvApTRk1UbYjUZnxIJRGY800Bb7LvChJcc9CyeVE+Fsj3Uatal
 2i+vsqZZU5x/artazjB4BiGCkDsWYf9r1xpV3rCO3+D6OakwQBt0OOPvFSVvItAdQnVcEIlJZ2
 jmE=
X-IronPort-AV: E=Sophos;i="5.73,489,1583164800"; 
   d="scan'208";a="139481171"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2020 05:34:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbTZrceq2kOSoUFbzFHsUA5ssC5ciZT7+IfVzOurXq/idYtj3wclomRZ+ExZ0FofJ7M/J3Xd7Bh6RI1gGo1P+9MtYSCO//3JDSAmPKSP+Xx36KYxRRy1gxw5+bMdUJFI00X+2YsKEIrRvRF3nsrowMO8uM7SE/MP1AMBBOG9iGWxYIiWI+hErIo9Zo9n93w0tdpWlMz1O8A8Q5P7El0WA6FszkzvpUMkpfs1VUdb1fRE6vIoEi6IQykuayx0U4th7spLeQ6WO86tS/BLYXfDz7/jsaYGSYdmtEcIC2vlxLcydVZZuIr1xfATV4bCgHEq3ikdNvAsjl2BFjAeVdPUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qQYbtRrDqBSlEKJqfZ3XJq64r6Dre27swE46ZRd9Qs=;
 b=KVtW3xH7kwcicFFpy5Ezi/NUNMbm2xVfErdSvcSVzkt7Eg+95LkazdyU8B0kWYBjpQSCEnXT5eO00ziSX1bfM0DwFAlwTtz4QGEsJzXcjZ/8PqLJQrwop5uSijGI4sJMppjBm/AVacXZ+t+Te1+5dF6AM+p4KDa9sl6naUG2MTnI4SpGJDyF6Ct/cObD0VotPK2KZJ5Un9avXHsrjLBAAMYG2/Qcr19/44lLzD05sm6TKHmO1Pml4kkdF9B7vwdBTfn2YCPzMk2io/CBKJZCF4twQR7EwKtKx7IXHnO3UawW/PO2bPnUp/GN8+tB1ZYhccOeKjdCVQ5a65WpJFlEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qQYbtRrDqBSlEKJqfZ3XJq64r6Dre27swE46ZRd9Qs=;
 b=v74dQNXukTmwcz1U9mUQobaOy3T1ySXABOIz9bRkeOao/glAm1yzdPDbZ9pE+5B+iT4rCBHFXQBflynFSeRVT4zcadqP3wiKZN+uqnPT5cpaTXuJn+U5PHyoUwiYXy1mnFIPU9bg03pN5tUHNZxzVXWKmh1syvQJpzZmB2HRtZ4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4229.namprd04.prod.outlook.com (2603:10b6:a02:f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 21:34:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 21:34:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme-pci: remove empty line following
 nvme_should_reset()
Thread-Topic: [PATCH 2/2] nvme-pci: remove empty line following
 nvme_should_reset()
Thread-Index: AQHWPbH5/ATd/SjbNECi8NphYMc+hQ==
Date:   Mon, 8 Jun 2020 21:34:30 +0000
Message-ID: <BYAPR04MB496577AD9293E325D3414C6786850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
 <20200608162002.17017-3-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95c6a44b-91e7-4362-6d9c-08d80bf3ba6a
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-microsoft-antispam-prvs: <BYAPR04MB4229412AD5F5DD93833BEF3086850@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:287;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFp3HtjbtNpBmmjm4xuDTHjRKpm+qPmS9vbr3elthbsthKM9cioxOkWD5mFrVDMLRGNVLkdDBAd+iuNKBiznbdHGsHM43oXOpg79lDYU3Hpmu0MlQvtGvahi36BiCpa7cMDw7gJkbyTr3iQz/47ZErrBbPVlbLP9kOqB+YRVMHxp8tOuQoHQFKnjCLOQafXLwUufdm3EveELmkA/o7N1vQm2vUNdSgTmv1R4rpT7+Lh95How8Bjva/htMYqlBYIpVVEgdSQE4g14vupcFdm2m40qYrRtcAapI6I6xfNs3M3atM/jBQ5i5ugG1oJEiNCRpyV5qiRbGEBKzbLbSmqXxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(110136005)(66446008)(9686003)(66556008)(66946007)(66476007)(64756008)(7696005)(316002)(55016002)(76116006)(6506007)(52536014)(8676002)(26005)(186003)(71200400001)(86362001)(558084003)(5660300002)(4326008)(33656002)(8936002)(53546011)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TfHnJ8urAzQo1crg5l6l5JzoLDnWAusMdz+g6UFYkhJQhCoLxBo3+nyJMQ9bxNeMvji4mx+Fy5SVsgVapCY2aFDtWHpxxv3AAwgtl2T5tdSiifWvjv4/VWT87biCysJBUJkhRhic9EmEOOLTY7XBvbIsKdcBpapkBgH48QMUBkvHugK4QR7F3JKNucSM1GgKs/WPCGBA5ox4smCnnxSyaJPa1up7uBbgfzptQBh+3nd7yIJwwOZYDaZShmYuiOrddO8Rt4iplDPktuFMDTkszHSHf3wMC98MGArvvDTO2mkvReJ5qEHpKjO+M98QkTy1NesvmMMngr9jRR/VF2DROEHWT8lbNDtSiBk/5bs3P1joIFGwwjcLkfYCuvg2JQC0l7mrKaDKtJw2AN6uQlC+uW8UWXiQkS4Dg12YX0q+HeHkzlodJu0lBpt7ASZk5lmR6zLgT4iNL/Ujf9DT2DbjLO7sce1lH/KbmjMeAfiEARk66R6zm9VDfZFfg4wuZy4z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6a44b-91e7-4362-6d9c-08d80bf3ba6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 21:34:30.4031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTtTTXXR/gCjod5t9ojM8YAq+GFAUaSS7OZzuscebU1tOgvWLsV/woQbbv8bI8I5aVlSxO34do6YvSz0s63155yLJ1K8xAEInRzIb/G9wuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 9:29 AM, Dongli Zhang wrote:=0A=
> Just cleanup by removing the empty line.=0A=
> =0A=
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>=0A=
> ---=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
