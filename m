Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03A5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BFA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkxWSxaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENA4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:56:19 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9EFC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:56:19 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c2so669297ybi.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywtmfrQ4bvC5mZcT0l80a/uW5Hgu+UN45Tyqwdq32Is=;
        b=OkxWSxaXhUyaPgEtFpvznn/IR4r/kI+9K4bNbcYvP6OCC+XmUj4CsOW8CLQGMWwa9e
         JwrRNfd55qmIftqfrkx9QiCWtXjnkB4sPmn7osrSVfrOkdg9zuxBLG4oYbbZ1g5Z5A/G
         nRpH6VnlK8bSOiCr5JLaDbnE6wsDF8b/KhlOVwvsvtRRCuyTqXuxezpi46UIoPBik4iG
         KN5kQYM+It1praMo+VOihF9/FCqil6pT42Sber9ocYOElwR5QO44DY1W5vDRreWE9Waq
         ndcoTReOCZ0WS+ozzJrURog5NQ3+YoscS3+HOQHNk4qli3HIWnd4GKMnPgsm/7sNBUor
         HH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywtmfrQ4bvC5mZcT0l80a/uW5Hgu+UN45Tyqwdq32Is=;
        b=Gaekq5hnfmditVX2pqNI/WJAb/oQElmdXS3JV90wANVfBugImyOXtT08nN5E7PieHv
         Jw3FUs/oKVr7RRi2JYAMLedXsxg/ugSDucqynZRVgjsUy3WiFLkspDEG8S8i6zSFxhxj
         J5oLj7hb5aOnBRU7Xvo+iFyLSsdsmzU6AqieZ6rQ/bBas2HSzQlrRcbUR5IhWaxstfW+
         u2cBZPRpTjNk5/pJSQAkJ5aWun0V0dv13EGlv9LPL6PRbSSsIi8toFBXh0JrBIh+so+4
         Q46Z9T4rym4OgIhL921TWMJ1CkCX5JqFr7tuMGyFUg1yuwjLX3vses1fECfBN1ZnPXUD
         ch7Q==
X-Gm-Message-State: AOAM532Ii62b5zeMlVAGeC5uBuhK9fuJ+rsQiOFXsxe6Pm27b6Ku1cE3
        L0mYH5U5HleekrANNVZJih0QO0G69JWxNwAzoNF6DZG5Grc=
X-Google-Smtp-Source: ABdhPJw+qk4VeY2tg26zqXyMNZtusjGg2XCTiWdMcKoJSuhin43muLjbGFl1CVDuAf26no+QkkphmWfleEQpZkjYzZI=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr3006026ybf.286.1589417777831;
 Wed, 13 May 2020 17:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200513234738.GA21211@embeddedor>
In-Reply-To: <20200513234738.GA21211@embeddedor>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 May 2020 17:56:06 -0700
Message-ID: <CAP-5=fV=hQQvafgp8saDUadZch7vwtBsEKqf==qmSm8htq3Ugw@mail.gmail.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in intel_pt_synth_pebs_sample
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:43 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Fix the following build failure generated with command
> $ make CC=clang HOSTCC=clang -C tools/ perf:
>
> util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>                         struct branch_stack br_stack;
>                                             ^
> 1 error generated.
>
> Fix this by reordering the members of struct br.
>
> Clang version 11.0.0 was used.
>
> Fixes: f283f293a60d ("perf tools: Replace zero-length array with flexible-array")
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Tested-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> Here to fix what I break. :)
>
>  tools/perf/util/intel-pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index f17b1e769ae4..b34179e3926f 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1799,8 +1799,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>
>         if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
>                 struct {
> -                       struct branch_stack br_stack;
>                         struct branch_entry entries[LBRS_MAX];
> +                       struct branch_stack br_stack;
>                 } br;
>
>                 if (items->mask[INTEL_PT_LBR_0_POS] ||
> --
> 2.26.2
>
