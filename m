Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD11C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA722078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590404889;
	bh=VwhE3Gs0kEbgsMJnGH0lEn6aH2cfpDks1wFq+mnUhmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vJAO/glOdJdX4Z1TLne9FO8jxgwVTeNbNE5uOyS2ZQNdKq8Py6RXL/6lojhMOXfQd
	 00+JgjKeX7vYGGdih082T0pzjPmEY0LJwEA0FLzbVXqcC3zKEGdnxeVcmAaKOmHCaq
	 kh5cmGkkaX8fAPUHDoA44ZcTH3aAz82ZGHVIIrFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbgEYLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:08:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35313 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389951AbgEYLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:08:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id z9so10867758oid.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DZOVuhlhUEa8RgTXTX1YNfYS6LvBGj2bCK1lLKf6Ak=;
        b=X0wjCpuBy+wq0HGNFazpMUpLWD1tOgn6SpQeZrRrNoTWPZYzi/eACwC0DV06SIseZo
         KARE77EEHsAbdVbIkAIHj9UeBjnrXHFcxYwgH9mss4mQsRe/VEyLltGC0/KQ4s8knMZi
         So6zKtWy4P1oGldtHKWx08Tw8xXCFj85NIRulsvQWKZ8Zj4qcd52lidmMxdnlHw3JQYq
         4P6Yhc819+wiWECL07XMX6Wbd1oAVFy+Zv7cDdnxrTUB5/uDfBOQGsM7ozbVyP9cOb9y
         EPowQoY3VJI9+AbgJ3AvU6/VWDYnGx76nLVxA1Y0j9sS5nxP6BTszr+nkQQS20C9n7sL
         iMOg==
X-Gm-Message-State: AOAM531KMle9LLHOXm4hwOtN3ISQtMcMiAKjKr/pgq453q1f4ZW5ZsYF
        SNUYPKMVv9bBgxyHd6nqL4w9H8os0dqeYLDL3kI=
X-Google-Smtp-Source: ABdhPJxroIEgGzLGRwsx88ZCjBuxMpPdxjfw7hIBPbw1hxWwrM8FeJxhUf+WpUXwUAY677EsbZIlFbK6ZJl4vPMShhU=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr11164683oih.110.1590404886954;
 Mon, 25 May 2020 04:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org> <20200524153041.2361-2-gregkh@linuxfoundation.org>
In-Reply-To: <20200524153041.2361-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 13:07:56 +0200
Message-ID: <CAJZ5v0i09StGT4oVSpRAWDjJRuHPWRRwiAvsADqmmbG29rC1JA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 5:31 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> after the files are actually gone from sysfs, due to how reference
> counting for kobjects work.  This should not be a problem, but it would
> be good to properly send the information when things are going away, not
> at some later point in time in the future.
>
> Before this move, if a kobject's parent was torn down before the child,
> when the call to kobject_uevent() happened, the parent walk to try to
> reconstruct the full path of the kobject could be a total mess and cause
> crashes.  It's not good to try to tear down a kobject tree from top
> down, but let's at least try to not to crash if a user does so.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

LGTM

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  lib/kobject.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 83198cb37d8d..2509e22ad74a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -620,6 +620,13 @@ void kobject_del(struct kobject *kobj)
>         if (ktype)
>                 sysfs_remove_groups(kobj, ktype->default_groups);
>
> +       /* send "remove" if the caller did not do it but sent "add" */
> +       if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
> +               pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
> +                        kobject_name(kobj), kobj);
> +               kobject_uevent(kobj, KOBJ_REMOVE);
> +       }
> +
>         sysfs_remove_dir(kobj);
>         sysfs_put(sd);
>
> @@ -673,13 +680,6 @@ static void kobject_cleanup(struct kobject *kobj)
>                 pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
>                          kobject_name(kobj), kobj);
>
> -       /* send "remove" if the caller did not do it but sent "add" */
> -       if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
> -               pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
> -                        kobject_name(kobj), kobj);
> -               kobject_uevent(kobj, KOBJ_REMOVE);
> -       }
> -
>         /* remove from sysfs if the caller did not do it */
>         if (kobj->state_in_sysfs) {
>                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> --
> 2.26.2
>
