Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24052C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4BA20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZx/n+Oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgBFMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:36:58 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41364 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgBFMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:36:57 -0500
Received: by mail-qv1-f68.google.com with SMTP id s7so2737893qvn.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUwmB6pLm1GEsn/L8zF8glzZF4rqmSPF22o5h0xr+2E=;
        b=lZx/n+OqjjhRfsxxr6sDFrGBej4mKe0jLFOJK+tMNyhZ2/dz6ghrL8tMa5FX2On9gN
         njZh7V8bQXdag9yD1//HZ9cFbSicAlGjVqkff76EXIObD9vPJ8WDFWME56QbrCIRASKj
         5S7vHeshuTCfG19yBQDSjpuU+Vtrq08RjN8ZhiOkqAWzBvxM494QiSJ+CyS+/EOpI8hf
         MSFIe0fAZxYGdpLacJ74ZR41Hy5BSNwoc2/NK4k/KccnEmsIRfC4NoaQyb9F0UsYT/8a
         +qEswq4A2WHXzmkcxMcL1qb51hSbP4dG4MB2f9kEuD8WcnnyiB9kiLMB9aJPlt3gAjeW
         MEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUwmB6pLm1GEsn/L8zF8glzZF4rqmSPF22o5h0xr+2E=;
        b=unIadu/hmHKxsJyySEabNVvaMCo7G9mEFggQ8qqdzLj9IFPhwhUO2wV2xBRWZ1mBxK
         SUZUC5R7YY8PVaHfg/m/78cZAhXpZlPrzPnfc79lNMekjrRU0TGrdudAGH8twNBtEA+H
         rvAl7JiXoxYAmEz+l0V8oufMSuhP+i/bFWoB4Y9IJhkASUpYR9fcqFIt+2rctaXFOgw4
         U/eW1JnMVayYVKPFCttHhdfgBXTTdmz3swDvoFjtgFCC6B1u4tbTxc03IixAoHauH0Q0
         sN05LRlYtmyRiKxusgWVRF1yJPRP8+W4K8XikKRyee6SUdVs2aBM/UelH0r14lgfAs5d
         2A8w==
X-Gm-Message-State: APjAAAXx2fhNqt1lAC5QnioGrLHzXKOP8gC7Cn/vgGTR+G0OEnl9dXL0
        bw7FC8uorAzZR2qd3dUKhMtsBniMvdWO1GV1qLR8mGLJMvs=
X-Google-Smtp-Source: APXvYqzELyWaNJrtofn/bo6/wn3br3pgWoPYE7GFWl8RGcwA/LeBLUsndoGw3R76DY0zlv+QGGUns4yxANASgHBue9M=
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr2058307qvm.237.1580992614918;
 Thu, 06 Feb 2020 04:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20200203020716.31832-1-leo.yan@linaro.org> <20200203020716.31832-2-leo.yan@linaro.org>
In-Reply-To: <20200203020716.31832-2-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Feb 2020 12:36:43 +0000
Message-ID: <CAJ9a7Vi37DAZ0q78MahmMQqSxD68Rphaw0t5cMsX3gDk8PA3DA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] perf cs-etm: Refactor instruction size handling
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

Hi Leo,

On Mon, 3 Feb 2020 at 02:07, Leo Yan <leo.yan@linaro.org> wrote:
>
> cs-etm.c has several functions which need to know instruction size
> based on address, e.g. cs_etm__instr_addr() and cs_etm__copy_insn()
> two functions both calculate the instruction size separately with its
> duplicated code.  Furthermore, adding new features later which might
> require to calculate instruction size as well.
>
> For this reason, this patch refactors the code to introduce a new
> function cs_etm__instr_size(), this function is central place to
> calculate the instruction size based on ISA type and instruction
> address.
>
> For a neat implementation, cs_etm__instr_addr() will always execute the
> loop without checking ISA type, this allows cs_etm__instr_size() and
> cs_etm__instr_addr() have no any duplicate code with each other and both
> functions are independent and can be changed separately without breaking
> anything.  As a side effect, cs_etm__instr_addr() will do a few more
> iterations for A32/A64 instructions, this would be fine if consider perf
> is a tool running in the user space.
>

I prefer to take the optimisation win where I can - I always do in the
trace decoder when counting instructions over a range.
Consider that you can be processing MB of trace data, and most likely
that will be A64/A32 on a lot of the current and future platforms.

Therefore I would keep the useful cs_etm__instr_size() function, but
also keep a single ISA check in cs_etm__instr_addr() to do
the (addr + offset * 4) calculation for non T32.

Regards

Mike

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 48 +++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 720108bd8dba..cb6fcc2acca0 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -918,6 +918,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>         return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>  }
>
> +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> +                                    u8 trace_chan_id,
> +                                    enum cs_etm_isa isa,
> +                                    u64 addr)
> +{
> +       int insn_len;
> +
> +       /*
> +        * T32 instruction size might be 32-bit or 16-bit, decide by calling
> +        * cs_etm__t32_instr_size().
> +        */
> +       if (isa == CS_ETM_ISA_T32)
> +               insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> +       /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> +       else
> +               insn_len = 4;
> +
> +       return insn_len;
> +}
> +
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  {
>         /* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> @@ -942,19 +962,15 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>                                      const struct cs_etm_packet *packet,
>                                      u64 offset)
>  {
> -       if (packet->isa == CS_ETM_ISA_T32) {
> -               u64 addr = packet->start_addr;
> +       u64 addr = packet->start_addr;
>
> -               while (offset) {
> -                       addr += cs_etm__t32_instr_size(etmq,
> -                                                      trace_chan_id, addr);
> -                       offset--;
> -               }
> -               return addr;
> +       while (offset) {
> +               addr += cs_etm__instr_size(etmq, trace_chan_id,
> +                                          packet->isa, addr);
> +               offset--;
>         }
>
> -       /* Assume a 4 byte instruction size (A32/A64) */
> -       return packet->start_addr + offset * 4;
> +       return addr;
>  }
>
>  static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
> @@ -1094,16 +1110,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>                 return;
>         }
>
> -       /*
> -        * T32 instruction size might be 32-bit or 16-bit, decide by calling
> -        * cs_etm__t32_instr_size().
> -        */
> -       if (packet->isa == CS_ETM_ISA_T32)
> -               sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> -                                                         sample->ip);
> -       /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> -       else
> -               sample->insn_len = 4;
> +       sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> +                                             packet->isa, sample->ip);
>
>         cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
>                            sample->insn_len, (void *)sample->insn);
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
