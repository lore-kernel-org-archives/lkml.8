Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 02:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11197222C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 02:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Onbb6ZUW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JtrkBpE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCACBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 21:01:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61190 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCACBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 21:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583028069; x=1614564069;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p3NUnq7+goAE+p4i6WEz4Jyb1QmtbD/PFYkq8IdPASo=;
  b=Onbb6ZUWhhGribzW3KKs8SvBGQqXCXtcdhAhLiEBdQbmDf+bkDJlNLBY
   fF9bt6n3dY3cOGg1T8cxCxEZZ8Q6Bj0/kVX0kFoclTN5JzgUC3SQB8ITL
   3euYzbgYCtb/LysSkZrpBTu/IpHkClVad4HRfDXsTL8mNljxIkhFJZTMB
   d/2t9hrcSQxg41k9vb6CaHiyKu0FaxBb5UNrTkg7Cfg0VvOToGZwh7PDC
   mBvZjAlm+eM//Vk6bn08qsSKp2QFHoGpushMOhcSyoHAaVatkOoEBPitw
   b3UpIDYk3a/EXCKcmQCsDhr9vnMMfS/QsUjjKSfvwLAlUIx5G795w8A/V
   w==;
IronPort-SDR: wLRr6LamsSd8y30YAAPRxsdQETpyYJ3RPiflzsOqOjnYW+A5aHZ+IvzeUucGYu2J7nJ7S5Cnq/
 gObFJOY68JaL/Z0mkENmxRCJJT9aZLMhlP26iS6hXvAqXOyr73VkyHyY80kCvl5LWrJSgscg0E
 /sMILGSJDSi8DibGNyNPnTkNuliIesTdjy4rq69h4csMoVmtozjH7bSNZnHVKSD1l/FJZ1mfFU
 tKZ0X3K7ZjjjCGpVvbHaBNpbSYf2Cg7tnUjjaR7t30Zw/oJWV4ZDcAzZzV9zen+pyCoJwCFM+t
 Mxo=
X-IronPort-AV: E=Sophos;i="5.70,502,1574092800"; 
   d="scan'208";a="132528117"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 10:01:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqnqM6ofREIVGel5Ea1Lr1L1+M8jMlteS87Lf9Gm7D3r86LiC9udeG6jtsd5YAwdrsMLaH3ybxUX9QyR2QkM+vN//RE4LFi2CIGM8nIFKY2wjhOXMor0y7g13lnGJZl/Zeu5rdtViiBXXziPJdwO71akLwmAeQJTxX2f2jmq698Zsm0UAziw/cbm7kAAXYyhbIRreaXbcjCl1o+eBZ4KGLFEqDwY01sJK9skPqWMsb74LkHQdz/kumYZNLYdCHJlAX5NDkwQV11HOvrxrN+HnUU5rE3hT1DesNMXwS5rzxoU7VjbCEEvqgMY2bx2ORFeLHZyGtQ9Ifhu39rZ8XkdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yz8V0mtHeZaZpikD8TZPmq6BFxKa31Mb/NMcehKPzg=;
 b=AlenQ7rHxWHWufMOqk4QaK92lI0vS01PbktrHWgFGWGnENDLlzR6PO+A25jIJd8vBZN4WhKsuhIseXWsrylL+NsjZFsXm60MXefeoKRSwHUxWGyZb9/3G55xeLwqpsvG8oWdIJD63GzU1W6ANyXxQ3MRNXCospZTAjRXCRzpeWfsU4xpWxwYnpMojSyz01QFLbLh2MBkYoIhUrVNQ6rNpn5sqdVZrFarQQsS9qJNzVKj6Du3b+EAdfz2scOfabEg2RclU8IsCNx3PY/vvw8r046XjnOfg+zdsXRrKcqTp458AIiBge90pohVrufTzO///22iTWKFL7eiTpNQYo4jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yz8V0mtHeZaZpikD8TZPmq6BFxKa31Mb/NMcehKPzg=;
 b=JtrkBpE4XRsRrXnspEbSQmLLRVncEOfQyJwgH7xv4ZDuNHemRy3Bdm3b5HfA0yJvJDIz5Ik8xhFeh/JrngAN9Yb5W7MJmGE8bdgtK/2SBkZTWiPNkSgSTa2NyTm8neVA5idK09/gkHzQkGHQWLpdlocABZcYjhd3osWeNIrZnUk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Sun, 1 Mar
 2020 02:01:06 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 02:01:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Thread-Topic: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Thread-Index: AQHV7qtY5m6g7a4cOEmKX4VCzFI0fA==
