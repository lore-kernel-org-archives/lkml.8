Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D610FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BEA20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgC0IB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:01:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:20926 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgC0IB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:01:29 -0400
IronPort-SDR: O0VdjnI9LQPCEkcvwaasvAmuaPdXKrbIYmRmzSYmJAxhk3qKdojS4JNzs2hUftE+8DhnPkYKEq
 RX4c/xn9pnfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:01:28 -0700
IronPort-SDR: u4frG0uSJN+vFDVpxGHihJ1Q16T8vGQuvgR7gytmxAV6sosToqdUB1gim9Er7CrTTAvx7Dw32W
 OlrGg4O+ohzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="271484024"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2020 01:01:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v8 2/3] perf x86: Topology max dies for whole system
In-Reply-To: <20200320073110.4761-3-roman.sudarikov@linux.intel.com>
References: <20200320073110.4761-1-roman.sudarikov@linux.intel.com> <20200320073110.4761-3-roman.sudarikov@linux.intel.com>
Date:   Fri, 27 Mar 2020 10:01:23 +0200
Message-ID: <87bloi6xbg.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roman.sudarikov@linux.intel.com writes:

> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>
> Helper function to return number of dies on the platform.

It's not a function though, it's a macro. And maybe more of an
"accessor" than a "helper".

It's also good to mention in the commit message, why this change is
needed and sometimes (though maybe not here) why this way is better than
the alternatives.

Another thing about the subject line is that it has to describe the
action that the patch is taking, in imperative mood. In this case it
could be "Turn the max die calculation into a function".

The prefix of the subject line should be: perf/x86/intel/uncore. Check
out git log arch/x86/events/intel/uncore.c for examples.

I also think that it won't be unreasonable to fold this patch into the
next one. That's up to you, of course.

Regards,
--
Alex
