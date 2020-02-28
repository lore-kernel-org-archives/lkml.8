Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D267EC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DDA24699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="krieKsgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB1R1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:27:09 -0500
Received: from ms11p00im-qufo17291301.me.com ([17.58.38.42]:39720 "EHLO
        ms11p00im-qufo17291301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgB1R1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582910826; bh=ItSj1ZjtgSNl/dANtXNTjGWbaWQwhfI7P3O1XWJ55E4=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=krieKsggzXv/tuwbXG7GUdpzmU7DUQcRp6N4xoR+noDIs570NuHClo+w77t10upzt
         cJ2rqaYSiaN9AwbA0R3XSqhx1X3pQn5lJ5fti0uoAQ2R2iGGhnriBu4vB3hSe9dlBq
         2sgntp4MkmxSYl3U4b/Ddm322XmN++NU1F568tuB9gPQDaixw/z0/9+5OTaV6xZ32f
         8eMFgWyP5Sf+soZF26Ex46YDG3knh225MlCiWizmYBtNPX72hvwIhJq/PTgPTYZxkn
         5Ov85u66DzbcJKKRB0RY6basqfQ0rvfPVdYReGhqTdM0Kao4yXc2W2oVIM1Djdhden
         rYyN4R84Hh6+g==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17291301.me.com (Postfix) with ESMTPSA id D907810071C;
        Fri, 28 Feb 2020 17:27:05 +0000 (UTC)
Date:   Fri, 28 Feb 2020 12:27:03 -0500
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
Message-ID: <20200228172703.GA34885@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
 <20200228160045.GA23708@shwetrath.localdomain>
 <f7dba82f-beac-2669-c7e7-5a85edc2798d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7dba82f-beac-2669-c7e7-5a85edc2798d@amd.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> They're producing nonzero counts on my model 31h, so leave them in?

> I'm getting nonzero values on my model 31h for that event's
> various unit masks, too.
Okay, will do.

> Thanks, I'd veer toward making them available despite differences in PPR
> versions.

Okay, that is consistent with what I have done so far for the Zen1
counters that are not mentioned in the Zen2 PPRs. Great! I will send v3
in a bit.

Best,
Vijay
