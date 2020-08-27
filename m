Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E10C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BFB22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="EenSbI5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgH0OsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:48:25 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:49520 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728043AbgH0OsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:48:01 -0400
X-Greylist: delayed 3506 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 10:47:52 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDitBC012196;
        Thu, 27 Aug 2020 08:47:45 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0a-00010702.pphosted.com with ESMTP id 332yd26r2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:47:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez6aI/WDLGWO4m0FyoH2ZPLStT9/1pZy7hasLUbIgc820KCUzVs/0cSvEBnhKuBc6aae4Fa9CeRJyNabk471UQCrZ+IVmPlNDrbWYD5oKch3VlY9qGb2UA5UlOY3H0A/MIHedkklioe5UsivkFIa+AwNcxq0evV67rEecTnUOtBgKNwEt+IXJbgH+MQCgDqGp04KYLMv+neF9hhNBv3t17p+iJCLO61nUPPOuGTpFEMTfaJGydJfM9MJ9WNAxiNP73iwicDZt88/s2/yBvKKk7kVjPhClVQjBJByo5UT6oiSQpDIIw0XSVOls4FUyQ4sQpn/MFIC+hwL/LYE+eIFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnzD30OSqbBlP3TKzzQR2rHtCNCizQB4pKMSVRPdM3Y=;
 b=C7DnxnC6wWzWuRLABowfk+hJ95IEPXg0F+n/kOuLQLQgj+K6MQhQ+VViH7LHyjtdSg52kJ49SOluQ+9DLf7BIHZb7Fw/ZXD/yVJtGQ3ADrVxsZOOWbN2mqDxTV7waXqAGzNwxKtugDZraFLPmpNxe0+IPfWjoZMRdmbe3qOo4LTClwCo91xf9WE1revegTfe5734ImaUpSHNNJ9JiX//EbMZtMwa5Fi1HIOk1sqcilGrrK5ud8QReW0qHmDwawXBMemwtS9u+AMVesG2hqxVdls0o2zvHa4eqG3yLywzYFYmGN7RrqnMbfRPnI8tdkq/JPVZbbIm9QqNiHge6NGLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnzD30OSqbBlP3TKzzQR2rHtCNCizQB4pKMSVRPdM3Y=;
 b=EenSbI5igwG0DV2YbMoNxjrI6AXkRc2qhsprUisZELEjlWAjSF9AexR2VUfwPPO4fyB+/+olRlZvbz3Wv3SiEppZCMYlxs9aoEhE06IPYoEJ0atezP+hgjmdepEQ6YzwNaPrFzazALTn5PMgghRpye5+yiBAq65QGzjHDt4RGsQ=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4829.namprd04.prod.outlook.com
 (2603:10b6:805:b0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 13:47:43 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750%3]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 13:47:43 +0000
