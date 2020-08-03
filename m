Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56F1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814FE20781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FVvTpasZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jkRUIuHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHCPkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:40:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26870 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgHCPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:39:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073FNYDS026745;
        Mon, 3 Aug 2020 08:39:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=f97uFPY6D+FTGO0agBT6kWUoyhS29E+gbz17gP2XJjA=;
 b=FVvTpasZO3WNaxTjOv/SrnftN8mHUUBoayEFltkq7nz+RIav73eDS5ZnQ1eOxHKcbBsX
 IuLkoj5J8JhEMafzqiqC98NS+1T4JgfVBCf8yU2gjVjmFsZUTEltE8sYZymj2gYG95bw
 gLjtVsTSoU/Kv6wXJ1ozPoU9g6x9JlI5IYM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32n81fqj4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Aug 2020 08:39:52 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 08:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdX9LOSng02Xr2HUCjmdIr7YAHvczBp8au1lk418/6ydGV7xVklaDfpbcUJlv/N2jK2QrlYyIJEJyi+SbmWqjnxJzxnrPgaVTb0KyqAY21hVMAt5ya8trpqgUjOfaZq5d3oQeK8lXZCD9nFQ+zfmiAtpZRV2dkCha4AM89RZQRvsWkEGv6srJDmEyZ9huBAmuX7pp+Z1gFtq911rOVGOjdau5lpledRX1xIGZZ7wRgCIc8DzUNE50v2UMwwwbLmQZpIHMPIAi95b0QHEXgcTGHJwAKmvntur21y4A0EEvbttcq9tmXooVueTmNJfOJrLDlPJjp7Zsgg4fuCtRZWbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34165ZLKkBvADp2ZcF/9hiNJ6JkS+VH6jJY3QiY3Vb0=;
 b=R5QNdYw2eJKep6WhDHbHr4Sj4fzktcEXuYqZA/QqGrD+4rcjNj4RvsSotTib7dDhQnAS6yOHsThDPl2PSPPtYMbQQkkKo5v/xx6124oEvEq8VdsgcTeDIVSbC1M9ZtkQrAuYfN2zoWldQ/ngdQHZjttfo9Cka6W/geQBhAH7vTdWRMztN4Z0iIodo0OtiCfSUJq16tIzBUYuFrC3Kquvb2PQyCoBV4Bp+bdmw4zcCT1aF20l0WLj76uFNPkyFJulrRDsSHF592Br5oOIlkj16PfAAesjTo4LliD21ZGGtxXp+wSHxs69u2krdGYXmf8OeIM/ncgw8qPudOswpKTqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34165ZLKkBvADp2ZcF/9hiNJ6JkS+VH6jJY3QiY3Vb0=;
 b=jkRUIuHfr7cY5PgAzMLm8XopL0L4VBehADjtsSgaa4kjbt4sEaQ30st2s8Foh4uH4HiZN5VflM7vncT5JmYlO9NrDv0ltBekOew5xm8D77dLyVPGwu2rw5VDDJgXDd7wbMOYA/Simvs2QJcrMLucjnvXPzxsyxPc7SWVjjEEqrs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4134.namprd15.prod.outlook.com (2603:10b6:a03:9a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 15:39:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 15:39:50 +0000
Date:   Mon, 3 Aug 2020 08:39:47 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Koutny <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: Fix protection usage propagation
Message-ID: <20200803153947.GB1020566@carbon.DHCP.thefacebook.com>
References: <20200803153231.15477-1-mhocko@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803153231.15477-1-mhocko@kernel.org>
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:2f3a) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Mon, 3 Aug 2020 15:39:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:2f3a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3af8603-402a-47d2-1d7d-08d837c3758d
X-MS-TrafficTypeDiagnostic: BYAPR15MB4134:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4134ECD6C0E0C45B8D7D853DBE4D0@BYAPR15MB4134.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wnOGUx0O67MhcSEhoNQ41ERJGf3no5uCX7j9E3u+oAR1c70QdRI1/4h6zwrogyEkKFd8/ODG/6jST2MHSjYSb3Wp0AkggRQ0krRJCtEC8mOHlmhmRmAxi18PcrLwHZ5l6gYkDjEb/0RTqL7oSXMXzQzRwNk1JgzJ0IVruPC2cFM6UyQO4y7rR5yLwgQ3xhEyWhxcowDzE80pZN7q3PlqMQWTQ0Gt6xQgRV7ucVwTg7N55IcHFKWNYb/pzEWi8mYrkbAKgiCphoXF9oncqJkXPSgxi+N49tzc1r80IqgD5Xmn3qHrtzdbRoe+qtLzNIs5eLJd/yQTCQFnIYEAt+5+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(6506007)(6916009)(86362001)(55016002)(33656002)(2906002)(83380400001)(9686003)(5660300002)(8676002)(7696005)(1076003)(16526019)(52116002)(66556008)(66946007)(316002)(8936002)(478600001)(66476007)(54906003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0dRWbAlc6tfSY6qRGAsUrQMGGXsBsYkHe9OYMpSWsUB2O00TkAfNvntz2NIAG0qiVN/O6I8AbZ3QfKaHy9Zca9cPl2I4mFrhPtb9VNrzWk/ju9GLjIVjHkeIAIvcMuE35YrM3SGCsueMtpCB3aygRU4cD1SSOtCjRzAS+UDH9+YR48bJnLeHsvlTCLSd4ORXm4AfMp8hJsIDJSG6Q5G815viVSxBmzLfoJpP9obpy8OvUOqfRuJQm5NdUO1kcIuPco3IDqvUEgK8RfiOgD+GQEyA4ILYCe1+y+CxGzi+SeIgD7hhgD9Jqv5BAwe3iZ7Ihj03/jWQhIaSbsRUUOKXhdSCV2qBDd6sdWkpTB9L7/X5eV7FKoGxuvwUW/o2khFVCyg6sWRYNK2EPjPuO4ZqPd6pGw4q4MorVUChTVe2Zcex4kqVKSDGmF9HwagdWPazaxGlLOl8aodanwAK/dcuQGYfBnjPkNmntJPVCvCShKrQnWHAR4mmC7s2Eor0Z91cvUA4JTnV/Ka6Y0K/zp5JZBQJcPp4Vt8dsUPKhavRP/Klk6NGq4MG+G8cMb1HlrZx/Z5umoua5nX1ipUTSA9T8zDyphC5RFTSmOBx6iC/1LqDgjwc7Ea3dzAWYxws/ltvoFTLTQrAyqPsIqlRGPn7/4eumghfiaMTMxZ5QWd5SUg=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af8603-402a-47d2-1d7d-08d837c3758d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 15:39:50.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/QLE1qUU2Ype2+8PjbKwENjfZXaB2Ql4O13qujHRyeIAwQtYXAlm4/dpLE3Nntd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_14:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 suspectscore=1 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030116
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 05:32:31PM +0200, Michal Hocko wrote:
> From: Michal Koutný <mkoutny@suse.com>
> 
> When workload runs in cgroups that aren't directly below root cgroup and
> their parent specifies reclaim protection, it may end up ineffective.
> 
> The reason is that propagate_protected_usage() is not called in all
> hierarchy up. All the protected usage is incorrectly accumulated in the
> workload's parent. This means that siblings_low_usage is overestimated
> and effective protection underestimated. Even though it is transitional
> phenomenon (uncharge path does correct propagation and fixes the wrong
> children_low_usage), it can undermine the indended protection
> unexpectedly.

Indeed, good catch!

> 
> The fix is simply updating children_low_usage in respective ancestors
> also in the charging path.
> 
> Fixes: 230671533d64 ("mm: memory.low hierarchical behavior")
> Cc: stable # 4.18+
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thank you!

> ---
> 
> Hi,
> I am sending this patch on behalf of Michal Koutny who is currently
> on vacation and didn't get to post it before he left.
> 
> We have noticed this problem while seeing a swap out in a descendant of
> a protected memcg (intermediate node) while the parent was conveniently
> under its protection limit and the memory pressure was external
> to that hierarchy. Michal has pinpointed this down to the wrong
> siblings_low_usage which led to the unwanted reclaim.
> 
> I am adding my ack directly in this submission.
> 
>  mm/page_counter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index c56db2d5e159..b4663844c9b3 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -72,7 +72,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		long new;
>  
>  		new = atomic_long_add_return(nr_pages, &c->usage);
> -		propagate_protected_usage(counter, new);
> +		propagate_protected_usage(c, new);
>  		/*
>  		 * This is indeed racy, but we can live with some
>  		 * inaccuracy in the watermark.
> @@ -116,7 +116,7 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		new = atomic_long_add_return(nr_pages, &c->usage);
>  		if (new > c->max) {
>  			atomic_long_sub(nr_pages, &c->usage);
> -			propagate_protected_usage(counter, new);
> +			propagate_protected_usage(c, new);
>  			/*
>  			 * This is racy, but we can live with some
>  			 * inaccuracy in the failcnt.
> @@ -125,7 +125,7 @@ bool page_counter_try_charge(struct page_counter *counter,
>  			*fail = c;
>  			goto failed;
>  		}
> -		propagate_protected_usage(counter, new);
> +		propagate_protected_usage(c, new);
>  		/*
>  		 * Just like with failcnt, we can live with some
>  		 * inaccuracy in the watermark.
> -- 
> 2.27.0
> 
