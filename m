Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC59206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IVEuEPA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIJSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:16:45 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:23745
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbgIJSO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:14:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6oBzjH+ltOGFYRajrtU1Tmlk+jVEm/P6si+t0v7qj9T3wYCtcDjISMpmnFOcne4/UsWtVsDqXE83ViOLp7jSUHY2y18K5Vv7+hurcypnZ6S57eJMtapRLqto3JOzsZ1E3BXMUGEIyJOs6fitbbPngQFWZFTwvFPVTsnndnjqCtlfUuYixkczs8kClT7nqnt66/jK6hJWSyPIXyZZo9VNEkAkT9z0ZaF4Kbfe1vCBX3WQTLHOa7EsHHlW7mDNeLd5d7DG0S+z/V0fT2moxIL7RLyt4ERnKC6zTCuSN/fuBpEZTcj1uwsNBeFLbfbnSSXAS3KGWEIW2OxULeBMWDyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHjB2unu+9Et4mo9cnxLh3GBS2bINldpk93zFl43Gzk=;
 b=gKa/Amvm7RvLB0dhff7ewfzXOXyVbTcVOdZ5RrRkwyLliG1byH6vERq62RS4P160fj3eMaLxFpP7FZA7lOFdhv/vEgBFFVkN90zCwcBRbT4z/8xPqjFOPzFVtPV/pYdx5FMeieXhNoWn711ZUWzrSu+TLGf1/hzsbCabfjF7vRg482c35SEWkvGkXxOsVs1JocFo01OSdMKYCY4dVLeqgHE9Dj4e+GN1lSHd/+BeGq0VfL0+FW9yQ+Ca47J8YKHhqgDknQmaV/IcyRec/B7bAd+oaSudBkLNh7jFP0s9IqR+t6ITDRrfWFsEkImKcK1PeucZOSU5v1zO0QSdVXSMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHjB2unu+9Et4mo9cnxLh3GBS2bINldpk93zFl43Gzk=;
 b=IVEuEPA7u40Gyu9wJ0tOyAgecrHHOlosMKJxUAUBCruBoPK+BoHpOg5ZJGxLsAb0ppjpnJihIHgU8V2Fxl/asSHVHoFz8tI5CLRs9ThXy3NvMm5VKlkhHVP+FoIkSGhyogjSjxbAhgCWAxGsFi3PATmr8F9QNbLqkgWis8xFFLc=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by DM6PR02MB7003.namprd02.prod.outlook.com (2603:10b6:5:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 18:14:26 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::ea) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 18:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; ffwll.ch; dkim=none (message not
 signed) header.d=none;ffwll.ch; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:14:25
 +0000
Received: from [149.199.38.66] (port=37327 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGR5D-0003IK-S1; Thu, 10 Sep 2020 11:14:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGR5V-0002dy-Bn; Thu, 10 Sep 2020 11:14:25 -0700
Received: from [172.19.75.82] (helo=xsjsycl40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGR5O-0002cu-98; Thu, 10 Sep 2020 11:14:18 -0700
Received: by xsjsycl40.xilinx.com (Postfix, from userid 13638)
        id 4003F352C02; Thu, 10 Sep 2020 11:14:18 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:14:18 -0700
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Michal Simek <michals@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] drm: xlnx: remove defined but not used
 'scaling_factors_666'
Message-ID: <20200910181418.GA3187626@xilinx.com>
References: <20200910140630.1191782-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910140630.1191782-1-yanaijie@huawei.com>
Content-Transfer-Encoding: quoted-printable
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78f61b6-73a3-402f-b8ee-08d855b559d9
X-MS-TrafficTypeDiagnostic: DM6PR02MB7003:
X-Microsoft-Antispam-PRVS: <DM6PR02MB7003EEBD33BA17B8D8BF7B06D6270@DM6PR02MB7003.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQwHXJqIyAnEQ9dQ2qu+IwQKxbYxX7EbC04QDo8smL6uCD+5e00xAVMwFPmG8Iw5XpRQotE3Ji5Aa/ofwKbpowlq8lGB3ZG2gMuWDc82YiBoy+jDYMnlP9rWsIo2gMCFKNIwYXHLp8g2ltY3kh37uXtirtwc994Iuizuk4j2kG50jd0p70zb8fCpwRHCq1hJjL1Uux80AdG/JUkkzqs0wey6dgQYi212Pma3xYVS7d1qEn/EGXP19t3QtptHYO23mz8G2yAR7I2wa4W14piTQtvYFp3GA3+sT2+sdQvI6oeSvcfBlJzhnV4q3+pDexb48kioi2HYQJL6QVIwK/hC7bphGEyA+ltbCOPwhrj1oEmpk+jdaaBYyorYovYMvs6JyeHTQtEPxvUs87enXc7Mpw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:ErrorRetry;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(46966005)(44832011)(81166007)(316002)(83380400001)(82740400003)(336012)(54906003)(33656002)(70206006)(2906002)(6266002)(426003)(2616005)(356005)(1076003)(26005)(8676002)(5660300002)(82310400003)(8936002)(186003)(42186006)(6916009)(478600001)(70586007)(36756003)(47076004)(63350400001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:14:25.7702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78f61b6-73a3-402f-b8ee-08d855b559d9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, Sep 10, 2020 at 07:06:30AM -0700, Jason Yan wrote:
> This addresses the following gcc warning with "make W=3D1":
>=20
> drivers/gpu/drm/xlnx/zynqmp_disp.c:245:18: warning:
> =E2=80=98scaling_factors_666=E2=80=99 defined but not used [-Wunused-co=
nst-variable=3D]
>   245 | static const u32 scaling_factors_666[] =3D {
>       |                  ^~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Hyun Kwon <hyun.kwon@xilinx.com>

Thanks!

-hyun

> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/=
zynqmp_disp.c
> index a455cfc1bee5..98bd48f13fd1 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -242,12 +242,6 @@ static const u32 scaling_factors_565[] =3D {
>  	ZYNQMP_DISP_AV_BUF_5BIT_SF,
>  };
> =20
> -static const u32 scaling_factors_666[] =3D {
> -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> -};
> -
>  static const u32 scaling_factors_888[] =3D {
>  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
>  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> --=20
> 2.25.4
>=20
