Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78552C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA36206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5494cAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgEDRGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728158AbgEDRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:06:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D04C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:06:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so5810683pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOLepqed3UQaNvtgfRJXbkhQgEQqrYEDd1UifYihdWI=;
        b=F5494cAVbA73+IZpCybURR8VGXi3uVGa8FLmiomSjkltiRQtXI6xL/jeGHk4AAlW5E
         Zd3tt+ZiuQAiYmlkCS8GUZ5Kk0Mucf73ZsKhYEuY2ovDsaDr8M0G7D5IBfPYa3mZCe+X
         +ACkS7l5lzkPT/mfjoPHwTTQgTSqRfA5EOFIKt1H1X5ZvS3cgc3+LB1p/sP6XZIT6wt0
         bhwzwq1XjRtzN+GZ20nx42/S14230YxxIg09Phgd+RZaJZdQH1UTYh3sTkKASVfGFsYW
         aDGHsZlruVpeA1T/ysH/Gy3ohccx1l0o4F7Mb9na2rwKmTl313cb0BT8wQ9wvxaF3q6T
         E+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOLepqed3UQaNvtgfRJXbkhQgEQqrYEDd1UifYihdWI=;
        b=hD8IU9MHwUPEPXqigRFmGWqNI36s0fbTyGbcgsBfKcH91Vy8oxFNXHG3zu3LehbWgH
         eUFpiUniC0+03Kk/1HDwogJsdQZwgzlLL7LgRIJNhUQr+QkrPxo3l9jVwj1RTpj2eXAS
         kFO7K1xz9BGtC5vbwwsyg7zqkaMjNiTYJzeE6GMq7oEN4p3cZcLcakoDsLCoD/zQKkP+
         e+O7pFj6HUIFwFuincw/NYgOXzuXobFDnak5f9ZXJ61Z4347Txpe5QsHRnBslapHX/Qi
         RlsntlbHGQw0n/tQm23/msioeGcoVXcT86SauQNowlfgflNZTseto9140PcO2Ax9V48S
         +aaw==
X-Gm-Message-State: AGi0Pua4mpFU077zPtmHf3xkxoV8JhH2zuQeyN+zZen6VIymHJYALvgw
        VPPeS/ewT2854vbc4rNWK3ZYtg==
X-Google-Smtp-Source: APiQypLOlELuFhW8RMXd2kyzGdHeTpdyD4q0k+CVpKadEQKfNWeZCLiYHpeQS2U74qxiNpEXZ3n+jQ==
X-Received: by 2002:a63:a36f:: with SMTP id v47mr13065286pgn.242.1588611981346;
        Mon, 04 May 2020 10:06:21 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o9sm48674pjp.4.2020.05.04.10.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:06:20 -0700 (PDT)
Date:   Mon, 4 May 2020 11:06:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Subject: Re: [PATCH v2] perf: cs-etm: Update to build with latest opencsd
 version.
Message-ID: <20200504170618.GA517@xps15>
References: <20200501143615.1180-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501143615.1180-1-mike.leach@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
>  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
>  	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
> -- 
> 2.17.1
> 
