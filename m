Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C73C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4969D20752
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsJORsGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgEEK1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgEEK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:27:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4A1C0610D6
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 03:27:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id k8so1246187ejv.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Orh5u/cGFa6CUf3Ru5y/QPpEtSbGN9HXkDg7tWvYPnE=;
        b=SsJORsGWqpqKroHw3juOiPB4jAoj7j0EugdHIIHw2eqbFfUiCLya+4s/vMXwX777AV
         Q6Gvxzp1ptHMdUcThPhLS/5pv+LKe9X/D+xifOF/VxYr9M+vpHeYBIWBgbqf0I0Ak1mw
         KKG9VB+GwPDv4zXgR51qnxe8nGhz2Ci2zJxls4yl5Pt7qUNgckkXy+L4d0cAg9hbRyhU
         DoAMIi/U7nG2zB2FJn2l2yURSbHkoPHlr2VfZzBcTrM6IY4r2rBQRX4h4+t8FGHTjdLR
         9diXW7lj9wss7Ubnw0i8NxTpKAOkAVKaPuRJJumf0TKHSK7E6PPPvS+F0CJ9+QeEGUfu
         rVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Orh5u/cGFa6CUf3Ru5y/QPpEtSbGN9HXkDg7tWvYPnE=;
        b=ILxUlpTa+C2+WeU0kHoIW+fzWctQcYCgGfpkaWec7O9UZuE7mQocuc9bHydBXSf8wv
         eTIRtAqf/gsiJtyweguZRcKYUTui/IO7CTbTr+D4yZnM/+eIOfDJLasUG2XloZMnvK48
         568YibT1VMDxRpa2RFMhLPptjzLIn+7E8F1biQQMIHPvjNhkMb4KO1OFHdRRbo/wufpt
         /rj0QHigVcI3UyeLzQOXbKIPb9ZD7rp1LKN7SS9sOAMbKqMrmS0qW0yoVqN4J2fRbrxr
         OZ+hUfQ0wPkg512U3fbZCSMKEUfpCG0n2MMjy1VRmT1tZIX/QpSHVccFdzCLyhVRjUjP
         wgOw==
X-Gm-Message-State: AGi0PubWOnzhOlLE8jK9I4Fxd4/v+pX2x2BPglr7OSZMCwnOca0S7zQR
        0dJZ937BbR3AwjV0MV0UXIUVUBN6is/YxOG6vHb4zw==
X-Google-Smtp-Source: APiQypL4FFjkxMGI8aLXdMhTJ3XGyBUIZqnU0wyfYDKRQb8wG4Ok9jkG5xaBSuXBG86XDN48syzA5yMzvtKRdYvGaFE=
X-Received: by 2002:a17:906:fcaf:: with SMTP id qw15mr1938820ejb.236.1588674420735;
 Tue, 05 May 2020 03:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <2869c4f6-9adf-3d55-a41d-a42865ae56f2@mageia.org> <20200505041050.GA8131@leoy-ThinkPad-X240s>
In-Reply-To: <20200505041050.GA8131@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 5 May 2020 11:26:49 +0100
Message-ID: <CAJ9a7Vh8nqT5zGO1XPzWhPTpmMK+rx-S6DXvzPC4m31Fjkr+rQ@mail.gmail.com>
Subject: Re: perf build error with gcc 10 on arm and aarch64
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Thomas Backlund <tmb@mageia.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

This is caused by GCC 10 new default to -fno-common. Temporarily
adding this to perf build reproduces issue with other compilers,
including x86 build of perf with cs-etm.
As such - your fix is good to resolve this issue.

Tested by / Reviewed by Mike Leach <mike.leach@linaro.org>

On Tue, 5 May 2020 at 05:11, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Thomas,
>
> [ + Mathieu/Mike/Suzuki ]
>
> On Mon, May 04, 2020 at 10:22:27PM +0300, Thomas Backlund wrote:
> > This is building perf from kernel-5.6.10 on armv7hl and aarch64:
> >
> > Compiler is gcc 10.1.0-RC
> >
> >
> >   LD       perf-in.o
> > ld: arch/perf-in.o: in function `.LANCHOR0':
> > /home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
> > multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/cs-etm.h:118:
> > first defined here
> > make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/build/Makefile.build:145:
> > perf-in.o] Error 1
> >
> >   LD       perf-in.o
> > ld: arch/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
> > multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/cs-etm.h:118:
> > first defined here
> > make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/build/Makefile.build:145:
> > perf-in.o] Error 1
> > make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> >
> >
> > The same build succeeds with gcc 9.3.0
>
> Thanks for reporting the issue.
>
> Could you help confirm if below change can resolve this issue?
>
> Thanks,
> Leo
>
> ---8<---
>
> Subject: [PATCH] perf cs-etm: Move defined of traceid_list
>
> The variable 'traceid_list' is defined in the header file cs-etm.h,
> if multiple C files include cs-etm.h the compiler might complaint for
> multiple definition of 'traceid_list'.
>
> To fix multiple definition error, move the definition of 'traceid_list'
> into cs-etm.c.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 3 +++
>  tools/perf/util/cs-etm.h | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 62d2f9b9ce1b..381d9708e9bd 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -94,6 +94,9 @@ struct cs_etm_queue {
>         struct cs_etm_traceid_queue **traceid_queues;
>  };
>
> +/* RB tree for quick conversion between traceID and metadata pointers */
> +static struct intlist *traceid_list;
> +
>  static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 650ecc2a6349..4ad925d6d799 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -114,9 +114,6 @@ enum cs_etm_isa {
>         CS_ETM_ISA_T32,
>  };
>
> -/* RB tree for quick conversion between traceID and metadata pointers */
> -struct intlist *traceid_list;
> -
>  struct cs_etm_queue;
>
>  struct cs_etm_packet {
> --
> 2.17.1



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
