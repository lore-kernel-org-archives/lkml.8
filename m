Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14CA20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gemkuhTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGXPGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:06:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGXPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:06:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OF2bQI155207;
        Fri, 24 Jul 2020 15:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cNUP853YkWwLJ+m++81WpFZuhAR4szqqYWHOb1sXqz0=;
 b=gemkuhToopoUsuLCsecObG4T6QgT4B/aXDAA8x0npNiRxeQHCfJPAFc7YRGKq07UfZ54
 E6kefAZq3Q9X4K5Pyrs5oXDKtN5SH959WSKmrnnjxedGP+WkxV3BPYfOOZ/M53dGtcDd
 Le2y//mM/fSs6bygMvLdQImbhqYwWH0OgvRGevpZmOBUUb7R2mz5lQtDD6OBaHfTz6az
 j7R2KNzfoXK7VLk8AEklC7mmy2ilw5mUT5ywWDkcP0dJEiy4DO4zporL9QTH31mVUYvA
 qy0AGa1/vZiavNVZ7tLqAuiqXmhiT6cpTY/iAjCL22oNOYEcmxIO1Aj8if21I/hXnpgc JA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32brgryn4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 15:05:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OEwRAX003007;
        Fri, 24 Jul 2020 15:03:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32fswsn2mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 15:03:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OF3kZ7022441;
        Fri, 24 Jul 2020 15:03:46 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 08:03:46 -0700
Date:   Fri, 24 Jul 2020 11:04:08 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Zi Yan <ziy@nvidia.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
Message-ID: <20200724150408.am4llb3qqjm4sibf@ca-dmjordan1.us.oracle.com>
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
 <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
 <97219d3b-96e1-4371-59ea-d038f37a672a@infradead.org>
 <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm assuming the newly-enlarged positive error return of migrate_pages(2) won't
have adverse effects in userspace.  Didn't see issues with any user in debian
codesearch, and can't imagine how it could be relied on.

This look ok.  Just some nits, take them or leave them as you prefer.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 705b33d1e395..4d434398d64d 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -46,13 +46,18 @@ MIGRATE_REASON
>  TRACE_EVENT(mm_migrate_pages,
>  
>  	TP_PROTO(unsigned long succeeded, unsigned long failed,
> -		 enum migrate_mode mode, int reason),
> +		 unsigned long thp_succeeded, unsigned long thp_failed,
> +		 unsigned long thp_split, enum migrate_mode mode, int reason),
>  
> -	TP_ARGS(succeeded, failed, mode, reason),
> +	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
> +		thp_split, mode, reason),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,		succeeded)
>  		__field(	unsigned long,		failed)
> +		__field(	unsigned long,		thp_succeeded)
> +		__field(	unsigned long,		thp_failed)
> +		__field(	unsigned long,		thp_split)

These three are ints in the code, not unsigned long.  It can save space in the
trace event struct, 8 bytes on my machine.

> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> @@ -1429,22 +1429,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
                ...
> >>>> +	bool is_thp = false;

Don't need to initialize, could declare with rc/nr_subpages.

> >>>> +				if (is_thp) {
> >>>> +					nr_thp_failed++;
> >>>> +					nr_failed += nr_subpages;
> >>>> +					goto out;
> >>>> +				}
> >>>>  				nr_failed++;
> >>>>  				goto out;

This instead, in each of the three places with this pattern?:

                                        if (is_thp)
                                        	nr_thp_failed++;
                                        nr_failed += nr_subpages;
                                        goto out;

> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
...
> +5. THP_MIGRATION_SPLIT: A THP was migrated, but not as such: first, the THP had
> +   to be split. After splitting, a migration retry was used for it's sub-pages.

The first part of this might be misinterpreted for the same reason Anshuman
changed this earlier (migration didn't necessarily happen).  We could just
delete "A THP was migrated, but not as such: first, "
