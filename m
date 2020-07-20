Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E189C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689E320734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHa2efVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGTG5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgGTG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:57:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDFC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:57:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 18so11347289otv.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6NUst1rchY94JUB0W3huiU2MUEkso7czGQSShPQ2Fc=;
        b=vHa2efVBkyuXuZfdhY6Q646Xjxnct5NdFDCqm7rb+1P95VXyZ2oDuw0IjG5o6AjwYj
         8Gsivv0nqtvbhxosSXeUeMJefbCLcJfLcQDv/UZRQWhKMWCnDkyDnZDAti7TBt5jv4Nq
         KyHDci6j19oo6KmiujOAcwfFJUIji12YaVz3PpQ7a8yzxmA3mdYTkvsYjs7ZCNWVqFx9
         VEYwaTRsaKGwEq9tB6a+nVbj+7wWgiaV9xVGZMaRyD/dBE3eVltNnn52+jL1s2EmpU2w
         1+zwgTyt13s0LbDmecUqrBg1tKaMcAF+WJJu0ydNIqUrSHmtDt4Ql2jgOp1KKwR67tO+
         1sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6NUst1rchY94JUB0W3huiU2MUEkso7czGQSShPQ2Fc=;
        b=undvLQyPTQJ4wmq6DO5Gv5dHGmevgOBQVTTE7Yr3tV5Jd+mUVeol8f4lIq2/b11OQR
         1WgAnaciNjlw7Rkn9pH6WNdgFs4O71kVA/0ryinGJcv3l6px17SYjK/YQveLqLPQ2Bv+
         AJ2d+07GPGGM/TsayY4418sZAJw+882oDeeJUWha+ZgUe/G2KJncM/Wvz3wbK72BgVTY
         FC23MLlB2PKAVaeF6UvDG8VIVFkvfH+7uWvCxrknS8IZtkUptP5IvYLCMYchtrLcg7LG
         akpQYuePLw37xf/pl90XtJ1NYynbdJqj9IHSuODUV5soIkI7KTjw626j0TPC7HnDDlm6
         VJIA==
X-Gm-Message-State: AOAM532PBmbrcYagx7/PIWH0faNRSOzVsp+tnXnEOkUGgym91Vej/Nb8
        PvuRYpHfQX2oWs8LdKxROt9DBT6c5vD/dB75zXg=
X-Google-Smtp-Source: ABdhPJzRBDfnGqC9iqhGneoqaTRzOpJA0ds7Kv/cYimAuhO4LdnmbLFJQSFTRoMYAS6SES3eYc9ZQ6QwhhN9FbDhfCM=
X-Received: by 2002:a9d:6a12:: with SMTP id g18mr20006080otn.155.1595228260861;
 Sun, 19 Jul 2020 23:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-11-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-11-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Mon, 20 Jul 2020 16:54:16 +1000
Message-ID: <CACzsE9og50tH9jRZjWYDgbFxdTkDXJq3gMuP8uxPWfrrREo=4w@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] powerpc/watchpoint: Remove 512 byte boundary
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:11 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Power10 has removed 512 bytes boundary from match criteria. i.e. The watch
> range can cross 512 bytes boundary.
It looks like this change is not mentioned in ISA v3.1 Book III 9.4
Data Address Watchpoint. It could be useful to mention that in the
commit message.
Also I wonder if could add a test for this to the ptrace-hwbreak selftest?

>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index c55e67bab271..1f4a1efa0074 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -418,8 +418,9 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
>
>         if (dawr_enabled()) {
>                 max_len = DAWR_MAX_LEN;
> -               /* DAWR region can't cross 512 bytes boundary */
> -               if (ALIGN_DOWN(start_addr, SZ_512) != ALIGN_DOWN(end_addr - 1, SZ_512))
> +               /* DAWR region can't cross 512 bytes boundary on p10 predecessors */
> +               if (!cpu_has_feature(CPU_FTR_ARCH_31) &&
> +                   (ALIGN_DOWN(start_addr, SZ_512) != ALIGN_DOWN(end_addr - 1, SZ_512)))
>                         return -EINVAL;
>         } else if (IS_ENABLED(CONFIG_PPC_8xx)) {
>                 /* 8xx can setup a range without limitation */
> --
> 2.26.2
>
