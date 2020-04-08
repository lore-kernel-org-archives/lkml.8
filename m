Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7482C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0942082D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586366739;
	bh=nhHL0eGBF+8lU0WiMVDXx88ZtGqDPhFXFNSoZ0ArEak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IbyDzEQhjtPZ0sTO0dKWVc3PV1XdQFlDBBL701FPwelK7+1oBObDt9hbRBUEEIWC1
	 rEqIZsR/W7g8cEqmJyCffmVIx3Itk1wruVl+jKmRVEtRjhKQeJOfqXpyNqOonpKzPC
	 ustFuyItihJh1th7w7HzSHmyN5O1QUh/+66e6IVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgDHRZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:25:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgDHRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:25:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id g27so8462809ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmW1kBANhNCKQomzjz6tBYP3TN8jkHzWDA2kJzdFS8U=;
        b=Ao5NFBjhbqRZ9wC2Ceqr+vcVRiRnoLz0Xh6wH0b44DvlMJCpcB9KHsqyceCapwB2EA
         iw/sBOeR2lWHoHARimi5ampBkxXBPU2gVattO6FBrHOZqgaJjk/7BOqGY33Phq64Tjxb
         IU0j7Ie975ItxQRjkfNwnJF+n4SiU7+8gUZmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmW1kBANhNCKQomzjz6tBYP3TN8jkHzWDA2kJzdFS8U=;
        b=N2kXJEeMaw0th1GrF0r7+/BMeyUnPGkDNy70IcdsGr7vAv1td01d856+ZEEFgmNWn8
         NwzS6KcOY4TCx7l5cvxljlHYYqe1AUEyyWkpBo6BEkiRdv1JiDMealc3YGrJxaMxFKN0
         h5wfrDH/1NtafIXebprjqKzyeI0E2G9s6n+hT7rEzd9IMUSa8WjOkMsNSW3ahzqv6vCZ
         NtEUtos6DVfNB7D95tCP5jy/ZJUYbrjMCCNJr5P/+vyyP7KImnd4R8BQVFbEGhf/Nihs
         1Mf0H9tub/HLq+daw182vN57449CuY041eKMS0q3+RsrTxicm1JFca4DHgHHryxGK2fW
         MKEw==
X-Gm-Message-State: AGi0PuZeNHSiexleTkkJePz+QV8aqON5rAPtkn6w5SJROl5VgZM6LLxL
        m+WHENVDx7NSl1YRlUCKxzkGo/rtY3U=
X-Google-Smtp-Source: APiQypIogqMwRUrGTQZU+MLdF3tuIJJwzW+OaYGOi12XvjHAi09zY/UBohIZGtTUnSKt4o2ckeToSw==
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr1931941lji.61.1586366735393;
        Wed, 08 Apr 2020 10:25:35 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r21sm14706128ljp.29.2020.04.08.10.25.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 10:25:34 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id g27so8462648ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:25:33 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr5932115ljj.265.1586366733516;
 Wed, 08 Apr 2020 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org> <87o8s43wuq.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87o8s43wuq.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 10:25:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy_e1OY=OoPXp+4ZGEsYmRVQW8c_0GPYT-HfK376MKqA@mail.gmail.com>
Message-ID: <CAHk-=wgy_e1OY=OoPXp+4ZGEsYmRVQW8c_0GPYT-HfK376MKqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] binfmt: Move install_exec_creds after setup_new_exec
 to match binfmt_elf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 6:34 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> In 2016 Linus moved install_exec_creds immediately after
> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
> potential information leak.
>
> Perform the same cleanup for the other binary formats

Can we not move it _into_ setup_new_exec() now if you've changed all
the binfmt handlers?

The fewer cases of "this gets called by the low-level handler at
different points" that we have, the better off we'd be, I think. One
of the complexities of our execve() code is that some of it gets
called directly, and some of it gets called by the binfmt handler, and
it's often very hard to see the logic when it jumps out to the binfmt
code and then back to the generic fs/exec.c code..

             Linus
