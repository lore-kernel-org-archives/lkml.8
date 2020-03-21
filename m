Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DADC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8020753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQpI+bMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgCUJeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:34:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45440 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgCUJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:34:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so2718231lfo.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7PQygVDJDvihpL+AHiWZt1rdNY3SE5YtKZGVTmo8xfA=;
        b=tQpI+bMhMxby/lZdY97K/5ZPx6Qm5PLiooGPuh2ziLzFIT/7rVGl4NUeqYJpbD0uiP
         8o5iXgvllB5weKkIjz/mwHe+ZCpzNymfRMU2RhV2+NOiMwbpwP3AbpXN08w6Kew6U/cZ
         q+/CNYt+VTHN3RqukIocOU+QUUtH0tSVoM4XV3cTFHAPAuaz0t553jZty16Eko+RFP1z
         J/5OI+DBJvWgNDSyIXz7k/axpCFNdc9+hv05hEwuGch3/Z1R2SA2FH77f4Jsj0oSzcHd
         BZvnJesJ+R6hUvLwUuKg6lt9Y8JDFj0wcRBK7ZzdL02M9NHRrfJ5bbQWMZVAwsPIfHgP
         ibCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7PQygVDJDvihpL+AHiWZt1rdNY3SE5YtKZGVTmo8xfA=;
        b=UCQRGRdMfNZ4C7HJLx8bM0II/2HWAVLoOYlB5Qpu85jcC9PuVAabps49FlhNQAfU/j
         fDRPXgLfkDt+wMx/oqvOnfHnkNzHwNELu4fD4TMFAXrXaIwjNa9ivJF2GtCQeiq/k2D3
         3LYodOvPZ+MXT7fbExYg5P7Zd/WR8M/9MdPKY5Yj3G4n6URamYnGW80zkTAvH9XNApFW
         rxqueLL5sMGEiaZDoqh/sihL9cL2gsYYSJOiLZaN9gtBmK/mqB2nkHaPx6UXQ+YtIDnP
         QIzu02ivODj0EQDqnN5OeVeJ5wV6ZMnCUHINN1YQC6EALfHvQZW7RMo7ycqUcItd38q6
         avqw==
X-Gm-Message-State: ANhLgQ0IHTRrOgbKr+Q/sLuDxIVoR3Zw4lUPptUKUVJTb9oi107q2mgO
        mqcd0/NB+88rebllD7SwMjL662Xe+Eso0jnpDgERNQ==
X-Google-Smtp-Source: ADFU+vvJ/Zo7pEohWKBTNFuMMWjR1nmN2fu5OMDlZeJXip5sYLxu47JPUH7i5GR+wkxrtE5ScKJ9SMfmo/biEz+ShN0=
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr7761237lfb.167.1584783242699;
 Sat, 21 Mar 2020 02:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200319150225.148464084@linuxfoundation.org> <CA+G9fYvOQ=oibqFZ=zffqj-c5mcjW2Bew2rVHg=FPs2mHxb_ug@mail.gmail.com>
 <20200321071046.GC850676@kroah.com>
In-Reply-To: <20200321071046.GC850676@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Mar 2020 15:03:51 +0530
Message-ID: <CA+G9fYtVW7n=Zc2sXayYR0a6U-2womo54CW4ebhz8XU=N9uZNA@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/64] 5.5.11-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Mar 2020 at 12:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 20, 2020 at 12:16:11PM +0530, Naresh Kamboju wrote:
> >
> > Results from Linaro=E2=80=99s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> >
> > NOTE:
> > The arm64 dragonboard-410c and arm beagleboard x15 device running
> > stable rc 4.19.112-rc1, 5.4.27-rc1 and 5.5.11-rc2 kernel popping up
> > the following messages on console log continuously. [Ref]
>
> That should have been resolved by now :(

The reported problem resolved now.
Thank you.

- Naresh
