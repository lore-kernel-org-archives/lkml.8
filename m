Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81536C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5347520CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iuHVvLQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407919AbgDOCmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:42:45 -0400
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:6369
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388214AbgDOCmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjAl34XhCuiLTgbHZP+Y1m0HZL7a4wv+C45i11B49sZCrBSk8i3CtTvAAqvGHBx2y/1/ySTzgI1rlSEx3jFSXCaYKpY1zvFhSvhkW1vRxWJtJe5AgLF2arc6NIJifLiK2sZE9JBqXh2t/KWzNk4erYFdkg98xKRMoeGe2tnEeAiXC0weeKPyFiyHso9BOvD8cB+HxDYplUV/Oam41IA8XeEnJ5CTqu7Uh64ArJFXwfiWGwwYzzy8JVmar74eQOtWCFwQkz9a2+HRo8bpHB/TesChyl9tkAVnHQs8WJy1TbP1z1cLHFZZcLBQ0n5d3O9J9xXzp4b7O3nYMMObNmgcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtFjWj1YucLUeoKjFAhlC/kjmEtosOXKWzmGv9cI8CE=;
 b=hwxVATyNwO7gnf0vBLjZiTj+x0lkDfIFTpbAhTIzFsrnIbXwnde+vOPT/69T+CKxgkBBu/CW0EAH2o21s5lQfYvoCTJFMDg8xili8EC9BP6cWnatTcCATfFrcY7Q0uAbhWpWaLJFBhwD6UMZU7pwEvWomQRJjuo5aUvzKUv/YZ+oNj1BcWtJzn3oUWDV3/04QaZT4UROUvvVzVj06TUkbz9LzPhqBYsz+6m2WunDE2qgdcMUAzCoaav+svuuuQgtLxTi6s/tJKRd1o1zifbecYFY8NLIyDS+KfPMon/nJUtY0IP/ClXiSivHPoHGMmWSUV5X/Qv6WaDBjtCqWXdbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtFjWj1YucLUeoKjFAhlC/kjmEtosOXKWzmGv9cI8CE=;
 b=iuHVvLQJ7SJmaxRRlon4KtALNpSARcW86sVHzHbWkbcgXa2Lt8FpEKALBfiyvwc7NsR5CCjhdMC8x87WCbkBbZyOLOAQGBx+8og6obhbFPy0APIPsf/HmGX5vdIhXfQ1nc9rT03FJazbycKnvd8sq4RYOAZkSu1IqKpulNIEg8E=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2695.eurprd04.prod.outlook.com (2603:10a6:4:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 02:42:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 02:42:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] remoteproc: imx_rproc: add virtio support
Thread-Topic: [PATCH v2 0/3] remoteproc: imx_rproc: add virtio support
Thread-Index: AQHWDAb+JdgObafwAkG5FGKUl9Xnrah5hqFQ
Date:   Wed, 15 Apr 2020 02:42:32 +0000
Message-ID: <DB6PR0402MB27603D39E31D30AA28D6893A88DB0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200304142628.8471-1-NShubin@topcon.com>
 <20200406113310.3041-1-nikita.shubin@maquefel.me>
