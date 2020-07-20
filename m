Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2269FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED474207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgN1DPmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGTXBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGTXBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:01:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE21C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:01:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so611306pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/Hzvj46GMWghkoSCjL0HOdxVoqVdmy+OPTcMewiWSvE=;
        b=PgN1DPmgNu3G53Ken5/LkSROIqJai/aUEUJdgWX/bIrqwwSi88jDTgtLHVlDsEAn20
         yytidWOkLG89/MBTyRDYHqWvAbOCVVSXv6SMl4ngAVPoiVFCCCmvIOjDvyjnNIVp52/P
         CGOh7AWyqCYb6aRVEAsnsCQb+R48Jb8fGqD8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/Hzvj46GMWghkoSCjL0HOdxVoqVdmy+OPTcMewiWSvE=;
        b=iYr4ptcU9AUvlnm7cRL5vEPcCNHvXNcExthq8KhETisu7VyC+UBRHQBymLaxh1VoPh
         WW5Twa9UzbB6ecyyWXoYzk2scHqiwk88EUERHK96A7YIO+Md4vaN0GJNSvg1pW+8k9WJ
         sIQ/y5n76WAUaLFrMZ9UZUfMeWiiPNSd0HAL166kkvFt32Qqei9oTNjvoa2xKpgdvkaK
         oUdm2v0VFHY+EcVRgsYoB3XhIhWYwPleCdku0Dr9M/iAG6/wCV96XA13yv8JDqhQGlQ3
         FXv/1hTqH048DDKbzJw8c2qPEYhAebnUuN0rUhl5iCB7jClIUQWHh8TPMHXBkzXG5Pzc
         d9Ug==
X-Gm-Message-State: AOAM533jLkUn+gys4YSg2x/fpYPFs7fbFa5jJpZtm6YWf2vcl5ZvFLPx
        4Ei0nI71SjYahrhnzNc5ODo/WuH8n6w=
X-Google-Smtp-Source: ABdhPJzXgqFOjLmu7Y7dsVD9MwBv8OeJovqcrWm13bqIcPCgOfSBrsTMLtmjODLXT/voxF6WSTVsSg==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr18091227pln.46.1595286110789;
        Mon, 20 Jul 2020 16:01:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g26sm17854719pfq.205.2020.07.20.16.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 16:01:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200720082709.252805-1-pihsun@chromium.org>
References: <20200720082709.252805-1-pihsun@chromium.org>
Subject: Re: [PATCH] scripts/decode_stacktrace: Strip basepath from all paths.
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Shik Chen <shik@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org
To:     Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 20 Jul 2020 16:01:49 -0700
Message-ID: <159528610934.3847286.7269726046959428266@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pi-Hsun Shih (2020-07-20 01:27:07)
> Currently the basepath is removed only from the beginning of the string.
> When the symbol is inlined and there's multiple line outputs of
> addr2line, only the first line would have basepath removed.
>=20
> Change to remove the basepath prefix from all lines.
>=20
> Fixes: 31013836a71e ("scripts/decode_stacktrace: match basepath using she=
ll prefix operator, not regex")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Co-developed-by: Shik Chen <shik@chromium.org>
> Signed-off-by: Shik Chen <shik@chromium.org>

I thought Co-developed-by and the other SoB came before your SoB.

> ---
>  scripts/decode_stacktrace.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>=20
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 66a6d511b524..0869def435ee 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -87,8 +87,8 @@ parse_symbol() {
>                 return
>         fi
> =20
> -       # Strip out the base of the path
> -       code=3D${code#$basepath/}
> +       # Strip out the base of the path on each line
> +       code=3D$(while read -r line; do echo "${line#$basepath/}"; done <=
<< "$code")
> =20
>         # In the case of inlines, move everything to same line
>         code=3D${code//$'\n'/' '}

Given that there's a while loop now maybe this line above could be
removed and the echo above replaced with a printf.
