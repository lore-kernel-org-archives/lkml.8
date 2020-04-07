Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92993C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op9I5tbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgDGQGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:06:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45324 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgDGQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:06:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so775846otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3T0puKgbBq3rfY+grvT0wOkCoDRrtJgTSPOBp3iVazk=;
        b=op9I5tbsEDyL+mZ3DXuvwohyBQu/tM90DwL0lN5jjdQ9cw55PXh0ud/ouLcfgb6ZA2
         1/nRIfNn0Uc2j6W7st1oLWuVobGoA45OeWVYU1ss7q44VyXLa9qBEclxovkM4cAhkyOB
         /fRccxfr0tw/Dw7cbjT0QAodtb0c6cBpqcA+rb3svXrF/w0OJTlPptw3762N5nyBkPnj
         ok+SRhIYRWlUba4WKslS5uPhjVSHibPd4qNiLf5As56IQclguuVZzNRxoSiOvAqbdoo9
         mjdFWMFImkaqwp9bG3PS0QkXJzOkWUpyyRric8Xdy0PtRdRtVFO28x4DcgPgBov/V+la
         pioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T0puKgbBq3rfY+grvT0wOkCoDRrtJgTSPOBp3iVazk=;
        b=j5/WOPWdY9tKBgi7KBr+cWpFnXBzG4RKyiOIFH7vPAN4KLkMG7FdSVS1LG6txJFB6E
         mrcrtG37SGHverupbvp48x0n/oebxk2v0xUYAVWdpsDScA7xO+NVAeDNL8WgPoITHwoK
         Topj3lNWJwD9F8HYLtdNR7G7z0zxxoSaL6irERoB3t2//lssSuR4/I+S8/7qbDdp7GDX
         bEcwZ+bAoKaZeeNgHkW9qtuMWP5udHrencOYwyg3ARDe82ISoHkEJKdjoyXlzjo+ZqC0
         6c7AEyVVQvsqpRbx6tgglXKZZBeLKaioj7EWHuFQjXND7UaxBy4U3W/j5sNm8ni299l9
         lV5Q==
X-Gm-Message-State: AGi0PubrY0seZRFmE1W4KZApqgl/q0ozYcIJ5uvrJ4uVmp2uzzp3gq3f
        qhLoC+fsXlNvb5kluYg3HlzbpZ0rNNtrRwVVHcKYimC8
X-Google-Smtp-Source: APiQypIJTouJhW6V6xueFoLhDGNBS+n9qhx8u78mTEIkC1qm9KkDMPD6OIVP9fMbzvjt5Eg5KwQCVsFkppg900W8swg=
X-Received: by 2002:a4a:e047:: with SMTP id v7mr2431670oos.49.1586275589121;
 Tue, 07 Apr 2020 09:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200407154643.10102-1-jack@suse.cz>
In-Reply-To: <20200407154643.10102-1-jack@suse.cz>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 7 Apr 2020 09:06:14 -0700
Message-ID: <CANaxB-wMOeR_aLfPdDKk-4RDp1Y0bwapbyGfp68Kg0p5M3-ZrQ@mail.gmail.com>
Subject: Re: [PATCH] ucount: Make sure ucounts in /proc/sys/user don't regress again
To:     Jan Kara <jack@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 8:46 AM Jan Kara <jack@suse.cz> wrote:
>
> Commit 769071ac9f20 "ns: Introduce Time Namespace" broke reporting of
> inotify ucounts (max_inotify_instances, max_inotify_watches) in
> /proc/sys/user because it has added UCOUNT_TIME_NAMESPACES into enum
> ucount_type but didn't properly update reporting in
> kernel/ucount.c:setup_userns_sysctls(). This problem got fixed in commit
> eeec26d5da82 "time/namespace: Add max_time_namespaces ucount". Add
> BUILD_BUG_ON to catch a similar problem in the future.
>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  kernel/ucount.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index a53cc2b4179c..3da4d868e452 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -81,6 +81,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
>  {
>  #ifdef CONFIG_SYSCTL
>         struct ctl_table *tbl;
> +
> +       BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
>         setup_sysctl_set(&ns->set, &set_root, set_is_seen);
>         tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
>         if (tbl) {
> --
> 2.16.4
>
