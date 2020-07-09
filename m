Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93BB20767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="V78WOIaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgGISKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgGISKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:10:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8569C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:10:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so3245919ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tpny+IfvksUcNBVh7AI/yK93gIOPfFjHFotjL50OR4=;
        b=V78WOIaMdW2+HJXmaAk4+l1yyNYhuFDu7Klmt8XO8dTcnxzNsqC2HKNIwBXLTzrkMI
         eOX6I8fz130icVJrTMuB4tV/V+GMkPPyflPOeNhTSTdoyAFOB0wo8em6imZsoRAvdzZ0
         UwmNfjHPbiF4rrtMSxm0QAW1S7R/M2BRqnOPZMEo0ueTEC9Y6IhXC1I0RWyO+Q6qcTtU
         yOQxC0HlVF3rNbd+UwHxJ+jGbWdwhw+ImFt7Q5XBp5UA6VfV1WrCp8uWo7I+G1SVqU0B
         gE7XC5KF+hZSla1qgna2zWFsJPej+a5ylJKr9dHpKpq4bMlecSVMnd9UrX1+FIonrg4d
         BMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tpny+IfvksUcNBVh7AI/yK93gIOPfFjHFotjL50OR4=;
        b=hYAY5JVEdp1s3nL1IO20Gn+eyQqgwS+C8eZ5WvLQdd2g5CvM/Bjhl91KvlRQCMDiGI
         QMLOR1DCYWTfsb8EPvX1gxKcxfdmq/YmxTdnAqqHntHj0r7jTn2SuGyIpQyFZ0xBWGiL
         eeEMeOSASCZCHmHw3hlIZFyWw5aOviFSY7EMNT9T7kq4dEM8ZUTiC9eSqFzdLJj/Irjf
         kZjEAwCuu0VfYDqORdNPH3IASOUo7c2WSlMYuY/VbKJfFPCIqBnD45dU/dADsYnFfs4w
         wSw1khbsnYOZH9GCNzqy/Yb1w2nimu8wxK1QGIqoy3AAaDNZ7XOhKSdn+y/gV5sO7aLe
         kRYw==
X-Gm-Message-State: AOAM531VGJUe13AIPFmrqghybRG/FryUJZnC2NRLyOtPhNIsY2Cynj0v
        4qHMCZZNL70ph4BOo8d3iRdZuBfQwVSEC3ploYY8
X-Google-Smtp-Source: ABdhPJyOf27f7rBkDHb/taO3jhGZp1ofl38ev63qsacDu5oyMNiV7flyGxc80dtDZgYb7m/loYb4o2qzRc4QPQV+BSM=
X-Received: by 2002:a17:906:4757:: with SMTP id j23mr30313846ejs.431.1594318208476;
 Thu, 09 Jul 2020 11:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200709131111.4mqrge6vjsbfs7ls@archlaptop.localdomain>
In-Reply-To: <20200709131111.4mqrge6vjsbfs7ls@archlaptop.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Jul 2020 14:09:57 -0400
Message-ID: <CAHC9VhSXfo6-S1awsPdj-Zm5Bj+Na1ZgDUi-2XqS7ASVP=+mKA@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: ss: conditional.c fixed a checkpatch warning
To:     Ethan Edwards <ethancarteredwards@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 9:11 AM Ethan Edwards
<ethancarteredwards@gmail.com> wrote:
>
> `sizeof buf` changed to `sizeof(buf)`
>
> Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
> ---
>  security/selinux/ss/conditional.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Why are you reposting this when I applied your original patch last week?

https://lore.kernel.org/selinux/CAHC9VhSakA7V99+tkvLLZHohiupWmjSFxSZLWZT4-Gwr5Cc-XA@mail.gmail.com

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 0cc7cdd58465..90a2f5927e55 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -215,7 +215,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
>         if (!booldatum)
>                 return -ENOMEM;
>
> -       rc = next_entry(buf, fp, sizeof buf);
> +       rc = next_entry(buf, fp, sizeof(buf));
>         if (rc)
>                 goto err;
>
> @@ -416,7 +416,7 @@ int cond_read_list(struct policydb *p, void *fp)
>         u32 i, len;
>         int rc;
>
> -       rc = next_entry(buf, fp, sizeof buf);
> +       rc = next_entry(buf, fp, sizeof(buf));
>         if (rc)
>                 return rc;
>
> --
> 2.27.0
>


-- 
paul moore
www.paul-moore.com
