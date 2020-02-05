Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC24C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA5420702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tAtDtV/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBEP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:59:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35099 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBEP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:59:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so1936454qtv.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgFtvKPDP0sDYi/MhyTOH2A1MExKnqnxSMqDrNLHf/M=;
        b=tAtDtV/KzO2rjT2J443TGWBe1bFoqvGnSPis/NovagA4PRvijZZN2eGIc7Ou8mXmQi
         uBvmFpsdWzjyK9q6EY8wbh9tvI4FX0DszTV2dnmPaNPDCJAKU4rC5ZDCAvAAbJxGZ4go
         xADzV7TP/DwMI6Bd24aBjFL3J093rFxJhPzpS/NX2bcNYngDn6r4qMEm63sqittFMD1p
         YusrPVafqr8u1VOmdUiaGDQPVSMDG9qtmsoKawkDB0FMSDHqzb2VZhwVfZPE4iSkLyF4
         +19pdq/P3JAQwmCg8Kmdwj+kYbeV9jMJ3EKssYZjfyJx+DOQAizitHqi//HXgKIYUpHM
         Pskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgFtvKPDP0sDYi/MhyTOH2A1MExKnqnxSMqDrNLHf/M=;
        b=aCD3rKOVBpyj3BAef/XMnXN7i8D+d7a4fyV5nC6Ecb9bixa4ecXJ4X9aOQLJ9ZH2dy
         /GkwViCAUHAcLpwsA32W0jbr7HdaM0FOFcS5KX0cLzuPy3OLdNgX9uC1OYeuzCb5Pwre
         337pEFpJOzI/77RO6JNBtocobyWRkX+RKEUc8O6rWew5b2dHCmNJzF7eZg/5Wluo1s0m
         9dPPEGS43wyrxFkm+uDJa0BmbsGAxSKT9LjkJY4JE3Mfn8o9fZS6jpsIQqusy5XlYsov
         NJygjmB/WakZzFcDv/gejpAY6EUwQ8SZyk6f0LMgdGxmsBgUsICTzkhDG1Up3B/fdiVJ
         Q1qw==
X-Gm-Message-State: APjAAAWiPJFGHK6mBS0T6Ax+Wp/xImAsU6m9IXA62voj0odqvvqBgK7b
        ad5zklpaZfM+H/MV0PmI43rPC/gNIHDb7iPjBSNEBw==
X-Google-Smtp-Source: APXvYqzz6JLrUAUDTjlc/jFlOSc/cjLwcyWkNWf76pAct7u7jUk0TCmgecnPO34q6QtYvDnrKNNbURQOt0SEHPw2QR0=
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr34530525qtu.2.1580918391571;
 Wed, 05 Feb 2020 07:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20200203015203.27882-1-leo.yan@linaro.org> <20200203015203.27882-2-leo.yan@linaro.org>
In-Reply-To: <20200203015203.27882-2-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 5 Feb 2020 15:59:40 +0000
Message-ID: <CAJ9a7VgFL24gWGGJ-Wn2YycsW1DzKgu29_HaHtE=OJ0Fz3oNcA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf cs-etm: Swap packets for instruction samples
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On Mon, 3 Feb 2020 at 01:52, Leo Yan <leo.yan@linaro.org> wrote:
>
> If use option '--itrace=iNNN' with Arm CoreSight trace data, perf tool
> fails inject instruction samples; the root cause is the packets are
> only switched for branch samples and last branches but not for
> instruction samples, so the new coming packets cannot be properly
> handled for only synthesizing instruction samples.
>
> To fix this issue, this patch switches packets for instruction samples.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5471045ebf5c..3dd5ba34a2c2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1404,7 +1404,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>                 }
>         }
>
> -       if (etm->sample_branches || etm->synth_opts.last_branch) {
> +       if (etm->sample_branches || etm->synth_opts.last_branch ||
> +           etm->sample_instructions) {
>                 /*
>                  * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>                  * the next incoming packet.
> @@ -1476,7 +1477,8 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>         }
>
>  swap_packet:
> -       if (etm->sample_branches || etm->synth_opts.last_branch) {
> +       if (etm->sample_branches || etm->synth_opts.last_branch ||
> +           etm->sample_instructions) {
>                 /*
>                  * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>                  * the next incoming packet.
> --
> 2.17.1
>
if is worth putting the 'if <options> { swap packet }' into a separate
function as it appears twice in identical form? Might help if more
options for swap packet are needed later.

Either way

Reviewed by: Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
