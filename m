Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AD82078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590567984;
	bh=5/AiaiHLDrMmoyJq/CBgGo0zb8S6b8Euvgc0uSAHcxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Op8dS4pgz+9JOmcCxrgH2uZ/ht81PSmRv8z0iUQjpma9M4Hw8KHiTezYUZl/gM4TP
	 DMRmg/8byM+86dHvAHX/ZyPok662Qln9sjPKqCzZeqQQQ7euVJHlwQH60PYmXEvddQ
	 KLh29wUYKLu6m1RQRxvBSybG4/G564XotfL6ZTz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgE0I0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:26:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39507 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgE0I0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:26:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id d7so18554822ote.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQFRXlz3v9KYQYWqUMLTA9a2mKxkyTeWpiP5hi9u5L4=;
        b=npYWwJEa3bwqZbqOCpEaXGZHFaYGsirfP6aFoRB5h/VN47xGXMdpYP20tnod9AN8Gh
         ynx0aaiB0ZYQvLcoPfpLzbAz4K4ORcq3S7t8Gbe0qhh1c+r0U0yOmhluBwdLrFGFFZPW
         PmaVDQIdCxsKc688gGI7trhN7xWqnWsoP4En71Og8JX41hiGVS0wvjsi+wNKEGNMNc1Y
         nwv+VpTHxGEp8x5oCYEnMzEY9LLrfQomX7XGaRbRzBWK5CJBSFMBaqPJ093EW7v+737G
         64LlKD3YLPtU7bmNigNeFAGr8ywqf/sRb+D/Ay8p6siPAl7h2QQ2fBpihdPmpUGcXggh
         lxMg==
X-Gm-Message-State: AOAM5301lLUt1lU/gqDF2bakPY1dj/x9kkc/WpQ/amnAA0JWAxovID7e
        aOCkcxm8++3CAd607YH581h/Y6AFNdOEvng1scHvng==
X-Google-Smtp-Source: ABdhPJxATt9xir+JiHA+8fLq5HMyihvzwGeOlU5PbXGiuq9krANLTtsthjybb5V2mu6JESSNjfdsqW4qDBV87Ys0WgU=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr3648935otf.167.1590567981105;
 Wed, 27 May 2020 01:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc> <20200526220928.49939-1-saravanak@google.com>
In-Reply-To: <20200526220928.49939-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 10:26:08 +0200
Message-ID: <CAJZ5v0g3Oo82-eUDqgSTGBM-dpaJEfOtvaXRVMmDQvHg72rAJw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:09 AM Saravana Kannan <saravanak@google.com> wrote:
>
> When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
> core: Add device link support for SYNC_STATE_ONLY flag"),
> SYNC_STATE_ONLY links were treated similar to STATELESS links in terms
> of not blocking consumer probe if the supplier hasn't probed yet.
>
> That caused a SYNC_STATE_ONLY device link's status to not get updated.
> Since SYNC_STATE_ONLY device link is no longer useful once the
> consumer probes, commit 21c27f06587d ("driver core: Fix
> SYNC_STATE_ONLY device link implementation") addresses the status
> update issue by deleting the SYNC_STATE_ONLY device link instead of
> complicating the status update code.
>
> However, there are still some cases where we need to update the status
> of a SYNC_STATE_ONLY device link. This is because a SYNC_STATE_ONLY
> device link can later get converted into a normal MANAGED device link
> when a normal MANAGED device link is created between a supplier and
> consumer that already have a SYNC_STATE_ONLY device link between them.
>
> If a SYNC_STATE_ONLY device link's status isn't maintained correctly
> till it's converted to a normal MANAGED device link, then the normal
> MANAGED device link will end up with a wrong link status. This can cause
> a warning stack trace[1] when the consumer device probes successfully.
>
> This commit fixes the SYNC_STATE_ONLY device link status update issue
> where it wouldn't transition correctly from DL_STATE_DORMANT or
> DL_STATE_AVAILABLE to DL_STATE_CONSUMER_PROBE. It also resets the status
> back to DL_STATE_DORMANT or DL_STATE_AVAILABLE if the consumer probe
> fails.
>
> [1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
> Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
> Reported-by: Michael Walle <michael@walle.cc>
> Tested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Rafael J. Wysocki <rrafael.j.wysocki@intel.com>

> ---
> v1->v2:
> - Added code to "revert" the link status if consumer probe fails
>
> v2->v3:
> - Fixed copy-pasta where I was checking link->status instead of
>   link->flags.
>
>  drivers/base/core.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 791b7530599f..9a76dd44cb37 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -646,9 +646,17 @@ static void device_links_missing_supplier(struct device *dev)
>  {
>         struct device_link *link;
>
> -       list_for_each_entry(link, &dev->links.suppliers, c_node)
> -               if (link->status == DL_STATE_CONSUMER_PROBE)
> +       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> +               if (link->status != DL_STATE_CONSUMER_PROBE)
> +                       continue;
> +
> +               if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
>                         WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> +               } else {
> +                       WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
> +                       WRITE_ONCE(link->status, DL_STATE_DORMANT);
> +               }
> +       }
>  }
>
>  /**
> @@ -687,11 +695,11 @@ int device_links_check_suppliers(struct device *dev)
>         device_links_write_lock();
>
>         list_for_each_entry(link, &dev->links.suppliers, c_node) {
> -               if (!(link->flags & DL_FLAG_MANAGED) ||
> -                   link->flags & DL_FLAG_SYNC_STATE_ONLY)
> +               if (!(link->flags & DL_FLAG_MANAGED))
>                         continue;
>
> -               if (link->status != DL_STATE_AVAILABLE) {
> +               if (link->status != DL_STATE_AVAILABLE &&
> +                   !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
>                         device_links_missing_supplier(dev);
>                         ret = -EPROBE_DEFER;
>                         break;
> @@ -952,11 +960,21 @@ static void __device_links_no_driver(struct device *dev)
>                 if (!(link->flags & DL_FLAG_MANAGED))
>                         continue;
>
> -               if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
> +               if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
>                         device_link_drop_managed(link);
> -               else if (link->status == DL_STATE_CONSUMER_PROBE ||
> -                        link->status == DL_STATE_ACTIVE)
> +                       continue;
> +               }
> +
> +               if (link->status != DL_STATE_CONSUMER_PROBE &&
> +                   link->status != DL_STATE_ACTIVE)
> +                       continue;
> +
> +               if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
>                         WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> +               } else {
> +                       WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
> +                       WRITE_ONCE(link->status, DL_STATE_DORMANT);
> +               }
>         }
>
>         dev->links.status = DL_DEV_NO_DRIVER;
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
