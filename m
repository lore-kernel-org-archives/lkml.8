Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F66C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9E2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tWJrBum2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC0PCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:02:42 -0400
Received: from mail.efficios.com ([167.114.26.124]:38752 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0PCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:02:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1A802280587;
        Fri, 27 Mar 2020 11:02:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ps2rFxB4-Wby; Fri, 27 Mar 2020 11:02:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D0038280586;
        Fri, 27 Mar 2020 11:02:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D0038280586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585321360;
        bh=tw1BVWCyi3g6nCgKcrcWoUju6S+qxftKZ2ndYv4pow0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tWJrBum2TBWAw6FzJhmbR0nSbiWT4xSKJ3Przz36HXtdQMTbdO5ywYH6UrxAJM0SJ
         DJPgBVUFnt3JGp7KNRM1HCAiPl791mPXajYVXtGYOdUkXscAn8nHzDbDnVqDtW1mP2
         rgfIpWCF7aLZhYUdXOrggw3tpqWKQIu/ZxXM6KYXqIqDMcgcwwYplxlVHxoe1lQIJw
         5SQ7078ZQPOy16LmV60t6lm7SHCyLlBG53BlxHUpiPPs1jRYE3vhCRULvoFcLPFcxA
         1gM3vZ6XmLuuD3rIi9s15QQSwWxSZzm4NNBmm/+crHtwQ03PFecJ7UUjhYeaN5C5nJ
         zgwnR8Eh7LvbA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4981O6qlVVSE; Fri, 27 Mar 2020 11:02:40 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C3C242802DD;
        Fri, 27 Mar 2020 11:02:40 -0400 (EDT)
Date:   Fri, 27 Mar 2020 11:02:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lwn <lwn@lwn.net>
Message-ID: <1562486575.14695.1585321360704.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules and LTTng-UST 2.12.0-rc3 (International
 Stay At Home Month)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Index: d67Ht2LdRVRIUVf3IAX2GaaFUkAMGQ==
Thread-Topic: LTTng-modules and LTTng-UST 2.12.0-rc3 (International Stay At Home Month)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This release announcement of LTTng-modules 2.12.0-rc3 and LTTng-UST 2.12.0-rc3
comes at an interesting time, where the entire EfficiOS team bringing you this
release is working from home, following the physical distancing guidelines from
Quebec's government.

Those are likely the very last release candidates before we reach 2.12.0.
There has been very little issues on the tracer side recently, and open
issues which remained within LTTng tools are fixed in the 2.12-rc2 release.

The only bug fix [1] really worth mentioning here is a change to the way the
LTTng modules (kernel tracer) dumps the kernel file descriptor tables.
Because it adds/removes fields to LTTng events, it is only introduced within
LTTng-modules 2.12 and onwards, and not backported to prior LTTng versions.

The lttng_statedump_process_state event gains a new field "file_table_address"
to allow trace post-processing to distinguish between threads sharing the file
descriptor table (created with CLONE_FILES) and the relatively less common
scenario where they do not.

The lttng_statedump_file_descriptor event also gains a new "file_table_address"
field (which matches the addresses of the field with the same name in
lttng_statedump_process_state). The "pid" field is removed from the
lttng_statedump_file_descriptor event because it is semantically inaccurate.

Now that a large part of the world is sitting home trying not to get
infected and propagate COVID-19, you might as well use this time to
download and try the latest LTTng 2.12 release candidates.

Feedback is welcome!

Thanks, and please stay home,

Mathieu


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

[1] https://bugs.lttng.org/issues/1245

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
