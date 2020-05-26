Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AC52071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590481739;
	bh=oozURJ9NhaDlYb6QsQbIT21mLQgdCAIMHtNVDD1zmBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O/S9qBnC7mVGGEXZmWVDD6N8jMFHDHH7d4cIMbfhZtt3OvT7l4pv5LfdbUTWBO7cj
	 nFawERR0CGfRKxgE4PBQhMLvPu3zWf33oscoLKQuTAAAAquvHuieETGCSHhMKMDMp0
	 e/2Og9Daqz72BN51AVWzBhfAPYXoY8rD72RmgBu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgEZI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:28:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41445 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgEZI26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:28:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id 63so15622042oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sDfD5MvHqOVKsiOpWR4jEKoPv0NunhRnUgZ58ivMcM=;
        b=LOIE6gp1VyIvtENQvxgqjOlRH04wbSeIr5tLNOUogEh/17fDslWt1nMFnqywt9t9Mk
         H2i/lMhhb4t5bUiCOz62P3h8UJ6tZn15TBrKC+4sVvRWf7KXVl1NnJX34dDw+IUyJ4xf
         GNh0COalPxr9nvlk+LTMotoYcvmDi9xY8Cx+fGhB9uvS6uqtv915mom+Hd78ZU5hQETx
         ULWyQqEb/lVfYlLDQhw0jXX/6rgNlpsPmWRrjBWZBMwox6TnNiY+9DC70Hk7zLboM4xY
         1rYOWGPE/NZKzs5IVPhVKElqWANYbru5cSjYVhpiIPlElAuXJ7qdAb9M7GMLJ0kZismK
         WwXQ==
X-Gm-Message-State: AOAM532lTwFtRB5n2fFK2pwzlbouwJ24rwMrajlWvco6IAO+AOs78Cv1
        QYg+Jx0oYCuC1lFWEGHVFTM9FvZ6LP/5gBHHl98=
X-Google-Smtp-Source: ABdhPJw4lPJ+FZJTfBnOyckv1D1aJQFKbIHgiBVLAHuea9bvEc8e6KHzf56i73OodCIN/41GFETLa2osQ1lgfr4ik4Y=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr51713otf.167.1590481735984;
 Tue, 26 May 2020 01:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc> <20200526070518.107333-1-saravanak@google.com>
In-Reply-To: <20200526070518.107333-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 May 2020 10:28:43 +0200
Message-ID: <CAJZ5v0i9yyvf0JAAUfj1DiFPgHHUdXkE3T6fWSxFEB1Mo_fx3Q@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Update device link status correctly for
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

On Tue, May 26, 2020 at 9:05 AM Saravana Kannan <saravanak@google.com> wrote:
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
> of a SYNC_STATE_ONLY device link.  A SYNC_STATE_ONLY device link can
> later get converted into a normal MANAGED device link when a normal
> MANAGED device link is created between a supplier and consumer that
> already have a SYNC_STATE_ONLY device link between them. If a
> SYNC_STATE_ONLY device link's status isn't maintained correctly till
> it's converted to a normal MANAGED device link, then the normal
> MANAGED device link will end up with a wrong link status. This can
> cause a warning stack trace[1] when the consumer device probes.
>
> This commit fixes the SYNC_STATE_ONLY device link status update issue
> where it wouldn't transition correctly from DL_STATE_AVAILABLE to
> DL_STATE_CONSUMER_PROBE.
>
> [1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
> Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tentatively

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

->

> ---
> Greg,
>
> I think this is the issue Michael ran into. I'd like him to test the fix
> before it's pulled in.
>
> Michael,
>
> If you can test this on the branch you saw the issue in and give a
> Tested-by if it works, that'd be great.

-> provided that the patch works.

Thanks!

>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 791b7530599f..9511be3f9a32 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -687,11 +687,11 @@ int device_links_check_suppliers(struct device *dev)
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
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
