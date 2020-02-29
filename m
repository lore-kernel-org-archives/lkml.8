Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1417DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80C324699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pim9Ezl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB2AuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:50:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41443 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgB2AuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:50:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id v4so5225348wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0fc83ZqAA6+83fPnMS4lxXssttTpf+l85Fw1w82L0QU=;
        b=Pim9Ezl7Ogaq4+QBBsebEB02RdWCvqDSk5e+uOiY+5RXQ1V+C68fvK9QsIWdvHkN/f
         OBPsP/JpzLaEhAtXXWhzuc9drpsT0f4y43v8vWquIfwSgzxpHoq7I5yL+lTiwe9mx5ae
         j7L0hjOzXyGaorIc4fJACvVGBXhCcTVOG0v4J8cxjYYxiqItAeSsciXciS62jlbKuyLV
         tTwg9fe2wrOHf5ERg1Bzi5sn0YPgUYPwtPeKHCpnx276D0/neLh271s7V77wR37so6kC
         QkzO9hz8kFZp+zNYV4iSE+1YzINAdq9N3jbU6U6nluZs/kvA9DyKYT9YrKY5Wl2FPvQD
         Nw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0fc83ZqAA6+83fPnMS4lxXssttTpf+l85Fw1w82L0QU=;
        b=hwcF7RMEApWPJXw6wYfNGNQ0r6+77spt68+1pKLquYYboLiiZ/+/ydmXG+u5F491mV
         3b5BSiHGb7N3nsM380qoV+hZkxEC3rLkead8RE3oPX35/fCdoYG9PpQ3O0ulB/4yiVZK
         ooYEF709hEGXe5v8jnWPTP80AOd0rcz8pd0v8VLGwUKX7CxaMiczVljb0RIDH9YzfdLn
         m3vQ3zfzntSdtpDDocN8njBtvZvBFwy1Pl8tNa9YQOxwfnXiN7np5D+H4bmUynnyy05U
         HaGb9Ytfx7BJL6xkLqDm4/VQsFdWKtY1G7FGitiLP+GFhdqHbAn1SKfCqnyaJ1TdpQY/
         tmQA==
X-Gm-Message-State: APjAAAUB7Poa+he2HGQ2N2qB/AkcY6zGxi+eUrYw/H4FlVEBSaCESkpx
        Qryev+/gRl0Iy8Bj2VmJZvg6pW5W1Fg/z4tHVqFZow==
X-Google-Smtp-Source: APXvYqxWGTtiwUL9PxLOYIePXDdM4+bHkwvOLmQq+Uy1p1lTrTCmmm7EHolfnlQp1sTZeAHX4qJocD0WQucx+d4aaME=
X-Received: by 2002:adf:e38d:: with SMTP id e13mr6955293wrm.133.1582937403580;
 Fri, 28 Feb 2020 16:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+b0LHp15GNchK_TPxaqX8zscqgBw-Jm2Y3yq8Bn=dRbeQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b0LHp15GNchK_TPxaqX8zscqgBw-Jm2Y3yq8Bn=dRbeQ@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 28 Feb 2020 16:49:52 -0800
Message-ID: <CAKFsvUJhbk6cOXKgQ1+9=eDRDES1AB0rSTM+zid-yfk2U-qhYw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 6:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Integrate KASAN into KUnit testing framework.
> >  - Fail tests when KASAN reports an error that is not expected
> >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> >  - KUnit struct added to current task to keep track of the current test
> > from KASAN code
> >  - Booleans representing if a KASAN report is expected and if a KASAN
> >  report is found added to kunit struct
> >  - This prints "line# has passed" or "line# has failed"
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
>
> This does not build for me:
>
> $ make
> scripts/kconfig/conf  --syncconfig Kconfig
>   CC      arch/x86/kernel/asm-offsets.s
>   UPD     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      init/main.o
> In file included from ./include/linux/uaccess.h:11,
>                  from ./arch/x86/include/asm/fpu/xstate.h:5,
>                  from ./arch/x86/include/asm/pgtable.h:26,
>                  from ./include/linux/kasan.h:15,
>                  from ./include/linux/slab.h:136,
>                  from ./include/kunit/test.h:16,
>                  from ./include/linux/sched.h:35,
>                  from ./include/linux/ioprio.h:5,
>                  from ./include/linux/fs.h:39,
>                  from ./include/linux/proc_fs.h:9,
>                  from init/main.c:18:
> ./arch/x86/include/asm/uaccess.h: In function =E2=80=98set_fs=E2=80=99:
> ./arch/x86/include/asm/uaccess.h:31:9: error: dereferencing pointer to
> incomplete type =E2=80=98struct task_struct=E2=80=99
>    31 |  current->thread.addr_limit =3D fs;
>       |         ^~
> make[1]: *** [scripts/Makefile.build:268: init/main.o] Error 1
> make: *** [Makefile:1681: init] Error 2
>
>
> On bfdc6d91a25f4545bcd1b12e3219af4838142ef1 config:
> https://pastebin.com/raw/nwnL2N9w

I'm sorry. It seems I only ever tested locally on UML. As Alan
suggested, removing "#include <kunit/test.h>" from
include/linux/sched.h seems to fix this problem.

--=20
Best,
Patricia Alfonso
