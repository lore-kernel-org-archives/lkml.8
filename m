Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0ADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA192467B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6x2xfaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgA3QCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:02:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgA3QCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580400154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2h2hq7aU9+X9eHNNsNlRzeknf9MFrD4dJBNBLwX04Tw=;
        b=I6x2xfawWQjq+AvJoE3Nsw22CDyq1GV1axglaY7ObFcwGxo7vSvsbPbe+r3dP7eP+CGRNK
        iVXYE5atrL1y7Vjr4N8uSsJ80lUCk82lrsZop+jENAHwJ0bTrxd2+E4Ze8YncGueOaEz1P
        P31N8/2L9ZfqVA/WCYSktJuftzm92Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-taTMYylWMsGDtBpDOXGRBg-1; Thu, 30 Jan 2020 11:02:29 -0500
X-MC-Unique: taTMYylWMsGDtBpDOXGRBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F15DB25;
        Thu, 30 Jan 2020 16:02:27 +0000 (UTC)
Received: from krava (ovpn-206-54.brq.redhat.com [10.40.206.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D124D10018FF;
        Thu, 30 Jan 2020 16:02:24 +0000 (UTC)
Date:   Thu, 30 Jan 2020 17:02:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 0/4] perf: Refactor the block info implementation
Message-ID: <20200130160221.GB1323504@krava>
References: <20200128125556.25498-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128125556.25498-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 08:55:52PM +0800, Jin Yao wrote:
> This patch series refactors the block info functionalities to let them
> be used by other builtins and allow setting the output fmts flexibly.
> 
> It also supports the 'Sampled Cycles%' and 'Avg Cycles%' printed in
> colors.
> 
>  v5:
>  ---
>  Only change the patch "perf util: Flexible to set block info output formats".
>  Other patches are not changed.
> 
> Jin Yao (4):
>   perf util: Move block_pair_cmp to block-info
>   perf util: Validate map/dso/sym before comparing blocks
>   perf util: Flexible to set block info output formats
>   perf util: Support color ops to print block percents in color

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/builtin-diff.c    | 17 -------
>  tools/perf/builtin-report.c  | 21 ++++++--
>  tools/perf/util/block-info.c | 99 ++++++++++++++++++++++++++----------
>  tools/perf/util/block-info.h |  9 +++-
>  4 files changed, 99 insertions(+), 47 deletions(-)
> 
> -- 
> 2.17.1
> 

