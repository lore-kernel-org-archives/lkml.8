Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352D62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glV6G4yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgG2H24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2H2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:28:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173FC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:28:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so11418936pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EJr/zTDFzZfQRmZS6ci7CqEyuf2WF4U9auGGGduBo5I=;
        b=glV6G4yF/ctOKkutWvrjdnMnG74hlw+iQArwph1Do5y5F/pCCoo0Ifg5//DTx+3kys
         P+WAQYeFVytmcxP/5t8WiCVBl8hklDLIsEDbl/YQOwZsMGg6+GIxxEA52i9nWws5YvGm
         m5CWQTVRNUJLwtj0q+CBV5dLM6X8kjQR7Q1NHjXuT0uSJ35hT37xXWnEskgZ054j/ZFk
         +FjE6H8JC0htoFVSRJ5bmG/qg6//aqQB+kSncDfpPKVfK1TALRK1lMuogqpWpi6kiadn
         0sjEmpZ2P35alY/uXNHexlgKVJdU4tXfNXPZZpyvOMNNJZM/x0CrFRGLkCZzOBH9Uehv
         hFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EJr/zTDFzZfQRmZS6ci7CqEyuf2WF4U9auGGGduBo5I=;
        b=o/NzIF6Q6zoFNGMUTJQYTS11hvFh0M63cRZN9MBv21soQt9OHLVIsnocomOu+WNzPG
         yFkSRDC7nYvLxEn9e3cgkPjV69Lpi0X2O2T2G11XmlYBK0aEyIYXjsw4jzdVBwmAs9Jb
         lHOCCThUAhFIM8lk3tsK730vDcDqm9qTxSXbypr2fjhYFPUmnosyTLa1hDslTU3JZSD8
         USV8xHwhAeIijAUniQTZ6gdA2t2ZJVa+1F8OeKuwKM7AL225+U1Q9wf5KHNxr/5NhP2i
         B/bmia57ZWAo6VznJGjDOMm4yEyxyMVPlLxPGaveAV5aIlxZsTbDWdqDubMwyXedpc9F
         0lUA==
X-Gm-Message-State: AOAM530i+bFpjcNfUBa59JuhH31+1//vPFuAXwc30YKlj8Y2K41X52Kd
        xeCZBB8/RLCYoibZAkb6vzQQKA==
X-Google-Smtp-Source: ABdhPJzQi3/n+N6dk4WNX9b8fO92IseRXtdS3tuBiUnMzRWekyfUXvYe3hhlDfh5IEzIinAQo+q/Cg==
X-Received: by 2002:a17:90a:e986:: with SMTP id v6mr4700183pjy.88.1596007733700;
        Wed, 29 Jul 2020 00:28:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 17sm1191144pjl.30.2020.07.29.00.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 00:28:53 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:28:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "liwei (GF)" <liwei391@huawei.com>
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
Message-ID: <20200729072844.GH4343@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-3-liwei391@huawei.com>
 <20200729062951.GE4343@leoy-ThinkPad-X240s>
 <a8f9df67-adf1-09e7-b117-ff4163cc2a03@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f9df67-adf1-09e7-b117-ff4163cc2a03@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:21:20PM +0800, liwei (GF) wrote:

[...]

> >> @@ -354,8 +372,38 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>  	}
> >>  	case ARM_SPE_OP_TYPE:
> >>  		switch (idx) {
> >> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> >> -					"COND-SELECT" : "INSN-OTHER");
> >> +		case 0:	{
> >> +			if (payload & 0x8) {
> > 
> > Some nitpicks for packet format checking ...
> > 
> > For SVE operation, the payload partten is: 0b0xxx1xx0.
> > 
> > So it's good to check the partten like:
> > 
> >   /* SVE operation subclass is: 0b0xxx1xx0 */
> >   if ((payload & 0x8081) == 0x80) {
> >      ....
> >   }
> > 
> > If later the packet format is extended, this will not introduce any
> > confliction.
> 
> Get it, but i think what you are really meaning is:
> if ((payload & 0x89) == 0x80) {
> 	...
> }

Yes.

> > 
> >> +				size_t blen = buf_len;
> >> +
> >> +				ret = snprintf(buf, buf_len, "SVE-OTHER");
> >> +				buf += ret;
> >> +				blen -= ret;
> >> +				if (payload & 0x2) {
> > 
> > Here should express as binary results: " FP" or " INT".
> 
> I think this is a style choice, i add these just like the current code where
> processing "AT", "EXCL", "AR", "COND" and so on. So should we modify all the corresponding code together?

Okay, understood.  Let's just follow the existed style and later can
enhance the output log with more readable format.

[...]

> > 
> >> +					ret = snprintf(buf, buf_len, " FP");
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				if (payload & 0x4) {
> >> +					ret = snprintf(buf, buf_len, " PRED");
> > 
> > Here should express as binary results: " PRED" or " NOT-PRED".
> 
> Ditto.
> 
> > 
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				if (payload & 0x70) {
> > 
> > This is incorrect.  If bits[6:4] is zero, it presents vector length is 32 bits.
> >
> 
> I am a little confused here.
> Refer to the ARM DDI 0487F.b (ID040120), page D10-2830, if bits[6:4] is zero,
> it presents vector length is 32 bits indeed.

Yes, if bits[6:4] is zero, your current code will not output any info.

Thanks,
Leo

> >> +					ret = snprintf(buf, buf_len, " EVL %d",
> >> +						32 << ((payload & 0x70) >> 4));
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				if (ret < 0)
> >> +					return ret;
> >> +				blen -= ret;
> >> +				return buf_len - blen;
> >> +			} else {
> > 
> > Here we can check with more accurate format as defined in ARMv8 ARM:
> > 
> >   /* Other operation subclass is: 0b0000000x */
> >   if ((payload & 0xfe) == 0x0) {
> >      ....
> >   }
> > 
> >> +				return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> >> +						"COND-SELECT" : "INSN-OTHER");
> >> +			}
> >> +		}
> >>  		case 1:	{
> >>  			size_t blen = buf_len;
> >>  
> >> @@ -385,6 +433,23 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>  				ret = snprintf(buf, buf_len, " SIMD-FP");
> >>  				buf += ret;
> >>  				blen -= ret;
> >> +			} else if (payload & 0x8) {
> >> +				if (payload & 0x4) {
> >> +					ret = snprintf(buf, buf_len, " PRED");
> > 
> > Here should express as binary results: " PRED" or " NOT-PRED".
> 
> Ditto.
> 
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				if (payload & 0x70) {
> > 
> > This is incorrect.  If bits[6:4] is zero, it presents vector length is 32 bits.
> 
> Refer to the ARM DDI 0487F.b (ID040120), page D10-2832, if bits[6:4] is zero,
> it presents vector length is 32 bits indeed.
> 
> >> +					ret = snprintf(buf, buf_len, " EVL %d",
> >> +						32 << ((payload & 0x70) >> 4));
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				if (payload & 0x80) {
> >> +					ret = snprintf(buf, buf_len, " SG");
> > 
> > Here should express as binary results: " SG" or " NOT-SG".
> 
> 
> Thanks,
> Wei
