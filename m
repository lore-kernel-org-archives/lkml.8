Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA992072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFtIJ+U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgC3TgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:36:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59610 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgC3TgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585596978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWTAjkjajdTnMmuVLUXHpOyNhDCt9s79bNubNzkpYiQ=;
        b=OFtIJ+U0zJbFJNClXoD6qsWYWxhSgSqWZAMxlMDkOrBT1kUEdn9FwT7qTdG/e5U/inedl8
        WfZG74DJRog/HUb7NKC6gL6Cr3Ev/0WrRE013nBjARjUaFlKYCTX8RPj+ncXWmaypN7y+d
        PmzexEM97faES2B/ZAEFfrG3hjNN/7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-xED46qSyP7eS7AxtU3CN4A-1; Mon, 30 Mar 2020 15:36:16 -0400
X-MC-Unique: xED46qSyP7eS7AxtU3CN4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8832D1005509;
        Mon, 30 Mar 2020 19:36:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1885D9E2;
        Mon, 30 Mar 2020 19:36:02 +0000 (UTC)
Date:   Mon, 30 Mar 2020 21:35:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v7 4/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200330193558.GD2490231@krava>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
 <20200327102528.4267-5-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327102528.4267-5-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:55:26PM +0530, Kajol Jain wrote:

SNIP

>  
>  %%
>  	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
> @@ -93,7 +106,7 @@ if		{ return IF; }
>  else		{ return ELSE; }
>  #smt_on		{ return SMT_ON; }
>  {number}	{ return value(yyscanner, 10); }
> -{symbol}	{ return str(yyscanner, ID); }
> +{symbol}	{ return str(yyscanner, ID, sctx->runtime_param); }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
>  "&"		{ return '&'; }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b905eaa907a7..66695b4a358d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -90,6 +90,7 @@ struct egroup {
>  	const char *metric_name;
>  	const char *metric_expr;
>  	const char *metric_unit;
> +	int param;

could you please use runtime_param everywhere? ... s/param/runtime_param/
or maybe just 'runtime' to keep it short..? it's param in any case ;-)

other than that it looks ok

jirka

