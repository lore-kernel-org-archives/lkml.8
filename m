Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09734C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6E121527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVSYAf8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFQKhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:37:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45811 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgFQKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592390228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+76RBm2rdDCRUK0E1Dtw0hXTnElRxA512NWs4Bw2rA=;
        b=eVSYAf8NmQjm8yUj4GeQ5PuXm3p2EkOpZmwJcoTU/I51dp0DclKN3uN07j5Spdt6i15Hhm
        b8YvZReGTMi4l5955AQvtkIhG4LRQ0wvRxWvEdYPR5NwUyp70NzW8gkTAmbhFzS3ZMYrn4
        67Re0bLadPxk5D+nc8gZ5zR1QE86aOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-P8SjbLLqNwOkZETISR0NRw-1; Wed, 17 Jun 2020 06:37:04 -0400
X-MC-Unique: P8SjbLLqNwOkZETISR0NRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC2B88B1595;
        Wed, 17 Jun 2020 10:36:41 +0000 (UTC)
Received: from krava (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id E91D35D9E4;
        Wed, 17 Jun 2020 10:36:38 +0000 (UTC)
Date:   Wed, 17 Jun 2020 12:36:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        irogers@google.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf: Improve list for arm64
Message-ID: <20200617103637.GD2210496@krava>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 05:01:52PM +0800, John Garry wrote:
> This couple of patches provides:
> - aliases for arm64 CPU core events in perf list, like x86
> - ensures that CPU core events are not sparsely listed
> 
> Differences to v1:
> - Add ack from Namhyung Kim (thanks)
> - use more concise logic in patch 2/2 and also add comment
> 
> John Garry (2):
>   perf pmu: List kernel supplied event aliases for arm64
>   perf pmu: Improve CPU core PMU HW event list ordering

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/util/pmu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> -- 
> 2.26.2
> 

