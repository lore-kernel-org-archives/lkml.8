Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FB0206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTO4yNSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHaJpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgHaJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:45:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:45:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l8so5203069ios.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/wJhQzLekIbhWUFB8CBHk7CDQYQkmDO/XAl9zxuSaU=;
        b=BTO4yNSgCoI25Xg7JSJrzr10BL4nA+/KtGiUNOUOfG2H7W7QvoCE3EPKXBVnUObt54
         H3KcidXy063F3eVEIdySSwsgKwFnSXd88rxrRfpNkqNUwiLwmkqktstHxTzwobj5S35B
         uvhwqbKtxZKNLmVLiWGEcr9Bh0njlbSX8+g8LiJr4Ehro3tF4CdmCFbCgZu4XkQmloJ/
         w3usDuRF0eQPVFCsk+9nLyDq6owIf1+bus1z3Ag9jZ6fQYnHFr5QSCci6O1iWYOG0w3e
         QPj+EsSh8f0dHt9LFq79mrQBvEMisdmTXHTN9SVEBWQt8/DSYtLzZYFNchuL+RH12JIX
         nGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/wJhQzLekIbhWUFB8CBHk7CDQYQkmDO/XAl9zxuSaU=;
        b=kHqOahHfgEXciYxKNLoD/wy23SzEP/VBiQfUkdeKEpVLG5fyd3SIbNZcEiqMPZWORi
         oYJ/pyHrDiXO3aI0JrPCZhXIwXu/YTTTB9ezcCrjuvacOpTts7KA7tvK4N8KeohSo/QV
         xGOQvMoltGfnE8hLlao+B1YRfQG5cqOU1gsk/Vy+r4rr3rS/N+PXo5JICcxwDLW0Ra/A
         5d7siVybPacFP/zWoRSpMSFZsJpTbth5WODxWtd6hlsKX7U0ScIwkKmdRMiyGAcxQNDt
         Qk5OBKgY2HjlLLOXav+NjsnhaKSChWAue43PrlRwkHTRqkbiZ3Yc9Y7mP6QIrwCTOjIV
         ir8Q==
X-Gm-Message-State: AOAM533Hz5MZ3qnqxeu+SkG7Ko0YLKPufk/CtAW/Gxtx7Ss3+2eAtHfo
        rcpmKxoUQgE86ciuQnML8Xtcn93I+FPnYZby60KyqGbD9iE=
X-Google-Smtp-Source: ABdhPJwWYaGimABsUFlmyBNL2gNq2/et8GfL8wEB7EeSIW66hiMjHMYtzhgWnn4EkRrP89FRe5AI8poN0nfcV70UKwc=
X-Received: by 2002:a05:6602:1694:: with SMTP id s20mr575122iow.159.1598867131223;
 Mon, 31 Aug 2020 02:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200830081053.64981-1-songmuchun@bytedance.com>
In-Reply-To: <20200830081053.64981-1-songmuchun@bytedance.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 31 Aug 2020 11:45:20 +0200
Message-ID: <CAM9Jb+hBeZO=y0=pKUhT6G=qF8-mcZU86wY_A6N7-cT5tJ1wmw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Fix return wrong value when isolate
 page fail
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When we isolate page fail, we should not return 0, because we do not
> set page HWPoison on any page.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memory-failure.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 696505f56910..4eb3c42ffe35 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1850,6 +1850,7 @@ static int __soft_offline_page(struct page *page)
>         } else {
>                 pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
>                         pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
> +               ret = -EBUSY;
>         }
>         return ret;
>  }
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> 2.11.0
>
>
