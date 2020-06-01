Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C863C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A59020734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fmebebk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFAQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:57:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48504 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:57:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051GlssD165590;
        Mon, 1 Jun 2020 16:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=if3Zz9VtQB2CrSuPmMraBpB3vDqCLb13ncvOUi5ei/c=;
 b=Fmebebk4d0w9qmYHB+aKDRuh464LuFtU984tT+TwpFLdHR6AgbrXWzQIcRDBgJqGesGr
 czeYD8pDiuO0xgWGgIHmFMvEbP/ulK2loWP0EEbTPd31hggAinj+AASvxFX08jCsjizz
 /xcW3qmT1ruAbgFBR+/+WXc4k8G76CT2+BxGK9I8VUsr2Fe7JQr7SFMbl7eKcjbxkTTk
 WP6L2um9TolXpqShvuwEmcwqyHqldoUwpyif96FTqC9XRxH91ky+b/8v7sxSDte9zOwh
 kquHT2EzcxRlzBBVcnBFsXQokhg45StDQ2tgPvY/N0C0mRup/iR+a1sVbh7V5W1vfyle rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31bewqqut3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 16:57:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051GrOSC069215;
        Mon, 1 Jun 2020 16:57:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31c12msrcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 16:57:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 051GvGlJ009610;
        Mon, 1 Jun 2020 16:57:16 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 09:57:16 -0700
Date:   Mon, 1 Jun 2020 12:57:36 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hughd@google.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration
 without split
Message-ID: <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
> This adds the following two new VM events which will help in validating PMD
> based THP migration without split. Statistics reported through these events
> will help in performance debugging.
> 
> 1. THP_PMD_MIGRATION_SUCCESS
> 2. THP_PMD_MIGRATION_FAILURE

The names suggest a binary event similar to the existing
pgmigrate_success/fail, but FAILURE only tracks one kind of migration error,
and then only when the thp is successfully split, so shouldn't it be called
SPLIT instead?
