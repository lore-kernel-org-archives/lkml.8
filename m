Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F142C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0608E2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7MsCxfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgCaSIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:08:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42991 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCaSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:08:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so22940528ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVhNCBWWhqrmhwzD0I8O0Ic/nmsiw3He1JBWn/IFIGg=;
        b=J7MsCxfDvDHJSsVI38CazslySt+gUoXu/ZKBlY7htM/gc41yUSh7NR6xMRpLk8Q1LS
         2KxGk8DK45xbvzt+Q4HnbsAqM8xXnMFJlduwHtX1xaQXvUkiCVGB2wTzV8fXQbyJv+gy
         0JQ5wivKByI4/57Kq6VsJu066YQLmUH3re6fGu6Qmj8Sy8qQ6iZIyTUpBQTbH46QGNLu
         aGahdwVpDcXAxiF4x3XrW8bHuro/qOD5lk+5H/4LtlpaqSsRuy0lD/UqpptyLnO/L1sj
         j1HXetXm6wUKWmUe+qrhM0dtgwPwWn5DXUxg19VbWhiW1GSuslcggAPC2UeipIhsS+So
         7daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVhNCBWWhqrmhwzD0I8O0Ic/nmsiw3He1JBWn/IFIGg=;
        b=nfSobfh2ROgpK2bHB8LzBcBI1GWnnyWibsQVi2X15Ko3B0J+HblrPl0oxnca2Q4DCm
         DLMbY7hsGb052rkPQ0whst1/Cub/kw8AvxumYn+SrEuQiHWfwjNQ2rS9Lu5/Cd23sZZe
         o8iMFuuktls5XlfgkODrbaT+6l/nDlSgr/b8Sx7vLnPZA4JcnQb5RlMn8m/QWk7a6ueL
         lbC+E7xksloOS7jU9F0Wy/mi/AUFv3zP9on7bSrJsE8jOSBL/S/Q/weHeauaF62uJ2nn
         WJiheXY+rztAZ/KI66I7+c7ie7Ply+AxqHON6BzPazizi4er4zKn9hJTAAkqbbXliNxh
         rbtw==
X-Gm-Message-State: AGi0PubCytxDym7bPK4Ktysx/WsDkgKWSIUhBFgex5o1OzLHEVlQkEK/
        tyOFEPHN/App+sDb7LqLPWoX/jBwVmQQDijnNNKi9w==
X-Google-Smtp-Source: APiQypKyNWj02m6O2+eo7TowUgPoys1dqm6YlLWwR2nN0+0/VQMpY2mP/gmN+2nUCtyDoNjDn+QfgYtycQwmL3sZNiI=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr10329966ljg.165.1585678087993;
 Tue, 31 Mar 2020 11:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200331085308.098696461@linuxfoundation.org>
In-Reply-To: <20200331085308.098696461@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 31 Mar 2020 23:37:56 +0530
Message-ID: <CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/23] 5.6.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 at 14:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.1 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2020 08:50:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Perf build broken on Linux next and mainline and now on stable-rc-5.6 branch.
where as building kernel Image is successful on arm64, arm, x86_64, and i386.

I have reported this problem on March 25th
https://lore.kernel.org/linux-next/CA+G9fYtr+Je4=pLWUgUvPNzUSUmg04oXPJ8zFwTRKji_udcZzA@mail.gmail.com/T/#m7909c9746aceadd95d67accbbc9798ba1dd19157

-- 
https://lkft.org.linaro
Linaro LKFT
