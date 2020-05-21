Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684342072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spJG7P5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgEUKMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:12:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:12:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so2661190plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIe2nQ5wLexPjaO9CVf6Qf80rzmPfsKb7xa72lbN0jw=;
        b=spJG7P5Uk2wIUTi2cXpdWZ0yBk0k6QZhpJo42zcsD8b/c4mDh5jEI9GHguHYqYr/9L
         +W1JlDvQuItS52ToK9jfewx9OZA+aMXHYDXNCM8yY+fjd0ksOLEWeffekXy6yg58BkFH
         Riij7sBoq4s6AdS6YGCS80JVzK0QQDmfQe3jcIHLituTinwLhDp0qXkFtzPmNZD5Mwz0
         6xyILmq5xJZ3ghzOFWKMnEXph6NOsT5YAKuWgZzKEQddns3MGlmBMovXFba7TcGZjoq/
         sJLnEn1WV/MPvL5zP/c0rFb/g7ENupKvAxBew79pdkijYRjPXA3eCJVaUW/bVTmnQnpL
         Tdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIe2nQ5wLexPjaO9CVf6Qf80rzmPfsKb7xa72lbN0jw=;
        b=dBATC152SdyR8NjeyAIOlUDFnLjTrlcPZqD+xq6NA54PLGKWY40sp9DRhCtfJWN5o5
         YKapJ2SKrri5AHlpgnswQZG5lcKqs5kgz5Tb0EBZOxIYMPWZ1Q5hgLTp3I3oE6uf7K/v
         EXT60haaR5uqCByWgfVHC1tOz+YNUd+mFaTlJUiLej87NuXef5v0z5+H/gu+UoLs4hxk
         b0opk+fjmeDsKfkynBXUpoepWSAYHPzliZTPGh34DulzHBXBlEoPCAzBvZqls3L0e+nW
         F71LuwHtFPdf3TL7c3/wB/o3aNm2+qJXcdk5WJLkzoLACADB5+ScKyZyuPN9jHPlzOW+
         2m8g==
X-Gm-Message-State: AOAM532HnrtWn8HsrhEE/2kHduB645PrFgOPlOXNyX4hM1iaRPc5cgZR
        lxQiwAVtRe2R9EvvK3ir9Cr2RWn3GPXFIyNsxh+D9f5Gw3oZcA==
X-Google-Smtp-Source: ABdhPJxqZdqnBwhwj5DNI8aPwJc0K4LVMLiS2Bw1ZGIchZoDAMOFJf7/VsNoOqD/kXFnEvqRAJ1sL3dxL0k0gFiqTYQ=
X-Received: by 2002:a17:902:d68e:: with SMTP id v14mr8730715ply.262.1590055928387;
 Thu, 21 May 2020 03:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589497311.git.syednwaris@gmail.com> <f4d924971feb15b0044eeefdd969b36747d2322b.1589497312.git.syednwaris@gmail.com>
 <20200515113202.GO185537@smile.fi.intel.com> <CACG_h5o5=DXFtNzHn+NzY0rRjbZXhjrs58ka042hoOsVFFHnkA@mail.gmail.com>
In-Reply-To: <CACG_h5o5=DXFtNzHn+NzY0rRjbZXhjrs58ka042hoOsVFFHnkA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 13:11:51 +0300
Message-ID: <CAHp75VcL9cSMaHqn0bn-GRGX92pbGY_vOqLOU14BTzT93Mu=Mw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:42 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Fri, May 15, 2020 at 5:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 15, 2020 at 04:48:46AM +0530, Syed Nayyar Waris wrote:

> I have incorporated your above 2 review comments.
>
> I will be sharing the new (v7) patchset in some time with your
> 'Reviewed-by' tag included in this patch. I believe I have understood
> correctly.

I think so, thanks!

-- 
With Best Regards,
Andy Shevchenko
