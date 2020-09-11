Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFECC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130E8221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OSFxQjXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgIKQ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:28:11 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:21601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbgIKQ1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrmBVfRU7ICRR15m7BipluRyQoEJ8tlN8sSyq/UEBrWJGkXwD7gEaSomoXBpA2Xjk1k0Cp0xgQlwTq0eyPTrI7wg3NGen4qem2aY040KI0nujlkELQVVNYWBwFkMn4MPmTVMt9NC/KyLTj+qkQ6rlNKR4QecD+yZuW3+5esPz+ipLDCZus8ndJhCIJZGZXvdjt1bqisUna7yH7Hk0DEef3X43ry9FnKRExBCHCqCObMZ+ZKReAkwdUzFjKfmMc4dKc/JGXj20MiKl/l5aUOiD/dqWKflsZPiIQNyQKq+hL8gK7M8+uKnciO9zZ3gTauxV75L825mc6VQEjoI1nKmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x3V/Nd53xRa2BqytRenQV19ktcCzWqzFhB9zwKa4hw=;
 b=N674SzA8pv9uWKfTQdeednRRXfwB6wxRQsKbG7LnMCrNounNVn1XIZS3vkx/YjTGr8qCckxGJW9byCpBiih1PVBqRtU2/YVDzCne1W7ksf6D+96Kpzg+Mf8dNyBcT7v8HFbiDPTBEzU/tuBsxMiR8CdPxSXRui8R24sxR9EtVqnSmlSJpHvLO4vhDXj5UNXO949Wwc0SS0qEU0+aqVkujzeW5CGr2mIO2YVesSsd/vBaMcCh9KsbH2RcBrTuXHxCMvUGD6xJ17m7GmY0i3c7pDZjSiiroaK/oE6IRhld7liuPxnpKE3DjUdQ6Vf7Hy/OJ7hqzrKrtTDJ58+CIpQrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x3V/Nd53xRa2BqytRenQV19ktcCzWqzFhB9zwKa4hw=;
 b=OSFxQjXExon5oyZebtbUrs2zwLS4AO58vwaHnkiUksGHGulqyY3vHvhcIXl+gDIytAk8CVkh9nl/nIpjLU2igFNkM8SuS5qba8C/zIArg0Km4nOmLXBPJOIlIgnLfez1atKdzijbje4V+z/t2aRTyf6MnWj+T5rKSQA9J5027i0=
