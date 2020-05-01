Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B4FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AEC20708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkecYhP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgEAPWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgEAPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:22:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ACBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:22:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so20151pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYtv1/voo7jDhfbxmnTy0yEnA7g2pq+CR4hTVmEAPqc=;
        b=rkecYhP8b6Qty2Gq1WbmprQqMuIPysQOrCwoH0d+IMetvB3POV1UqkP0+xWnrmHjtl
         +9idov6Acpw2GO0U1wa6IhnXy3L+m28ZkbNB8Rfus3nmMOeFtQF8CM+B2K4+GMhVjixY
         +vAHn4gP27yXJDZhIOsqtolFZzjZxs2XHG49sDqTetBi18h3EG6E1QtORULhMZHPRwh1
         flKTwi2/j2TCpXPtim/FFBR1il5TQfRPiELjWLDeBqHzs9KKSFvX2MdDJVwlPauY2Umc
         2Ed0CiR2t8WBwnqDAG7pTGquY/PGGOeu0g9Un34LmLvdU7hyUtk6k6ogHppnedANk+SK
         +QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYtv1/voo7jDhfbxmnTy0yEnA7g2pq+CR4hTVmEAPqc=;
        b=PocTMXZT76W2JII1KA1iy/l6RVarcy5IGN4c+zrHPbyQoz4Hn6jbuOEL42n8566d+R
         OwnZq59Nz74qAL9fzNlJCRTdY582m7h2ASQDEhpmN1MDkmrO3t09WJNdK9mbZV0iw1P/
         b0vflJYPkbYQbo9Ab312jm1LALXX1vsaHMefL1EXUOGLJ6ClCbY3EDwraVrr0LrLP/er
         SnvLYKppROk4Cg66wJouSuiIkiNZB7qRZfyvrh2UE3O+wxw5/iIqblunhCJL8xkn3wEa
         W/tyC7etljv24/wH/DhBVODiZdBzDw80VlyWmH2F45XFncYeMrpy/dJEqqowb0tYEKRE
         WhMA==
X-Gm-Message-State: AGi0PuZQ7sjY5WR9xasoEGkFIWkc4bdWrGLo1A6lG5lm2qHI4k6JZ59X
        e05MAKOnbR9YL2BtVDeCH0lLXg==
X-Google-Smtp-Source: APiQypI/QjBHEDdnzOAMmpWQ5qTYvHgTE81LPIrw2zKRFWqErybHIncvoiytu4+aq1rS9YKiLAbkMA==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr87601pjs.17.1588346525878;
        Fri, 01 May 2020 08:22:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id k12sm2285858pgj.33.2020.05.01.08.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 08:22:05 -0700 (PDT)
Date:   Fri, 1 May 2020 23:22:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Subject: Re: [PATCH v2] perf: cs-etm: Update to build with latest opencsd
 version.
Message-ID: <20200501152202.GB9650@leoy-ThinkPad-X240s>
References: <20200501143615.1180-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501143615.1180-1-mike.leach@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:36:15PM +0100, Mike Leach wrote:
> OpenCSD version v0.14.0 adds in a new output element. This is represented
> by a new value in the generic element type enum, which must be added to
> the handling code in perf cs-etm-decoder to prevent build errors due to
> build options on the perf project.
> 
> This element is not currently used by the perf decoder.
> 
> Perf build feature test updated to require a minimum of 0.14.0
> 
> Tested on Linux 5.7-rc3.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Looks good to me, FWIW:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/build/feature/test-libopencsd.c           | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 2b0e02c38870..1547bc2c0950 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
> +#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 0.11.0 is required"
> +#error "OpenCSD >= 0.14.0 is required"
>  #endif
>  
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cd92a99eb89d..cd007cc9c283 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -564,6 +564,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
>  					       elem, trace_chan_id);
>  		break;
> +	/* Unused packet types */
> +	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
>  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
>  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
>  	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
> -- 
> 2.17.1
> 
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
