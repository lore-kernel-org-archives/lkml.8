Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38870C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FB42073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OXm404pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390806AbgDCNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:12:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35158 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390716AbgDCNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:12:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033D9eT7168136;
        Fri, 3 Apr 2020 13:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7n+MDhRrbq9TiAJJ1tQrkO6V5YiXNpNCJQJK7RlWz+4=;
 b=OXm404plt1hUNxb6VAOgMemfBQLkiHpewCmA07AQG9r2c5wETvbE6GSRniCm+pB5g4HN
 rlzKelYJqyb5HC1ZuM4DHeLMKxfnZ/V5bgNAYup/oSljC0YAwg/9gSm1lGwOuE5XA9F1
 3490cS9YME+H2TycIHdniYzYjA9juevwFWbKfgz6FfDeqGgjD97K8XW750U2JeAFEKc/
 UfDVJMV7ZK3mK63vev/KbzVEYfDmZ51ODm825M5Vke17D24p+Add2brQresrRe1xljeK
 gyBjxISmw8oihWnpJw12rIXhBFXXKYtkmG9Kajzl7F31S9CyarW8UMDhcg7HiYu9ZyZF Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 303yunkhve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 13:12:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033DCETM026091;
        Fri, 3 Apr 2020 13:12:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302ga4pmav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 13:12:16 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033DC141027756;
        Fri, 3 Apr 2020 13:12:01 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 06:12:00 -0700
Date:   Fri, 3 Apr 2020 09:12:20 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: don't need drain lru cache when splitting and
 mlocking THP
Message-ID: <20200403131220.za3wfj6k33whobp7@ca-dmjordan1.us.oracle.com>
References: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200402230411.7ckwkmd6wwtqfkm2@ca-dmjordan1.us.oracle.com>
 <20200402231731.32imzorzucpj4s6w@ca-dmjordan1.us.oracle.com>
 <ee712068-cf37-35b8-7dfb-50e290b6b2c4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee712068-cf37-35b8-7dfb-50e290b6b2c4@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=639 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=692 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:37:06PM -0700, Yang Shi wrote:
> 
> 
> On 4/2/20 4:17 PM, Daniel Jordan wrote:
> > On Thu, Apr 02, 2020 at 07:04:11PM -0400, Daniel Jordan wrote:
> > > On Sat, Mar 28, 2020 at 03:29:40AM +0800, Yang Shi wrote:
> > > > Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
> > > > page arrival") THP would not stay in pagevec anymore.  So the
> > > > optimization made by commit d965432234db ("thp: increase
> > > > split_huge_page() success rate") doesn't make sense anymore, which tries
> > > > to unpin munlocked THPs from pagevec by draining pagevec.
> > > > 
> > > > And draining lru cache before isolating THP in mlock path is unnecessary
> > > > either.
> > > Can we get some of that nice history in this part too?
> > > 
> > > Draining lru cache before isolating THP in mlock path is also unnecessary.
> > > b676b293fb48 ("mm, thp: fix mapped pages avoiding unevictable list on mlock")
> > > added it and 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge
> > > pages") accidentally carried it over after the above optimization went in.
> > > 
> > > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > Since we don't mlock pte-mapped THP, it seems these huge pages wouldn't ever be
> > > in the pagevecs if I'm understanding it all.
> > Actually pte-mapped THP doesn't matter for this, both paths always drain when
> > they're working with pmd-mapped THP.
> 
> Actually either pte-mapped or pmd-mapped doesn't matter, as long as it is
> compound page the lru cache would be flushed immediately upon the arrival of
> the compound page.

Ah, that's right!  The checks in swap.c are for PageCompound.
