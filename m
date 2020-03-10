Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D13C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100F221D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Nno4lGeg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OBobrhSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCJUaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:30:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgCJUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:30:01 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AKP5x7026875;
        Tue, 10 Mar 2020 13:29:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NqQz4qjXiPmv6o5hFfR6UWqc49oHdMLaE7YfivyLh1w=;
 b=Nno4lGegLqEqK8PAD3NbILCI0vebVW7Qxvgkoc9iEdrwn+jOXSHuAf4hjNd2+igd625S
 Uf6JYDqESZ6tm0YNrO2+du3Pr2kkLr7NAteH1TDNwORNzKZqhhpBMnN5CZYqAMzUNdsS
 PVOjosfKewVFN94m3jYZhIyluTpEkVQWPQY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yp25fmnc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 13:29:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 13:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtvVbFx3m03rnUdnev3J2Hd3buj8ivnhStgwBUVAQnmDaIXjEijmiuc+Y1cT3ldFpNtcqvyfmHnyCxP1BSNtUkBEi0PCTF/p676vXbbi5z0Sg0XzahpS2W+R+q4WHIJShz3driKemDFR1TmHXiQaTO5E9Pcm+vdIRWlMKRNp7H9D6G4oZ+nZyV6N6DKST1EegeWjJ4DzJ2pIxby9tnw21wNWslGvM81HwqPxenSrNgbtAlS7z/Dv0uuhXPW97DIJBqNJUe1dc9w83Cm8EaZfHwBTA9wUslnn/PBaIe9UW9juWPAIdHfMgoE1JRKvNidKUO6Ml+zik19DW+OesascIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqQz4qjXiPmv6o5hFfR6UWqc49oHdMLaE7YfivyLh1w=;
 b=EmQboETqoGscIN1woMuwujv3G6D4xh5dRok+idtcBOAcI8BsZMTdcQ8/vsEH/v3WfmEAan2mzdCUbjYycExQM1bSsgvnrD7HE9I+F35fHI5f4QiQuf9DYsgX3rGB3Fu7O6FepU2IcGzOH32SBQXG1o6UNgF71RVNTtNaOSG+LguxQEBnNqk8cMuxFMX844D/5NFeyTYJPTIXB+PcRJEtF+Oh6KRuMvh21Uo0CAx6nbPR8ggWwdmzchN03yBnsep1+eU/kSh8yw4jC5n3EjPgIVHwO+gAelvQNiBsi3mPhyKDfbpVyLxrG5EWNIkH3QtuKx10JGSkuov6Ap2bFSMHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqQz4qjXiPmv6o5hFfR6UWqc49oHdMLaE7YfivyLh1w=;
 b=OBobrhSMaZ+rhf7BHSMGyRZJunP7Ig5+vM+09M35AFrKbu35fe4ME1A94pTB9v8zPKMIZnjU8RiDm/wyTE9ZyqzZ2Hbq4PKVSYUx/Xw8iUyPGbTRwmsDszCiMYusN+IGBiv0cqs+EbT+wR9x0Fmk/c1Nik5X8ftIQ7JBPogEIOI=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1728.namprd15.prod.outlook.com (2603:10b6:301:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 20:29:47 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:29:47 +0000
Date:   Tue, 10 Mar 2020 13:29:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Rik van Riel <riel@surriel.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310202944.GB96999@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
 <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
 <20200310193622.GC8447@dhcp22.suse.cz>
 <43e2e8443288260aa305f39ba566f81bf065d010.camel@surriel.com>
 <57494a9c-5c24-20b6-0bda-dac8bbb6f731@oracle.com>
 <4147bc1d429a4336dcb45a6cb2657d082f35ab25.camel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147bc1d429a4336dcb45a6cb2657d082f35ab25.camel@surriel.com>
X-ClientProxiedBy: MWHPR1401CA0020.namprd14.prod.outlook.com
 (2603:10b6:301:4b::30) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7ca7) by MWHPR1401CA0020.namprd14.prod.outlook.com (2603:10b6:301:4b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Tue, 10 Mar 2020 20:29:46 +0000
X-Originating-IP: [2620:10d:c090:400::5:7ca7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a7121c-260d-4cd4-05c6-08d7c531c6ba
X-MS-TrafficTypeDiagnostic: MWHPR15MB1728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB172883660669A6626B5F4B8DBEFF0@MWHPR15MB1728.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(376002)(366004)(396003)(189003)(199004)(86362001)(53546011)(8676002)(4326008)(33656002)(6506007)(81156014)(1076003)(478600001)(54906003)(9686003)(66946007)(66556008)(66476007)(81166006)(55016002)(5660300002)(316002)(6916009)(8936002)(186003)(16526019)(52116002)(7696005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1728;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxjYN5g4S80yErq8nHQnafZfx/Ta8fmd9c2y4MjSS1S8e0JiM/BpX3hwZIGE32ZLBiE9t4E2UTJTsDqttImGhMeStIDnO02zDqL7mvQ+MdoFX4Xby59IVw8aj3sKq2rMfqetNGOI/n74uTC2ab9MGPTcvBQgBDgtQwYKcFM/1m3r/ZLCZ/B9uP1UqruP0GPX7ENfAkAWU6elOn9M6QDCP4Ay6TUT8hFIoaRknv3s7CFzsZqIdl9wwQCxCbMcjonFIh7HuBNeiKg6I67dEmU9GaikVBlKIVP3r41ieKwrgWc1KJBtVrpDQxqU6ZAnpx8rI2nmNOEOU1JiJ3w3UxknbN2MBaSpeA4kXHkWhWAH3Jg0Yodvk/w0yRUCe00hXcq7vmzy23R2RD33fCAWk2cNOAnqsODnVfBZn30ZSI+d3RvS0erRJiHf7e99fIYZJlEn
X-MS-Exchange-AntiSpam-MessageData: S2PmuGkbAWu3OXdEUMVCXSt91ofK0XwZVu+iZX75Uj0o3kWF1hRo/3cps6bMqmsndmxxAYVQPkQCyTk0xtCK5vn6ZiAOuBWam1QNSLG5gDoQ7wKyZxg4p3FUnZW8EYNGucCTlF+x+xcXGwwqRupVGMuC7y2jJDJcPizQ7Mb6GtVs5B/ODt3ErIf/U31Pb6DV
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a7121c-260d-4cd4-05c6-08d7c531c6ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:29:47.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUAB4AOUBNFem9H6gyCFrs06Oztbo7A7YUev4wM0g9IfDtCpNCyuw15znxIiZCuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_13:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=1 clxscore=1015 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100120
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:15:18PM -0400, Rik van Riel wrote:
> On Tue, 2020-03-10 at 13:11 -0700, Mike Kravetz wrote:
> > On 3/10/20 12:46 PM, Rik van Riel wrote:
> > > 
> > > How would that work for architectures that have multiple
> > > possible hugetlbfs gigantic page sizes, where the admin
> > > can allocate different numbers of differently sized pages
> > > after bootup?
> > 
> > For hugetlb page reservations at boot today, pairs specifying size
> > and
> > quantity are put on the command line.  For example,
> > hugepagesz=2M hugepages=512 hugepagesz=1G hugepages=64
> > 
> > We could do something similiar for CMA.
> > hugepagesz=512M hugepages_cma=256 hugepagesz=1G hugepages_cma=64
> > 
> > That would make things much more complicated (implies separate CMA
> > reservations per size) and may be overkill for the first
> > implementation.
> > 
> > Perhaps we limit CMA reservations to one gigantic huge page
> > size.  The
> > architectures would need to define the default and there could be a
> > command line option to override.  Something like,
> > default_cmapagesz=  analogous to today's default_hugepagesz=.  Then
> > hugepages_cma= is only associated with that default gigantic huge
> > page
> > size.
> > 
> > The more I think about it, the more I like limiting CMA reservations
> > to
> > only one gigantic huge page size (per arch).
> 
> Why, though?
> 
> The cma_alloc function can return allocations of different
> sizes at the same time.
> 
> There is no limitation in the underlying code that would stop
> a user from allocating hugepages of different sizes through
> sysfs.
> 
> Allowing the system administrator to allocate a little extra
> memory for the CMA pool could also allow us to work around
> initial issues of compaction/migration failing to move some
> of the pages, while we play whack-a-mole with the last corner
> cases.

I agree. Because the cma area can be effectively used by userspace
applications even without allocating gigantic pages, there is no
need to be very greedy on setting the cma size (unlike allocating
1 GB pages on boot, where every unused page is a wasted 1 GB).


