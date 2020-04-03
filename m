Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C894C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED8020675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7VkOY2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbgDCTYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:24:31 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:43530 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgDCTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:24:31 -0400
Received: by mail-io1-f45.google.com with SMTP id x9so8700014iom.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnRbA/qfAuZrNiKW7PlDbNmNmhxrDXj54QKlbM9Oqfw=;
        b=d7VkOY2deeUHkwdplgi5lQCHavHOBxfkJAwy4crlz4R1CcXyyHPCn6Yqr+IkjBUrbJ
         TO2upVzWHTNOm0jIIjWUV8GLcDj/k6uw7MVTA8nA9zFiyK+2bWvTddpqnFWVqHfuVGoJ
         5mPfwbbDbR9fDOF6xGah/iC6MTzdUIHr2GMQmotSLj2zqjXvQnk5E6cYtMI8LZmBOxGD
         p/NzW+M02I1ozJ/fxOEqtsJ3SKTk9rheEZgzLUp0HNo5+/wG8qKtfqA4h8EOGGJnz44d
         nItwxxtRQ7rmLYJtlbKR/nGSgZoL6/5nhR/7hSEOAC5I4rqqAAxJbuRNeK065RrkFVpS
         Zp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnRbA/qfAuZrNiKW7PlDbNmNmhxrDXj54QKlbM9Oqfw=;
        b=HgJD2WiTzJKInDAboA5pG+WjJXZqsVFnlfAxCxMQsY4t7xDsXUnEz7ZjBOiC/SPzRb
         1oqGnUlhMKi5udTQKiLrfvPfaIoVInvyl6WIewq3TKhpADcOihLaN2a4Fp2jQhKX8SZE
         odFcpVGTneobDS2zZfpKQAEAg1g1uEhTlmWZdHwtEVcd/2VwnQ6qtLaUk8euU+S6U2vU
         IF3hHLBA04Gk1CUYaDeUTSOjH2plniLgYe7Em3w9iClGOuzds1viJ+bE52KumVM5L90/
         w2+z7rdNJLMGb2pOUBM0OiDJt6FoMuc9Qf9wDvT720MD3A+T75wwpjsfRkMU/8JFIidr
         +4Ww==
X-Gm-Message-State: AGi0PuZg17U9oCBc7Nc3l1VO4e5WCA9QxJiyUkuV97a3upNVkr5euygO
        eUScob9gEoMoyjbMRRJPHFSBO26jT0apBTRpsxxQ2aCuCoo=
X-Google-Smtp-Source: APiQypIsEcnt7WhgbLb1UnP0hJFxH2K4F1u/DZj8zVJQrtDFzsuGNdl3JJoa//pjVgV64FrBImP7WH6EFEs1RlthxkM=
X-Received: by 2002:a02:b783:: with SMTP id f3mr9873509jam.4.1585941868678;
 Fri, 03 Apr 2020 12:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
 <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
 <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com>
 <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
 <CAOkhzLW42a66wNL7Pz8+d+yO_oyZZJBEps=8WPHaXXFjb54dTQ@mail.gmail.com> <CAKb7Uvh=44_S_EAfma+JX9j_igaE3CSWws_TUqLWwJ50zcmA9Q@mail.gmail.com>
In-Reply-To: <CAKb7Uvh=44_S_EAfma+JX9j_igaE3CSWws_TUqLWwJ50zcmA9Q@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Fri, 3 Apr 2020 21:24:17 +0200
Message-ID: <CAOkhzLVGsOyKsf=Lm69UMGutWv-yZVFqZ=Yi61HDHCUCAwchoQ@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 8:31 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> Depends on distro specifics. Also the firmware has to be available at
> the time that nouveau loads. The corollary to this is:
>
> If it's built into the kernel, then the firmware must also be included
> in the kernel (since this happens before any FS stuff)
> If it's loaded as a module from initrd, then initrd must contain the firmware
>
> If you need help including firmware in the right place, a distro
> support channel is probably your best shot.

Ok, thank you. So far no luck on the end.

https://wiki.gentoo.org/wiki/Linux_firmware

Please let me know if the fallback version comes back to life.

best
Zeno
