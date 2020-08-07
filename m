Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1034C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97789206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="llZzgkuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHGJcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHGJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:32:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79819C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:32:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so1279037iod.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2e+C7cne98K7WAXGpHGymF2mpr0Yj6NJ2Dg7lBo/rwk=;
        b=llZzgkuPfcTI3rprKRKI7TMEvFqdP8V3RtrN7Tun6gLDkDTjS8mLrNv+RNHTZ9qPD7
         Tbvv27PX0AnxEIJhtibKbXx25NzVSwTpD4oYBHjZeC9MLuiXRoid+OCyv+WGPySPelWd
         +Qi3Xw9YYDtIrMu05AVwpc+F23d6wim1zg39587yWp4ddnGyu10tlf/fGZLgY1YWb7Bc
         YM06oU/OFu76FVq9W+d9DigW5uKigRT94tki+FdOtKJoAbl760uR11fQ5OHw9o0GEuC4
         lv5OeEfkoV7wb0Lt/Vcztkm5+vy8jywMllI2HEQM5X5vZYsfIM0UZhfpHDjT3fCCccPp
         +J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2e+C7cne98K7WAXGpHGymF2mpr0Yj6NJ2Dg7lBo/rwk=;
        b=FZFMRCaaRwIfa4t0nCiJoja8q4bmjouCDMd0lrWndK7tm6JieOIgmPEy1Olttkdj3Y
         IdLHuW1HVbw6pAH+eCI4gaPUW2hkQQJthqMqavQuqpYnhPmJwmfhS6uswjX3hFyQEtrD
         eP1GjP0EQKuGwBJ9P+RtOHh7MUFmqYJtxjflMhKwXQDelJ/7iWD6OAA/DuFhnaiNwI6W
         TJ7eFYpcenOYwxPWTp/ratRoQvzD3l574B8Tn3cdVrIwpZ+VMVWCJQJMASQhTJZl50F6
         sikqkDchqaP9E/H0qVhpqpcIQG4OS8fTLeNcus8PadAGofrqwMMDxCxz8NoSeaLWUcik
         AKiQ==
X-Gm-Message-State: AOAM531TblhL0drWdfkHv0BOPCJHMHmEz8hWz1abBSYgp7QYvdn6u4W+
        tdI8DXOVZ3f0pmTm+Xh9YV+ABuY07GGR66qgYjvL6A==
X-Google-Smtp-Source: ABdhPJysjNOsmaMfanSJt9eSDzN7H1m/TOUGUUbOwKXNqwiJbBKQpcrCzOMMLc4bnqEQ7WkMdFmqvT9iz2gQtLyq6jk=
X-Received: by 2002:a02:cf26:: with SMTP id s6mr3856158jar.44.1596792765360;
 Fri, 07 Aug 2020 02:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200807091900.967047-1-cmo@melexis.com> <CAHp75VcJ_h2_Lkn2DiG1B5AOQGmsRx5N5jU2ADX5bgq2cqBnYg@mail.gmail.com>
In-Reply-To: <CAHp75VcJ_h2_Lkn2DiG1B5AOQGmsRx5N5jU2ADX5bgq2cqBnYg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 7 Aug 2020 11:32:09 +0200
Message-ID: <CAKv63uvo3ovJbcSV011-1MSExGvNFRFPKV9hCZ+niT6bqKMKGw@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: temperature: mlx90632: Add extended calibration calculations
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 at 11:29, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 7, 2020 at 12:22 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > Since the second patch is dependent on the first and was still not
> > merged, I have decided to send them together. First patch just makes
> > second one more readable as it splits out the repeated calculation and
> > that enables the second patch to tweak the variable to the new
> > condition.
> >
>
> When at it, bump the version relative to the maximum of all patches
> involved, like v2 should be for all patches in this series.
> So, there is -v<X> option to git format-patch to help with this.

Thanks for the heads-up. I was doing this by hand so far :/

I assume there will be some comments, so I will follow this in future
submissions.

>
>
> --
> With Best Regards,
> Andy Shevchenko