Date:   Thu, 27 Aug 2020 08:47:42 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     stefano.stabellini@xilinx.com, michals@xilinx.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200827134742.GB404249@xaphan>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827015810.11157-1-ben.levinsky@xilinx.com>
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SA0PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:d3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:47:42 +0000
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5453c7-6bb2-460d-4803-08d84a8fc59a
X-MS-TrafficTypeDiagnostic: SN6PR04MB4829:
X-Microsoft-Antispam-PRVS: <SN6PR04MB48294F21CE7DF9312522F53B87550@SN6PR04MB4829.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQ9m2qXaJu5z/mODUVbNUvWAmLxtHoGgut3rEi2EZHNiN3UN1X+Ib1icNvIEoV+wBZxewXtn05a07v7+65IXXmw++HES8M896cAkkzFuc7kFnxUF3IA4ccl9cfGcp/6J8PdMihlyS8nNhjhW9pNMTulD1yI792+u06i2/fimjEjf0L9Xxz+KvuiMGAJNZ4oTFiFIDrz9gdOXHpzHRFKHmK4two4c45/nklb6bYM+hiLnTB2AP2cya/Fn/+XCnD6i9AkS5hg3ucHCrVSFDSIYf1WGo608haWDV4fKCDmpW6H20DiglX3SWcjxnVf66IrQeAbSGVHKmISfQrp5jaWzuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(396003)(366004)(376002)(136003)(39860400002)(5660300002)(86362001)(7416002)(478600001)(33656002)(44832011)(2906002)(6486002)(9686003)(316002)(186003)(8676002)(52116002)(1076003)(6916009)(66556008)(4326008)(66946007)(66476007)(83380400001)(16576012)(956004)(8936002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: D6q8zs2YATuyC2VFWcOHTd5gszxC2DPvLPTkymqe6O2TlI84u/JKFfZYjMytjYx3EQsM2kAAn2ejHw5WDmUmn8vuzHRyMJyqZrvHrBR4K1ABKcOpu/h9dTLdgWz6VToWXvoatZ9KDOyPteNmxFdasoqB7iSiYkjLMXfpbsmdSzNXNvc7iJkPrM5Zv2E6pdbFwD5tGSsuOFNksH0Ww0ctHOMONLWUFYt3hWgQKCKQDz1FMtJTrUTX6vbbbwfcawjNirD4Un4I9j4UpsCiRP8UUsfPUHJ3+9zbcQ++Aq00mtzrN9T/Y67wRohyRUE5OuUC7KeOwcbOT1dTfi0bSeuy2H4EsyeNeOmuJpBACZD+zNlHGl/h6EVnPgJaAOEDSPGmnUZIa61DRrTSkymYOXroFgD6LPLyp3jFAGHd0EyVUIXiiLPOI4A5OMY8o9nNkmMDHSup0CY9qLJM0B1x5n9q+UnzBFmFfBvjELOjmfVotiLDfgM8FzKK4bQ/0rv5yzaL+WyrNpYonUFDqAR13+yvcT2vaLN/vbmpZsqcOX8bDE6Mv9gpPpnNrp7ajCOVQpgEMZU3Z+IzSo9gFIw843M8x8LrwP2w29NoXMNsp1KzEaQiPvy4hEk15Y5XmBUGNPZRQQWsPpeGH8W96eQn/k3Yf2P+8t7aXZXXi3kdS9b8hSeEZkPEIQbSoXj1jOvfw7lY0YxMqpDN5eq6rY05FLGLQQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5453c7-6bb2-460d-4803-08d84a8fc59a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:47:43.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adb81k0fCiBBH+IGYajJWWI2eDQeUc0i1Dnnsa5ESW3HtUVBg6DLotRIa40qCBR+pZTVtAQ9ihNFqQGNwLGG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4829
Subject: Re: [PATCH v9 0/5] Provide basic driver to control Arm R5 co-processor
 found on Xilinx ZynqMP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxlogscore=634 bulkscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ben,

On Wed, Aug 26, 2020 at 06:58:05PM -0700, Ben Levinsky wrote:
> v10:
> - add include types.h to xlnx-zynqmp.h for compilation

I appreciate the quick turnaround on v10, but it looks like much of my
feedback on v9 went unacknowledged. 

Most concerning is the fact that loading firmware on to R5 1 is _still_
broken in v10 due to the incorrect TCM banks being used.

Thanks,
 Michael

> 
> Ben Levinsky (5):
>   firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
>     configuration.
>   firmware: xilinx: Add shutdown/wakeup APIs
>   firmware: xilinx: Add RPU configuration APIs
>   dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
>     bindings
>   remoteproc: Add initial zynqmp R5 remoteproc driver
> 
>  .../xilinx,zynqmp-r5-remoteproc.yaml          | 113 +++
>  drivers/firmware/xilinx/zynqmp.c              |  86 ++
>  drivers/remoteproc/Kconfig                    |  10 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/zynqmp_r5_remoteproc.c     | 898 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |  63 ++
>  6 files changed, 1171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> 
> -- 
> 2.17.1
> 
