Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796BF2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIdFres5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgG2Xru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgG2Xrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:47:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244FC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:47:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so22626782wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Yb8JOoh+LSsOfdrY/X9ZAwRyZ4kLPnC6nnWUaDd9tc=;
        b=DIdFres5Tl0wvrFB+fV7XnLJIh0s3Mx7Nf0HnayGSLVRNXGZ7hGXtBGliczuymiZ1z
         Iw3nDLtxttfnafX/ne+/ag+iZfQVnWEayVP6KNkMEn2DSmInHFdDr5dihgquTWd22rfp
         wg5yuDm5f6fXU6cCAW097RA7NxPfimeOKMImel28VeoArOsaHebtEo5+7kPgB+qJCttJ
         nfYJdF8AZCBMo4NL+F1Tm4EFeF67dSpW3ygCenqbgjqYcO3nglgoDX7FR9fB04aK26tT
         wkmb7g5mSF8m7Qs3zIzS8UHXGu+zjrtULZZTq7Qe4ww1dyZBsqJZqyaKk4LwogcBgjus
         sA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Yb8JOoh+LSsOfdrY/X9ZAwRyZ4kLPnC6nnWUaDd9tc=;
        b=J9Y2DfcCdfmEN92jgv+bjluiX3fXm+9/KlPnLMbSBHKzbuMF9D/qA+wrIfwuO3L47Q
         oFcF9aMHXNlGx+0Tn3XaOATxe1wpRx1fmGsCjLyzifBSw7lKqiiN2CLPr95oUOWdX6ac
         BGfwQbV0irVhKvnIWDK2neMEsOF+wUfSbyR6FstNDuhZkqGBwXkYalhQgf8dTcsREGkz
         ILgxa2277paLhYCqpXXD66XN39IQnTWcxwUkVUAvuVLxrpgbHATTJaGPLWxgJI0wEvKp
         aTQ9qjV1QEUnqgPQ1Rh1pbcbmrwJ1ph/te7DcJ5Jy2liFna7cHUoEMT9GPcmOSCEJAQ1
         JQxg==
X-Gm-Message-State: AOAM532WiayizT3Xz9NsA3mXaMROUjiFY/z1xRZRqKfTk4aaqg2ONl93
        MAah8n8qePrSQn2LEVRFkH3Evwp90SF/Nh7sx81oiA==
X-Google-Smtp-Source: ABdhPJzYAo02NOPiYYCLKzjRcaDGeIZSfaiMglLqS2wtsgbBUCbIXJACEL6jUL7zCrH7G+ngDj4YEPUeaSOWSQUkLrk=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr89894wrr.48.1596066467544;
 Wed, 29 Jul 2020 16:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jul 2020 16:47:36 -0700
Message-ID: <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked
 in jvmti_agent.c
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, Li Bin <huawei.libin@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 3:07 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Function jvmti_write_code called by compiled_method_load_cb may return
> error in using fwrite_unlocked, this failure should be captured and
> warned.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 88108598d6e9..a1fe6aa16b6d 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>         struct jr_code_load rec;
>         size_t sym_len;
>         FILE *fp = agent;
> -       int ret = -1;
> +       int ret;
>
>         /* don't care about 0 length function, no samples */
>         if (size == 0)
> @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
>         rec.code_index = code_generation++;
>
>         ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> -       fwrite_unlocked(sym, sym_len, 1, fp);
> +       if (ret)
> +               goto error;

Sorry, it seems I lost a reply to this. Won't ret here be the number
of items written and not an error code? Consequently all writes will
immediately goto error?

Thanks,
Ian

> +       ret = fwrite_unlocked(sym, sym_len, 1, fp);
> +       if (ret)
> +               goto error;
>
> -       if (code)
> -               fwrite_unlocked(code, size, 1, fp);
> +       if (code) {
> +               ret = fwrite_unlocked(code, size, 1, fp);
> +               if (ret)
> +                       goto error;
> +       }
>
>         funlockfile(fp);
> -
> -       ret = 0;
> -
> -       return ret;
> +       return 0;
> +error:
> +       funlockfile(fp);
> +       return -1;
>  }
>
>  int
> --
> 2.17.1
>