In-Reply-To: <20200406113310.3041-1-nikita.shubin@maquefel.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de760fa7-0c26-4bf9-0fc8-08d7e0e6a5e7
x-ms-traffictypediagnostic: DB6PR0402MB2695:|DB6PR0402MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB269562743D7977329228622F88DB0@DB6PR0402MB2695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(8676002)(6916009)(76116006)(66556008)(966005)(8936002)(316002)(7416002)(66446008)(64756008)(5660300002)(66946007)(55016002)(9686003)(66476007)(44832011)(81156014)(478600001)(54906003)(186003)(7696005)(6506007)(4326008)(52536014)(71200400001)(33656002)(26005)(2906002)(86362001)(505234006);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uv8CnEOS8qMeLmlJKtDH0WjIKiXocqebxmyKKRYXPd4P2qLN4G4xLzGvWHqwy37INwXnX+HH7hyDAELqG6YiqAA48nBRFvYIKOq1ihTssT9RZ70jsoWJ31CTuRyvCh7cHIcS6CVmnTXGQm2URAyamoPIqNWWJo6sWodfMNFJNOYji2N9NGnzvLnRzRDc5DfLgknQMhChqW66uiwtMuBOZbmoxoKWp9QXtXj2uzCBl0WJ2A9Y1CIJLddN9sjKF6kHD5E5+oItIj1ApspjdLPVQmMu/cdjSk0FugYN6862DbktEykIlww9AlDEylSeEG8gv6oPyrAUaNIW4V0lv2WzCi1csdIuVHlcN5vH4XufJ0DonlDxM+F0uvWUkivsj9jJ8X8ytK7slYgKZo04vZ3LTyvmEtBQhUKZaBWtu4mrnPJErtJpRq6yYOCEInQBpfNRVDiT9hcWADZHUxBctLri3USza0hY6UkWX0YIPGsnX7edyMQkYug1l8BiA9cLG3Ds4y9qRV4AJk7Y9RwX0Xxm2ZUWDJk7R2eGc6ofeL9KwkMWSbfRsWkk+fZngf/09p7PBxeG8woJTAYnqs7x1s5pGg==
x-ms-exchange-antispam-messagedata: Iu/bQsl1Rr4KTCWbz59s/ZknJXYLKMLgyG9pJz6lg5a7o5Avo13SIs1cJxEbxrH6QCrEcfw7zE0uqAAgsCIGDjau/QjkrKvvMxw2Eaw8uBBTpjMOP/XfHOHMrGyeOk74xH1XwyWVr9FruzO/DBdqGg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de760fa7-0c26-4bf9-0fc8-08d7e0e6a5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 02:42:32.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TAbGj87zyHa1h9LU/mv8Te/18qIxLbo0fapHSR8Y2kRA570hwmzmU+AhhEaCaEg+POyLl2kU7g5nRKiPIQtGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 0/3] remoteproc: imx_rproc: add virtio support

Have you ever see https://patchwork.kernel.org/cover/11390477/?

I have been waiting for Mathieu's rproc sync state patch, then
rebase.

Thanks,
Peng.

