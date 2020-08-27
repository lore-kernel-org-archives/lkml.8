Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE0FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE452177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="neA69P9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgH0Pep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:34:45 -0400
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:25568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbgH0Pek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:34:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSTqQh//tggO7uP0aogiHIzQVNObOpcXyNPpfIt13VZp7unHhzYtPXDRWJJCA4HeS4pTWKclJrUqGOGicsBxQRUZKFypVLqAvahBoYFwKMmoydngLjhoMW8I4wY8dn7NslUFt3zlNgMBRbQfh0uxTVugNfX/LCz0rDLR6kTmnGGXaEc/fmk7oaimhao9NarQdbal+iL8+RW/TMfqckQXG2Yn6wrJy01VrJUzL6IRxqhtgWCEz7yDs+unMJz1iBvNFgAHnMSR7NF+qSaDjxF8Jjr/cteUyOqi9WZ5n2FIhl0aQSIzlBmNlRNV9OQc2vyj7aXhmcRwL3q+dtYbqFaifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLKHTR8GFieYm6kpeie2gE+lDHmzMMV7IrijqbNvjJc=;
 b=F4tpocf9ojsLZii0zo00ECSYBHrzT1Ngudq7mFho4kglsGBlp9HfMVwOoPHoQ2Qu+ORRkrbQbcgaj6I+4FuU/9X/DPorE7ESZvCdKyEaBf24ZZDONweJIhIgXguvaIVwz+9wU53IOQrG4JHDPbwxQwtpfHh8Rx2vVxI2PguJFZp8N/eyWzT5inhw7aCFL1Sdxy7yPpQsShsaExKedThsUWtg8I1eCNnI5fobxIRbHwZna/90NommlnJtUqtCA0mEokDNdCp4J1wwgdt+anG20BtIqi/8iZx2Pv+t4CJmKGQ0CBUtIbDQ4F6+bXvY4DHWv23bdq7mbnAEUqCSsbDAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLKHTR8GFieYm6kpeie2gE+lDHmzMMV7IrijqbNvjJc=;
 b=neA69P9OtWxq5VH/43XGQ1K6t8mHo9NDNDAlBJ+lrGgVEDYejHlH/IbB2xsQ9s24uR1FGbuAKOsfP7m2AI5P/gaUHydKotmHRA+D2ckKjH4/iUVB/w11ri/3n/DL8cb5q4++Ix8fg0LD7PSPUxhA5EqZ5Jz74gvO9rJryFpu5dg=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 15:34:34 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 15:34:34 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Michael Auchter <michael.auchter@ni.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 0/5] Provide basic driver to control Arm R5
 co-processor found on Xilinx ZynqMP
Thread-Topic: [PATCH v9 0/5] Provide basic driver to control Arm R5
 co-processor found on Xilinx ZynqMP
Thread-Index: AQHWfBWgHhYT12VXOUuBHovnehXuc6lL+RkAgAAbSjA=
Date:   Thu, 27 Aug 2020 15:34:33 +0000
Message-ID: <BYAPR02MB440788CF3D35297D41DA385BB5550@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
 <20200827134742.GB404249@xaphan>
In-Reply-To: <20200827134742.GB404249@xaphan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: ni.com; dkim=none (message not signed)
 header.d=none;ni.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f66ff7e-1cf6-4169-3360-08d84a9eb2f6
