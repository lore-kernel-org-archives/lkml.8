Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC98C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3CB22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Btl64gHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCBVvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:51:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39281 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCBVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:51:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id l7so362167pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A14QEnluAfy61zPlyOAgKgUKJNYdcdSbcWS256De/Mg=;
        b=Btl64gHCqFESo8nzkD/TMtxRWNCqZzrgYn6cwLdnuYB9TEEF7ir6cyZWBScRS44MWv
         TqFMv6lRCB7Mr39FnCTNoC+kxmXGcgFA5Tz6d64AOb5+4tVWJQ79oPnC9H56lGREje9f
         MaS+L9jfToyMU1snIAbPtXgt+O6zUA3X6LQltJ2L+A1BUtrNEwD7gx1mkMhfAqM2ASUB
         Phg4lSUI5S/a7fRw61fSdgk5Fiwxkxf1XZJCoL2B7c4vXZAvJ6asxaT1yif77FlTTAiv
         UK1A+dkkNbxmM+5+uRgC1TnNbaKXbq8GP90rQ1iIfmduAOdgA12H27iqUIXb3GoJ5xLw
         tUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A14QEnluAfy61zPlyOAgKgUKJNYdcdSbcWS256De/Mg=;
        b=HyzQGIL+QjZM7uzsaUKzZQSCmgjocXOM0bKbNAEitnrQj73lcOBN+x/qN6e/gCXq5c
         SpT/WdYutoVIortf4xXiwadfbqFzFw2Ys1d6QnzsDt9UJDR2lsaoiTYBWbjcox507T2z
         PMKs1LtbXgKbNMW4Q2EEn3TnVW+cBE0w+avdeROzBaFJ4N38d2cb5dR11P2hZRTJSh0b
         Vc3xq+h0hsu+iVXcJt3DVnyL3rSMbMEocrl5PVEmNoko10PtURnuOPXXc8IpqCskS+6R
         mxiTSOkxYKtPA+OqueWqc/USOdRt7CWgYR3+fTM738andXMkEPDYaZpdm25ejXzk+YuO
         rOnA==
X-Gm-Message-State: ANhLgQ3C+SGXRHvAgyNngTBUg332YThhl8wdClBHIarrBuntt1zaDx/B
        lxxiQmKBVKi+yG08y2YY3VYfGEDsg+QFAUhIS217Lg==
X-Google-Smtp-Source: ADFU+vsFiOsjnufNSWTYa5s4zkSsIXKEXTdX92uVw2XZoiuJmVru8rWfMLLCbtJLYVcGqCWGnrQZTfKtxW3jnd4ik6M=
X-Received: by 2002:a63:4d6:: with SMTP id 205mr916704pge.10.1583185878849;
 Mon, 02 Mar 2020 13:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20200302213402.9650-1-natechancellor@gmail.com>
In-Reply-To: <20200302213402.9650-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Mar 2020 13:51:07 -0800
Message-ID: <CAKwvOdn8SgY-C1YRGOcCnTn84MHHGirkDHPfg=mCONmUV_wqSQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: Remove unnecessary NULL check in cti_sig_type_name
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 1:34 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/hwtracing/coresight/coresight-cti-sysfs.c:948:11: warning:
> address of array 'grp->sig_types' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (grp->sig_types) {
>         ~~  ~~~~~^~~~~~~~~
> 1 warning generated.
>
> sig_types is at the end of a struct so it cannot be NULL.
>
> Fixes: 85b6684eab65 ("coresight: cti: Add connection information to sysfs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/914
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Yep, GCC and Clang both eliminate the false case as impossible:
https://godbolt.org/z/tjbDqR
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index abb7f492c2cb..214d6552b494 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -945,10 +945,8 @@ cti_sig_type_name(struct cti_trig_con *con, int used_count, bool in)
>         int idx = 0;
>         struct cti_trig_grp *grp = in ? con->con_in : con->con_out;
>
> -       if (grp->sig_types) {
> -               if (used_count < grp->nr_sigs)
> -                       idx = grp->sig_types[used_count];
> -       }
> +       if (used_count < grp->nr_sigs)
> +               idx = grp->sig_types[used_count];
>         return sig_type_names[idx];
>  }
>
> --


-- 
Thanks,
~Nick Desaulniers