>=20
> This patch set introduces virtio support for imx7d-m4 communication:
>=20
> - support booting loaded vim imx-rproc firmware
> - implement .kick method support using mailbox in imx-processor
> - parse vdev0vring0, vdev0vring1, vdev0buffer memory regions required for
> virtio_rpmsg_bus initialization
>=20
> Regarding imx7d-m4 boot proccess
>=20
> Citing ARM documentation:
>=20
> At Reset, Cortex-M3 and Cortex-M4 processors always boot from a vector
> table at address zero.
>=20
> "With uninitialized memory at address zero (for example, unprogrammed
> Flash or uninitialized RAM), the processor will read a spurious initial M=
ain
> Stack Pointer value from address zero and a spurious code entry point (Re=
set
> vector) from address 0x4, possibly containing an illegal instruction set =
state
> specifier (ESPR.T bit) in bit[0]."
>=20
> So to successfully boot m4 coproc we need to write Stack Pointer and
> Program counter, i see no obvious to get Stack Pointer value, so two ways
> exist ethier form a special elf section:
>=20
> "
> .loader :
>   {
>     LONG(__StackTop);
>     LONG(Reset_Handler + 1);
>   } > m_start
> "
>=20
> and put it at 0x0 address:
>=20
> "
> m_start               (RX)  : ORIGIN =3D 0x00000000, LENGTH =3D
> 0x00008000
> "
>=20
> Or (the way i've chosen) only put Entry Point at 0x04 and set stack as fi=
rst
> instruction:
>=20
> "
> Reset_Handler:
> 	ldr   sp, =3D__stack      /* set stack pointer */
> "
>=20
> Regarding mailboxes and memory regions :
>=20
> This code is heavily derived from stm32-rproc (i.e. copy pasted) and this=
 fact
> needs to reflected in commits, please tell me how to emphasize this fact.
>=20
> Attaching succesful trace booting m4 (with Add rpmsg tty driver applied) =
:
>=20
> [  143.240616] remoteproc remoteproc0: powering up imx-rproc
> [  143.251768] remoteproc remoteproc0: Booting fw image huginn.elf, size
> 466876 [  143.251786] imx-rproc imx7d-cm4: iommu not present
> [  143.251825] remoteproc remoteproc0: rsc: type 3 [  143.251837]
> remoteproc remoteproc0: vdev rsc: id 7, dfeatures 0x1, cfg len 0, 2 vring=
s
> [  143.251924] remoteproc remoteproc0: vdev rsc: vring0: da 0xffffffff, q=
sz
> 16, align 16 [  143.251935] remoteproc remoteproc0: vdev rsc: vring1: da
> 0xffffffff, qsz 16, align 16 [  143.251955] imx-rproc imx7d-cm4: map memo=
ry:
> 0x00900000+20000 [  143.251987] imx-rproc imx7d-cm4: map memory:
> 0x00920000+2000 [  143.252003] imx-rproc imx7d-cm4: map memory:
> 0x00922000+2000 [  143.252020] remoteproc remoteproc0: phdr: type 1 da
> 0x20200000 memsz 0x240 filesz 0x240 [  143.252032] remoteproc
> remoteproc0: da =3D 0x20200000 len =3D 0x240 va =3D 0x(ptrval) [  143.252=
043]
> remoteproc remoteproc0: phdr: type 1 da 0x20200240 memsz 0x5b38 filesz
> 0x5b38 [  143.252053] remoteproc remoteproc0: da =3D 0x20200240 len =3D
> 0x5b38 va =3D 0x(ptrval) [  143.252105] remoteproc remoteproc0: phdr: typ=
e
> 1 da 0x20205d78 memsz 0x4b58 filesz 0x758 [  143.252115] remoteproc
> remoteproc0: da =3D 0x20205d78 len =3D 0x4b58 va =3D 0x(ptrval) [  143.25=
2159]
> remoteproc remoteproc0: da =3D 0x200006cc len =3D 0x8c va =3D 0x(ptrval)
> [  143.252176] remoteproc remoteproc0: Started from 0x202002f5
> [  143.252211]  imx7d-cm4#vdev0buffer: assigned reserved memory node
> vdev0buffer@00924000 [  143.252232] virtio virtio0: reset !
> [  143.252241] virtio virtio0: status: 1 [  143.260567] virtio_rpmsg_bus
> virtio0: status: 3 [  143.260598] remoteproc remoteproc0: vring0: va
> c083c000 qsz 16 notifyid 0 [  143.260614] remoteproc remoteproc0: vring1:
> va c0872000 qsz 16 notifyid 1 [  143.260651] virtio_rpmsg_bus virtio0:
> buffers: va c0894000, dma 0x00924000 [  143.260666] Added buffer head 0
> to (ptrval) [  143.260674] Added buffer head 1 to (ptrval) [  143.260680]
> Added buffer head 2 to (ptrval) [  143.260686] Added buffer head 3 to (pt=
rval)
> [  143.260692] Added buffer head 4 to (ptrval) [  143.260697] Added buffe=
r
> head 5 to (ptrval) [  143.260703] Added buffer head 6 to (ptrval)
> [  143.260709] Added buffer head 7 to (ptrval) [  143.260715] Added buffe=
r
> head 8 to (ptrval) [  143.260721] Added buffer head 9 to (ptrval)
> [  143.260727] Added buffer head 10 to (ptrval) [  143.260733] Added
> buffer head 11 to (ptrval) [  143.260738] Added buffer head 12 to (ptrval=
)
> [  143.260744] Added buffer head 13 to (ptrval) [  143.260750] Added
> buffer head 14 to (ptrval) [  143.260756] Added buffer head 15 to (ptrval=
)
> [  143.260771] virtio_rpmsg_bus virtio0: status: 7 [  143.260779]
> remoteproc remoteproc0: kicking vq index: 0 [  143.260788] remoteproc
> remoteproc0: sending message : vqid =3D 0 [  143.260802] imx_mu
> 30aa0000.mailbox: Send data on wrong channel type: 1 [  143.260810]
> virtio_rpmsg_bus virtio0: rpmsg host is online [  143.261680]
> imx7d-cm4#vdev0buffer: registered virtio0 (type 7) [  143.261694]
> remoteproc remoteproc0: remote processor imx-rproc is now up
> [  143.354880] remoteproc remoteproc0: vq index 0 is interrupted
> [  143.354895] virtqueue callback for (ptrval) ((ptrval)) [  143.354912]
> virtio_rpmsg_bus virtio0: From: 0x0, To: 0x35, Len: 40, Flags: 0, Reserve=
d: 0
> [  143.354924] rpmsg_virtio RX: 00 00 00 00 35 00 00 00 00 00 00 00 28 00
> 00 00  ....5.......(...
> [  143.354932] rpmsg_virtio RX: 72 70 6d 73 67 2d 74 74 79 2d 72 61 77 00
> 00 00  rpmsg-tty-raw...
> [  143.354939] rpmsg_virtio RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00  ................
> [  143.354945] rpmsg_virtio RX: 00 00 00 00 00 00 00
> 00                          ........
> [  143.354956] NS announcement: 72 70 6d 73 67 2d 74 74 79 2d 72 61 77
> 00 00 00  rpmsg-tty-raw...
> [  143.354963] NS announcement: 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00  ................
> [  143.354969] NS announcement: 00 00 00 00 00 00 00
> 00                          ........
> [  143.354980] virtio_rpmsg_bus virtio0: creating channel rpmsg-tty-raw
> addr 0x0 [  143.356584] rpmsg_tty virtio0.rpmsg-tty-raw.-1.0: new channel=
:
> 0x400 -> 0x0 : ttyRPMSG0 [  143.356651] Added buffer head 0 to (ptrval)
> [  143.356658] No more buffers in queue [  143.356667] virtio_rpmsg_bus
> virtio0: Received 1 messages [  143.404302] remoteproc remoteproc0: vq
> index 0 is interrupted [  143.404319] virtqueue callback for (ptrval) ((p=
trval))
> [  143.404337] virtio_rpmsg_bus virtio0: From: 0x1, To: 0x35, Len: 40, Fl=
ags:
> 0, Reserved: 0 [  143.404350] rpmsg_virtio RX: 01 00 00 00 35 00 00 00 00
> 00 00 00 28 00 00 00  ....5.......(...
> [  143.404391] rpmsg_virtio RX: 72 70 6d 73 67 2d 74 74 79 2d 72 61 77 00
> 00 00  rpmsg-tty-raw...
> [  143.404399] rpmsg_virtio RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00  ................
> [  143.404405] rpmsg_virtio RX: 01 00 00 00 00 00 00
> 00                          ........
> [  143.404417] NS announcement: 72 70 6d 73 67 2d 74 74 79 2d 72 61 77
> 00 00 00  rpmsg-tty-raw...
> [  143.404424] NS announcement: 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00  ................
> [  143.404430] NS announcement: 01 00 00 00 00 00 00
> 00                          ........
> [  143.404441] virtio_rpmsg_bus virtio0: creating channel rpmsg-tty-raw
> addr 0x1 [  143.411114] rpmsg_tty virtio0.rpmsg-tty-raw.-1.1: new channel=
:
> 0x401 -> 0x1 : ttyRPMSG1
