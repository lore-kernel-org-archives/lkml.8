Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABF4C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1E208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etGhjExw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBTLjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:39:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgBTLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582198776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65azVoQTkiBxYIIGWnRhyuI479FEvbLqbTexlaKEWfQ=;
        b=etGhjExwAtCuRqAti2Buu6qyfzM/R5Dk/RoKyatXY5Wt9Ka0w8+Pi5SPahORYdrHOp9Uwd
        HmLNmijCnLUHiDoWAN+/AK/HF0C9UFr89Dg3mJPjDsvjnXrL1hmY+VFj/RHHJMDOmC7eO0
        Z6Q/uTFVm93PSbSZEl6ERM7x3dBj1VE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-kLrUMjIuM_CrQFFILUFRAQ-1; Thu, 20 Feb 2020 06:39:30 -0500
X-MC-Unique: kLrUMjIuM_CrQFFILUFRAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3156718C35A0;
        Thu, 20 Feb 2020 11:39:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 261B890F79;
        Thu, 20 Feb 2020 11:39:26 +0000 (UTC)
Date:   Thu, 20 Feb 2020 12:39:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 0/5] Support metric group constraint
Message-ID: <20200220113924.GB565976@krava>
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:08:35AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Some metric groups, e.g. Page_Walks_Utilization, will never count when
> NMI watchdog is enabled.
> 
>  $echo 1 > /proc/sys/kernel/nmi_watchdog
>  $perf stat -M Page_Walks_Utilization
> 
>  Performance counter stats for 'system wide':
> 
>  <not counted>      itlb_misses.walk_pending       (0.00%)
>  <not counted>      dtlb_load_misses.walk_pending  (0.00%)
>  <not counted>      dtlb_store_misses.walk_pending (0.00%)
>  <not counted>      ept.walk_pending               (0.00%)
>  <not counted>      cycles                         (0.00%)
> 
>        2.343460588 seconds time elapsed
> 
>  Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>  The events in group usually have to be from the same PMU. Try
>  reorganizing the group.
> 
> A metric group is a weak group, which relies on group validation
> code in the kernel to determine whether to be opened as a group or
> a non-group. However, group validation code may return false-positives,
> especially when NMI watchdog is enabled. (The metric group is allowed
> as a group but will never be scheduled.)
> 
> The attempt to fix the group validation code has been rejected.
> https://lore.kernel.org/lkml/20200117091341.GX2827@hirez.programming.kicks-ass.net/
> Because we cannot accurately predict whether the group can be scheduled
> as a group, only by checking current status.
> 
> This patch set provides another solution to mitigate the issue.
> Add "MetricConstraint" in event list, which provides a hint for perf tool,
> e.g. "MetricConstraint": "NO_NMI_WATCHDOG". Perf tool can change the
> metric group to non-group (standalone metrics) if NMI watchdog is enabled.

the problem is in the missing counter, that's taken by NMI watchdog, right?

and it's problem for any metric that won't fit to the available
counters.. shouldn't we rather do this workaround for any metric
that wouldn't fit in available counters? not just for chosen
ones..?

thanks,
jirka

