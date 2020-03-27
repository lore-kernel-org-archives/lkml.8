Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A643C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59C2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xSOnox+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgC0WpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:45:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45195 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC0WpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:45:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id u59so13206900edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LGuc0QqW9HR71Y1NNbAkC8Bf5W/OzoGDIgpyPzWX5k=;
        b=xSOnox+1TN9e9prVqWp62ZCF3N/UkOZnjrZvSo7uZZHGBIs480j52MjNHh+TbQoueQ
         DVqn7TmWHGc3Nu/z7VBqVnEHJ53ndRea5gywFzuSDnMCz3fQdoR25ZMt2x7hb1P8V25W
         IfO+S+4V7ixws6ZtcIaQArFxwnKE75D9vC1Pv246btnV03YxkXfMiIXaju+QBWEbPVsB
         DiIOkT2ejeaX5DcN93WU5FVtzcD10HpTGZkIvQAEFX7710KHXupTRPnHnxtWOzTNw49a
         aqS9exTHbBGD6cEnFFiMc2s1GchbIdLRf9tY1V4ACtXUnNZgNF5orFPB9hF8mjOeTCJC
         Wkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LGuc0QqW9HR71Y1NNbAkC8Bf5W/OzoGDIgpyPzWX5k=;
        b=AdLP6TxYjbEtRmE4K+GFOjqmUCzGtyCzWKMwR4kI5yUmvXpAOT/4j/K8qF9nksO36q
         zHnOCSYnsRkkwSc3oCISTDKp0M594pZ8Nb/wZ2wkA+4pHOi9b2psszPjAePpIlQXHNz9
         e9IyY4t/R14gsOHlu9QgA1ijGXu14El74ytI9O/996faN+SC2NBWY5pBquinzZCSIqcs
         4ZI/Uqrx3wtt5nnrXVD0zxELD2So+32SCLzl0LQkZuh7Aa2ABxOrbf+m9/JWctdKOQdW
         rYm0Wg//Kew21CGq5/tbaY8HpjpA+ocE6N2sHI/KowmCkZuDZZPewDhw2P/G1IPoqKJA
         QtTw==
X-Gm-Message-State: ANhLgQ3rdMB3Nr8DLLvJVjVxce4Pqsf9A6MRtxTDlOW1Tior2idOhzyi
        zsx/KpAHhH/dIeJBptqYSR4D7JFznHkSaH4sl7Sy
X-Google-Smtp-Source: ADFU+vtPz2f20HeMrGRumvzvtd33Lj903GfTooGJ3K0DV5XYxoq4cFDiri2nBc6zrER/kask/V6CYP3kgc4C49YuTBQ=
X-Received: by 2002:aa7:dd01:: with SMTP id i1mr1459195edv.164.1585349100363;
 Fri, 27 Mar 2020 15:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200327174402.351334-1-colin.king@canonical.com>
In-Reply-To: <20200327174402.351334-1-colin.king@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Mar 2020 18:44:49 -0400
Message-ID: <CAHC9VhQOdoNXHjymbMCh1p0Bun5+bzxykhWzPNtjcwoEJ0cAjA@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up indentation issue with assignment statement
To:     Colin King <colin.king@canonical.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 1:44 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The assignment of e->type_names is indented one level too deep,
> clean this up by removing the extraneous tab.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/ss/policydb.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I generally dislike style/formatting only changes, but one could argue
that this is just plain wrong regardless of how you like your code to
look.

I also dislike merging changes into selinux/next when we are at -rc7,
but this is trivial and obviously correct.

However, despite not wanting to merge this into selinux/next I decided
to do just that - thanks for the fix. :)

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 932b2b9bcdb2..70ecdc78efbd 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1219,10 +1219,9 @@ static int read_cons_helper(struct policydb *p,
>                                 if (rc)
>                                         return rc;
>                                 if (p->policyvers >=
> -                                       POLICYDB_VERSION_CONSTRAINT_NAMES) {
> -                                               e->type_names = kzalloc(sizeof
> -                                               (*e->type_names),
> -                                               GFP_KERNEL);
> +                                   POLICYDB_VERSION_CONSTRAINT_NAMES) {
> +                                       e->type_names = kzalloc(sizeof
> +                                               (*e->type_names), GFP_KERNEL);
>                                         if (!e->type_names)
>                                                 return -ENOMEM;
>                                         type_set_init(e->type_names);
> --
> 2.25.1

-- 
paul moore
www.paul-moore.com
