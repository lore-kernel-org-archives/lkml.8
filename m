Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50582C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248A021841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQNvpU+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgDQCLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:11:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D600C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:11:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g2so392008plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ef3EavB2w1X9h4uH+JNa4JPXZ9W1ja0BOge+XoHtx1k=;
        b=fQNvpU+DK7jSBwnFkiBNvYsSVV0LjRinwCANVNVip3ffSFN24tXtxMka/lwY3x/iyN
         7JoKEIHLj4t/o93KSn1emvRI7BwJEWPcCeUeNfarJLDI25f3n5OrA8QJ0GAGn5DbquvV
         CF8ddu95yQxl5jN8EPdwo97trGQSfaPVNvbyW70f5iiCiXXbehcAwsjNbqIegL91H6Xk
         IjJ+uUSaqfb+3epWAfAB5Ig/q96YTgrSD/7CtnGvvqZxVv5jC2Y+LioSf/+pSXA30Z2l
         djjJucy3kMKwrSVWOilbQECm+hAUEW8aQxY4VX5+4K3hLLhjcldGa9TUydmgkOFgVchh
         EmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ef3EavB2w1X9h4uH+JNa4JPXZ9W1ja0BOge+XoHtx1k=;
        b=UprNmCL7h3lyC1aapyLdgtmW6EztlzAv6TMG+to4MwmPfHIaSMnyxGxmyRQfmYKGiY
         6O1IslgKDSu6LnlhwvdQ42YiNRhTxXvuElnoXly4rDmhX+GIBf6bdNXFe92RBTVz87kj
         AI3WkkDDNVOM01RPSgOCZSQbaaaops06oaU4NKezsc2+kSrHgh7h5vsGDD+yHpPI3Tfd
         ORbru9HxZZPXb/pkXqvSuPiCN5Zsu27ANLp/xSAYoM5DAYHDsH6Vv6x/nNmkKHzZmSoB
         vmo097tKc7Xka9kPlwD4hdeaDYWx+bHeeLAWMtwQa4etHQO9P5Szoepe76pZkby9AVYt
         WUpg==
X-Gm-Message-State: AGi0PuYsqlxk9fP/V6p+hwl/wMgd1Kyj1TnSjFGiwr75TQREJLbTw/b/
        a/fn0W5FlAh+NsSSrtACXvR54eN6BYg=
X-Google-Smtp-Source: APiQypL8edZmGhJK8e7akmSp+lgiuiz3PlPcpzL0viCqes6neNZv3QlnG7Qkh3/8sPy0T8R9GicalQ==
X-Received: by 2002:a17:902:ab8b:: with SMTP id f11mr1256914plr.320.1587089480960;
        Thu, 16 Apr 2020 19:11:20 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i9sm18256862pfd.148.2020.04.16.19.11.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 19:11:20 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:11:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Subject: Re: [PATCH] perf: cs-etm: Update to build with latest opencsd
 version.
Message-ID: <20200417021113.GB5426@leoy-ThinkPad-X240s>
References: <20200415201420.15958-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415201420.15958-1-mike.leach@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Apr 15, 2020 at 09:14:20PM +0100, Mike Leach wrote:
> OpenCSD version v0.14.0 adds in a new output element. This is represented
> by a new value in the generic element type enum, which must be added to
> the handling code in perf cs-etm-decoder to prevent build errors due to
> build options on the perf project.
> 
> This element is not currently used by the perf decoder.
> 
> Tested on Linux 5.7-rc1.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cd92a99eb89d..da4737cbc2ab 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -564,6 +564,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
>  					       elem, trace_chan_id);
>  		break;
> +	/* Unused packet types */
> +#if OCSD_VER_NUM >= 0x0E00
> +	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
> +#endif

I don't think use macros to distinguish OpenCSD version number is a
good idea, this will get more and more code to checking version number
if later have more these kinds improvement and finally it's hard to
maintain.

Sugget just simply add the new case for
OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH, considering if user uses an old version
OpenCSD and doesn't output this new element, the new added case doesn't
introduce issue for old OpenCSD lib.

Futhermore, suggest to change the code in
tools/build/feature/test-libopencsd.c, so can reflect the kernel 5.7
to require OpenCSD v0.14.0 or later version when build perf.

Thanks,
Leo

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
