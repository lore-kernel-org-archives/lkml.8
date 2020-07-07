Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2D820674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594137562;
	bh=pHABt1xkSO30pAE6pokYsrVBJow+rhBN54eHVjPGB24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FkRR7wOT54t3LZckOvAnwwcESXO6pKUkXWwSyBNN+l2oJcGSwQ4Tx2PAZ8t544GEJ
	 btRWFU8ZgHHMg2Re/nfhOEm9r2c2nFZGPYfQ64qVsI9qiTHb+TIBnGrxjJw4hMSmQG
	 oLNB38b9a5fGlEHZgLjCKmop4RyQfCfwozIDdbHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgGGP7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:59:21 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:35238 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:59:20 -0400
Received: by mail-oo1-f66.google.com with SMTP id k47so4707041ool.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybKYjyxhBNv1kTn9dag4mFuNouSoGCR2/Y20joSpfWA=;
        b=aOin9jLMmI+aTwtKSECSRBbu9zlMTTARa11CekVdx4rOqDkF8y8MTDlgt/prS8gEsC
         ZzGhFYcmJLnKY5y4qXGcc6iobndOJnhq8Kz91mFOR5MDdSEowBDISgf8gVyobhWcq12e
         JXrxyfdQHCJDGaxCj7pcRz3BUvTAAGyR5yM9fejeAImONzLbSr3XgGesPSWW5hifBJd5
         eCDMObkFA/REhQYopCu/c9t8dkiaLwgLdmnvhezHzzJZopz8Ea6f1uH+zDmk83McKpDZ
         BGs2hflYC4UdK+MxJtVgGN75R32ymx2N/sb2imIP4VO6kRV6mEGLC4oxBJS9Z/afiW3F
         X6eA==
X-Gm-Message-State: AOAM5314unHPBfnTtgt0mwT8crLwYEN/6sMzBcZ+uyHalBgoY7zAHdu2
        OaPrkZXEMj19w98Ftyi9ucDY52t0dZ5TNDLOub8=
X-Google-Smtp-Source: ABdhPJxgIcG1DZyavED8sdSqF07AzJotJeUnC8/Ncw9mnaxVZb6e+P2ytm8y9iWc+fyHIcwiLTvMhXzxRPXtsphT+HE=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr47061329oov.75.1594137559641;
 Tue, 07 Jul 2020 08:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com> <20200701194259.3337652-2-saravanak@google.com>
In-Reply-To: <20200701194259.3337652-2-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 17:59:08 +0200
Message-ID: <CAJZ5v0jS39EPgsiNrGzCGeSpMpccu2tUQZ_zn9PABMMmtD-PBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Don't do deferred probe in parallel
 with kernel_init thread
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
> The current deferred probe implementation can mess up suspend/resume
> ordering if deferred probe thread is kicked off in parallel with the
> main initcall thread (kernel_init thread) [1].
>
> For example:
>
> Say device-B is a consumer of device-A.
>
> Initcall thread                                 Deferred probe thread
> ===============                                 =====================
> 1. device-A is added.
> 2. device-B is added.
> 3. dpm_list is now [device-A, device-B].
> 4. driver-A defers probe of device-A.
>                                                 5. device-A is moved to
>                                                    end of dpm_list
>                                                 6. dpm_list is now
>                                                    [device-B, device-A]
> 7. driver-B is registereed and probes device-B.
> 8. dpm_list stays as [device-B, device-A].
>
> The reverse order of dpm_list is used for suspend. So in this case
> device-A would incorrectly get suspended before device-B.
>
> Commit 716a7a259690 ("driver core: fw_devlink: Add support for batching
> fwnode parsing") kicked off the deferred probe thread early during boot
> to run in parallel with the initcall thread and caused suspend/resume
> regressions.  This patch removes the parallel run of the deferred probe
> thread to avoid the suspend/resume regressions.
>
> [1] - https://lore.kernel.org/lkml/CAGETcx8W96KAw-d_siTX4qHB_-7ddk0miYRDQeHE6E0_8qx-6Q@mail.gmail.com/
>
> Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/base.h | 1 -
>  drivers/base/core.c | 1 -
>  drivers/base/dd.c   | 5 -----
>  3 files changed, 7 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 95c22c0f9036..40fb069a8a7e 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -153,7 +153,6 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
>  extern int devres_release_all(struct device *dev);
>  extern void device_block_probing(void);
>  extern void device_unblock_probing(void);
> -extern void driver_deferred_probe_force_trigger(void);
>
>  /* /sys/devices directory */
>  extern struct kset *devices_kset;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c..35cc9896eb9e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1323,7 +1323,6 @@ void fw_devlink_resume(void)
>                 goto out;
>
>         device_link_add_missing_supplier_links();
> -       driver_deferred_probe_force_trigger();

So it looks like this was not needed after all.

What was the role of it then?

>  out:
>         mutex_unlock(&defer_fw_devlink_lock);
>  }
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9a1d940342ac..48ca81cb8ebc 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -164,11 +164,6 @@ static void driver_deferred_probe_trigger(void)
>         if (!driver_deferred_probe_enable)
>                 return;
>
> -       driver_deferred_probe_force_trigger();
> -}
> -
> -void driver_deferred_probe_force_trigger(void)
> -{
>         /*
>          * A successful probe means that all the devices in the pending list
>          * should be triggered to be reprobed.  Move all the deferred devices
> --
> 2.27.0.212.ge8ba1cc988-goog
>
