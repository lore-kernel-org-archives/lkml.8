Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED39C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8A32083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTKG2mu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIAJK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:10:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEAC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 02:10:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so590790ejf.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkWjP7J99RGaIk/+/yc3phGQ607PBeB2sCL7xCLcx1Q=;
        b=mTKG2mu396NdevY4U+6vq6hEBFogOdu7/3QEb+B0IGh9x5tDUHh6mrXyxxp9/VLSQS
         qiYp+UEmaM5XRbgBn7gGV+4gB0IyYLL/4ZWLeeV1PqBe+8d+RrRE4sWALZU66kwcplUY
         tWAFBGuOmZlAYDW8XGzCMPaQpGNBi9mSco39tHuQkTEqNimhfb10jL0t41VMi36g0pNK
         6NGlnbtlc8qd9uJOwmM/eSqK5kyIUnbaGHLh8hbq/8Cczs8dvEIRMCUoVxbKTOXZSWn7
         j2tvKOkJxvai2VUOxuH3KeGz8iRuCLvycA81FfhNtfVfk3SGnh6K+5pS/9ZldO04QJaz
         e6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkWjP7J99RGaIk/+/yc3phGQ607PBeB2sCL7xCLcx1Q=;
        b=r0eN35gbTfOzNOA1zsqb1iGktY7A2yOUA3s9aOdNbfFw1tE/3ngT79zqgUnhtxCR6b
         G2IWQv6IK00r6A68soCFxtnanRhbgPhD2YLfAejBgdtZP1+o20iqSjTwGSas8wvezY2z
         hXg4Z21hyEXMA4snvdmrB9OOoRAGJJv2qWMa/lfKlGU6hDha9qH6vvZkvI7+L+NZKJxb
         j+YcUH5jooekZPvsD+k3XKD95qB+1227ctUeFXvqxXFNVXH/5Ovx75XOvqsiPJSTAb2J
         P1pOqIM0yaZ+JxlLlTn30ClBpg2ZeFOBbuwaJ6ko4d3cYdPtF21rp8adS7Dq4OnzMdSh
         krTg==
X-Gm-Message-State: AOAM532y/+aCPqeHcyHE8CTBylPXNGrLivp0eENLefcU+OJQJUvgF/vW
        wtSA0U4W8Ge5o8Qdbv+KzddSUkRc8C0VxWkBrFc=
X-Google-Smtp-Source: ABdhPJwM2CGcSDsMjaADcWYW8VP+Coo4uHyU3V0Y2y5LfeIxoldgaaR6+GgCZwOPpzNLDYB1S61iqLDE0LLG1qVl3Qs=
X-Received: by 2002:a17:906:2a04:: with SMTP id j4mr662557eje.440.1598951424537;
 Tue, 01 Sep 2020 02:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200831221007.1506441-1-saravanak@google.com>
In-Reply-To: <20200831221007.1506441-1-saravanak@google.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 1 Sep 2020 16:55:00 +0800
Message-ID: <CAA+hA=QmG+k1tZ2fRDpAewzF6pE7SeERxkeHsSEXRxEhvBwFqg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix device_pm_lock() locking for device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana

On Tue, Sep 1, 2020 at 6:10 AM Saravana Kannan <saravanak@google.com> wrote:
>
> This commit fixes two issues:
>
> 1. The lockdep warning reported by Dong Aisheng <dongas86@gmail.com> [1].
>
> It is a warning about a cycle (dpm_list_mtx --> kn->active#3 --> fw_lock)
> that was introduced when device-link devices were added to expose device
> link information in sysfs.
>
> The patch that "introduced" this cycle can't be reverted because it's fixes
> a real SRCU issue and also ensures that the device-link device is deleted
> as soon as the device-link is deleted. This is important to avoid sysfs
> name collisions if the device-link is create again immediately (this can
> happen a lot with deferred probing).
>
> 2. device_link_drop_managed() is not grabbing device_pm_lock().
>
> When device_link_del() calls __device_link_del() (device_link_del() ->
> device_link_put_kref() kref_put() -> __device_link_del()) it grabs the
> device_pm_lock().
>
> However, when device_link_drop_managed() calls __device_link_del()
> (device_link_drop_managed() -> kref_put() -> __device_link_del()) it
> doesn't grab device_pm_lock(). There's nothing special about managed
> device-links that remove the need for grabbing device_pm_lock(). So, this
> patch makes sure device_pm_lock() is always held when deleting managed
> links.
>
> And thanks to Stephen Boyd for helping me understand the lockdep splat.
>
> Fixes: 843e600b8a2b ("driver core: Fix sleeping in invalid context during device link deletion")
> Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
> [1] - https://lore.kernel.org/lkml/CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com/
> Reported-by: Dong Aisheng <dongas86@gmail.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks a lot for the quick fix. It worked for me.

Tested-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng

> ---
>
> Rafael,
>
> A bigger question I had is why we need to grab device_pm_lock() around
> device_link_del() in the first place. I understand the need to grab it
> during device_link_add() -- it's because we are checking the supplier is
> in the dpm_list and because we are reordering devices on the dpm_list.
>
> But during deletion, we don't need to do either one of those.  So, why
> do we even need to grab the device_pm_lock() in the first place. The
> device_links_write_lock() that we already grab before deleting a device
> link seems like it'd be sufficient. If you agree we don't need to grab
> device_pm_lock() during deletion, then I can change this patch to just
> delete that locking.
>
> -Saravana
>
>  drivers/base/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f6f620aa9408..de1935e21d97 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -766,8 +766,10 @@ static void __device_link_del(struct kref *kref)
>         if (link->flags & DL_FLAG_PM_RUNTIME)
>                 pm_runtime_drop_link(link->consumer);
>
> +       device_pm_lock();
>         list_del_rcu(&link->s_node);
>         list_del_rcu(&link->c_node);
> +       device_pm_unlock();
>         device_unregister(&link->link_dev);
>  }
>  #else /* !CONFIG_SRCU */
> @@ -781,8 +783,10 @@ static void __device_link_del(struct kref *kref)
>         if (link->flags & DL_FLAG_PM_RUNTIME)
>                 pm_runtime_drop_link(link->consumer);
>
> +       device_pm_lock();
>         list_del(&link->s_node);
>         list_del(&link->c_node);
> +       device_pm_unlock();
>         device_unregister(&link->link_dev);
>  }
>  #endif /* !CONFIG_SRCU */
> @@ -807,9 +811,7 @@ static void device_link_put_kref(struct device_link *link)
>  void device_link_del(struct device_link *link)
>  {
>         device_links_write_lock();
> -       device_pm_lock();
>         device_link_put_kref(link);
> -       device_pm_unlock();
>         device_links_write_unlock();
>  }
>  EXPORT_SYMBOL_GPL(device_link_del);
> @@ -830,7 +832,6 @@ void device_link_remove(void *consumer, struct device *supplier)
>                 return;
>
>         device_links_write_lock();
> -       device_pm_lock();
>
>         list_for_each_entry(link, &supplier->links.consumers, s_node) {
>                 if (link->consumer == consumer) {
> @@ -839,7 +840,6 @@ void device_link_remove(void *consumer, struct device *supplier)
>                 }
>         }
>
> -       device_pm_unlock();
>         device_links_write_unlock();
>  }
>  EXPORT_SYMBOL_GPL(device_link_remove);
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
