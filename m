Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB2CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E303720675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6+ZFFyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBLMYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:24:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgBLMYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581510272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02thXXwKdJdsWCJDCArtijKBLWpAxcSktpwDL3W1img=;
        b=O6+ZFFyDv209It3TLuWjxCfF2xerSP+0KZ6yfTf8kITUWgoz6uAHeO7OT4IFUv/ybfTB3f
        LhgqVvfJlenaqUSHSJPOZQF9qSu8Mh648shloa+YTtv5lKG1AZZo3fVnlI4o9bgrZiy0i2
        wDXyAE7RLEsbO2DUVchC/dpAW9DJzW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-77atQPJLNDai5_pK6bL6CQ-1; Wed, 12 Feb 2020 07:24:30 -0500
X-MC-Unique: 77atQPJLNDai5_pK6bL6CQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74AA71005512;
        Wed, 12 Feb 2020 12:24:29 +0000 (UTC)
Received: from krava (ovpn-204-247.brq.redhat.com [10.40.204.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40A505D9E2;
        Wed, 12 Feb 2020 12:24:28 +0000 (UTC)
Date:   Wed, 12 Feb 2020 13:24:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 0/4] perf tools: Add support for some spe events and
 precise ip
Message-ID: <20200212122425.GA194466@krava>
References: <20200210122509.GA2005279@krava>
 <20200211140445.21986-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211140445.21986-1-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:04:41PM +0000, James Clark wrote:
> Hi Jirka,
> 
> Oops. I've removed all the changes to evlist.c and evsel.h

hi,
it looks ok from my POV, but I don't follow auxtrace that much

Adrian,
it's changing some generic bits of the auxtrace framework,
could you please check?

thanks,
jirka

> 
> 
> James
> 
> Tan Xiaojun (4):
>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>   perf tools: Add support for "report" for some spe events
>   perf report: Add SPE options to --itrace argument
>   perf tools: Support "branch-misses:pp" on arm64
> 
>  tools/perf/Documentation/itrace.txt           |   5 +-
>  tools/perf/arch/arm/util/auxtrace.c           |  38 +
>  tools/perf/builtin-record.c                   |   5 +
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 ++++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
>  .../arm-spe-pkt-decoder.c                     |   0
>  .../arm-spe-pkt-decoder.h                     |   2 +
>  tools/perf/util/arm-spe.c                     | 756 +++++++++++++++++-
>  tools/perf/util/arm-spe.h                     |   3 +
>  tools/perf/util/auxtrace.c                    |  13 +
>  tools/perf/util/auxtrace.h                    |  14 +-
>  13 files changed, 1089 insertions(+), 41 deletions(-)
>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)
> 
> -- 
> 2.17.1
> 

