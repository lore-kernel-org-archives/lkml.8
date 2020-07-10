Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F61DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755562075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ0WYE/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGJUgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:36:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C07DC08C5DC;
        Fri, 10 Jul 2020 13:36:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s26so3030462pfm.4;
        Fri, 10 Jul 2020 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWLYvJh8yU6cv/NrJKn8wOdsuzJCOURJMQu9i4+3fMM=;
        b=RZ0WYE/RkoDshu/Mr2+Ir0+pzkPCulkt2pu1gNwSpTQbs3V9M2r1D2k4x2e8NPo2gW
         Dw6Md0NUpLckhnAaPvCgsMM/DQc5iKO7/v+hbJEDDdps+8nviqMyJzc1BTKievKmZok9
         wuDhfNJY+/zOpsU24DKy916jTT5yDaf6P6EjCgND9LHXtic8ZRc/FF5HEHnoCldlSeX9
         HX4ECNiOojp7tZW5XYkcvYQH7tLhi3eiiVKXiVQ3q3lLaAm7XHdOCZxEXO4uzkxWlCFO
         2AyDo51OnL51rBSiCb5xKSX8cqAt1dSccBfG/l4s9ZwyI4xUhe/APyRG1zTpZ6ObSg4y
         uSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWLYvJh8yU6cv/NrJKn8wOdsuzJCOURJMQu9i4+3fMM=;
        b=mSbwzftHSNDQoxRapyOQc8FXbF+3hEHtuNXzrcijAD7DnwQTjC+We0T3iAqsoLCvqK
         oRgYY4nSggB/MPrjbXbIvqvGz0VNCzCE2FAXG5UDe6p3I35WCd4DDQatdxkEvWnkuNSN
         Q8aneZrQN5XICoEVEDWBwmxnOcLSklSsXfHwngeAT9hGKc73iOE4LZXMfW+UEWhhRrMd
         POcGBnvBthLgZLH1nJ9VHOOkfJ+rWh+oPaM8WwkcT1RYTaAtDvjzGpKfgD5CTvXRym8H
         XA7ygkRoInHCk/TOAANcH6dvlfMc8DXZhEXqGP6inAm5s2QNLEAaezM0lsiIFpkEp1Jm
         w/hQ==
X-Gm-Message-State: AOAM531Q5jZo9mYnjTx/mZfmaIVJ3EkVij9QeLnemG+BP6K23qY5ds0A
        wkaKwVgXQRNKRJ2E4zDdFl1IaMUVLNzRrU1+GhuaPzBRgGE=
X-Google-Smtp-Source: ABdhPJwr/wKlMl25xcbx0BwyWwAuZjX2Ey7oeqMxxL5qnf4bCKJpvw3Txd9bPARZUwiKcvvaP+t9fEnyfVLLAi5tkWE=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr50302948pfd.170.1594413372671;
 Fri, 10 Jul 2020 13:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200624033126.5972-1-gaurav1086@gmail.com>
In-Reply-To: <20200624033126.5972-1-gaurav1086@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:35:56 +0300
Message-ID: <CAHp75VcQRLT6z0wb+iCfWr1hmrcLS0Rg6TpTx5rK1EbvPzq9VA@mail.gmail.com>
Subject: Re: [PATCH] [drivers/x86] fix bound check in pmc_core_mphy_pg_show
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:INTEL PMC CORE DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 6:31 AM Gaurav Singh <gaurav1086@gmail.com> wrote:
>
> Check bounds before accessing map[].
>

Pushed to my review and testing queue, thanks!


> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 7c8bdab078cf..f571f9cf7217 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -795,7 +795,7 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
>         msleep(10);
>         val_high = pmc_core_reg_read(pmcdev, SPT_PMC_MFPMC_OFFSET);
>
> -       for (index = 0; map[index].name && index < 8; index++) {
> +       for (index = 0; index < 8 && map[index].name; index++) {
>                 seq_printf(s, "%-32s\tState: %s\n",
>                            map[index].name,
>                            map[index].bit_mask & val_low ? "Not power gated" :
> --
> 2.17.1
>


--
With Best Regards,
Andy Shevchenko
