Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1414BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72A2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Q3PvQfjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgB0UGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:06:44 -0500
Received: from ms11p00im-qufo17281901.me.com ([17.58.38.56]:60662 "EHLO
        ms11p00im-qufo17281901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730012AbgB0UGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582833629; bh=JYNKugIJWyzo77R6VplipDGlj2abNXrkHHhg21IHtgk=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=Q3PvQfjHaFzRx7qDnYCCmQSxzUe5cmEIyzMorLqIyl0/8ieDpqq/7dHbhm+cJExEG
         hPNBizwo/fGX/FHJWDl6edUu6dnJZE6zJ4UXoNda2AQUg16amfxJ0y9OxWs+PDLFTw
         eUoOIWFrFXFqSewHjmbn6LsyS27v70Y6sWzgOD0DSosJuSbIOei0UEKntBPBx7J694
         fTyZzmspe7dnkEvNy1XAcCAeQVWzLmSQXHoEC3ZBKXbHC10HyQwI/irEdbDEX5tOFI
         ZT6xbxa23DakzkgDbGEXQMmHroTM/yuRLgAf+iVWWYSYCrVwJuQ3PTgOauf2hUxclx
         nltACiC8baQSQ==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281901.me.com (Postfix) with ESMTPSA id ABC7F740439;
        Thu, 27 Feb 2020 20:00:28 +0000 (UTC)
Date:   Thu, 27 Feb 2020 15:00:26 -0500
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
Subject: Re: [PATCH v2 3/3] perf vendor events amd: update Zen1 events to V2
Message-ID: <20200227200026.GA8493@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-4-vijaythakkar@me.com>
 <73b5b731-9597-1243-485a-788437500c7a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b5b731-9597-1243-485a-788437500c7a@amd.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002270137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018
I have included this for v3 that I will submit later, including all the
changes for the FPU counters. Sorry, I messed up copy-pasting the text
and forgot to change the trailing pipe number.
> and their counts don't seem to match up very well when running
> various workloads.  The microarchitecture is likely to have changed
> in this area from families prior to 17h, so a MAB alloc can likely
> count different events than what is presumed here: a Data cache
> load/store/prefetch miss.
> 
> I think it's safer to just leave the PPR text "LS MAB Allocates
> by Type" as-is, instead of assuming they are L1 load/store misses.
> What do you think?

I did some checking accross PPRs, and this counter seems to have changed
names multiple times throughout the PPR revisions. 

Zen1 PPR (54945 Rev 1.14 - April 15, 2017) lists counter called "LsMabAllocPipe"
with 5 subcounters that have different names compared to ones we see in
the mainline right now. PPRs for stepping B2
onwards change this to the 3 sub-counter and primary counter name
we see right now. This public description still changes accross various
PPR revisions, which is why I had this set to what it was. The lastest
PPR I can find is indeed lists it as "LS MAB Allocates by Type";
I will change it to that with the fuffix of tehe sub-counter name. Since
the same counter is in Zen2 as well, I will make the same changes there
too.

Let me know if this sounds good to you!
Best,
Vijay

