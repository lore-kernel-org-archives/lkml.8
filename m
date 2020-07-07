Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B358E20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594137753;
	bh=afdTfMkLFX5tM4Gb2ShzctMF3UHYX3lx+SJtq/8jgr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n6809P4/y7eH8W5wm2uWWDk/yF1bv0wAwHFQ1q33sLSwOV0bsiYGYMuDLNmBEPu98
	 L8xJ/TMi3uX7Sxwi7cmwn4rnVCpyKZR0/nKXVQuI74ug+TjP9O/CZjcIFvYHmr27V6
	 c/WfmI8bcd+ceG3NyibJ1Wvxg8K3kuwgq/VWOERY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgGGQCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:02:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39193 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgGGQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:02:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id 18so34660521otv.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ze/Zhr7gcibvF5oQVnxz/AHUTpnnF5GAsl+lQqgR+8Y=;
        b=Ui0ouDR1kdEJrGrv2YqCGM0Bcm+V8emumcYf0fRkb6pOmfd6vUvEfpa4SKtuH7eE4U
         pATPAoU4p1eaZF6JQa3C/jJm9WoO/gvz7a/EYzcD/ChsFyxBvHtSpaLSJ7kziLzPRkeh
         T6vxr3JrweOdTP3x4eg5sQYpBDP03NXjO/HqHjmSgMUFQJy+uFNlNv0lYdDwDKVPfLaI
         PiFlJExhjUaUP+373OSszWd1Rtb1beJ4+0UxTuJW3+KeEWwYYWKaaQcm6g++58FF+aDv
         4OlDNO9HlCZiUVg/ijMrG3j55xCduInF9NIjjT96ZlxsoBKufz9RciQtDg/Kq0fwlxdD
         s6WA==
X-Gm-Message-State: AOAM530o2sHpvoDj+T51s37kG4Azl61eSHg194F9Rst7bVPwFhBgFCYh
        4S+HZE17REkk3b/+X9SjtoF4g/fNEjvV4qk6boE=
X-Google-Smtp-Source: ABdhPJzsB9vH8x8AYOO7tw3LskSYF1k1Al3bjJk1ljBFielqocWpx1VDyzLeYGFNp663tL0cLXmOG3o1/ivrK4rXYtU=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr24297676ots.118.1594137751260;
 Tue, 07 Jul 2020 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com> <20200701194259.3337652-3-saravanak@google.com>
In-Reply-To: <20200701194259.3337652-3-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 18:02:20 +0200
Message-ID: <CAJZ5v0hy3vUUWzTrYFQxDEbJ-SKiVLW4rSvqReDZL__n5TnNfA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] driver core: Rename dev_links_info.defer_sync to defer_hook
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 9:43 PM Saravana Kannan <saravanak@google.com> wrote:
>
> The defer_sync field is used as a hook to add the device to the
> deferred_sync list. Rename it so that it's more meaningful for the next
> patch that'll also use this field as a hook to a deferred_fw_devlink
> list.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This is a trivial rename if I'm not mistaken, so

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>


> ---
>  drivers/base/core.c    | 22 +++++++++++-----------
>  include/linux/device.h |  4 ++--
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 35cc9896eb9e..d1d2cdc3a8d8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -754,11 +754,11 @@ static void __device_links_queue_sync_state(struct device *dev,
>          */
>         dev->state_synced = true;
>
> -       if (WARN_ON(!list_empty(&dev->links.defer_sync)))
> +       if (WARN_ON(!list_empty(&dev->links.defer_hook)))
>                 return;
>
>         get_device(dev);
> -       list_add_tail(&dev->links.defer_sync, list);
> +       list_add_tail(&dev->links.defer_hook, list);
>  }
>
>  /**
> @@ -776,8 +776,8 @@ static void device_links_flush_sync_list(struct list_head *list,
>  {
>         struct device *dev, *tmp;
>
> -       list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
> -               list_del_init(&dev->links.defer_sync);
> +       list_for_each_entry_safe(dev, tmp, list, links.defer_hook) {
> +               list_del_init(&dev->links.defer_hook);
>
>                 if (dev != dont_lock_dev)
>                         device_lock(dev);
> @@ -815,12 +815,12 @@ void device_links_supplier_sync_state_resume(void)
>         if (defer_sync_state_count)
>                 goto out;
>
> -       list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
> +       list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_hook) {
>                 /*
>                  * Delete from deferred_sync list before queuing it to
> -                * sync_list because defer_sync is used for both lists.
> +                * sync_list because defer_hook is used for both lists.
>                  */
> -               list_del_init(&dev->links.defer_sync);
> +               list_del_init(&dev->links.defer_hook);
>                 __device_links_queue_sync_state(dev, &sync_list);
>         }
>  out:
> @@ -838,8 +838,8 @@ late_initcall(sync_state_resume_initcall);
>
>  static void __device_links_supplier_defer_sync(struct device *sup)
>  {
> -       if (list_empty(&sup->links.defer_sync) && dev_has_sync_state(sup))
> -               list_add_tail(&sup->links.defer_sync, &deferred_sync);
> +       if (list_empty(&sup->links.defer_hook) && dev_has_sync_state(sup))
> +               list_add_tail(&sup->links.defer_hook, &deferred_sync);
>  }
>
>  static void device_link_drop_managed(struct device_link *link)
> @@ -1052,7 +1052,7 @@ void device_links_driver_cleanup(struct device *dev)
>                 WRITE_ONCE(link->status, DL_STATE_DORMANT);
>         }
>
> -       list_del_init(&dev->links.defer_sync);
> +       list_del_init(&dev->links.defer_hook);
>         __device_links_no_driver(dev);
>
>         device_links_write_unlock();
> @@ -2171,7 +2171,7 @@ void device_initialize(struct device *dev)
>         INIT_LIST_HEAD(&dev->links.consumers);
>         INIT_LIST_HEAD(&dev->links.suppliers);
>         INIT_LIST_HEAD(&dev->links.needs_suppliers);
> -       INIT_LIST_HEAD(&dev->links.defer_sync);
> +       INIT_LIST_HEAD(&dev->links.defer_hook);
>         dev->links.status = DL_DEV_NO_DRIVER;
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024..9bb2bc7bb8e3 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -433,7 +433,7 @@ enum dl_dev_state {
>   * @suppliers: List of links to supplier devices.
>   * @consumers: List of links to consumer devices.
>   * @needs_suppliers: Hook to global list of devices waiting for suppliers.
> - * @defer_sync: Hook to global list of devices that have deferred sync_state.
> + * @defer_hook: Hook to global list of devices that have deferred sync_state.
>   * @need_for_probe: If needs_suppliers is on a list, this indicates if the
>   *                 suppliers are needed for probe or not.
>   * @status: Driver status information.
> @@ -442,7 +442,7 @@ struct dev_links_info {
>         struct list_head suppliers;
>         struct list_head consumers;
>         struct list_head needs_suppliers;
> -       struct list_head defer_sync;
> +       struct list_head defer_hook;
>         bool need_for_probe;
>         enum dl_dev_state status;
>  };
> --
> 2.27.0.212.ge8ba1cc988-goog
>
