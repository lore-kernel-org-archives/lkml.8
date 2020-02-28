Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B425EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5B224699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="tFbHwisp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgB1ReX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:34:23 -0500
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:57850 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgB1ReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582911262; bh=ANENvU4jr43pIDD1rLz6hWXeI64gIBqEeJe6HrJ3ZH8=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=tFbHwispmJSoi/CPnV0eYllh7C64jy/qjegiAvEuEhfSgin1kmdmNp0MUTlPtnoR9
         w3A0IuScq0lANcgYAc8SyvD2LE4a5CWm2LkF1C1YL4rqXO6loHR5VdBQyoJe6iWhzk
         CCQiaysabcgjr+NUYaM2ZC5aW0fxfOaJJBtSovVwxUvpnrqVVyDYKL5rIlYCRhfhEt
         Oe1nH8ItgfLs1ur9/SJS1EqjKtd6pAmLe44LNqIGj8QgiwKlG3BDU9EM/9mYmYsynf
         QucYog83g9vr5UmrtmvRtZTJsUcC2Zpyd7h9EYF/OxJ0rBZVH5o4xNoDoTcJsB2WZY
         /WeTEzkqUbkVA==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id 962268603FF;
        Fri, 28 Feb 2020 17:34:21 +0000 (UTC)
Date:   Fri, 28 Feb 2020 12:34:19 -0500
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
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200228173419.GB34885@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +  {
> > +    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
> > +    "EventCode": "0xaf",
> > +    "BriefDescription": "SC AGU dispatch stall.",
> > +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> > +    "UMask": "0x80"
> > +  },
> 
> All the above Public descriptions have "RETIRE Tokens unavailable." 
> yet their BriefDescriptions are different.  Please fix.

Just noticed that this one is not present at all in PPR 56176 Rev 3.06 - Jul
17, 2019 and that the umasks for the rest of the sub-counters in PMC0xAF
are right shifted by one when compared to those in Zen1. As a result,
the previous counter at umask 0x1 is no longer present.

I will update this counter to reflect what is documented in model 71h PPR 56176 Rev
3.06 - Jul 17, 2019.

-Vijay
