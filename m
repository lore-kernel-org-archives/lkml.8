Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE66CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D6D2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="ekRrOC+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgH0Sno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:43:44 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:35052 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbgH0Snn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:43:43 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RIYqDd002875;
        Thu, 27 Aug 2020 13:43:39 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-00010702.pphosted.com with ESMTP id 332yd27kns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:43:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTExRrZNssaQHUbxudnERDbqocKHi1wO9uWZ4ua4OHx1GFkROHTZlfUoJtSYpDPmXcA0oBa0u/2sMRrqrQz/hXK3I/bO/xmcaRvUgJD6nk1JCIuw1uR88KTo72172wM5th6pqckTKnav7i6egkUEEqwjSPFPW6ASXAeH8rlSw7n2GZVTjgGEDTHUsoF6qatc/Ovy3VkJj0qLWaNwwBZILx0V2HvZOkwYAgYlw1V+KdpcS/p/IRUjS7tcXMestYl/s5DzaAKwnxdskgnAU+b/fSKzMfYV22Gq+Qscf5fSI3ZLfOHpdajriOOZ2F4oFhKnYYw2N0zOOgeVvTp9ahrUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfK7GXXHo7TN4Vj6QDI+M8MwLoRLcDP6H5xVBz/+TvM=;
 b=S1drDip24EZFX5ZAc+843krNLJuE5lgtFjzJ3P0C5YRH/nFxPRorkou8W6UE/+37UasA1QDAqEYjRc+n7QJikpFT5NRe8xlHZigsRlKM6i9tu/7oKsmKCL8bHoVmd8dfgPboMcQgYaBIIgfAX2MEPkm7J0nK9l4tNJ+LkIk7P1kY2O2rW7t2HLG8uZ8MBIwaHC24EhINjaD8uy+CST2qfIqNAe9iEoQicXa6wvbFVDYBdzCaOlhsftCVQArRViTJFJPTTPSEHkwWjl7fiOgdt1KghF7wOXs/QwlSG50jqpD4QEEw7jlDqY/oCMeObLamSrBp11U4NrBYMumvGgeMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfK7GXXHo7TN4Vj6QDI+M8MwLoRLcDP6H5xVBz/+TvM=;
 b=ekRrOC+zlmwFd+u9VOuAjHNPt+EEQfg4ejv7kBO+WSiG2zJP4NmAYYGYWwWnGnjfpHl+cI741pS/PSR4/YGaCrcWIVKewb+yax+mVLCCyy4QOMmpoZiWOoPmGq7jmPtIzGdmDs6zsheG/Ds96yVEWrOJfupyRBHEeF/zZP/Sk/A=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 18:43:37 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750%3]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 18:43:37 +0000
