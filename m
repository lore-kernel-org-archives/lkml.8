Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE06F206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589965997;
	bh=uXpehXfQAXLtA1Bk4iTWrCyHj87VS/F/DgihMsGHERE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cl/6PW3YIptd+R8dPUnacYazMi93SjsuEZ+62ColcKtipAVCrYRASBJCLhERu5RPZ
	 /JkE7sqvsdZYJpV0K72rPtgkV7HSnZX2UgCcQf6W/DqfLHheFqzrzo8j7ERktYHDmM
	 BIJb10oxqIQhYtKnbbMWJGT9Rwml01r57NJsPDvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETJNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:13:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42839 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:13:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id z3so1878127otp.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoitxofxdcZF88ApsFuFoZL7BHUanT6st1VxSuWkKL0=;
        b=VFVoCW6IJLcdy7EbZ/HNQKfrogt3fGtybVP4DZMmBmhoaJGTwml92MDN3KNl5kTiUT
         gTSXUdjcvPe9AZPF0oVoXbyi944+0dTFYJC78GjSIgcQA4nsUaiT3AfOx4RDWDq1x/6m
         x/ETcV4aOW7cn9u3ETouR98QLEzsI3YCBtabZmz9wUHMXShuGy73cmTgIIk+OFxcgro1
         2rgz0Slg6jeu2duTrKKAxOC4pjWWZ+WWYjv5exn7xf7JMerhTDx0P8G/whzCwMLVS/gm
         0lUJIMN3pLCrO608Tnx3tQL+QMidaSz3M1AUG/zHF63sK1BvIvc/AypQPoriLkC5I3ND
         FNTQ==
X-Gm-Message-State: AOAM530qEz2+h5p/hiyi0hAaxjWlHGXOmxU/WSn7WV1STS51dMDCIkpZ
        CSlYu2N5MNdM3DH4s7UXwQm5KgQJdcgv5Wfk99w=
X-Google-Smtp-Source: ABdhPJxvoAXt54eunVMvuRpdJq87YT21H8CqKDI5O6EsnR6CKJSkxxpmzBKh8V6YHgmFI2Bdps53BzlZFKbNhdSLwMs=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr2495693otc.262.1589965994552;
 Wed, 20 May 2020 02:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200520043626.181820-1-saravanak@google.com>
In-Reply-To: <20200520043626.181820-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 11:13:03 +0200
Message-ID: <CAJZ5v0iKcks7g1hKL+OfhwAhfF7G7Ma10X3=aRGuXEJw=CUHJA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix handling of SYNC_STATE_ONLY +
 STATELESS device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 6:36 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Commit 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
> implementation") didn't completely fix STATELESS + SYNC_STATE_ONLY
> handling.
>
> What looks like an optimization in that commit is actually a bug that
> causes an if condition to always take the else path. This prevents
> reordering of devices in the dpm_list when a DL_FLAG_STATELESS device
> link is create on top of an existing DL_FLAG_SYNC_STATE_ONLY device
> link.
>
> Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Sigh... device links are tricky and hard! Sorry about the endless fixes :(
> Also, how was this not caught by the compiler as a warning?

Well, I haven't spotted this either ...

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>  drivers/base/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 83a3e0b62ce3..dfd4e94ef790 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -543,12 +543,14 @@ struct device_link *device_link_add(struct device *consumer,
>
>                 if (flags & DL_FLAG_STATELESS) {
>                         kref_get(&link->kref);
> -                       link->flags |= DL_FLAG_STATELESS;
>                         if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
> -                           !(link->flags & DL_FLAG_STATELESS))
> +                           !(link->flags & DL_FLAG_STATELESS)) {
> +                               link->flags |= DL_FLAG_STATELESS;
>                                 goto reorder;
> -                       else
> +                       } else {
> +                               link->flags |= DL_FLAG_STATELESS;
>                                 goto out;
> +                       }
>                 }
>
>                 /*
> --
> 2.26.2.761.g0e0b3e54be-goog
>
