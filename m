Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569502088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590666595;
	bh=6tXY+NtLS1Pos3AdFhEZ1H9p5rzUSOVN7uckmYZ2xgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mx6xSik4HODn2Ih8TU9owELdXC7LwQiSTzGrr1JQNHQZEicI0QsOPfVF2gmtg1x7j
	 QKkX6gue9BhNRp3qzkzhtdO0KRx6l6hlYSOzJMXtb6kB5X3mPJsDpiwjg8Qm8C3NLW
	 17BHk6F5ZSrNiIsEopPsFz2+vJkRapRyt5bITRlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbgE1Ltx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:49:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42100 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbgE1Ltw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:49:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id z3so2097512otp.9;
        Thu, 28 May 2020 04:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaBonLX68Shl/cr/OjMysREG0VPDSDKN16LVHgtCeIs=;
        b=cVpozyuUr3Kz6PokwwRmyuF8DcsbX3DFtbc5GUkHlaz6isQBHFWyGfJxRYvnZqk6PZ
         G19YXJ0fRyYUA4cUZHJkWoej2TIWaNbkNCJgl2uKyk1+A9bDd6lFrNZkIopJhWxkLiwE
         qhAIyQK6enwDM/ruG0Ga9EpP5X6KB75E/tSdRr8YUPcFWBuQIfc95cGpqdxXm15tVLGP
         AjIQ2fNPk+BoOVLl2PFiUe4mPthfTaqo1niTTmtncQapKUj3nPIVa5VKblqb9/6HSoSL
         cU21TJXIPEBHV/+Qc5fUfCuDuupkb4TIdRJFN7Wobzr3AkM9VzT7jAJ/7AUCijvEV7AV
         JLgw==
X-Gm-Message-State: AOAM533S4V+p16086+6BVPZSDclZVt9uS8XgRDfqVJAoceThrsdradBO
        40yyXTg+hjD7VUji4HkIeetW68K5iB5n/AlgkJI=
X-Google-Smtp-Source: ABdhPJxVYdkmtmI3XFgV3IC8O4r6Rc3v9KMkBMkdt1MoxRgw7rciBYu0q2weGZJoqCjn9VcR6myNO8WuhuiMdREtyHI=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr1982592otc.262.1590666591853;
 Thu, 28 May 2020 04:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200527223551.20156-1-wu000273@umn.edu>
In-Reply-To: <20200527223551.20156-1-wu000273@umn.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 May 2020 13:49:40 +0200
Message-ID: <CAJZ5v0jj60jvU_0C2mpXaK0-eeHwhzSMZCtUpAKJRtjbU2H6Mw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix reference count leak in acpi_cppc_processor_probe.
To:     wu000273@umn.edu
Cc:     Kangjie Lu <kjlu@umn.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        Ashwin Chaugule <ashwin.chaugule@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:45 AM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Previous
> commit "b8eb718348b8" fixed a similar problem.
>
> Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/acpi/cppc_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 8b2e89c20c11..067067bc03d4 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -846,6 +846,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                         "acpi_cppc");
>         if (ret) {
>                 per_cpu(cpc_desc_ptr, pr->id) = NULL;
> +               kobject_put(&cpc_ptr->kobj);
>                 goto out_free;
>         }
>
> --

Applied as 5.8 material, thanks!