Date:   Thu, 27 Aug 2020 13:43:35 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Ben Levinsky <BLEVINSK@xilinx.com>
Cc:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Message-ID: <20200827184335.GA520606@xaphan>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
 <20200827134742.GB404249@xaphan>
 <BYAPR02MB440788CF3D35297D41DA385BB5550@BYAPR02MB4407.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB440788CF3D35297D41DA385BB5550@BYAPR02MB4407.namprd02.prod.outlook.com>
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Thu, 27 Aug 2020 18:43:36 +0000
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3d7a58-53a0-4110-3716-08d84ab91b65
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3567:
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3567BA7020AAEC6DEB075C2D87550@SN4PR0401MB3567.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaL/2dPGwS1Pbjq7bwkn5CNx4RYptOG0YcyaZ8LB6/LiGZfqhRhOOwUp6u+oegYVOZvnre1oj9d6TkPTVtLz79lql7aob4L+K2MQg2XNbYOu31oUIrHVkpWAsX/c213WtinkQ4C2YUT7vqzv0NU0Mk6tB+29qH6WpEUcyYGIXncn06PkOu1+e7qfLC6Q68zlJVUl97z+RgPlaXRCI/OdNyTlyKjW6BJeFG5hHm723CJfELFdlCVCwk3EWtNisIVp4KsgVRtV0Y/NMd3yT8ZWnDiuSTNEzEUJmLrN+EGw3J5uUNtoX205z4xR16aMSikyPQl7jPBkrokgKBq7eCp2lvG2ZOK8DqbSgktCJY1HXgXUVHVzWlEUnoKjE5+jZgJPOo83sGlVwqbu5KXbHaArLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(86362001)(33716001)(33656002)(53546011)(54906003)(16576012)(52116002)(316002)(83380400001)(1076003)(2906002)(6916009)(6486002)(9686003)(66946007)(66476007)(478600001)(956004)(8936002)(966005)(5660300002)(8676002)(44832011)(186003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DB0SNOUOwjr0/q+Pe6Iekwf7MhtV69daW0/NFkMlF+p0LJ2YevVmxojSo/9IvZIOaaxf+taOBlKWlwR6Ni//NwZJiFQHQQ8SkUs09fHQF5vObryWRTq2RJqYPYPhpPUEgt0Jhe/sQhGZhlTkL8k3c8gy7T2eOEjh82WSmg23Q9v0/PPEdzb/ivNlUVSosiUM/nIGT+7VBH1h4d1NJP82UbT7wJzqhyCUJl79kCoHcsC+F8gyupecutwEYIkTQUIZSmZKYqxVX6ZD6GI6vlXjCWElQ7criT6ritwBjfh/gSqyeXqmcGKpA3nRuM17FtBYNCNzSkgFr1nuujd33HV9iEceehs1M5cBXGr+l9TRTAwmSFSfBlvwifJdB4jIqOhpu50Pi2htoyXmARkNt+AS8aiRj3KPmscXT3jJX1cCxmZUgOeetSbYVmy+f0R8u+V/7sFiQeXKPwecHMZ9+/DHk5ZB6wJM5X/gheG6T8/Q/LUdnKyrxa8ThTiBO0BE/ZWw5HYMDgtWz5HLTpBJj2FnetVX8St93K7xKfVLrAxw/QryvnAYPuJWdFsrXdCShg6aZqebsopObnTanYEg9Fcljggndw5xFPE4lWcaqIz5IVGW7DNZpExpVeJNWICivbvqwJprbfJsv5V2iLETSoZrhfu8MUQ6NLTiXIf2rgZnxG3aCu+Vm8j9CH0jZzTZlWP0A5VtsHR8PfasvVoN4fyBCA==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3d7a58-53a0-4110-3716-08d84ab91b65
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 18:43:36.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJe1Ee5zONkdcjeAIi2+foN7dKnYCF6p5sFzuXJcVPc5GUC7Mm2DJjYeIiKbYCLsfQpaxy7wk4d9S+9l8XarYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Subject: Re: RE: [PATCH v9 0/5] Provide basic driver to control Arm R5 co-processor
 found on Xilinx ZynqMP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_10:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ben,

On Thu, Aug 27, 2020 at 03:34:33PM +0000, Ben Levinsky wrote:
> Hi Michael,
> 
> Thanks for comment. Maybe I missed some of the comments then? I had thought that your comments were the following and that I had answered them in the code:
> V8 3/5:
> - zynqmp_pm_set_rpu_mode: pass arg1 instead of 0 to zynqmp_pm_invoke_fn
> This should be reflected in v9 3/5
> - update kernel docs for zynqmp_pm_set_rpu_mode
> may have misunderstood the comment here. I updated the function and its comments above the function so that there is no obsolete iocl_id or arg2 mentioned
> V8 5/5:
> -  " In the event that zynqmp_r5_probe() fails before zynqmp_r5_setup_mbox()
> has run, this will be called on an uninitialized skb_queue. (Also
> obviously an issue once mailboxes are made optional again)."
> To remedy this I added logic in v9 in the zynqmp_r5_release() function so that the driver checks if a pointer field in the struct is NULL or no before discarding skb's
> 
> Were there other comments?

Yeah, there were a few others on v9, you can see the email here:

https://lore.kernel.org/linux-remoteproc/20200826161307.1064-1-ben.levinsky@xilinx.com/T/#m1b326e5f059712dd33bee1bcd47e3c0ae245055e

It looks like the first comment regarding the compilation failure due to
the lack of linux/types.h was addressed in v10, but none of the
subsequent comments; perhaps you just overlooked them?

Thanks,
 Michael

> 
> With that being said, I will make sure the R51 case is more completely covered.
> 
> Thanks
> Ben
> 
> 
> > -----Original Message-----
> > From: Michael Auchter <michael.auchter@ni.com>
> > Sent: Thursday, August 27, 2020 6:48 AM
> > To: Ben Levinsky <BLEVINSK@xilinx.com>
> > Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; devicetree@vger.kernel.org;
> > mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Jiaying Liang
> > <jliang@xilinx.com>; robh+dt@kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v9 0/5] Provide basic driver to control Arm R5 co-
> > processor found on Xilinx ZynqMP
> > 
> > Hey Ben,
> > 
> > On Wed, Aug 26, 2020 at 06:58:05PM -0700, Ben Levinsky wrote:
> > > v10:
> > > - add include types.h to xlnx-zynqmp.h for compilation
> > 
> > I appreciate the quick turnaround on v10, but it looks like much of my
> > feedback on v9 went unacknowledged.
> > 
> > Most concerning is the fact that loading firmware on to R5 1 is _still_
> > broken in v10 due to the incorrect TCM banks being used.
> > 
> > Thanks,
> >  Michael
> > 
> > >
> > > Ben Levinsky (5):
> > >   firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
> > >     configuration.
> > >   firmware: xilinx: Add shutdown/wakeup APIs
> > >   firmware: xilinx: Add RPU configuration APIs
> > >   dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
> > >     bindings
> > >   remoteproc: Add initial zynqmp R5 remoteproc driver
> > >
> > >  .../xilinx,zynqmp-r5-remoteproc.yaml          | 113 +++
> > >  drivers/firmware/xilinx/zynqmp.c              |  86 ++
> > >  drivers/remoteproc/Kconfig                    |  10 +
> > >  drivers/remoteproc/Makefile                   |   1 +
> > >  drivers/remoteproc/zynqmp_r5_remoteproc.c     | 898
> > ++++++++++++++++++
> > >  include/linux/firmware/xlnx-zynqmp.h          |  63 ++
> > >  6 files changed, 1171 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-
> > remoteproc.yaml
> > >  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> > >
> > > --
> > > 2.17.1
> > >
