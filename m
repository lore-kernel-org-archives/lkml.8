Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8850C2074C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="odrmidpC";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="L99CvfaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCLJni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:43:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9670 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgCLJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:43:37 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02C9dUCS016245;
        Thu, 12 Mar 2020 02:43:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=5bcKt82gTQ82Lit/lPmuheheFOChLkISM1QEHndIaXs=;
 b=odrmidpCj+SZcrVG7jVKNAzdzyJRcCJ/fVOXaig0890qtftL+1JCrJi5Ba/B1hcvIF9W
 dygKcLaW2+3ufPKM3P96x3PGWeovNMjsPWlhxx1VJCFToB9Oj7Rl67e22Ay9pJdLr67c
 LEOfvic9DdF4mPr4yWlNtghq+WgZvhQ3E14llGsBCDpjcfe2SQFNHNa/A6xDU1WZGWj0
 RDvdcB9yzMDOFkXcTF/uUd+RdpRsFRy/TwUmZKSQTg79FCDNEXA409erwx43bUO+lrSh
 XyzxI3JNF3tebADoyttf5o9CGM5tGG75H4kmE20GWRxvBdGjv2/g8oIJCyfeF6f3Xs6H 5Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yqfggruws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 02:43:34 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Mar
 2020 02:43:32 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Mar
 2020 02:43:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 12 Mar 2020 02:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+OV7Y8kLTc00qfCQMAh2Ybjx2dzBqnQSMThgwxq/JHuga+GcNfWzJ36IbNd9k3pU7c0VF/P5IG/5SeVUVPJVj9QP1apgfz8zUh4ne4kR4CRvytn4+vu1vzSnlWqAT/L8HRS6s9KCcENRaJKqMpuVqoh220tg+q0duTAt9LKEssspjiHW3lAHdpYFNvVkmHo4N6IbRDaup6aY13aJ1xc4v0TWuK0lO29uqY8BhB1JB74KqKtRmsqQXT9iPM9IrtdW+Gpt0BytpV+b/mWWtTV26eVrWKtm+M58cdQhGiW6UwSiQnwsELAWrrFrZC3GXljk0PebWg9dXZ9KnEGEJ7fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bcKt82gTQ82Lit/lPmuheheFOChLkISM1QEHndIaXs=;
 b=MQT+Zv2Zu2SZWeSMwT89APvhndD5PBjIogNcXoGGjllbXzpwJ5ueOiyVcbOQD20WqXL69WQQwMwHMRv1dYvus3CNcFgxp8aj9z9dzuvpwHriNKtk2/J3TqYILDiI1xL0XH0UBZXZXBPhBryLcp5/LupVEe6tLsR9MROokKHBb1CunrJxnmALeQTmnAYnYvztFtNVOcveipIJbkIlGa9MRdfEuMDLm4MPFu9GBtVwjyA7v39T7SqKCr5Ce8kaEAEubE7MCUq+oJJe+ceZr181wOhDv85DtnDu/L/QX0LJlYnPTYZnlxlxichVfjwMKoklUGGfQ2aubRlBsFvwUXG7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bcKt82gTQ82Lit/lPmuheheFOChLkISM1QEHndIaXs=;
 b=L99CvfaOkjmTDWsK1HgK+6SOHcEJCWH8NJ4NCwBpA6DhribNDj4S50/FOVcDBuvCw33ckrwp4aTBTfig6rywh8OMevQJRrvLsT83vaRDjOGcZV4N5RuUQcTz6B1kFxQmU4kGtYVoGIGNH5x/dRhrCHZwZhxjt6P8PbMDeRkIqqE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB3070.namprd18.prod.outlook.com (2603:10b6:208:ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 12 Mar
 2020 09:43:30 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:43:30 +0000
Date:   Thu, 12 Mar 2020 10:43:23 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Tim Harvey <tharvey@gateworks.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: Re: CN80xx (octeontx/thunderx) breakage from f2d8340
Message-ID: <20200312094322.bohnhgnyb7nogpq5@rric.localdomain>
References: <CAJ+vNU0qVnCkWpG_NKNQTdYf5LJpRrgOeWX0xH=GgavKJ1QNwg@mail.gmail.com>
 <0c3c16c770d21e5ad2276c83feb27ce4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3c16c770d21e5ad2276c83feb27ce4@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::16) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR09CA0048.eurprd09.prod.outlook.com (2603:10a6:7:3c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 09:43:29 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd0448d-b958-45ed-bf39-08d7c669d248
X-MS-TrafficTypeDiagnostic: MN2PR18MB3070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB30700D2EE1FA97F3726E1290D9FD0@MN2PR18MB3070.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(86362001)(6916009)(966005)(53546011)(6506007)(5660300002)(1076003)(54906003)(81166006)(478600001)(316002)(4326008)(956004)(66946007)(16526019)(66556008)(8936002)(81156014)(9686003)(107886003)(55016002)(26005)(8676002)(52116002)(66476007)(186003)(7696005)(2906002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3070;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtGQOGvHKvuKJMZ3kSUMpF9UO0Eidqis/vGpP2VyP/b2r4WG3OqT4HEZxKLBSAvgaj5X7Cbl7UJonVV8sZiByq9Yhi17sL3A7nQrAh0Z46DtpX7MyEvAuuqqWFFXDCL4dP3e+KioAcMzhQP2l+qoicMHH4wpO/Zsc2GXiaw6XN6HMuZA73BPJsIu5b829ZvxNP7AC672ZMv7leRE5Up8ld0CYkFNwxm20OQkGoTfRoXD9JqW/2cw3zZLOd6o9nFaA5VhiNhjCJwiKESVLQweY+RV1UAkW9k6qa2furisGhVRA4Hv2On3tvEoVmHqIFEvU9V7GnaYZtpnkmQpjcvwPV1zOJicSC+keomoDoIv/8WSzjOccKYAu8S3c4tQiSsYgtRcEpZmP5CQOrnesM0XO5sb1jeJfs6WuAJyRtKysBn7BKeUBbAl/RBYV9pzrTXng4NrCkkJ+XGxeZo1Zas+DUEpcUJzugHNbZKkBDheVomBgHdmCdBSYO4AZWv9KbFBWhyH5FHHl1zzZdRyuddSlg==
X-MS-Exchange-AntiSpam-MessageData: mgxF+6JjdpVPb2g06Sk6bgW+PODqoM3BZfnPYpY7SyHwkcvSd4cEqR/QEDc8CdXQzR2bjAhkCwQBXNeGrJuxSZKa7i0haGJcaNNobuxz15cYYv0ReDyCfXsjflQHbBwXRiyfibpXVVhF8jvEs213fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd0448d-b958-45ed-bf39-08d7c669d248
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:43:29.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBfKwKTMySX2fBhUlXEffy5ORieFg1A3OOKzBfMYys9LhyZFLjCvNx1qbREzAc7J6op3cwBH5FnEwNC++L8jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3070
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_01:2020-03-11,2020-03-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Sunil here.

-Robert

On 12.03.20 08:55:52, Marc Zyngier wrote:
> Hi Tim,
> 
> On 2020-03-11 20:17, Tim Harvey wrote:
> > Marc,
> > 
> > Im seeing a failure to boot on an octeontx CN80xx (thunderx) due to
> > f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery"). I'm not
> > sure if something is hanging, I just get no console output from the
> > kernel.
> 
> That's odd. It probably means that a SError has been taken to EL3,
> and the firmware is not equipped to deal with it. Great stuff!
> 
> > Is there perhaps something in the dt that requires change? The
> > board/dts I'm using is:
> > https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw6404-linux.dts https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw640x-linux.dtsi https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/cn81xx-linux.dtsi
> > 
> > Any ideas? I've cc'd the Cavium/Marvell folk to see if they know
> > what's up or can reproduce on some of their hardware.
> 
> This is most probably Cavium erratum 38539. Please give [1] a go and
> let me know whether it helps by replying to the patch.
> 
> Thanks,
> 
>         M.
> 
> [1] https://lore.kernel.org/lkml/20200311115649.26060-1-maz@kernel.org/
> -- 
> Jazz is not dead. It just smells funny...
