Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D57C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB38204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWxoyMUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgHQPE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHQPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:04:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32BC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:04:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so7819192pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UaBLznpKDizTNge1awPErBrIaArrL3hCJFbh4AaJehU=;
        b=KWxoyMUOnwQx5kHVtG+SdXctCilm+x7Xq2sJZFbvuIJG5UKFULhqkRWg0gA+zOQplX
         DCfi/4EcxZASN/ENMwBPcVlUZ1BwbFKODvKErpRQ+Bfs44HoRclZU/VfoSvt0likvxT5
         52JpgEth/2YyqABO8XqP5qdxrpapoOj3siisL5gdhuhEEL72clmMIxOBlKkh+TxQgJH0
         dolAJWq5O61xSNxRgb4cQQ2VYIZ1uUf2ilSXz7Mx9qwoFmzzM1Sn64O0R0CV5EmMhRqS
         h7XPOzpG5Q+7GdsBSsBXh7hY07ehLqtgxgvmJSBC5IlzZHj1Be5+h0QCQX2vNPDbZ8eP
         WVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UaBLznpKDizTNge1awPErBrIaArrL3hCJFbh4AaJehU=;
        b=JQBCrILwDn7yefm2KnKslFB6sqtuOuiNsu+IEJCm6zD1WzfmhK8nPuoyE9/fBAa9wS
         6FsIn1vxixWFYRDUI8cbjpu12Nc55UoCEPRav0NtKPbXhT4tlR50sZVEE5FT40J8WL+7
         bRkdjIN3bu2rmDIX5A/ug0jPHoyGhzwxqlm3QzlXTKGmUVetB/JyKEOYPlPBCm20qHGl
         RWHEDIquAo5Fc1rOgxu+sNwPXXmykPgLOsXYuXYR0WtjS6f5F1hlL3t5IYkzG6g7GZkG
         WMejros1+ia2U5DU94qZ/zKy8j2I0SpVMrwQoP3+AlHCtjgVV3Ib0cxdYaUEsFdz3WPv
         QNVA==
X-Gm-Message-State: AOAM5317DShul/ADruwPNyo66h/Fd2QBtRRulBVzqMQBEgz12ovdrnk3
        yZmpDXA5FTPkLrx/JvACTFrEYQ==
X-Google-Smtp-Source: ABdhPJze8Z66pqu3BzApDswHS9kV1EI/PpT+KyHOZ5POINjJegP+j4aXuLJ7/ZEvXGJxsHmRIILDaw==
X-Received: by 2002:a17:90a:6f85:: with SMTP id e5mr12732312pjk.128.1597676696150;
        Mon, 17 Aug 2020 08:04:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 30sm18184680pjz.24.2020.08.17.08.04.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 08:04:55 -0700 (PDT)
Date:   Mon, 17 Aug 2020 23:04:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 2/4] perf: arm-spe: Add support for ARMv8.3-SPE
Message-ID: <20200817150444.GA7927@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-3-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091607.41903-3-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Fri, Jul 24, 2020 at 05:16:05PM +0800, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>   using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>   packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>   and filtering on these events using PMSEVFR_EL1.
> 
> Add the corresponding decode process of Events packet and Operation Type
> packet in perf tool.

Since I am refactoring the Arm SPE decoding and dumping flows, based
on new introduce macro definitions for packet format, I also improved
your this patch and combined it into the refactoring patch set, hope
this is okay for you.  Please review the updated patch:

https://lore.kernel.org/patchwork/patch/1288413/

Thanks,
Leo

> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 69 ++++++++++++++++++-
>  1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index b94001b756c7..10a3692839de 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -347,6 +347,24 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  				blen -= ret;
>  			}
>  		}
> +		if (idx > 2) {
> +			if (payload & 0x800) {
> +				ret = snprintf(buf, buf_len, " ALIGNMENT");
> +				buf += ret;
> +				blen -= ret;
> +			}
> +			if (payload & 0x20000) {
> +				ret = snprintf(buf, buf_len, " SVE-PRED-PARTIAL");
> +				buf += ret;
> +				blen -= ret;
> +			}
> +			if (payload & 0x40000) {
> +				ret = snprintf(buf, buf_len, " SVE-PRED-EMPTY");
> +				buf += ret;
> +				blen -= ret;
> +			}
> +		}
> +
>  		if (ret < 0)
>  			return ret;
>  		blen -= ret;
> @@ -354,8 +372,38 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	}
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> -					"COND-SELECT" : "INSN-OTHER");
> +		case 0:	{
> +			if (payload & 0x8) {
> +				size_t blen = buf_len;
> +
> +				ret = snprintf(buf, buf_len, "SVE-OTHER");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x2) {
> +					ret = snprintf(buf, buf_len, " FP");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x70) {
> +					ret = snprintf(buf, buf_len, " EVL %d",
> +						32 << ((payload & 0x70) >> 4));
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (ret < 0)
> +					return ret;
> +				blen -= ret;
> +				return buf_len - blen;
> +			} else {
> +				return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> +						"COND-SELECT" : "INSN-OTHER");
> +			}
> +		}
>  		case 1:	{
>  			size_t blen = buf_len;
>  
> @@ -385,6 +433,23 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  				ret = snprintf(buf, buf_len, " SIMD-FP");
>  				buf += ret;
>  				blen -= ret;
> +			} else if (payload & 0x8) {
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x70) {
> +					ret = snprintf(buf, buf_len, " EVL %d",
> +						32 << ((payload & 0x70) >> 4));
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x80) {
> +					ret = snprintf(buf, buf_len, " SG");
> +					buf += ret;
> +					blen -= ret;
> +				}
>  			}
>  			if (ret < 0)
>  				return ret;
> -- 
> 2.17.1
> 