x-ms-traffictypediagnostic: BYAPR02MB5029:
x-microsoft-antispam-prvs: <BYAPR02MB5029A35A35804D0A74A2E037B5550@BYAPR02MB5029.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWBIlXyMr+5o8MQLbntU08Li7KMXyUjVBAkozVST0SJTkUt9fZsIfYTwzXYfp8n70k/xtkOSsTJ82xYtev3effZEl12u1vn/zJwf3MkEL9Um2AmqOip9Z/eKdYegjzHB7Rib1ml+cDLtWKLR1Fmwb447STlEY8qvnFWjKEvZU59moTlILfNSgeJ4tXaS/ZquLK3fxo7hM5HtwAbqzouPNzDkda7TOEpW6f12HEweP7re+RwWJwpSyvyPXWZZDXILcB+zQhMqbdhRwAzv1YNPYKCC7mndOpwMfAvDooqYl+3T4HJuhP8fJDda/sCWHwBsBDOpqB7ODj7nBEhJkdl6hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(83380400001)(8676002)(8936002)(478600001)(5660300002)(2906002)(71200400001)(66446008)(66476007)(64756008)(66946007)(76116006)(7696005)(33656002)(66556008)(53546011)(316002)(55016002)(86362001)(6916009)(4326008)(54906003)(52536014)(9686003)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v5Bls18pfYGrAzn7O6hkat4fXlQUJx9Nnbgflvto4TYi0kWAcBp476EGl6VkHLl+fW92/HWlhCN3RVWG3VSTtXvzOTtsUoe3Id6Qly67YDbT+DU/NV3hQAiHdkMevWkQWc8fo58zvMqtMPv9XVD4aAYQb4rTWBTIUrlF3VABbYja4X7C5rz+rHiDpimZ7uNyV7ufq9XLkVNKbHSW7PmUU40ikEYUY4hJhxCSQ0+meyZK3nZlXWjK9VFKOTwReJKmdc4VxlckyaZci2IlQp7pmP8hSrGVWRhA7bYuxhaTB9tm1HtqAF/Zm4Vp3xvJ3X2t1ckoGX1tu3cQtbwgM6fUwa+Pi3ohnvCLqqUuLXu/gJR7sSOTrXcL4AtKUYGTt6A+CeEBRCzHBbTAeZLQpoNCWjy1WSRYnot/9H81uNkx4J/9STtgk6XQO2Z9lB/gBtmGa1+un452XvB/G/yRoo3Yxrh789Ay6cfhEQcpKMXTqPtCIKyGsWnSUp9X0FNlQjkeWWjw51H4aZlEfDxpEPUCdumdiafMgyZhy0/WCgvIg0KzS6KVUCX0SHeGb/Q4lH8AbpQ2u6e5NIfw2D6NYHi/rc9yLM/c0IG8QsUd3vXgpENG8ka/qKFW/nMMhgLshkLa+idoEu8NB+aBRszgvK5IJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f66ff7e-1cf6-4169-3360-08d84a9eb2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 15:34:33.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WECNRmMjI13LyCUKiSHc+vd5lZ3y6WOlxQssIukeaa6Xdyo222jUmhRPUh/NfaZGHj60z38+7UTK3jksPuvjlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for comment. Maybe I missed some of the comments then? I had thought=
 that your comments were the following and that I had answered them in the =
code:
V8 3/5:
- zynqmp_pm_set_rpu_mode: pass arg1 instead of 0 to zynqmp_pm_invoke_fn
This should be reflected in v9 3/5
- update kernel docs for zynqmp_pm_set_rpu_mode
may have misunderstood the comment here. I updated the function and its com=
ments above the function so that there is no obsolete iocl_id or arg2 menti=
oned
V8 5/5:
-  " In the event that zynqmp_r5_probe() fails before zynqmp_r5_setup_mbox(=
)
has run, this will be called on an uninitialized skb_queue. (Also
obviously an issue once mailboxes are made optional again)."
To remedy this I added logic in v9 in the zynqmp_r5_release() function so t=
hat the driver checks if a pointer field in the struct is NULL or no before=
 discarding skb's

Were there other comments?

With that being said, I will make sure the R51 case is more completely cove=
red.

Thanks
Ben


> -----Original Message-----
> From: Michael Auchter <michael.auchter@ni.com>
> Sent: Thursday, August 27, 2020 6:48 AM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Jiaying Liang
> <jliang@xilinx.com>; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v9 0/5] Provide basic driver to control Arm R5 co-
> processor found on Xilinx ZynqMP
>=20
> Hey Ben,
>=20
> On Wed, Aug 26, 2020 at 06:58:05PM -0700, Ben Levinsky wrote:
> > v10:
> > - add include types.h to xlnx-zynqmp.h for compilation
>=20
> I appreciate the quick turnaround on v10, but it looks like much of my
> feedback on v9 went unacknowledged.
>=20
> Most concerning is the fact that loading firmware on to R5 1 is _still_
> broken in v10 due to the incorrect TCM banks being used.
>=20
> Thanks,
>  Michael
>=20
> >
> > Ben Levinsky (5):
> >   firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
> >     configuration.
> >   firmware: xilinx: Add shutdown/wakeup APIs
> >   firmware: xilinx: Add RPU configuration APIs
> >   dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
> >     bindings
> >   remoteproc: Add initial zynqmp R5 remoteproc driver
> >
> >  .../xilinx,zynqmp-r5-remoteproc.yaml          | 113 +++
> >  drivers/firmware/xilinx/zynqmp.c              |  86 ++
> >  drivers/remoteproc/Kconfig                    |  10 +
> >  drivers/remoteproc/Makefile                   |   1 +
> >  drivers/remoteproc/zynqmp_r5_remoteproc.c     | 898
> ++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h          |  63 ++
> >  6 files changed, 1171 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-
> remoteproc.yaml
> >  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> >
> > --
> > 2.17.1
> >
