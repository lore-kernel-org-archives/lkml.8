Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5998D2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZS/mQr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbgDCR7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:59:10 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:38966 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgDCR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:59:10 -0400
Received: by mail-il1-f171.google.com with SMTP id r5so8156777ilq.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zGqjh8tWIOzg8bYhDujKphXb4w8b8uyQL/GSu4o44fE=;
        b=KZS/mQr5IM4Xv77DJj/Sy7o1do9YRZztAYja3YLa5C3rDOTvHBkchl/fHXZdILzyJD
         lhYg8DiwrZzPjZAaUvFwZQxGosVc8+nTJtU7KuVgMZe3EVMPbDRlE3oTbJ7Kzjbl1A76
         xHebNT5aNoOq1YtPZ57EoByuXgIfJw+cyCEfjkwi7u5QEqLfTD9pXFPyyENLLi8cjYyH
         a5SesUAv9KBTgf3b7sPhP9bSFq5iyD95NM5hBD/PumI2yqsolTdQiKuUbpio4xmxoMWs
         14fjLybG7qkfyezyiATLOoTEFz7hp1HmL5LvVe17klGdlVttZP4r5UFkxJLxD+qduAmp
         4YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zGqjh8tWIOzg8bYhDujKphXb4w8b8uyQL/GSu4o44fE=;
        b=ciMPFS1oerFth7kWY5WwrsD5JL91Gd5SmCO81kARrGoLLIHqSctpOL8yIQx1Ufw3kh
         1WZH9ZXCjkFJGSooKR7LLnjsBqr0WVSsBenSwy8tm2PMCxt9avOP198kMzw9YolkI/ai
         WI3xDiJ8cX07meGY3CBW7bu4HVOtyWFjn+2JUfuht9fW+HLU4ZVot4sEGcqcbpfzm6mM
         9BbOn6gw8uwgAcQVzkcrJEjUhL5+wH5BQ7FrbDiBDEmCUjhJvMwQyOOrisisphhoV679
         qY7uMh2fmrlLqmJTW85MHqniPARn6Iu6oV8QWp+ovsJy4TMm+9nkrF6BM+tx0jFnpT8T
         YXtg==
X-Gm-Message-State: AGi0PuZy6xeWGlWSERLyzF0LRKKCswGcq6O+WHLbXYfuTkYMdx5fUrjD
        64BKKbzlDi+yGZCa2OtDqhDt02qq79YeRvySOh0=
X-Google-Smtp-Source: APiQypLV22UI8hbMaQ9Ris88qX06T72jTuFx9SCF4OIefxzMJSV+YMnG8Qz4wDUnIWas/SylofX6SN506g5UerTyVMA=
X-Received: by 2002:a92:912:: with SMTP id y18mr10118914ilg.299.1585936748782;
 Fri, 03 Apr 2020 10:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
 <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
 <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com> <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
In-Reply-To: <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Fri, 3 Apr 2020 19:58:57 +0200
Message-ID: <CAOkhzLW42a66wNL7Pz8+d+yO_oyZZJBEps=8WPHaXXFjb54dTQ@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 7:23 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Fri, Apr 3, 2020 at 1:21 PM Zeno Davatz <zdavatz@gmail.com> wrote:
> >
> > On Fri, Apr 3, 2020 at 6:59 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote=
:
> > >
> > > Ben -- probably the ACR changes in 5.6 don't fall back nicely anymore
> > > when there's no firmware? The load shouldn't be failed, just GR
> > > disabled...
> > >
> > > Zeno -- if you grab linux-firmware, it should be all better. Not sure
> > > if you're missing it on purpose or by accident.
> >
> > Thank you, Ilia
> >
> > I will try that on my Gentoo/Funtoo machine now. So far linux-firmware
> > was not needed with Kernel 5.5, so it was not installed on my machine.
>
> It was needed on 5.5 as well. It's just that it fell back gracefully
> without firmware, and you didn't get any acceleration features.

Do I need any of these enabled for linux-firmware to load properly in
Kernel 5.6?

 -*- Firmware loading facility
  =E2=94=82 =E2=94=82                                      ()    Build name=
d firmware
blobs into the kernel binary
  =E2=94=82 =E2=94=82                                      [ ]   Enable the=
 firmware
sysfs fallback mechanism
  =E2=94=82 =E2=94=82                                      [ ]   Enable com=
pressed
firmware support

Best
Zeno