Date:   Sun, 1 Mar 2020 02:01:05 +0000
Message-ID: <BYAPR04MB5749363E3AC8C583F5CB076786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200229025228.GA203607@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faea1525-f000-4ef5-7505-08d7bd84670a
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-microsoft-antispam-prvs: <BYAPR04MB53333DB2F5C7DB868638487186E60@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(33656002)(2906002)(71200400001)(478600001)(9686003)(55016002)(110136005)(54906003)(8936002)(186003)(76116006)(4326008)(66946007)(8676002)(66476007)(81156014)(81166006)(66556008)(86362001)(6506007)(7696005)(26005)(66446008)(52536014)(53546011)(64756008)(316002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5333;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Fk/SZiJL0k25JQ4iymZ0tl+RvWnE1x+j5F8X3LjvBeW9rn7G5HTwn0VNx+7Lh/IkuYX7fdrTxszOIbk7sAtD2FF+1TFAY2PSfPVGkJSEMyRllJz0+V5fmF0PtDYcXJFcMNHJKzI6YF9Eii/dujgivITIyTf1Bkmgp4zQ06i0wmpmxyUNAcwa8t0J2XNU49U04adkQd0YOFqd4j9wLFRtLrtzAVSwLNkB/0S9G23oy4rmxLKrZWniMrlubOiYNTf/X4+LU81Lf/VQbDKlQCCIIZO1OhVu2qoTk6yEZ8mMx/zR7oMKRzZXQXDlbjMLg5k4PhmaHpA/2Ve5owrADSWXye4kjCRv4Zi3uZRdJjhohv9+kgZh59wf/q/egsnjYshlqLonJCsninTtn3D8dwf+8WprcGtm+ZF4YD34wv3hznLWnmQnOynS3HusZPU2jf0
x-ms-exchange-antispam-messagedata: W0nmT6bxdf1B7FyjcxGDFV053XY4RqsrUKJHPK8vDlHTuxfNRVdgBuDT/5qTMFgvXWw3LItieCg7AChrB8MNRRkgqbKphuSF+pRlGa7XjelK5KnoPm07bsYP7KrOxYQ6udblIVX/HmDMKridFWI0Yw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faea1525-f000-4ef5-7505-08d7bd84670a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 02:01:05.7226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+G+8ygP+IHfT7dOLobsy5gXLo8UoZqP07G1Ml5JpqlrwuNy3XVVOMxlwO4hVN2rKYIjbiskEG0tqZPGMG7UWY9opqco6DbRCKSowX7Kv5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit:- please have a look at the patch subject line and make=0A=
sure it is not exceeding the required length.=0A=
=0A=
One question though, have you seen similar kind of performance =0A=
improvements when system is booted ?=0A=
=0A=
I took some numbers and couldn't see similar benefit. See [1] :-=0A=
=0A=
Without :-=0A=
=0A=
714.532560-714.456099 =3D .076461=0A=
721.189886-721.110845 =3D .079041=0A=
727.836938-727.765572 =3D .071366=0A=
734.589886-734.519779 =3D .070107=0A=
741.244296-741.173503 =3D .070793=0A=
=0A=
With this patch :-=0A=
=0A=
805.549656-805.461924 =3D .087732=0A=
812.199549-812.124364 =3D .075185=0A=
818.868111-818.793779 =3D .074332=0A=
825.636130-825.554311 =3D .081819=0A=
832.287043-832.205882 =3D .081161=0A=
=0A=
Regards,=0A=
Chaitanya=0A=
=0A=
[1] Detail log :-=0A=
=0A=
Without this patch :-=0A=
=0A=
[  714.456099] nvme_init 3133=0A=
[  714.458501] nvme nvme0: pci function 0000:61:00.0=0A=
[  714.532560] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  721.110845] nvme_init 3133=0A=
[  721.114112] nvme nvme0: pci function 0000:61:00.0=0A=
[  721.189886] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  727.765572] nvme_init 3133=0A=
[  727.767814] nvme nvme0: pci function 0000:61:00.0=0A=
[  727.836938] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  734.519779] nvme_init 3133=0A=
[  734.522099] nvme nvme0: pci function 0000:61:00.0=0A=
[  734.589886] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  741.173503] nvme_init 3133=0A=
[  741.176089] nvme nvme0: pci function 0000:61:00.0=0A=
[  741.244296] nvme nvme0: 32/0/0 default/read/poll queues=0A=
=0A=
With this patch :-=0A=
=0A=
[  805.461924] nvme_init 3133=0A=
[  805.464521] nvme nvme0: pci function 0000:61:00.0=0A=
[  805.549656] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  812.124364] nvme_init 3133=0A=
[  812.126975] nvme nvme0: pci function 0000:61:00.0=0A=
[  812.199549] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  818.793779] nvme_init 3133=0A=
[  818.796581] nvme nvme0: pci function 0000:61:00.0=0A=
[  818.868111] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  825.554311] nvme_init 3133=0A=
[  825.556551] nvme nvme0: pci function 0000:61:00.0=0A=
[  825.636130] nvme nvme0: 32/0/0 default/read/poll queues=0A=
[  832.205882] nvme_init 3133=0A=
[  832.208934] nvme nvme0: pci function 0000:61:00.0=0A=
[  832.287043] nvme nvme0: 32/0/0 default/read/poll queues=0A=
=0A=
=0A=
On 02/28/2020 06:52 PM, Josh Triplett wrote:=0A=
> After initialization, nvme_wait_ready checks for readiness every 100ms,=
=0A=
> even though the drive may be ready far sooner than that. This delays=0A=
> system boot by hundreds of milliseconds. Reduce the delay, checking for=
=0A=
> readiness every millisecond instead.=0A=
>=0A=
> Boot-time tests on an AWS c5.12xlarge:=0A=
>=0A=
> Before:=0A=
> [    0.546936] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs=0A=
> ...=0A=
> [    0.764178] nvme nvme0: 2/0/0 default/read/poll queues=0A=
> [    0.768424]  nvme0n1: p1=0A=
> [    0.774132] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data =
mode. Opts: (null)=0A=
> [    0.774146] VFS: Mounted root (ext4 filesystem) on device 259:1.=0A=
> ...=0A=
> [    0.788141] Run /sbin/init as init process=0A=
>=0A=
> After:=0A=
> [    0.537088] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs=0A=
> ...=0A=
> [    0.543457] nvme nvme0: 2/0/0 default/read/poll queues=0A=
> [    0.548473]  nvme0n1: p1=0A=
> [    0.554339] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data =
mode. Opts: (null)=0A=
> [    0.554344] VFS: Mounted root (ext4 filesystem) on device 259:1.=0A=
> ...=0A=
> [    0.567931] Run /sbin/init as init process=0A=
>=0A=
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index a4d8c90ee7cc..04174a40b9b0 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -2074,7 +2074,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, =
u64 cap, bool enabled)=0A=
>   		if ((csts & NVME_CSTS_RDY) =3D=3D bit)=0A=
>   			break;=0A=
>=0A=
> -		msleep(100);=0A=
> +		usleep_range(1000, 2000);=0A=
>   		if (fatal_signal_pending(current))=0A=
>   			return -EINTR;=0A=
>   		if (time_after(jiffies, timeout)) {=0A=
>=0A=
=0A=
