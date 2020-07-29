Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A6A2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcoiY9ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgG2GaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2GaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:30:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE33C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:30:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so13719195pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5XjxR2D1PW7z/hEvGpFV0uhjH8JAxZgxGwL9HK9m6g=;
        b=gcoiY9ryexJmt9Xbw9Z4LmrJzGJKAEjz1Ay4NOJDdQleL7RVf095EkO81BF6Z7pk9n
         nTKHUOI83St7IPdp0OacljP60pvjFh2hIT6VMp8ERRbCBx9781TW9CWH3u5mZTWSumqr
         kpC54wZjgdKUmOGrdQ3Cx8qoy9SFmzk32B5m6S1ALJ2CQd34iNe1MeG5uevtfBZh/kRy
         TchIstHf7rdFYlP4Vm7jdvlMatfKrcrksMdzFLIovhGO08TRJF+r65Q+ZD8+8GJxZ6MC
         UX3egGLFjYu4oO3KOsEI9LMfSrrDtQ0l1lsm0t1X++DAyNCQA6nURQcOz9IdqKBY0B9w
         jaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5XjxR2D1PW7z/hEvGpFV0uhjH8JAxZgxGwL9HK9m6g=;
        b=PFGfsLg0EuYHt8oZtA0KuzAJXYkZ8VPNIJYZ05A9ufTzT+YqdAtwIn4D5glVaXlEIT
         NMw3C+jWZEtffG3mSn2nF1ijgwuMh700R7tEuFuQ7JY6Ykw2lQLOm9jeQ7CtWkugnvhU
         MJoKBf1QIaCGHhZtlcQxJI8AdoXtSKLNuscFvVOI4Vu1Ma8nUmzz2cBvKHNd7SwwfP6C
         LSqNA2L1R+J1eh3YW6JIEgjTakbe3LSk6d/elI/zAfCWuPwxcMzK46Y81msxRsymA1I6
         g5VnePZ6B69vOIz+ITmpOQo3zYuQOuJ++0mziabpVXRZwaL/YSx6Dqdf4RYrvgz5Q7W2
         rm0w==
X-Gm-Message-State: AOAM531uKYqhVnz9UckekzYJjYQH72j8N4gUA5NlnEST3lK0b35YgPB3
        lyeFxtqqgqX9j4qlbuHwVW5v4w==
X-Google-Smtp-Source: ABdhPJyLktvCVbk2dFjHebImqHL42LIfVPyfToDmVIO7TNTSaAWvpylf4CgEOc8S2E+lSEFauxtw6w==
X-Received: by 2002:aa7:970a:: with SMTP id a10mr29301103pfg.319.1596004204749;
        Tue, 28 Jul 2020 23:30:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z67sm1186482pfc.162.2020.07.28.23.29.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 23:30:03 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:29:51 +0800
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
Message-ID: <20200729062951.GE4343@leoy-ThinkPad-X240s>
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

This comment description is not relevant with the changes in this
patch, so could remove them.

> Add the corresponding decode process of Events packet and Operation Type
> packet in perf tool.

This patch is to add the raw dumping for Events packet and Operation Type
packet.

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

Correct.

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

Some nitpicks for packet format checking ...

For SVE operation, the payload partten is: 0b0xxx1xx0.

So it's good to check the partten like:

  /* SVE operation subclass is: 0b0xxx1xx0 */
  if ((payload & 0x8081) == 0x80) {
     ....
  }

If later the packet format is extended, this will not introduce any
confliction.

> +				size_t blen = buf_len;
> +
> +				ret = snprintf(buf, buf_len, "SVE-OTHER");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x2) {

Here should express as binary results: " FP" or " INT".

> +					ret = snprintf(buf, buf_len, " FP");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");

Here should express as binary results: " PRED" or " NOT-PRED".

> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x70) {

This is incorrect.  If bits[6:4] is zero, it presents vector length is 32 bits.

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

Here we can check with more accurate format as defined in ARMv8 ARM:

  /* Other operation subclass is: 0b0000000x */
  if ((payload & 0xfe) == 0x0) {
     ....
  }

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

Here should express as binary results: " PRED" or " NOT-PRED".

> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x70) {

This is incorrect.  If bits[6:4] is zero, it presents vector length is 32 bits.

> +					ret = snprintf(buf, buf_len, " EVL %d",
> +						32 << ((payload & 0x70) >> 4));
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x80) {
> +					ret = snprintf(buf, buf_len, " SG");

Here should express as binary results: " SG" or " NOT-SG".

Thanks,
Leo

> +					buf += ret;
> +					blen -= ret;
> +				}



>  			}
>  			if (ret < 0)
>  				return ret;
> -- 
> 2.17.1
> 
