Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69BDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825CD2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BnveTbzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbgDBXEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:04:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54716 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBXEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:04:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032MsjJM108362;
        Thu, 2 Apr 2020 23:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BzlYfWPfjVLLViKroV5Bj/wWdp/CwSXppVCjZgXhNqQ=;
 b=BnveTbzR3ITbMbCPydFkAjSvvZUI4aHmZCki96ZoMIzopayt4MNwouLsqnMN+2qo5Ka1
 aAT4ncKFtb3wqJJwoq02Gtn48bxPbLGMB5IQxH1epEEtozIxZUYYwJ3IUx6ESG0oaV4S
 0HU/NBhnhWb9D+r61yvkTn5/0KKGGBwdXnEwpK11T3GbqKVNXy4VxXenGtetM0dSWaNv
 XDiHigag8026jNcI4gJj4eNY7BH+z2/EcQVN1pKyBKQmfIcpSH7Eqn+TqCa7WX1LdQPv
 NEAY4pa1X3l+tCTDCqjJBECfZ31D+icT7RoKtYtHdhOZEq01jIWYZR1AoPhgq0jltJs/ mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 303yungusu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 23:03:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032Mq9ed076063;
        Thu, 2 Apr 2020 23:03:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 302ga3a6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 23:03:53 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 032N3qvW029087;
        Thu, 2 Apr 2020 23:03:52 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 16:03:51 -0700
Date:   Thu, 2 Apr 2020 19:04:11 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: don't need drain lru cache when splitting and
 mlocking THP
Message-ID: <20200402230411.7ckwkmd6wwtqfkm2@ca-dmjordan1.us.oracle.com>
References: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=929 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=994 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 03:29:40AM +0800, Yang Shi wrote:
> Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
> page arrival") THP would not stay in pagevec anymore.  So the
> optimization made by commit d965432234db ("thp: increase
> split_huge_page() success rate") doesn't make sense anymore, which tries
> to unpin munlocked THPs from pagevec by draining pagevec.
> 
> And draining lru cache before isolating THP in mlock path is unnecessary
> either.

Can we get some of that nice history in this part too?

Draining lru cache before isolating THP in mlock path is also unnecessary.
b676b293fb48 ("mm, thp: fix mapped pages avoiding unevictable list on mlock")
added it and 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge
pages") accidentally carried it over after the above optimization went in.

> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Since we don't mlock pte-mapped THP, it seems these huge pages wouldn't ever be
in the pagevecs if I'm understanding it all.

Saves lines and some amount of overhead and lru contention, so looks good.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
