Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F35C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4E42086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRZkwZaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgHGV2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgHGV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:28:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B292C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 14:28:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so2233601edk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdNucF0koSppcU0GmU9pSl6fM9HVcxNoH43SdcmhMo4=;
        b=WRZkwZaLt55Y2h276GQIL0EwY8JZgUt+nO04eGdR+5coh476ORbcDKISCIzllLYqgr
         7pXl9SAv+kRl9cT8mG/IIezkcnD/mOK8BF31NyqErmOkrd2TjVOko70lECZRwmQMlz1Y
         b8cFcuQo1C617FdhnPXZESL8OsSbpCtiVGg/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdNucF0koSppcU0GmU9pSl6fM9HVcxNoH43SdcmhMo4=;
        b=nFdVlMaplROi8dThGp22BaMj2tz2PL5f+6WFgD+UObu5hmYmNzQRqutdymlf3p2WKN
         wAVyOlBdYJkz9SQ4PUw6XGjjHxGPf2cRAO5C9M6bKR81mZXMDcyCED4GzsCNtyQOaD5I
         7K8kRH88+KlcW9kFAHqjISpk6lEVt9isueWWOgOuD5pNOHaWdx+ZEuKSEaEKaDG64VBM
         ZxHyUf2NRbIaXDZC/vuKVHon98u7rU0Yr2vOx5cYtWqKLVyjUx/r67OLrbzSiyF/5qP5
         028OH0vBmr6J4hulGMdPfQ1WgGGLU4JoF/hyLYbotv1lkI6VI8lNG3XSa7Mi04AiY64c
         2K/Q==
X-Gm-Message-State: AOAM530f3ZFaAvdeQawBAZiutSTNar2BnBof7bQLmrXdyHjxYo/qXgxl
        Wxpa4ZlbK4fXaiUFVUHhD3BVt3D1q3Q=
X-Google-Smtp-Source: ABdhPJwRUhERrMBC3w6Q8l+DvsYGBeVwPgesiIWBaXEo6L5u2pbREKzcimFt0KU5GAbPenAI54A8bQ==
X-Received: by 2002:a50:d75e:: with SMTP id i30mr11146847edj.246.1596835715971;
        Fri, 07 Aug 2020 14:28:35 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id g24sm6135082eds.42.2020.08.07.14.28.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 14:28:35 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id a14so2878878wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:28:35 -0700 (PDT)
X-Received: by 2002:adf:fdce:: with SMTP id i14mr13480967wrs.273.1596835714967;
 Fri, 07 Aug 2020 14:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200730114632.6717-1-stanimir.varbanov@linaro.org> <20200730114632.6717-2-stanimir.varbanov@linaro.org>
In-Reply-To: <20200730114632.6717-2-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Fri, 7 Aug 2020 14:28:22 -0700
X-Gmail-Original-Message-ID: <CAMfZQbx36rZc=9p8a=mGSqwvtfQ-KRO+5=8yEuo-NA+eeoBBNg@mail.gmail.com>
Message-ID: <CAMfZQbx36rZc=9p8a=mGSqwvtfQ-KRO+5=8yEuo-NA+eeoBBNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] venus: parser: Prepare parser for multiple invocations
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 4:47 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Presently the hfi_parser has been called only once during driver
> probe. To prepare the parser function to be called multiple times
> from recovery we need to initialize few variables which are used
> during parsing time.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 7f515a4b9bd1..363ee2a65453 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -239,6 +239,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
>
>         parser_init(inst, &codecs, &domain);
>
> +       core->codecs_count = 0;
> +       memset(core->caps, 0, sizeof(core->caps));
> +
>         while (words_count) {
>                 data = word + 1;
>
> --
> 2.17.1
>

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>
