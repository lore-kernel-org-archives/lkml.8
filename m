Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C90EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9C22072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="R7MEsHh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407061AbgDNIN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407053AbgDNINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:13:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A8C0A3BE2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:13:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m8so11493616lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0AFfJl+/HREBpAIEr3R3eD3vK7f3cLfChMESLkU3ZA=;
        b=R7MEsHh0lV4EXqX7criLWoVHxwcphg0cIVvwHu7eqCeSqw7hZftgjGd7GQ+n2F+Rp2
         i6qdeAOTKFxlHIw4gWfQO475elR/gAC5ydvsHyB8vK+offO085GBrkQ9+9n8XzWSUwNk
         66+BGHjTBsex2X4lMaqkXwxnCR39ZVg5hC2aabqpwTZEE01Gfvz0jbFHPghf/QsCSn+8
         lHUpDeWQT5E8J65/B+hAsFEc8/JHugwmPf6s0UYSwTkJeiKly8uoKb19yCDqNQ2ENQeE
         ADtQmlyLuxhZ/99+oXVa29uiR88fJkIYD/dnq5akaYcwXKBamwZtbdafzMV7N/n2YDcq
         9ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0AFfJl+/HREBpAIEr3R3eD3vK7f3cLfChMESLkU3ZA=;
        b=kN7RS/uVJGb3I1K2BgMaC4+FBwwBtCJCT7FKVgOhTu3hINmMb8PWf91wd2HnH6r1nj
         0oQRAtzA4jnbOFDgfRlqB13cgWgnxZmdV176rVboQMqbLhuNRXJrG/sHM9VE3+bECcC6
         MBoFVrbMNruoxoH5W1dMhbtS++5xLX3sNAN18WxH9+NRvaqSroxxeu6mmMhBchR33h3t
         83YO+POelanwl3XjxRtXALD7Zx7CCSM42h2sUjfxnh1MRog5UEiL72U3oQfGR+GxaY84
         RwAMuuEd44DqLJwUPioF7Dw/3Pp9iTTl0SyKYn9/TKkNCtVjs4XMOz5IJw+9o3ac/Est
         yN/w==
X-Gm-Message-State: AGi0PuZhppYf7kgcy3Gh7iA6zVTV/jVvMgzaqgGrMJGihf6PHT82BCQx
        eyH6f3XHQM4PbT23jdmdFUzTe5y/XmClvXRqrCdwygOoLIQ=
X-Google-Smtp-Source: APiQypL3bt30tO1xq5I3jaKWN9l0ktN8iS7ZbgbyWNRt1DbCqbWTui4gMILpBogAJY4hxAlK+cx4KrI7mbrx/Xr8eGQ=
X-Received: by 2002:a2e:2a85:: with SMTP id q127mr3203163ljq.273.1586851994890;
 Tue, 14 Apr 2020 01:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114116.21642-1-maco@android.com>
In-Reply-To: <20200331114116.21642-1-maco@android.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 14 Apr 2020 10:13:04 +0200
Message-ID: <CAB0TPYHt=8EDMUKijn62SmNUEHpt0dGKxxe3uz9BVmwPrVkznQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Call loop_config_discard() only after new config is applied.
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, any thoughts about this one?

Thanks,
Martijn

On Tue, Mar 31, 2020 at 1:41 PM Martijn Coenen <maco@android.com> wrote:
>
> loop_set_status() calls loop_config_discard() to configure discard for
> the loop device; however, the discard configuration depends on whether
> the loop device uses encryption, and when we call it the encryption
> configuration has not been updated yet. Move the call down so we apply
> the correct discard configuration based on the new configuration.
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 739b372a5112..7c9dcb6007a6 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1312,8 +1312,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>                 }
>         }
>
> -       loop_config_discard(lo);
> -
>         memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>         memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
>         lo->lo_file_name[LO_NAME_SIZE-1] = 0;
> @@ -1337,6 +1335,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>                 lo->lo_key_owner = uid;
>         }
>
> +       loop_config_discard(lo);
> +
>         /* update dio if lo_offset or transfer is changed */
>         __loop_update_dio(lo, lo->use_dio);
>
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
