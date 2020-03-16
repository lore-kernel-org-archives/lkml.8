Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B51E20575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbH43ppH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgCPNZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:25:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36496 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbgCPNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:25:21 -0400
Received: by mail-io1-f66.google.com with SMTP id d15so17096527iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TMB3I+rumZbopL7iA7VgSh6g4RCIDOU1fcM/KqObKVk=;
        b=lbH43ppHwZ+4bP9DpdgMlJd10QGcbF3VkZgARIIwmPAabLVrq89yo59Wkvpg0B+FOr
         LKkDkwn+A+RlzmNcjdQlpN7WocV+dq/bcnczJqSsY+gFWs1g1z25MUdZ4acX7Xi2qhnY
         GFcS6BbZK+K/Pq2RQybjP9tmkujzmaWDwsSQjNzycd2QY8mMVXfKpDJNLgwvqkF8Jots
         y9XZQvsztYs3SfIodSB1ESokwzOAjrGuQ8mADrY+a4GcxmUjhLhBU/KJ4qDmdOQg3JC8
         Y0W+05I4f8zp/7HcEsYZAQhZQZBv37waLj8MV+UHtcoo45uXd4mz2gkYJX+xLQmMtdiE
         U21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TMB3I+rumZbopL7iA7VgSh6g4RCIDOU1fcM/KqObKVk=;
        b=iDZl33Hpb9lIzBMixBtccxDcq1txVBLp+mw0ylmRBHayxcKhmloaZnxVrI5PjUSERW
         Tu6XXJQl2EXaBCE+Vo+mfGqlVWTQ23dijRzT/mLIZ7NLsegMgpDuyC5AdvOk2cKtn6oJ
         pafH8bO55LbSDx4PBUH2xqh0e2G+UN5EO8VKPty8UsbLlZj0ButZBvRMAtr23CtCgvl2
         w6V0B6UopZLkobTsYGzX1QJjGM404OEkk6jdua3nF+K6kL9IBdTXFoMzWhTIsmDHyVY9
         6zV/rU+/bQlKfMfN0Fet1+OoPDzlJ2CWK7AvT7p7gs9p9Blvxo6/2f9Kb/O4hMgoeNMv
         j+rQ==
X-Gm-Message-State: ANhLgQ1YnzukmE9+ezVMjjuD/fVBa3uybCy1ldzPmnO75UxnNJ4EDCiF
        kvhXZP5g9du4Ns6Xt/vQo7O/PwjpvAuMA6Fp2GCQ5x9O
X-Google-Smtp-Source: ADFU+vscEA3DoJzNBLF3qlT/fJsareFDrGhP8Rg51CJcgR4jOmMPbvczqx3L/rtwKbzDjttTclmRQP4/LD7wLacCIX0=
X-Received: by 2002:a02:81cd:: with SMTP id r13mr9442364jag.91.1584365120586;
 Mon, 16 Mar 2020 06:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200313031017.71090-1-ling.ma.program@gmail.com>
In-Reply-To: <20200313031017.71090-1-ling.ma.program@gmail.com>
From:   Ling Ma <ling.ma.program@gmail.com>
Date:   Mon, 16 Mar 2020 21:25:42 +0800
Message-ID: <CAOGi=dNniSgkUtJPfaYLAbR+_8DMFdU59mx7hf8Otj_VjDF_dQ@mail.gmail.com>
Subject: Re: [RFC PATCH] locks:Remove spinlock in unshare_files
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "ling.ma" <ling.ml@antfin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments ?

Thanks
Ling

<ling.ma.program@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8813=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:09=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Ma Ling <ling.ml@antfin.com>
>
> Processor support atomic operation for long/int/short/char type,
> we use the feature to avoid spinlock, which cost hundreds cycles.
>
> Appreciate your comments
> Ling
>
> Signed-off-by: Ma Ling <ling.ml@antfin.com>
> ---
>  kernel/fork.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 60a1295..fe54600 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3041,9 +3041,7 @@ int unshare_files(struct files_struct **displaced)
>                 return error;
>         }
>         *displaced =3D task->files;
> -       task_lock(task);
> -       task->files =3D copy;
> -       task_unlock(task);
> +       WRITE_ONCE(task->files, copy);
>         return 0;
>  }
>
> --
> 1.8.3.1
>
