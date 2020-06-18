Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92123C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B06208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DlkF8jyP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YyiuqBUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgFRCSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:18:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730205AbgFRBTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:51 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I1JahM023901;
        Wed, 17 Jun 2020 18:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wcx8YVBZHU75QQNWCyUI4ONPrV3RM4j1rlti8vgFFL8=;
 b=DlkF8jyPuH56kSaY53k4g/MgCFdf+lY9tXyoodbuNOd9p90j6b/GRaL45GbDuwyzkFSE
 Bq1JXSquQL3Muj1X59BMHG8PZ76vukOCDuNEHl6s53tOUog32V8IFMIOEfeUqqelB/CC
 oXA0D8xqWKN78koX4NjmG9VC7MCKIl4zywA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q644hkqp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 18:19:37 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 18:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihOmv1LGb2z2KJIdD+H2OZvPLXtTJijzgFphM035e6iRriq78guqaO/TZziMFjoshQV9LmKKv7deO99Ky6ltExtGW9Lmt9xr61uTcInSzjhP5SrpgRTX7C2uXIr/LXdjlccVndYGpxD1kwuW2Ni69dEdkhFAbkTbk5vrEfezzZPdln6xufdF2lO0xJY3Vv3T5EiIwfcsZ/L/JU8e6bYKrgCrSZ/JgBXl1tQU0lv1Ln4hZYL6f5YBTrtrLtrQ/+EntUODB26nnjgAal7sSXtjiMSaxU0R6oAPrJNr7PkBVJf9dxreRhAoVnBjtr0mkvcwKVFqA8sJvkmo4Ov0fMhiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcx8YVBZHU75QQNWCyUI4ONPrV3RM4j1rlti8vgFFL8=;
 b=RRljhxp3sQqCKgjFIbA0hzYR7QoBWObDwtB2bw8HcidPIPL0XsY+aqU2DLKdT4hg2twpMrS4Gb8ivW/Mfil2ferJNIvkvOBkzxrHNNneNNvZJV8yQG/y7x6G08n9hRr54l1KVYSii30KnYhgh9S7Iua5wrDVZAscKW6KIod0NWrxihcwyvSrgfsHnwhZTofanobwxVBP85NZN8dDaTOZdxBMH3CdouY8EblYTQDKWDKe9ulvcUtxlsxGQ/3d96JfJjwePTaW8HHwVSrgOwQ+C/10Zi6Db+z6JxJZ1NNRotKNVqjoCvgwGX1kGoW0cMuN7IsTXwrRIUF3+8AkQcrEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcx8YVBZHU75QQNWCyUI4ONPrV3RM4j1rlti8vgFFL8=;
 b=YyiuqBUAFQZbx8daxKUEzV9DzREfYTw59Tk4u8OOsOaYfJn9W7CIKKAFDRvxWkKcCqGgbWa+Z4ebQvIZnOQhbxQN5LPGQWL0/42qQZ76afh5pmIUamIIB/1/kpkMKNN3f1fNHnbnLIcgHPIXuCV7Csi4wsnUKoZ5cSmiGwgEim4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR15MB2397.namprd15.prod.outlook.com
 (2603:10b6:805:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 01:19:02 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 01:19:02 +0000
Date:   Wed, 17 Jun 2020 18:18:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200618011858.GC24694@carbon.DHCP.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9687) by BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Thu, 18 Jun 2020 01:19:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:9687]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16ada88-6052-41bf-40d3-08d8132595e9
X-MS-TrafficTypeDiagnostic: SN6PR15MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB23973B4B55E575057CAFD85BBE9B0@SN6PR15MB2397.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zFTndWHVNNGtD9y2m0Evv0yC/XMLRqOqGiVQrTnT679IiCntvn9KJtZ9uPQik8yuAPctq6Bowh3uU0yEI4TbWzIuUpQIOj6KJ84jxM7xc+znrEBHwhKZgwU0i0+ng+MvpNWAsgu/mgY002bxKuW3lRPbvTR55mny/Tb9yX9JYSzwdLmhUyipxKiSqL8ZtCLiAFmJzyzlDGmXzSG/BhV87K9v4JeXHaIsW7KYj44C6tvKE2EbD1iXGijUYVjcimGf/4ab20Y0haLpGNrNOJ4ZLadk5DT/AAkc0WoWPle7Ji6eiisqdaI1AT8qNEMfVBLdctN905kQhgP996Rf9IcKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(54906003)(2906002)(83380400001)(316002)(5660300002)(478600001)(4326008)(186003)(16526019)(86362001)(6666004)(7696005)(8676002)(52116002)(66476007)(66556008)(33656002)(66946007)(6916009)(6506007)(53546011)(4744005)(9686003)(8936002)(1076003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YXQPT9FQjdzZyLAL/fTffFAeV9ae3ww88rEXWnY41N0DB43YYc0NLa5UXGwObXZiTkspAvPIslfsep4tSMYXXV520hsrs2BdyqyTPVcE3Ln+VpX9BiLfpUNwkk/TYMrZXLTvuGr32h+3xvpX/cnuIAeLleB1nKXjjyiC2Bf/P+7KJSkjbFnN153UrkO+1SnCjdsDwCRx3qjMNcVteLMvjw2izddt5vCv1CrUWNnmPuJdi/dlo0K7ZL6c7QwJoFXtuJwYXm+r5JYtoqPrMzozvqyM8SuUvWotapBY1HX+RocZhMMvH7FQwp1O94+ocWgVOCl+7zov+olFUTYsAM8Y5B4Y55+6UasEtKqA3qq8lDGyoQfHuuvoPKdYtsV4ZuewQBPdnwuirqhuL2dpX7VBgXm0v1u4MQGtKIwKWEGuneRRmoMO0Ro3oTegeFk+ZvtJR/Uyr+vt2GIaUj1VNll4prk+jyrtmBxF0PZbPpUMvs2wxYPPCikwZTgs65HmiIzOA51UCuXb2gcNyrtjZcp02A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a16ada88-6052-41bf-40d3-08d8132595e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 01:19:02.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwdRVfYvtKnaJrROtiVC5Vd+nizCR6BzkGgVXgQyaXN1vZwIX+zjRggBK7av6XyK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2397
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_12:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 cotscore=-2147483648 suspectscore=1 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180007
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > This is v6 of the slab cgroup controller rework.
> >
> > The patchset moves the accounting from the page level to the object
> > level. It allows to share slab pages between memory cgroups.
> > This leads to a significant win in the slab utilization (up to 45%)
> > and the corresponding drop in the total kernel memory footprint.
> 
> Is this based on just SLUB or does this have a similar impact on SLAB as well?


Just got some fresh numbers on my desktop running 5.8-rc1 + slab controller v6.
It's 8-cores Ryzen 1700 with 32 GB RAM running Fedora 32.

I measured the size of slab memory just after logging into the system.

                   SLUB           SLAB
Original:     463232 kB      312880 kB
Patched:      194840 kB      193392 kB
                   -58%           -38%

Plus perpcu memory usage is also a bit lower.

Thanks!
