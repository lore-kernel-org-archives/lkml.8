Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5945C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D7020721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MtsVz8pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405408AbgE1RLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:11:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405334AbgE1RLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:11:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SH1hYO194536;
        Thu, 28 May 2020 17:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RNA5EiRdOxWHyc773hcc18vsX6Aelg58rv1UtOvHwJQ=;
 b=MtsVz8pGALILYv7e1mzQeP0pv92sFhFkk09VDqZZGhlYjcWUBYuXag4BRTHpcnV7zr7V
 YZDOJNvlP8tQnEzXwMEaHTzifoa4FV6xT+vfzW3+Xq81d8J3PV/SOidDzivt+dEdy0Oi
 HMLrT31elMelMcV6+KiSNV3HgaX6vcwTl3DFEAyO4pJoMkvdgNc14tjPfdoZr2I4eku8
 ptLmSvWgIeqng2FXqHIkjZaCyd4yIkLSFCi3ZXJtv74P8kSEOI9aFKEzKDpC1vzeR2Pf
 R6A3NWDSkPmmHNRbRXvKBl6mTGmJm5VotUEpqmhJhCT6D+uZoacpkekvh7C3FhdhpxoC /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 316u8r68ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 17:11:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SH8wRm012360;
        Thu, 28 May 2020 17:11:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 317ds2xtmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 17:11:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04SHBHit019755;
        Thu, 28 May 2020 17:11:17 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 10:11:16 -0700
Date:   Thu, 28 May 2020 13:11:41 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] swap: Reduce lock contention on swap cache from swap
 slots allocation
Message-ID: <20200528171141.k3lc3mf7taqadv3v@ca-dmjordan1.us.oracle.com>
References: <20200525002648.336325-1-ying.huang@intel.com>
 <20200528013724.flx6pwcmaazpek32@ca-dmjordan1.us.oracle.com>
 <87h7w0hbev.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7w0hbev.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:32:40PM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Mon, May 25, 2020 at 08:26:48AM +0800, Huang Ying wrote:
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 423c234aca15..0abd93d2a4fc 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -615,7 +615,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> >>  			 * discarding, do discard now and reclaim them
> >>  			 */
> >>  			swap_do_scheduled_discard(si);
> >> -			*scan_base = *offset = si->cluster_next;
> >> +			*scan_base = this_cpu_read(*si->cluster_next_cpu);
> >> +			*offset = *scan_base;
> >>  			goto new_cluster;
> >
> > Why is this done?  As far as I can tell, the values always get overwritten at
> > the end of the function with tmp and tmp isn't derived from them.  Seems
> > ebc2a1a69111 moved some logic that used to make sense but doesn't have any
> > effect now.
> 
> If we fail to allocate from cluster, "scan_base" and "offset" will not
> be overridden.

Ok, if another task races to allocate the clusters the first just discarded.

> And "cluster_next" or "cluster_next_cpu" may be changed
> in swap_do_scheduled_discard(), because the lock is released and
> re-acquired there.

I see, by another task on the same cpu for cluster_next_cpu.

Both probably unlikely, but at least it tries to pick up where the racing task
left off.  You might tack this onto the comment:

		 * discarding, do discard now and reclaim them, then reread
                 * cluster_next_cpu since we dropped si->lock
                /*

> The code may not have much value.

No, it makes sense.

> > These aside, patch looks good to me.
> 
> Thanks for your review!  It really help me to improve the quality of the
> patch.  Can I add your "Reviewed-by" in the next version?

Sure,
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
