Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E046E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIIGpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:45:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:6193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIGpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:45:18 -0400
IronPort-SDR: rgtbG2iJunMjh3+4mJbmG3tpCqHGEBFccqI54I+5dmgU1FjmWwHaVRe0RqzdY/z32Y/IcntPMm
 T6crA+qvFZvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="137796876"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="137796876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 23:45:18 -0700
IronPort-SDR: vpvCsOeJrcXHK+2ZLb/8FiQfDPV6+Xh7438/WGgZ7DOS2IESAIWFqo6sEuSTN8+NVVw1nnLJ5l
 GHr36XrXIDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="333724606"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2020 23:45:15 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] kernel: events: Use scnprintf() in show_pmu_*() instead of snprintf()
In-Reply-To: <20200901234930.359126-1-skhan@linuxfoundation.org>
References: <20200901234930.359126-1-skhan@linuxfoundation.org>
Date:   Wed, 09 Sep 2020 09:45:15 +0300
Message-ID: <87o8mfxxc4.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> Since snprintf() returns would-be-output size instead of the actual
> output size, replace it with scnprintf(), so the nr_addr_filters_show(),
> type_show(), and perf_event_mux_interval_ms_show() routines return the
> actual size.

Well, firstly they should just be sprintf()s, and secondly, I wouldn't
worry about it, because [0].

[0] https://marc.info/?l=linux-kernel&m=159874491103969&w=2

Regards,
--
Alex
