Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64102C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0392173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YqOeiTix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgD2NAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:00:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49164 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2NAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:00:36 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200429130033epoutp0364687b0accbd8e61751fc4cdce717edd~KS92CF75p3180431804epoutp03a
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200429130033epoutp0364687b0accbd8e61751fc4cdce717edd~KS92CF75p3180431804epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588165233;
        bh=oi1Cvuzj0cj5gw/9YGJe2ynMN3rlmpPU0C4n3b7LBF0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=YqOeiTixE0GP0i8Y87Ej0N+dMqv9JJCsHbjevwa+LFmlvXX0mrP2zvKwdHAQ331BJ
         CoiW2ItWAHvj6pi9do0MS2DZ3HZ79ZzfZVqL80N7hvaIWAySchtFG71b9syflBZIko
         bNfMRBjpph6eI1/6dFiuBV66oRMKtmrEdEDjKaVg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200429130032epcas5p19ba953fffc07fdd39b2efc61d915833d~KS91kUEv40053500535epcas5p1U;
        Wed, 29 Apr 2020 13:00:32 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-e8-5ea97a7025e7
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.B7.04736.07A79AE5; Wed, 29 Apr 2020 22:00:32 +0900 (KST)
Mime-Version: 1.0
Subject: RE:[PATCH 1/1] mm/vmscan.c: change prototype for shrink_page_list
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200429120951.GC28637@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200429125323epcms5p67a539511c573cd598d78b726503e3204@epcms5p6>
Date:   Wed, 29 Apr 2020 18:23:23 +0530
X-CMS-MailID: 20200429125323epcms5p67a539511c573cd598d78b726503e3204
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7bCmpm5B1co4g4knDSwu7k61mLN+DZvF
        5V1z2CzurfnPavH62zJmi0Mn5zI6sHlsWtUJJD5NYvc4MeM3i0ffllWMHp83yQWwRnHZpKTm
        ZJalFunbJXBlTF28lrmglavi15dF7A2MX9i7GDk4JARMJGbvru9i5OIQEtjNKPGv7TMbSJxX
        QFDi7w7hLkZODmEBL4mmM5eZQGwhAUWJCzPWMIKUCAsYSPzaqgESZhPQk1i1aw8LiC0ioCKx
        vu8OO8hIZoGfjBJfJ25kBklICPBKzGh/ygJhS0tsX76VEcTmBDqhec5DJoi4qMTN1W/ZYez3
        x+YzQtgiEq33zkLNEZR48HM3VFxGYvXmXqiZzYwSnUtSQRZLCExhlNj9qosNImEusXvDPLAi
        XgFfib1tB8CaWQRUJfZvfQjV7CLRvuIrK4jNLCAvsf3tHGaQJ5kFNCXW79KHKJGVmHpqHRNE
        CZ9E7+8nTDB/7ZgHY6tKtNzcwArz4+ePH1kgwewhcWsqMySYdzJK3P52mX0Co8IsREjPQrJ4
        FsLiBYzMqxglUwuKc9NTi00LjPNSy/WKE3OLS/PS9ZLzczcxghOLlvcOxk3nfA4xCnAwKvHw
        WqSujBNiTSwrrsw9xCjBwawkwvsoY1mcEG9KYmVValF+fFFpTmrxIUZpDhYlcV4tRqBqgfTE
        ktTs1NSC1CKYLBMHp1QDY/ynRUa+Ya94si22FsYaX5QMfPxypnGU3eKmvxHxJXd3TC6L/vO8
        mP+ZDpd9UZlUcuRZzsOCDRJLc7LrZsxdO9v09UuWugQrHoPz4bdOHpx0acrWpiXRRVInlBpd
        owxfPlx29wBfwA4mjwthP6MSfBV3B0fnBV/7V1m8SeffvBdn783a9Ib7hBJLcUaioRZzUXEi
        AG6uT/4oAwAA
X-CMS-RootMailID: 20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c
References: <20200429120951.GC28637@dhcp22.suse.cz>
        <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c@epcms5p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>
>Acked-by: Michal Hocko <mhocko@suse.com>
>
>Is there any reason to move declarations here?
>

"unsigned int ret" was changed mistakenely, sending V2.
and "unsigned int nr_reclaimed" is changed to remove hole.
 
>> -unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>> +unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>  					    struct list_head *page_list)
>>  {
>> +	unsigned int ret;
>>  	struct scan_control sc = {
>>  		.gfp_mask = GFP_KERNEL,
>>  		.priority = DEF_PRIORITY,
>>  		.may_unmap = 1,
>>  	};
>>  	struct reclaim_stat dummy_stat;
>> -	unsigned long ret;
>>  	struct page *page, *next;
>>  	LIST_HEAD(clean_pages);
>>  
>> @@ -1900,13 +1900,13 @@ static int current_may_throttle(void)
>>  {
>>  	LIST_HEAD(page_list);
>>  	unsigned long nr_scanned;
>> -	unsigned long nr_reclaimed = 0;
>>  	unsigned long nr_taken;
>>  	struct reclaim_stat stat;
>>  	int file = is_file_lru(lru);
>>  	enum vm_event_item item;
>>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>  	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
>> +	unsigned int nr_reclaimed = 0;
>>  	bool stalled = false;
>>  
>>  	while (unlikely(too_many_isolated(pgdat, file, sc))) {


Thanks,
Maninder Singh
