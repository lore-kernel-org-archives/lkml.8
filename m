Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D47C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A880B20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b/ZlydeU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Yfux2O9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgDBCpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:45:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727135AbgDBCpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:45:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0322iDAE028166;
        Wed, 1 Apr 2020 19:44:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mYVUd34I76MPipSp3mAzkKl4bk0slrIyZ9n2x5SmU/A=;
 b=b/ZlydeUpzX2a/zMwKZB1ncfB2KW+xe7UER2twLyfk96sYYVLPDbcsqlMU9E2lhkXCPw
 3hvFM1Id/rspSX92y+/EH3dRrfOgl9AqWg4KkEvJXEEv+Ae+zxHhKqRrkI7yQ69FgvRQ
 tKavgFJUofMq4ZmnZVyX7lz9B+5pOzcMkZk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 304wbbayj0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Apr 2020 19:44:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 1 Apr 2020 19:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec/BUFZvm+RiMw71mLrTkfPqc+1ZeV+JwyybExGjRmSj3muQybz2sNh20mclejWCBIOj++GMf31inERpfhUZS0Gc0wYFmpJiDNRTzOiOus/a6qvHm9IMStZfEYN2TvIcFaCUxbRgIUeeZD39KBvAeRmhkNujYvVeO/mE4YGWEjrvw0TGOwpBhfWk24TcAC24WjVXNRuSrf9m2YsXK+0+aw6rGyYj1UICdOay2H9ZB6wKmSgy9OOQVwbgimj+0s3IFg3GOtMh0VB3an+M4YTpsjz0it9NJ/8yRzH33zrs5H4tKc3PiPK6hGSYqULf9WSRNJgxSzF35fCOewUOF1x5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYVUd34I76MPipSp3mAzkKl4bk0slrIyZ9n2x5SmU/A=;
 b=fjVa8gtJHU1U2pPVUHYSFSeG7ZjVQt7PqHtEAwzk1ZGwQoJIOdi90gLsnCJdMUZo2viMPstqeQmBZ+TgVMSYTqKlRVznb0K6OlLoypD9fnYvGtY1gyLpmgQeMyFQnhAhEves7ToNUzD6rXKiDtMuIAxjwVyQw8F00dL2YnlM4c68m2pZkR+Qb2Rwx8/MxJlDzvO0pmF2YLvZ0VDfEU6uuE7RFpresp/TVNIQlxS/cvofuLCtkmb80OdpyxzQxpZ+Wwpi2TszsEtM9dxGS2Cky42Vepx9xAZgmCsm7KWWTb6zNiudoHy78v8bktJ01fmylUHqEBDKGJKtvPM/7H6/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYVUd34I76MPipSp3mAzkKl4bk0slrIyZ9n2x5SmU/A=;
 b=Yfux2O9FPNDYFKDwK1Vjy+eF0rBoerWVQHI9gpVUgD63Cd85FBaoKj6RuJbebjIxijEfwylaphDBQyq868nOizsIdBMVmdoZg5ayYSBT2HCCRNnsqnUpXHfLMp/JE+npnnuasDxSB3U/uW6Wge7xd/yha1vMC9gl5SKPJHbFvIw=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3365.namprd15.prod.outlook.com (2603:10b6:a03:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 02:44:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 02:44:10 +0000
Date:   Wed, 1 Apr 2020 19:44:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma 65;5803;1c Commit 944d9fec8d7a ("hugetlb: add support for gigantic
 page allocation at runtime") has added the run-time allocation of gigantic
 pages. However it actually works only at early stages of the system loading,
 when the majority of memory is free. After some time the memory gets
 fragmented by non-movable pages, so the chances to find a contiguous 1 GB
 block are getting close to zero. Even dropping caches manually doesn't help
 a lot.
Message-ID: <20200402024406.GA69473@carbon.DHCP.thefacebook.com>
References: <20200311220920.2487528-1-guro@fb.com>
 <20200401192553.7f437f150203a5fa044a1f75@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401192553.7f437f150203a5fa044a1f75@linux-foundation.org>
X-ClientProxiedBy: MWHPR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:300:115::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:7c71) by MWHPR11CA0029.namprd11.prod.outlook.com (2603:10b6:300:115::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 02:44:09 +0000
X-Originating-IP: [2620:10d:c090:400::5:7c71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 575f8f5a-92a6-4a43-d6e1-08d7d6afb880
X-MS-TrafficTypeDiagnostic: BYAPR15MB3365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3365DE698D030678A7A0AC8BBEC60@BYAPR15MB3365.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(8676002)(81156014)(478600001)(316002)(2906002)(8936002)(66556008)(66476007)(33656002)(9686003)(66946007)(54906003)(55016002)(6506007)(52116002)(16526019)(86362001)(81166006)(6916009)(4326008)(6666004)(5660300002)(186003)(7696005)(1076003)(37363001)(219693003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akseB6pCiO6dg55em7Kd/X901izHCdR92uXWqJTRjj7xXuh1cJeqzFq2R+05+31xvhhVetar8pVFo6dZh8T94A7gafB93wFfuH2IHBYduC4l3rsbD03UqIXiaHyggb1hub0sv1reEAnE9WeU14wM05WF6eZ9RzKGCF4UVLfkNuy+tNvPjF2EmG9rLmL6YL8qTEupOqlsr2pwWV+g6UGRJe179mN1aCqvlkpGhPFtvUD9z4m6qROeEE7r+51ucRlk1i/d1Bn/8/QEZboJMCF3PCKEPDqsi8qlN9dgl1K9jfNx2dHz4T0mTKDZU2m1no76MTvabC7a6XkI2vuUZ/llUIcqHFsPh5AbfUxKn+zM9i9G75tb2uPezdPSdGBSoDU1iPYlOb/H9KLkk5seggI1aPOv5dMlkS4HGJHMxNktX76Z1caG9IBG2XlPxa/ZhGGPhcu0GmoyUiL8wMHeQluXz8LwNYxAZCMM/ngdYMoZtR7x6t2JRVvteY8A/6Yk2Mbs4DWvaUivG/xf02v3cRkiRA==
X-MS-Exchange-AntiSpam-MessageData: 4AUhCOgf+lfR6B7Rt9ZbAmv4AeMREO4Td6+eKalG7BOsS/NUXVc5p33gp3JCRVa1xnFLME5UvnA6AVPK2CbuiqoAGlBslrovU7Dw6/MkitHVYibS6yE1EwnVW83qMeNXbHhTOfr/hHh2QSfGiLPBagGrh7mpOuCZkSLgg6cWX72eV63OYMJ3dBjLQ+4hXpk5
X-MS-Exchange-CrossTenant-Network-Message-Id: 575f8f5a-92a6-4a43-d6e1-08d7d6afb880
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 02:44:10.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +e9OxJvGIa1+GBLNRucskuqRMt4tIvmwi69xxNq1OLUST2pPH+zpEC5BCl9bspR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020023
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 07:25:53PM -0700, Andrew Morton wrote:
> On Wed, 11 Mar 2020 15:09:20 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > At large scale rebooting servers in order to allocate gigantic hugepages
> > is quite expensive and complex. At the same time keeping some constant
> > percentage of memory in reserved hugepages even if the workload isn't
> > using it is a big waste: not all workloads can benefit from using 1 GB
> > pages.
> > 
> > The following solution can solve the problem:
> > 1) On boot time a dedicated cma area* is reserved. The size is passed
> >    as a kernel argument.
> > 2) Run-time allocations of gigantic hugepages are performed using the
> >    cma allocator and the dedicated cma area
> > 
> > In this case gigantic hugepages can be allocated successfully with a
> > high probability, however the memory isn't completely wasted if nobody
> > is using 1GB hugepages: it can be used for pagecache, anon memory,
> > THPs, etc.
> > 
> > * On a multi-node machine a per-node cma area is allocated on each node.
> >   Following gigantic hugetlb allocation are using the first available
> >   numa node if the mask isn't specified by a user.
> > 
> > Usage:
> > 1) configure the kernel to allocate a cma area for hugetlb allocations:
> >    pass hugetlb_cma=10G as a kernel argument
> > 
> > 2) allocate hugetlb pages as usual, e.g.
> >    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > 
> > If the option isn't enabled or the allocation of the cma area failed,
> > the current behavior of the system is preserved.
> > 
> > x86 and arm-64 are covered by this patch, other architectures can be
> > trivially added later.
> 
> Lots of review input on v2, but then everyone went quiet ;)
> 
> Has everything been addressed?

I hope so. There is a nice cleanup from Aslan, which can be merged in or
treated as a separate patch.

If someone else has any concerns, I'm happy to address them too.

Thanks!
