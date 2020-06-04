Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0046C20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGjKygj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFDNM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFDNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:12:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E2C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:12:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k22so5106037qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89Een71ToGdwCSxQd7tlHimfNZeLDiVl6kiUkYupQ58=;
        b=VGjKygj+nT8JZi4b1eBCX1UkbushZE6Pzi3GMF4NsDIqX0EkyMzcM1EbsY1qIXPjdw
         11tbZMikjqxVioi3gyUx+gITmgkecFi84R/xPee5s5evRH0hW0diJtYEVuPYrNxQtFJK
         ynF0wMBCxJrWjzjB8ZdVXJbkp34iRp2uXHS0R7AMnhHCot7ivPOGP7tG3ahiHgiexB69
         wrK3Pg6ML4yihSbDPaZmpwPEFEkVccUFL2Kc75waotdXNv0aqDT55zYtIjQvsFkEGkc3
         ddjvH6/hEhObYGJvOjHhh1i5UDkBWRWrJ2fk4X0Q26RlhHXgOXzjhPXRidUWbsj+tzpn
         iaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89Een71ToGdwCSxQd7tlHimfNZeLDiVl6kiUkYupQ58=;
        b=BmzljNRMXZWVAN/hvs0sUU9YxKTxi0K+lvGUa+F/3YKaw4gkH1BmsIZ9qppC7M40Ob
         JBx6U8iCfZGgPJtWWOWwQOM4F10PHNvECL8QaggtPaUu2oBu3IkaHMvpWjhwGQF9upGW
         4ZlxSmqO7ao+8YivIqE5sQ7RNMAAaZLaIpwoi6Q3CwViHFzYhzoXWMutwncA/tXFAZBI
         kM+OYyPeB2vgdVZHDjTa8oOkZbm1XMSkG2Gu12CBxFyEG/DXuqyav5Ggz3902GCZQhxM
         Jlz9RJU4CCaUDl/7TJSq4HK7BxPe7Gw2wjg6woJpz73xnG1kboyaW+x/L/o8rijAj/Jo
         bFtQ==
X-Gm-Message-State: AOAM532cYbpC+rdSgfWPffDjZKxG4dxfNgBtKJ2+rqALML7wajvBvx2W
        ivaCAUd0QAoeQ9PWf+j+zH0vorTMJjt/CxSkmY7BYOmd1i0=
X-Google-Smtp-Source: ABdhPJwkT8Si1NcTs/fSSq13l0wzFSKlTqlYgWFjE5hDKDWZEjt94PH8nlQ4iRCoCMAAUc+/LW9TiQjIcsvgD39UtRM=
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr4339323qtc.257.1591276345652;
 Thu, 04 Jun 2020 06:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com> <4520671eeb604adbc2432c248b0c07fbaa5519ef.1585233617.git.andreyknvl@google.com>
In-Reply-To: <4520671eeb604adbc2432c248b0c07fbaa5519ef.1585233617.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Jun 2020 15:12:14 +0200
Message-ID: <CACT4Y+ZXXin5Vfa+YtByzh9=+ZpTuPnseTYKfFBOoqZw+8J3Ag@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] usb: core: kcov: collect coverage from usb
 complete callback
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch adds kcov_remote_start/stop() callbacks around the urb
> complete() callback that is executed in softirq context when dummy_hcd
> is in use. As the result, kcov can be used to collect coverage from those
> callbacks, which is used to facilitate coverage-guided fuzzing with
> syzkaller.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  drivers/usb/core/hcd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index aa45840d8273..de624c47e190 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -31,6 +31,7 @@
>  #include <linux/types.h>
>  #include <linux/genalloc.h>
>  #include <linux/io.h>
> +#include <linux/kcov.h>
>
>  #include <linux/phy/phy.h>
>  #include <linux/usb.h>
> @@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>
>         /* pass ownership to the completion handler */
>         urb->status = status;
> +       kcov_remote_start_usb((u64)urb->dev->bus->busnum);
>         urb->complete(urb);
> +       kcov_remote_stop();
>
>         usb_anchor_resume_wakeups(anchor);
>         atomic_dec(&urb->use_count);
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
