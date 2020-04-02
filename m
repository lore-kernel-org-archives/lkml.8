Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D55C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC616206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xEvxI3GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390052AbgDBXTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:19:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33440 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgDBXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:19:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032NIh1i011995;
        Thu, 2 Apr 2020 23:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2LYxeCRZSl/BBRTDhWUm9FlwdmmvWsoKVfJi+5EqCCc=;
 b=xEvxI3GUT+YK/KboRvEkZghpMcmKS47T6CVV13RcOP0hcFNPiWZbhKQ4m4PoHdajQhDj
 C/qI5/Nun/Awee1Pbz/y3qd8M9hqT3UPqvDTeJaVqvWVLA6wHdu20g1LXwy+Qf0PMIUG
 naNEb9bwEY8HoHOOapUAYYhY4dB+uyJacH7E3qxh+XrcqN0Tv9bhUnvvP8r1oqo3JvOn
 BETJzAqTRLs1wChjtMkm7KwcIixQ3m5i9q0ozsDbwzSEiwpsTBhTCeXLE2c/rN0jdKlN
 pLq//Lq1Ee8R9JQkRcmRIIdlHvkKwSgDFewNco9gVL25VSI2Ah+1gBwgj7wZ+HkgfnV4 fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhxrr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 23:19:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032NH943117422;
        Thu, 2 Apr 2020 23:17:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjqv6gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 23:17:23 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032NHMdU025065;
        Thu, 2 Apr 2020 23:17:22 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Thu, 02 Apr 2020 16:17:13 -0700
USER-AGENT: NeoMutt/20180716
MIME-Version: 1.0
Message-ID: <20200402231731.32imzorzucpj4s6w@ca-dmjordan1.us.oracle.com>
Date:   Thu, 2 Apr 2020 16:17:31 -0700 (PDT)
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: don't need drain lru cache when splitting and
 mlocking THP
References: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200402230411.7ckwkmd6wwtqfkm2@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20200402230411.7ckwkmd6wwtqfkm2@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=757 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=808 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:04:11PM -0400, Daniel Jordan wrote:
> On Sat, Mar 28, 2020 at 03:29:40AM +0800, Yang Shi wrote:
> > Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
> > page arrival") THP would not stay in pagevec anymore.  So the
> > optimization made by commit d965432234db ("thp: increase
> > split_huge_page() success rate") doesn't make sense anymore, which tries
> > to unpin munlocked THPs from pagevec by draining pagevec.
> > 
> > And draining lru cache before isolating THP in mlock path is unnecessary
> > either.
> 
> Can we get some of that nice history in this part too?
> 
> Draining lru cache before isolating THP in mlock path is also unnecessary.
> b676b293fb48 ("mm, thp: fix mapped pages avoiding unevictable list on mlock")
> added it and 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge
> pages") accidentally carried it over after the above optimization went in.
> 
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> 
> Since we don't mlock pte-mapped THP, it seems these huge pages wouldn't ever be
> in the pagevecs if I'm understanding it all.

Actually pte-mapped THP doesn't matter for this, both paths always drain when
they're working with pmd-mapped THP.
