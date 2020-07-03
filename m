Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73922C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346CC20656
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJX/ZDpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCKzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:55:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgGCKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593773717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IW9MFSLhUfDzQ2wP5O2FCe1qiiypACsJ5yjAx966nYo=;
        b=AJX/ZDpzOOzMOYLqjX4PNfjqCJ12fITsnCs/zG7ZZm51nYSVqxjk8r863OuIVd1uHw53qR
        gIeueWYUM33x2bUz3QT3c27D6PcmzUSli/92J0v9u2JNrDiuGBWFaQRpvheSvErUE+xgdJ
        +X7If+Vy3AA15bAr2nrgnNSdE6in8ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-7-r6tVuaPjK61oEM1NoQEg-1; Fri, 03 Jul 2020 06:55:14 -0400
X-MC-Unique: 7-r6tVuaPjK61oEM1NoQEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C740107ACCD;
        Fri,  3 Jul 2020 10:55:12 +0000 (UTC)
Received: from krava (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA3347BD40;
        Fri,  3 Jul 2020 10:55:10 +0000 (UTC)
Date:   Fri, 3 Jul 2020 12:55:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/2] perf tools: minor fixes regarding macro usage
Message-ID: <20200703105509.GB3261456@krava>
References: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:25:19AM +0300, Emmanouil Maroudas wrote:
>     Hello,
> 
>     Here are some minor fixes for perf tools regarding *SEC_PER*SEC macro usage,
>     found while reading the code.
> 
>     Patch 1 replaces a macro with a more suitable one (same value, different name).
>     Patch 2 converts some hardcoded values (which seem appropriate IMHO) with their
>     respective macros.
> 
>     Based on v5.8-rc3.
> 
>     No functionality change. The final perf binary is the same, before and after
>     these patches.
> 
>     Thanks,
>     Emmanouil Maroudas
> 
> Emmanouil Maroudas (2):
>   perf stat: use proper macro for time conversions
>   perf tools: use *SEC_PER_*SEC macros

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/builtin-record.c |  2 +-
>  tools/perf/builtin-stat.c   | 12 ++++++------
>  tools/perf/builtin-trace.c  |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> -- 
> 2.17.1
> 

