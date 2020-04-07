Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3711C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DD720731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzzFlv8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgDGNvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:51:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34211 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:51:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id x23so2453717lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ZDRUt3eOgGiaKX8/LhaubmvfH76uWvW+ZDm0Jnzfuw=;
        b=OzzFlv8dJTtxOJq1DDp9Cu2oRQ/u+vPgLaEttIDiFFYQazpja60LVy7GcKOJtN9KVe
         SmrXMtt829rBJtRwFrp3Yo/+7RFQEeIsDt98Pmf/rpjoto8Yv7lsBFoxnYGCa98+NA8q
         vcTQB0ObNwY4RiV5U4m7tH0TtQHdzuWrcRBBbqWhX6KrJXbHlAl9cgLshL54vG20Zd8b
         xV/iK/LsadsjL6dqgJO0i1xsWjf6hDsX9JxtfL1vROqP1Fj2QqnyOox+badK8fshoKKK
         jVzjW2XeWQmn7RuiROOwFLeCkOdpW89f63oXCNGJf5D5PkaR1508DuCtwpSz1unPHN6+
         K5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ZDRUt3eOgGiaKX8/LhaubmvfH76uWvW+ZDm0Jnzfuw=;
        b=eIxmob99zrI73RTGDnZ6jCyVMwe8y8VbL3LAb9ec3idHHwfDVzSpDU/VLZ34jke3g1
         kwCRamwTqS+MtJ28eIICiHnRRZzc52at/uUnzTuZlhUo/HJ8LdZj742thJeRWIAvMt9t
         ozPNsVsCGglDbzQIq8qRw2spvFnHunYnjUFvB7kaJm5UVRUUGKVEaTg5h/tvH4EawgHQ
         EIgvh8BmC/p7+bfYCrHMT9984rXua0ulLaxvJ2ZtEhPVWxwxzIsTlJiRg9g+/noYGC7H
         QAPaM8SCZHacN2hZd7llWlGfYyXPUXGfEJOLvUSZ8S5w/eSvTaxGYyfkoCL+ebETMGKj
         btTQ==
X-Gm-Message-State: AGi0PuanGXC9zQ/PVdo1ZLmWjc7Y9RRG3miRhSnlamX2carsV5z+1JXk
        Kq4w3b3YjugcSeSlARUmCUmjR327GH8VhnxJvjM0WRJlV9A=
X-Google-Smtp-Source: APiQypJwDVqCmyA8mC9IcT6X63VEZpPEFfsRPRlDBmqddx+8Lh4NnRodBiV0OnC173NkLm76vKQtFva8Cl1/9fUSaFM=
X-Received: by 2002:a05:6512:1109:: with SMTP id l9mr1632108lfg.50.1586267488223;
 Tue, 07 Apr 2020 06:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200407101452.046058399@linuxfoundation.org>
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 7 Apr 2020 08:51:15 -0500
Message-ID: <CAEUSe7_Je2e_ExLnnwj-SLtSqLyoAPTXqS_WO8yiHneMh46qfw@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/29] 5.6.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 7 Apr 2020 at 05:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.3 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Apr 2020 10:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Perf still fails to build. Can be fixed by picking up 9ff76cea4e9e
("perf python: Fix clang detection to strip out options passed in
$CC").

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
