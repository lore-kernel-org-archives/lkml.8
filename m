Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8999AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601D82074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="CZSIjUYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCNDNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 23:13:14 -0400
Received: from st43p00im-zteg10063401.me.com ([17.58.63.175]:35003 "EHLO
        st43p00im-zteg10063401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgCNDNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584155592; bh=XVg9MvTPmWfYV3MDEBTqmqWRsnFid69lEYXtgfapPy4=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=CZSIjUYIeLflaR99z6LjMM3ISLMMAIHfD/GW6W7w3YdhKwr8XVknPlOMTwsqojZLu
         a/nO0yaQ2DxWPZ3ao25p9gmBnItaNWH12DSp12ZS6A/oT03I4FOmYeAMvKgMlc4rCT
         eJjV0yOJdHqRIDtnttasJOGMMVUhkLHR0Xtpx5QuQM1f7bTJXqcDdMB923Uosw87D5
         3A7u75njBoN/mZPB0s1F0ZOFwyc2J11C8f7ra8qmTlgDvnwbtTyO/FswRK+8/qi7/M
         B96KMkPMkCXjJQLVsYUw6ahJTJ079kHVDfX8064Yh2rgLqwFhyDcxF0e7Cnb0P9STY
         baMQA9dKDc2ww==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id DA50D4A016B;
        Sat, 14 Mar 2020 03:13:11 +0000 (UTC)
Date:   Fri, 13 Mar 2020 23:13:10 -0400
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf vendor events amd: update Zen1 events to V2
Message-ID: <20200314031310.GA66224@shwetrath.localdomain>
References: <20200228175639.39171-1-vijaythakkar@me.com>
 <20200228175639.39171-4-vijaythakkar@me.com>
 <77552e9e-7fca-7186-24cc-6a8a87d4b7b6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77552e9e-7fca-7186-24cc-6a8a87d4b7b6@amd.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003140016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may have accidentally deleted your review of Patch 2 so I am
replying to that here. Still quite new to mutt, sorry :p

> > +  {                                                                                                  
> > +    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",                                    
> > +    "EventCode": "0x46",                                                                             
> > +    "BriefDescription": "Tablewalker allocation.",                                                   
> > +    "PublicDescription": "Tablewalker allocation.",                                                  
> > +    "UMask": "0xc"                                                                                   
> > +  },                                                                                                 
> > +  {                                                                                                  
> > +    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",                                    
> > +    "EventCode": "0x46",                                                                             
> > +    "BriefDescription": "Tablewalker allocation.",                                                   
> > +    "PublicDescription": "Tablewalker allocation.",                                                  
> > +    "UMask": "0x3"                                                                                   
> > +  },                                                                                                 
>                                                                                                         
> I see each of the two tablewalkers got consolidated into their own                                      
> unit mask groups?  Any reason we couldn't leave the original
> instances there, and add these in addition?  In any case we'd need
> clarification of which 'side' are the both counting - I or D - in
> a single BriefDescription here.

So these have not been changed since zen1, and are still present as is
in the mainline. Zen2 PPR version 55803 Rev 0.54 does not include them.
But I see that these have been updated even for zen1 in the latest PPR
version 54945 Rev 3.03 so I will add them for both.

> I thought we agreed to call these LS MAB Allocates by Type", like the text in the
> later PPR for AMD Family 17h Model 31h B0 - 55803 Rev 0.54 - Sep 12, 2019?
> 
> DC Miss By Type is probably less correct given the MAB != DC, and the name of
> the event is "LsMabAlloc".
> 
> FWIW, a MAB is a Miss address buffer (seen in the Model 71h PPR's MCA_CTL_LS
> register definition).

Ah I am really sorry, I must have missed these. Should be fixed now.

> Another case where it's hard to make out what the event is counting
> in general: Make its PublicDescription a single Breifdescription?
Yeah, I agree. Will merge the descriptions.

> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from different die.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Local L2 hit.",
> +    "UMask": "0x1"
> +  },

These events are ripe for fusing the public description with the brief
one too, so I will do so as well.

-Vijay

