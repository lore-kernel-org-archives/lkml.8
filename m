Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1127620735
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfcyncsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHVChB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 22:37:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40812 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgHVChA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 22:37:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07M2Vqrj044965;
        Sat, 22 Aug 2020 02:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VrMyZbyBm5q5JH1uyUIBYVhGI28hB+36YlS9BaRhVzc=;
 b=KfcyncsEN599jLWRwRUFy++fSRdYfTDYxQgh8M3zAGZ4jZrLiJ9+0RWpahpIulxAsKjT
 Ngc53d5QfpXw1dEwtpToWBTMdeTw63jZ6CjfsL+kgvmwqR7hCDFQyHyFoFZBascJt/xj
 /Y2wG9QheOrsDfbkEBmsDjct+wCXOf1dAFwFU7Oy21x8V7oMOiPVyaN8X/8jYztwp6E2
 gxC2l3/LSCjhpPSXOTs/QJ1LYEGLTqcxWbyB/ICXroKz191h2G0UXcHeIZG9egFluNCm
 VC9mnfKM90RI5nuFhzI5GdBr20iEgxrJ7ZQ2Phj5NUgmn1k8maUQZra0NnLcwDBzYULn Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3322bjn8ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Aug 2020 02:36:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07M2XITN135968;
        Sat, 22 Aug 2020 02:34:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 332rfqtq57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Aug 2020 02:34:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07M2YdNw010014;
        Sat, 22 Aug 2020 02:34:39 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Aug 2020 02:34:39 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3\))
Subject: Re: [PATCH 0/7] Overhaul find_get_entries and pagevec_lookup_entries
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
Date:   Fri, 21 Aug 2020 20:34:38 -0600
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3875B5A-52FF-41B8-8F57-2F25659949D6@oracle.com>
References: <20200819150555.31669-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.0.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008220022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008220021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 19, 2020, at 9:05 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> This started out as part of the THP patchset, but it's turned into a
> nice simplification in its own right.  Essentially we end up unifying
> find_get_entries() and pagevec_lookup_entries() into one function =
that's
> better than either, and we get rid of a lot of code in the callers as
> a result.
>=20
> I'm running this through xfstests right now, but something similar to
> this has already passed xfstests as part of the THP patchset.
>=20
> I've done my best to avoid off-by-one errors for 'end', but I wouldn't =
be
> surprised if I made a mistake.  We're not consistent with whether =
'end'
> is inclusive or exclusive and I didn't want to make extensive changes
> to ensure they were consistent.
>=20
> Matthew Wilcox (Oracle) (7):
>  mm: Use pagevec_lookup in shmem_unlock_mapping
>  mm: Rewrite shmem_seek_hole_data
>  mm: Add an 'end' parameter to find_get_entries
>  mm: Add an 'end' parameter to pagevec_lookup_entries
>  mm: Remove nr_entries parameter from pagevec_lookup_entries
>  mm: Pass pvec directly to find_get_entries
>  mm: Remove pagevec_lookup_entries
>=20
> include/linux/pagemap.h |  3 +-
> include/linux/pagevec.h |  4 --
> mm/filemap.c            | 19 +++++----
> mm/shmem.c              | 85 ++++++++++++++---------------------------
> mm/swap.c               | 38 +-----------------
> mm/truncate.c           | 33 +++-------------
> 6 files changed, 45 insertions(+), 137 deletions(-)

Very nice cleanups and the code makes more sense, thanks.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
