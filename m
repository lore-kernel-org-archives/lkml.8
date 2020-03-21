Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D946C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D6820753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 18:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUadTanT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCUSTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:19:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42333 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCUSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 14:19:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so9993670ljp.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HmzOHeO+HRpIjBM95vy/qqGNJoa4vZPLdaJZ/DoRpA=;
        b=lUadTanTr6oXRZjkSX1QtsJnaG4O7cUM2aFGiw4IIC/5e54AEgdPMxYflgrk9k9OWt
         mypz0RvgI39sw4Xh+GjOcHFY7oUIs5ynBD9jAuyitoHWJwWDrsy+8PR4iM8duH13sYUt
         ejh8xapRGxE/2gR+lo1moC8EIJfxMMT+LcR6e0crHpno4wGU6Pimr367YIjBK0YHZrc0
         Np/kPfN8SdsQwW2UraJ6ScdSsfTgRJaXPOIf5G/m8VCsigLHuoyeViyuhjVrKwR3mycr
         dQRMpwFRsQvWC2p6/LJAowxQHbuQIsjpHW1VZEuo7eKtnEK3MHhwoXspACSNMxVpsWBP
         qUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HmzOHeO+HRpIjBM95vy/qqGNJoa4vZPLdaJZ/DoRpA=;
        b=f9dmLmuxI7VbZpm99GMv13zZAIrG1vvU+fCeB9c7eKybQa+Yi3mtcrMJaHz7WO6PUy
         +cPwCB1IedWMVdM8F9QvaOrLO6x3hNUkHplFK6h2fGVbzz08ESBGEUnKGiMo8THZomvw
         ksD65V53QIca5mOod2fx+FyhItK0LNmT3qcvxGVf2V4nj7wNGfhgjMxyb0g7qtTvcKu6
         3VGIhtEpGCUA+hSy+cz/qNBktyQsUlCQQGxITDs6kAKshvPHq+FlvvFszS41S3+2aOHb
         YvvPFNzK8Jbvcy6FcTYlAQ3VrF5zeLassD5e2EdLJAOii+a1CAjlq2iAveTsrMeAX7I8
         rmvQ==
X-Gm-Message-State: ANhLgQ2WYeRehDjHvY+ZiLM2Q7PvA0lr9PB3CkFkZL+YckQU7RrVUYI5
        HVe3zHQWtbnrcZUcT7731uFOEYb4YVuaAt07vR1cHQ==
X-Google-Smtp-Source: ADFU+vvNyMExf0IJEXBPI+NKwmfuZCT3vkDoT2RS+Gvogw0gj2xqD0bwee63UP2nZGymQY4ZgHKxTMQiI4A3qSBfD+k=
X-Received: by 2002:a2e:8885:: with SMTP id k5mr9159232lji.123.1584814741294;
 Sat, 21 Mar 2020 11:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200319123919.441695203@linuxfoundation.org> <CA+G9fYvLC7xBuULxhG9yRi+EbUqmQjnS0X+0j-vGpX6XPVskOg@mail.gmail.com>
 <20200320071256.GA308547@kroah.com>
In-Reply-To: <20200320071256.GA308547@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Mar 2020 23:48:50 +0530
Message-ID: <CA+G9fYsd9nfwiYyuSh0C6JiAg8b-fhg2-MbbC=VuAPKoFcQs0g@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/60] 5.4.27-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 12:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 20, 2020 at 03:29:47AM +0530, Naresh Kamboju wrote:
> > hugemmap05.c:89: BROK: mmap((nil),402653184,3,1,6,0) failed: ENOMEM (12)
> > tst_safe_sysv_ipc.c:99: BROK: hugemmap05.c:85: shmget(218431587,
> > 402653184, b80) failed: ENOMEM (12)
> >
> > Running with 50*40 (== 2000) tasks.
> > fork() (error: Resource temporarily unavailable)
> > Running with 20*40 (== 800) tasks.
> > pthread_create failed: Resource temporarily unavailable (11)

On 5.4.27-rc3 the above report problem not reproduced.
I have re-tested multiple times to confirm this.

- Naresh
