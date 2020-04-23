Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC242C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E1120736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1U3VKju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgDWL3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:29:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728092AbgDWL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587641358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SjM7KaiBYriqKkcfDY1yHbo7APq5KrXwowHweSnF8pk=;
        b=K1U3VKjuKsREwtfZr3D5xVLgVRr66AogImoS1vjB4gNZyu3Tg93fAXdT+SCSbJOPSCfjQO
        CnIqDkig/aZq7Ng9+xNpGKD1ZBfkcMWfYRFhmIl4vliL6/aqWbe6VxYPJC/Am2Zhu7dB0r
        iOKrmLuTDQ4cDGV/eJUOOvNChymS5do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-CMYBw69wO6G0YAkXP-ehCA-1; Thu, 23 Apr 2020 07:29:14 -0400
X-MC-Unique: CMYBw69wO6G0YAkXP-ehCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E3728005B7;
        Thu, 23 Apr 2020 11:29:11 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 844091053B1E;
        Thu, 23 Apr 2020 11:29:07 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:29:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 01/11] perf expr: unlimited escaped characters in a
 symbol
Message-ID: <20200423112905.GG1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:20PM -0700, Ian Rogers wrote:
> Current expression allows 2 escaped '-,=' characters. However, some
> metrics require more, for example Haswell DRAM_BW_Use.
> 
> Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 2582c2464938..95bcf3629edf 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -73,7 +73,7 @@ number		[0-9]+
>  sch		[-,=]
>  spec		\\{sch}
>  sym		[0-9a-zA-Z_\.:@]+
> -symbol		{spec}*{sym}*{spec}*{sym}*
> +symbol		({spec}|{sym})+

yep, much better ;-)

thanks,
jirka

>  
>  %%
>  	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

