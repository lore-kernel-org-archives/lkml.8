Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2509F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNu/5dT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgEZHH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgEZHH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:07:58 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625BC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:07:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d26so15467007otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnyNZB6KjOSsGIcNelWALZYBHxkm1rsDpfOrdFIXkpY=;
        b=pNu/5dT3Y9cf8fiWHDj3fGdEwHVV9BZdIBJUypSi5hleKltNa2+CrWdFuiJa3oOyuY
         KPUpvrdqHCD0poNzOK9/yxv69TLWfdoYbnprEzOU+DA9XECshB2s/m0f/OacmBnMVKjt
         GUilnF7165thVE6sOolwNU7nSthfIg8/97MXzyaaVgWqYe4G7dsKTPLYUBD7RtoHXbDh
         eQVorXWRIT9L5Z7b50n05qrkjuHAtKClSS9ZlMZjjD/nFfmOcWjwHRy6On7TrRd6kfrL
         NneC0ZfV1LfgLDIdaCcuyB2Ett7Gfi81Y+ye1HXXHl1I9/9dGdIm1U2waYiU2k5QXpBy
         ZKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnyNZB6KjOSsGIcNelWALZYBHxkm1rsDpfOrdFIXkpY=;
        b=RLUW/eg3G2uf+0QRHQGI9XMhmnQHL6rf01iB87l5xot0SXPBGcO98+syVkpytP+Z4j
         45qVXVJXsMmdNzQ1H3Ow0OiuF+NP7oCKACp65/tSThsN/B41Xe5RMZfcgQ1sRHKDAK5D
         RmzQTcrLU2hTUtBEVwOyio1oe+PcKnZ6QYv9HtPreCQaObN7mYqYNvUv1zvciSDTwQR5
         5lcubuydsHKAaKKN8AUfMZc02FpsEFYM2fSTh9Wfb+ieQvMdT1r3DGYF6M+sU8EWXRGU
         046vfo1mU5kIU7Mvtv2C2B56jz6wcszR6xopqe+chYAeYNiXtSB+AJGP2N+72hV12x65
         R2fg==
X-Gm-Message-State: AOAM531LyxyINMerjfKFcvQSZX4sbqLELMDcZJl0P/lUUQZRejZQ5FrO
        c3kR5VDOVknE2XLyucJA9uoR0hbqS8wALgJg586iUg==
X-Google-Smtp-Source: ABdhPJz4NQQooUdMBsKWjtTBCcoToZSnWHgRxs0F1hGcc5qof6Gm7+jYkiXKWBDtDXJAP7u06eN2uMeMtdXe1u7zrIw=
X-Received: by 2002:a05:6830:18ec:: with SMTP id d12mr24890568otf.139.1590476875920;
 Tue, 26 May 2020 00:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc> <20200526070518.107333-1-saravanak@google.com>
In-Reply-To: <20200526070518.107333-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 26 May 2020 00:07:20 -0700
Message-ID: <CAGETcx-b4+a8U=Qd0mKaB9JUBaj178694QshqZVrAa_x6AgcAg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Michael Walle <michael@walle.cc>,
        Android Kernel Team <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:05 AM Saravana Kannan <saravanak@google.com> wrote:
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
>
> Thanks,
> Saravana
>
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

Adding stable@ that I forgot to add earlier.

-Saravana
