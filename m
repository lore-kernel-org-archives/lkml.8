Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B3C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC4620736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QThNPR4A";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CzxjR+VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDWVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:02:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51278 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbgDWVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:02:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NKKGj5024685;
        Thu, 23 Apr 2020 14:01:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SgyIf1p4GdPKkHSnvcPXXDcyiQKo9PwreXigNDsh8tQ=;
 b=QThNPR4AqUe+tn/mtZ9babiYkp2TrPe/dqObcfp9jNmLwYOdzZYCTgter1fJOQvrgevP
 4tMS2dfJxTWRTD5ssOU3ltLWdP6r9fn9k2NXyouSm9QQcvJ/dC8z0KPUy60XdyW4HaDg
 BH1nIvcm4z2CvpVpcYW5c1Mn9xKuc3vfn2s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30jtc5r3a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Apr 2020 14:01:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 23 Apr 2020 14:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hukzox6XFjnGUUUFvLoaduWdCbfa3wAcmWBbaXPoHHEKNkWknJ7Tfr+JzX0Jeckuy0T4hQF8orB0liIflkVLga3gj5KimUEdr9k30EN30MNqGNsAdWkPQ0Xcf3B0FaRHnzIpiNj6idfJ1fsA3y21RDo6pZWedBmpUSAb/MbHRTSXkU/v1e/mThOwKITSqu2VO5VslCCYG6Oq7X8rYbznXJg3hzYW0dmeMry3JGqdfgdSb5KhvJxKAB3/gvisz3sPlUiqcHUFwSwBlDZXGfY/FfKzzWl7z4iEO35XfzIqr/9FEq+zboYCPsb54sQWRFSPQgFgZdu4pBVzqrvNNu+pyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgyIf1p4GdPKkHSnvcPXXDcyiQKo9PwreXigNDsh8tQ=;
 b=L3ITgljhbKTD84U1Eybbft810+HmAoawmrG+9R/WgwruUyzdv3Mi1AkOfZVGIB/Ydo23xYqmd1xGQYPhbddTYUBHmg5OMwXUpQB23MVzpuafpKzkI4HttcZd82KuorFsORaYPwose19BRJuI/HmeIBscucHjYVGeN/v7VBoKy4vv67Eg8xENURea7Kuw6Gi6U9adwM66mvCHed/7o4UJa5DLR/yYgqoKD2CpOnctJuOGtIXnCqc3znu/QZiHO3rxkHlceocxBv4UzEr39xsM644soUfNLgiuz64M7uDKsebkbA+NYAYa1C98C0uT9c6PYLGw9BjP0J+fTsYojvZ49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgyIf1p4GdPKkHSnvcPXXDcyiQKo9PwreXigNDsh8tQ=;
 b=CzxjR+VV0zT5+EC5sYH3gEqjz5PSCx7rum1IKLe6nL0fEe3GH13LEY1APje1M8Sq1ZNaHK32iGI1xUPBZ5i/oLkkuX431kcf06bMnlerABfS6fCAB/qVzGaeDJxUzaO8mBDebne8SgbtXDGnP0zFZBVt9Cus9luTptls8npS3ak=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2677.namprd15.prod.outlook.com (2603:10b6:a03:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 21:01:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 21:01:51 +0000
Date:   Thu, 23 Apr 2020 14:01:47 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200423210147.GA83398@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
X-ClientProxiedBy: CO2PR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:104:3::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:adb1) by CO2PR06CA0062.namprd06.prod.outlook.com (2603:10b6:104:3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 21:01:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:adb1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801655fe-4216-4630-a1b1-08d7e7c98ba0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2677B7031359A0159D648083BED30@BYAPR15MB2677.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(186003)(55016002)(33656002)(54906003)(52116002)(66556008)(9686003)(66476007)(4326008)(478600001)(16526019)(316002)(2906002)(66946007)(7696005)(6666004)(5660300002)(6916009)(8936002)(81156014)(8676002)(86362001)(6506007)(1076003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iLZ4xq8oVU7GSqnO2oInfaZkbOQM39Qjd+flo2tBIApwMpCH8u0qvNLTk+VKRjcE0GV+smkCfciFA4NXRRkFch9LUHHwcbQ6RL1OVLWlQhEG+wCDVefIqZVUvFETNRoGFd+DyXvrQM828ykwR1mNr4umcwaWPlaYJD9scO7QX2r/eZUvCvfNVOaMdWu5NF76whyTOaECAvqM0mB+v/hxcjmoct+XrcvPqQmM/DgHFXE56N8JhQut0a5+UgVmcwPfvIxxqxaX2XlSWxRMTC8F6GAEbx7OQmas+OMwzBzUxDS/Jwhp9bgp3WQU8eICA7viC9JC4Va0/v2SZUoI0PaNrwscoUJMfzmYmx8/xdi4keXn6O/co/GODBSKffqoMYsWdg6Vrv200EgnsIGZO/OCcZcw4oKS4JRsZpxQljvxSgPm2h0glME3zlMIIZEryeT
X-MS-Exchange-AntiSpam-MessageData: 0kskA+v+NOYT83Xp2vrucJKbF0Zratfm03Dfp293GntyWgLbOPT4//bdqMMROirR2LyXKlWEsXLd3jN4LVVCIyPkGXgN4JBxBeNORetYWekaV3N7ZYuDIjkgm2hRX4BQeIS4QrR2RGvgYaFuiIAFQlYZFEFdtN18+x/OfCe+o8KpxELVuptFotS9767pPls/
X-MS-Exchange-CrossTenant-Network-Message-Id: 801655fe-4216-4630-a1b1-08d7e7c98ba0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 21:01:51.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S55VR/ErcmxK0RPUdiEk+6u8NHNetivNxkSkI6zTVtgvFD5u/HxXVJBETHgZ/vbx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2677
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_15:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=5
 bulkscore=0 mlxscore=0 mlxlogscore=948 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230150
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:52:13PM +0000, Christoph Lameter wrote:
> On Wed, 22 Apr 2020, Roman Gushchin wrote:
> 
> >  enum stat_item {
> >  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> > @@ -86,6 +87,7 @@ struct kmem_cache {
> >  	unsigned long min_partial;
> >  	unsigned int size;	/* The size of an object including metadata */
> >  	unsigned int object_size;/* The size of an object without metadata */
> > +	struct reciprocal_value reciprocal_size;
> 
> 
> This needs to be moved further back since it is not an item that needs to
> be cache hot for the hotpaths. Place it with "align", inuse etc?
> 
> Hmmm. the same applies to min_partial maybe?
> 
>

Something like this?

Thanks!

--

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index cdf4f299c982..6246a3c65cd5 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -84,10 +84,8 @@ struct kmem_cache {
        struct kmem_cache_cpu __percpu *cpu_slab;
        /* Used for retrieving partial slabs, etc. */
        slab_flags_t flags;
-       unsigned long min_partial;
        unsigned int size;      /* The size of an object including metadata */
        unsigned int object_size;/* The size of an object without metadata */
-       struct reciprocal_value reciprocal_size;
        unsigned int offset;    /* Free pointer offset */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
        /* Number of per cpu partial objects to keep around */
@@ -103,6 +101,8 @@ struct kmem_cache {
        void (*ctor)(void *);
        unsigned int inuse;             /* Offset to metadata */
        unsigned int align;             /* Alignment */
+       unsigned long min_partial;
+       struct reciprocal_value reciprocal_size;
        unsigned int red_left_pad;      /* Left redzone padding size */
        const char *name;       /* Name (only for display!) */
        struct list_head list;  /* List of slab caches */
