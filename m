Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F753C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258E521582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubfbVMHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEHMCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgEHMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:02:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDFFC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:02:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b26so1209473lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNKVrkJdHzfMbK2WFg5Y7tu/Zp5ibf2iNC5EM1tQRJo=;
        b=ubfbVMHFvkGFqi6/lMGAmUyGcg20V5yh8C00LQp7ohCZxq2z4EmwwX3B73H8EZ7Y6+
         aJCVbMOvPuRCut0Bnl8ET5c2XfZXweuNYjo3brQ6CEYILBG8HhEgVuhFWVWA1BmL+7wr
         PaMOGT8qiPBOFsYR+vprL3K/7EVvJ8oJXMBygdJ6uGjhciK55QG7biHSQuFnHCtyvZe5
         srhzCTXCfW52nQOZMKMQqUcLd8x7Ffk6Kk/ZsU0oOHDAWkNAqGX1e8h1hy8E4RAfCjEQ
         6gCD/cXPSscJnlWgSBvvUILe/g9S3+oDCA5v+IgSinV7FqAm/oZSQvwlhvdPaLD8bWMp
         QpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNKVrkJdHzfMbK2WFg5Y7tu/Zp5ibf2iNC5EM1tQRJo=;
        b=jt5T2pwbkIemVv8rKA16OwkyDfrU/+p9bDtLKvVdzImOJToB0yhWFtxxx9dwaZ71mi
         ckX/3hQ/mthYGnmD5Rre0Wd2uHEghx05tPTUQMWlWu0vc6TP9RyzSM8oecDSyuGYBklQ
         9nLKLFWIMH3QOpFrrfLqp9nrZz570AUTFDlKeU8sUdhltvmaD2Segc52nUGN2IpfYbuv
         TxeHeaDgtJ7CDSKQKIK/TR0+L2WCGpGX1ZItTev2ogjH0lT94EAyKsR6vdZa+exe545g
         Bgu60HnRtZlDq9+xJkckPtcV2EG7bilwk2vgInYK+2j2lx7STMkSQrtdgF/BAylcFN7b
         cOOA==
X-Gm-Message-State: AOAM530LdvhDd9OANJ6/3F1QmPj0GorCULNZZ1A3aBsTYY6Ujdntc9a9
        arW5qHlnhkQDNY1fJ9TJZnD8+FiuSP/STfJnV/dw2Q==
X-Google-Smtp-Source: ABdhPJwC7HcQZBmnzQTCK4sgJwvhh1shXjGpCyyI6P2ffCkh7V87ZwnoziPmO0iHtAk8wnYX7eQKeQNhe8U2VKMv2Qo=
X-Received: by 2002:a19:ccce:: with SMTP id c197mr1688763lfg.59.1588939355636;
 Fri, 08 May 2020 05:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200507161125.1.I2cce9ac66e141230c3644b8174b6c15d4e769232@changeid>
In-Reply-To: <20200507161125.1.I2cce9ac66e141230c3644b8174b6c15d4e769232@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 8 May 2020 17:32:24 +0530
Message-ID: <CAFA6WYNbrhiagmqLGOGq+-WRdmbA0Y8FP9PYYsOoerqHeQcmoQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Cleanup math with KDB_CMD_HISTORY_COUNT
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 at 04:42, Douglas Anderson <dianders@chromium.org> wrote:
>
> From code inspection the math in handle_ctrl_cmd() looks super sketchy
> because it subjects -1 from cmdptr and then does a "%
> KDB_CMD_HISTORY_COUNT".  It turns out that this code works because
> "cmdptr" is unsigned and KDB_CMD_HISTORY_COUNT is a nice power of 2.
> Let's make this a little less sketchy.
>
> This patch should be a no-op.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

>  kernel/debug/kdb/kdb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 515379cbf209..6865a0f58d38 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1108,7 +1108,8 @@ static int handle_ctrl_cmd(char *cmd)
>         switch (*cmd) {
>         case CTRL_P:
>                 if (cmdptr != cmd_tail)
> -                       cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
> +                       cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
> +                                KDB_CMD_HISTORY_COUNT;
>                 strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
>                 return 1;
>         case CTRL_N:
> --
> 2.26.2.645.ge9eca65c58-goog
>
