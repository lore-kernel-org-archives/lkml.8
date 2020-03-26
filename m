Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EAEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976FB20772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZIWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:22:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36342 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCZIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:22:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id l23so4968659otf.3;
        Thu, 26 Mar 2020 01:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PY127Ek5ZIc1Pg5150yQ9OyRCaQzSCDhL9BbsnXaEI=;
        b=N/068kUZSqhJ0d1Xrz9zYYtNa5K8Yz1oqmkk0zppFDtyf5W4AqHncd6nlrmmQ5BUOT
         OMal31/LiFs33chs/KjsA+Z6EA9lzWNZeK3XddLAlTu94B+3AIg+pAdwafVUqF2UFMr4
         8MBwUU2ujls+jPlsX5ArxcT449saRmVcJvhntn5Ossg14bokZaEnIAPMF2v7L5D+7VUF
         +xoYm/gpdmtMH+Hw5aSMIx+pGdz/03ReZVesjZWi2ofjXhKsGyAdhnTa05dkdE/Cqm69
         F/m10g83HXnTGHRjhMh6ii/dNEhWjaJYki+1QpA3Nx5ZJi2vaAvV8pvjiLH/ErYFre96
         Mazg==
X-Gm-Message-State: ANhLgQ2suGwr+C/o/6a39UugKXIFNtK+SjfFoBnO4PO7jBdtPcu2XGVI
        7LZCuzkYZNgirEeVUMALy9DkR18Znkp0ztTDky5b9x0+
X-Google-Smtp-Source: ADFU+vvEoCHp8Gu5Z7ftqwMNgRYUWNLZad4cTHik/KVTaauItYI8/8dUFrD2yXZFNcai2bVRmIgddye0tunerLePQn8=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr5354181otk.250.1585210926496;
 Thu, 26 Mar 2020 01:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com> <1585187131-21642-3-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1585187131-21642-3-git-send-email-frowand.list@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Mar 2020 09:21:55 +0100
Message-ID: <CAMuHMdXnQ2Tcbac4OoWuSDO9KK0zMLt7ZbMdF79sCj-Yf78Bgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: some unittest overlays not untracked
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Thu, Mar 26, 2020 at 2:47 AM <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> kernel test robot reported "WARNING: held lock freed!" triggered by
> unittest_gpio_remove(), which should not have been called because
> the related gpio overlay was not tracked.  Another overlay that
> was tracked had previously used the same id as the gpio overlay
> but had not been untracked when the overlay was removed.  Thus the
> clean up function of_unittest_destroy_tracked_overlays() incorrectly
> attempted to remove the reused overlay id.
>
> Patch contents:
>
>   - Create tracking related helper functions
>   - Change BUG() to WARN_ON() for overlay id related issues
>   - Add some additional error checking for valid overlay id values
>   - Add the missing overlay untrack
>   - update comment on expectation that overlay ids are assigned in
>     sequence
>
> Fixes: 492a22aceb75 ("of: unittest: overlay: Keep track of created overlays")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Looks good to me, so:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still, a few suggestions for future improvement below...

> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1689,19 +1689,27 @@ static const char *overlay_name_from_nr(int nr)
>
>  static const char *bus_path = "/testcase-data/overlay-node/test-bus";
>
> -/* it is guaranteed that overlay ids are assigned in sequence */
> +/* FIXME: it is NOT guaranteed that overlay ids are assigned in sequence */
> +
>  #define MAX_UNITTEST_OVERLAYS  256
>  static unsigned long overlay_id_bits[BITS_TO_LONGS(MAX_UNITTEST_OVERLAYS)];

Obviously this should have used DECLARE_BITMAP() ;-)

>  static int overlay_first_id = -1;
>
> +static long of_unittest_overlay_tracked(int id)
> +{
> +       if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
> +               return 0;

Do we need all these checks on id? Can this really happen?
I guess doing it once in of_unittest_track_overlay(), and aborting all
of_unittests if it triggers should be sufficient?

> +       return overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id);

No need for BIT_{WORD,MASK}() calculations if you would use test_bit().

> +}
> +
>  static void of_unittest_track_overlay(int id)
>  {
>         if (overlay_first_id < 0)
>                 overlay_first_id = id;
>         id -= overlay_first_id;
>
> -       /* we shouldn't need that many */
> -       BUG_ON(id >= MAX_UNITTEST_OVERLAYS);
> +       if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
> +               return;
>         overlay_id_bits[BIT_WORD(id)] |= BIT_MASK(id);

set_bit()

>  }
>
> @@ -1710,7 +1718,8 @@ static void of_unittest_untrack_overlay(int id)
>         if (overlay_first_id < 0)
>                 return;
>         id -= overlay_first_id;
> -       BUG_ON(id >= MAX_UNITTEST_OVERLAYS);
> +       if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
> +               return;
>         overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);

clear_bit()

>  }
>
> @@ -1726,7 +1735,7 @@ static void of_unittest_destroy_tracked_overlays(void)
>                 defers = 0;
>                 /* remove in reverse order */

If it is not guaranteed that overlay ids are assigned in sequence, the
reverse order is not really needed, so you could replace the bitmap and
your own tracking mechanism by DEFINE_IDR() and idr_for_each()?
And as IDRs are flexible, MAX_UNITTEST_OVERLAYS and all checks
could be removed, too.

>                 for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
> -                       if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
> +                       if (!of_unittest_overlay_tracked(id))
>                                 continue;
>
>                         ovcs_id = id + overlay_first_id;
> @@ -1743,7 +1752,7 @@ static void of_unittest_destroy_tracked_overlays(void)
>                                 continue;
>                         }
>
> -                       overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
> +                       of_unittest_untrack_overlay(id);
>                 }
>         } while (defers > 0);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