Received: from CY4PR08CA0039.namprd08.prod.outlook.com (2603:10b6:903:151::25)
 by MN2PR02MB6110.namprd02.prod.outlook.com (2603:10b6:208:1bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:27:11 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::1d) by CY4PR08CA0039.outlook.office365.com
 (2603:10b6:903:151::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 16:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:27:10
 +0000
Received: from [149.199.38.66] (port=51300 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGltF-0006Dv-Ou; Fri, 11 Sep 2020 09:27:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGltG-0001nh-ID; Fri, 11 Sep 2020 09:27:10 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08BGR8pT002592;
        Fri, 11 Sep 2020 09:27:08 -0700
Received: from [172.19.75.82] (helo=xsjsycl40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGltE-0001mg-CE; Fri, 11 Sep 2020 09:27:08 -0700
Received: by xsjsycl40.xilinx.com (Postfix, from userid 13638)
        id 51345352C02; Fri, 11 Sep 2020 09:27:08 -0700 (PDT)
Date:   Fri, 11 Sep 2020 09:27:08 -0700
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jason Yan <yanaijie@huawei.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Michal Simek <michals@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] drm: xlnx: remove defined but not used
 'scaling_factors_666'
Message-ID: <20200911162708.GA3715173@xilinx.com>
References: <20200910140630.1191782-1-yanaijie@huawei.com>
 <20200910181418.GA3187626@xilinx.com>
 <20200911081519.GM438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911081519.GM438822@phenom.ffwll.local>
Content-Transfer-Encoding: quoted-printable
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d8a328-5ba8-450e-6ffc-08d8566f88ba
X-MS-TrafficTypeDiagnostic: MN2PR02MB6110:
X-Microsoft-Antispam-PRVS: <MN2PR02MB61103328AD69393F857C0AE5D6240@MN2PR02MB6110.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWb2wHcGfg6z5Cw9SGfh2/D86tb/WjWOwdsGnlu1V+R1pJQS/syW392Q5FCoJLH/wrSng2xuWlUOOKGaT+IstnORmbjNyNlWVRt5ui3w2sBoYdUu66B6F4SMQpiu/614/BlI2CwDhgSz91l9KOG/Trn5paRaQy7t8vKC3Nh1p37udlKdInROVnj1DIVsemwZnWxRmBPi517zpQjmj2khNCY/n+w3je3+m/pe7Wn7tYb3VVGE5R3JSVenaa+yfsEGTjHp/5KDMYBbtOJW1rD6LuiHLW25diO2uLdY8IjNmJH2tTfO3qXSLgvVriB0IeVxd7fL8t2LQJ7i4rmMo9eeiX1121TCmeb8Z3/C2eGOCFN6+2cUV69J2Z/yX/e7j4B6oOyxilj20Y8kWIORvWXvCOXKEyfvPNFlJxw5rCGL9hIIn0s5s8V84OraeB1hIun76hfgB8I41lzn+h9WjsqyeqNbgmSGhnq3mtSYFbHTONY=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(46966005)(70206006)(83380400001)(33656002)(82310400003)(336012)(70586007)(1076003)(316002)(5660300002)(42186006)(6916009)(81166007)(36756003)(83080400001)(478600001)(82740400003)(54906003)(426003)(47076004)(4326008)(966005)(8936002)(6266002)(356005)(2616005)(8676002)(186003)(2906002)(26005)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:27:10.8113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d8a328-5ba8-450e-6ffc-08d8566f88ba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Sep 11, 2020 at 01:15:19AM -0700, Daniel Vetter wrote:
> On Thu, Sep 10, 2020 at 11:14:18AM -0700, Hyun Kwon wrote:
> > Hi Jason,
> >=20
> > On Thu, Sep 10, 2020 at 07:06:30AM -0700, Jason Yan wrote:
> > > This addresses the following gcc warning with "make W=3D1":
> > >=20
> > > drivers/gpu/drm/xlnx/zynqmp_disp.c:245:18: warning:
> > > =E2=80=98scaling_factors_666=E2=80=99 defined but not used [-Wunuse=
d-const-variable=3D]
> > >   245 | static const u32 scaling_factors_666[] =3D {
> > >       |                  ^~~~~~~~~~~~~~~~~~~
> > >=20
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> >=20
> > Reviewed-by: Hyun Kwon <hyun.kwon@xilinx.com>
>=20
> I think you're the maintainer, so please also push patches to
> drm-misc-next. Otherwise they'll just get lost, or at least it's very
> confusing when a maintainer reviews a patch but there's no indication w=
hat
> will happen with the patch.

Right. I wanted to give it some time before pushing. I'll clearly state g=
oing
forward.

Thanks,
-hyun

> -Daniel
>=20
> >=20
> > Thanks!
> >=20
> > -hyun
> >=20
> > > ---
> > >  drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/x=
lnx/zynqmp_disp.c
> > > index a455cfc1bee5..98bd48f13fd1 100644
> > > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > @@ -242,12 +242,6 @@ static const u32 scaling_factors_565[] =3D {
> > >  	ZYNQMP_DISP_AV_BUF_5BIT_SF,
> > >  };
> > > =20
> > > -static const u32 scaling_factors_666[] =3D {
> > > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > > -};
> > > -
> > >  static const u32 scaling_factors_888[] =3D {
> > >  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> > >  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> > > --=20
> > > 2.25.4
> > >=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
