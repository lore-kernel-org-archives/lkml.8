Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F44C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AE8214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDIJww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:52:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDIJww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:52:52 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUog3-1jn3Fy3czR-00Qhna for <linux-kernel@vger.kernel.org>; Thu, 09 Apr
 2020 11:52:52 +0200
Received: by mail-qt1-f176.google.com with SMTP id o10so1117357qtr.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:52:51 -0700 (PDT)
X-Gm-Message-State: AGi0PubZ+QhTMV0IW/+5f9irbcFpQBZxi8Ct2qWwme70GX/RqBXUVvNf
        5bDN9yapY9okY25egx01rfvndS+wXFNBOljc5Jg=
X-Google-Smtp-Source: APiQypL+DwHH2ZguxZLXN8OA5ycsBeUoFtHigT4vFuKKbtUbT4QIjDNqDn6MdopgZgREkiqjW4wiglbzubeOCiv08nY=
X-Received: by 2002:ac8:7292:: with SMTP id v18mr11264133qto.304.1586425970748;
 Thu, 09 Apr 2020 02:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <CAK8P3a1rWuL-mSeFBN0Dk7u3wnDmPgknEM3Em734KP64-Wv0ZQ@mail.gmail.com>
 <CADBw62qEfdLM9e2oyPKz1qRk4mZaFPbXRYpLfVHzxKj0Cz90kw@mail.gmail.com>
In-Reply-To: <CADBw62qEfdLM9e2oyPKz1qRk4mZaFPbXRYpLfVHzxKj0Cz90kw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Apr 2020 11:52:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rFKVukWk7U1abHnW4a-5TV4e57f=9Lt9Xbfytm7H09A@mail.gmail.com>
Message-ID: <CAK8P3a3rFKVukWk7U1abHnW4a-5TV4e57f=9Lt9Xbfytm7H09A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add new reg_update_bits() support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ukI8mr9iL59Bz0uuiB4N0ZZtSMVBLLSIhU44Wy8tIBCvQpQZ1cY
 5LbkevPtle+07lq9OGqfyPCDsBwtQtZ0CGjDuTieB2Ta4tHJOipPkPfycyIF11NTaaOUdIp
 L6fdmsBpYgY0FnY6Nx+InqC69pNeT8M7dLSa7a6zFZlxMe8exe9ySNUMUssRmi/YNLp7h2Z
 SuXTpV6KqHOcvm6tsQrPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BE3k4PoYWps=:Y+IOHy/sTJvz749kizmGjw
 Eajge275lCu9WQ7iHmd4PSRjXowqMsAN3Xwk4YSEh00eQHzgNNZcTfdPN8oyMIiFDOf4NQVl2
 cb4V66ASJmYsFrEITBiyLyOtqFgqXJi6XoWjwxJtIcss3sfXirB2dSxdgw59DdItj2gYVtVhR
 qEh0dMZGJpIlG7agbKyLl2x4yC3/EbcQdQYnySPkc7hH94vN+8SHNUqS6P19KP/uoaESnUwuk
 luu4qvf6o9UwDQQb382uOs9YpLzAF5soGM4i+bKDk9kbnwtf0QVGAyi2iCUvpwO2dhYQH0lM1
 HUBZy7gXLOax5Y/Gxk5opkaS24HgED3n0SDjB0kacH52ZqvGMHbFUg2parS8JePTuZfRhSBmW
 P9q6HaL71zt1d9yyRmFn9TgJ7uel2m92pJTKUTJxmcWzRf/1hC0h7WYmF22HE6hpYcN46+4wx
 NQAN8QFyWfIqeLFP108xdwj/r6aqyo8lL+OvsJp1yuYJd5wHIl63kYfTdVPbrEdaWqPUcQVin
 8nHDl4Sqf9EY4VezTG04zwPINsoCx8oskOF/hhad9Nbh0Oj4FbCiAH12DPZ8eUf0/P5gxBck+
 FOR1QE52SDxoo6p4lZVeLMjUurh7X8jgLwM38GUrVrSkKDgrj3K9kHysVjO1w1ol7X1+gJ52f
 /ZfKowDL4pytu5o7LbmtH7A2aKIy3PFbFdHg8K++WvJg+1kBJldlsMnHZBLEBz/RM6oxRTYWr
 2dTeO5t76FmCrkoHKKJtmOk7oQhNtELA2JrKlm0v6lhWSpkryADkKOHbIEmyeQYe4qdI6br87
 x4nv9PqqlYLTk3M0iJpsRKkvsfXKwzcU9OxyFbXLyyzdjErG9k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 11:40 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> > It would be nice in theory to move the sigmatel devices over to
> > reg_update_bits() in theory, but this seems unlikely to actually happen,
> > given that these are mostly obsolete drivers at this point.
>
> I checked all sigmatel devices (about 10 drivers), I think there will
> be more work to change them to use syscon/regmap when changing to
> reg_update_bits(). I am afraid I can not thelp to convert them without
> a hardware, and as you said, some drivers are already dead. So I think
> it would be nice if the driver owners can help to convert these
> drivers, if we get a consensus about the reg_update_bits()
> implementation at last.

Thanks for taking a closer look. I didn't want to imply that you should
fix them, just saying that it might have been nice if they had been
done like this in the first place. Of course, when the drivers were
written, we did not even have the regmap-mmio helpers at all.

      Arnd
