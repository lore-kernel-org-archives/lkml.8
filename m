Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA101C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C421B20936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttor3tIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgDQOmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:42:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:42:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x2so2132513qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csk45J3QlDVpXoqVtwNJG/cTe4Fq+3IpTiIDfUCZ1mk=;
        b=Ttor3tIAUPurJgffIemLwExuiPsGFWkkrkt5kFG2qInmuCyVPlEgjI8KvS19ACT5v9
         1Vlpj2EX4TjkKjSjH/MLn49FL0xcvvSX0nxQS1C3UC44xJhrpxMUG2Li2nV4FdO7oW3B
         lPMkurSrGf6qn+FI8C/KVb7mtEZjV4DDYcg38sE0lcFYixqG5NjUrnhdp3WBMUniqSER
         6vqI5Ev3y0XdwTZyivvDr1p41KpbMjlJqKVcPh79iOO7tuWBAFmodIpKl7GdG5YYm1RZ
         /iKY1dA1vXV2evZSXdvmdaCJ00r73IQD2w/x8AzcvueEF9sfX+o2yRppsqEG/67tqzoH
         FnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csk45J3QlDVpXoqVtwNJG/cTe4Fq+3IpTiIDfUCZ1mk=;
        b=a9GA0mftMZLuWq3PxE6x/c6QRo+tgskkTnF3mM2yl7s7LxdrMNxJ17GvMpp7ZjBGZS
         ItscRoImSWPxvfsNP5BSKwBZPDsYH0Uwh2SufvhMuyeuwraUJTz/hBSumyJjr6F45Cdo
         JRzVRRfcMjLElifU5K0MYT9I6tlpB1RJmJy0wm/NyNKTgEWbDnB0b0rrRfmaj2py6PWx
         5SozBmp4oqI2z8mcvu1lrppBy5YPHY3vOS4YX9/2D2c8nQgVwsVm4U/u27H58KsUN5pD
         Y/PSsu3NQvEbS0Pjc3k5SxvqvggMrav2GxLvf+ElWLM1gEsw63Y3WlFwiXOXB2KB/8B4
         qqVw==
X-Gm-Message-State: AGi0PuZPG5SBROz8D6+zxASdKrqZOS8XxNDxXhhjCb4yKFSH9h0LWXoY
        kIsU2cLi0P3GVp2Ew7rJs8g=
X-Google-Smtp-Source: APiQypKWetA2O6mQWofMkRo3Q2qH9bbBkCUwI3Qe9rcBAtuEzP44EW78Iy/1rvcgCssxLrgvGl3Dvg==
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr3363745qtw.185.1587134539172;
        Fri, 17 Apr 2020 07:42:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j14sm3396729qkk.92.2020.04.17.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 07:42:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ECB42409A3; Fri, 17 Apr 2020 11:42:15 -0300 (-03)
Date:   Fri, 17 Apr 2020 11:42:15 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 03/17] perf record: Clear HEADER_CPU_PMU_CAPS for non
 LBR call stack mode
Message-ID: <20200417144215.GA17973@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200319202517.23423-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319202517.23423-4-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 01:25:03PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The CPU PMU capabilities information is only useful for LBR call stack.
> Clear the feature for other perf record mode.

Humm, I think it is useful to have this extra piece of info in the
header in general, i.e. some user may want to know about these
capabilities when investigating some perf.data file on another machine,
etc, so I'l skip this patch for now.

- Arnaldo
 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4c301466101b..428f7f5b8e48 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1120,6 +1120,9 @@ static void record__init_features(struct record *rec)
>  	if (!record__comp_enabled(rec))
>  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
>  
> +	if (!callchain_param.enabled || (callchain_param.record_mode != CALLCHAIN_LBR))
> +		perf_header__clear_feat(&session->header, HEADER_CPU_PMU_CAPS);
> +
>  	perf_header__clear_feat(&session->header, HEADER_STAT);
>  }
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
