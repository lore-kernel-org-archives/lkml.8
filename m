Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F94CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D9721741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pARo2ubH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBFLso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:48:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34479 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:48:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id h12so4234014qtu.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/pZBjGmRibeFQhst686LZsoek0A7Z7BXLX2DlQFGnY=;
        b=pARo2ubH+1/kHlo6wDUOs+dWvF3SV/Sn0LeNm6q2WWGaQRNSnKT3r4DHohTP2F+qnM
         VV9DsD5ppuSlZ2jwtS+I50q2cV7ik8qxtvr2DWtssf0B5zY3fwPmnbrnq8j69a8q9dwz
         opg+F0aKppVQLYRmVWYWoATvW40iqRJ6BNHlK/lhJG+VpQ9SY2ODxsCiNFFnxhpJNusG
         W6wdOhjf6Nwxx0tlDLYyL2Swx6WCTZP4+WX+XQZWitFUqCB88eSv7OA8zQLIIQngJiHj
         K+rukKxxc2+HwluS4dlHnIptG2xL3jkvXMdQBq4g94lipAtZ5cVMCYhf+ugo77PQVlxa
         rYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/pZBjGmRibeFQhst686LZsoek0A7Z7BXLX2DlQFGnY=;
        b=cIH2oyohARWNreak+sPND9sIwJqs5CZIM2qhXYV3NbS9d9hLHDopeMiTCjVXA9fkVf
         Fkc16zInDQ1lhK9yaG+uJ72E76OWfXIYVC6iF64qbsuJDO9P3vK8HfatwpV/EpN0wPEl
         uz0mQe22/JQzvDXBItp5nBPsjzMJm3lLK9CQx1BSRdrWz74RlkGwarZmrWW777tMKDVW
         npbn+osipJfactHRu6lplRdtuB7pZF4keaoUJqZneRystdGkfDL70GT7BREvRKw9oS6e
         K4zB2j5EfcqqXynqMp05Mf7zOCGIFZdyGaaxPHnXSuXh0SqINN8G4tosXWvLSpo8K7tp
         gXXQ==
X-Gm-Message-State: APjAAAXDjTYkyD90faY2ZGTp241v6/Do+wRAbLU4ckBxnFrxezvshJBb
        B62TKQnKtsdfvhGt1+S2rYJ7qobhHurTFykDmKdomQ==
X-Google-Smtp-Source: APXvYqzmObYg6m7Lmmdk/gnLgw7URb2vfFfW4dAtBEFqDOxjQOcsIEO/5UpbicQ3YsSQ5XCqf/xKHcw5RcRj/0AkJFw=
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr2275741qtu.2.1580989721322;
 Thu, 06 Feb 2020 03:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20200203015203.27882-1-leo.yan@linaro.org> <20200203015203.27882-6-leo.yan@linaro.org>
In-Reply-To: <20200203015203.27882-6-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Feb 2020 11:48:29 +0000
Message-ID: <CAJ9a7VjnOw_XgFXmOgE7ufB98_VNEZH7vX=8yO5qrogoBqJQXw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] perf cs-etm: Fix unsigned variable comparison to zero
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

Reviewed by: Mike Leach <mike.leach@linaro.org>

On Mon, 3 Feb 2020 at 01:53, Leo Yan <leo.yan@linaro.org> wrote:
>
> The variable 'offset' in function cs_etm__sample() is u64 type, it's not
> appropriate to check it with 'while (offset > 0)'; this patch changes to
> 'while (offset)'.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index dbddf1eec2be..720108bd8dba 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -945,7 +945,7 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>         if (packet->isa == CS_ETM_ISA_T32) {
>                 u64 addr = packet->start_addr;
>
> -               while (offset > 0) {
> +               while (offset) {
>                         addr += cs_etm__t32_instr_size(etmq,
>                                                        trace_chan_id, addr);
>                         offset--;
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
