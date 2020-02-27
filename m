Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBFDC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BF524656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQBU8iu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgB0OpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:45:25 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46003 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgB0OpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:45:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id m4so1953174vsa.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uIt9DyZ9nPgtt+YVHDl4cWP+F6uXmWHM0NievYA3/mQ=;
        b=VQBU8iu2uCPmMFA6ZKYuIFOaqxlIebNshhGY19HbX6TJSpWpKgmpqa+OiCriOvOtfU
         SURggXzLsOrJPCaj2ZcunCf16QRKxHwV+Tln/q+jGedzB6sCrBuhKpDYKEMg60GJWWMK
         lMR1htPczf5Po2JHrIdWjlWPXyunGfIE0XuEU0NbogWA9f50GQK7Q6rxJWyoq6XXTFpR
         rtG323NNbZowjcYgEr8VNhaRP1Ml4MBs1jk546H6xPLSyU4wF883j7mE9+h51e1Hjl7h
         6ZdSg6VS9SDba70F7hxyUJZGRa0WA/PbzdcftGgzs0iJkWdF5j8GuiPhpb8sAjPaK7yM
         zATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uIt9DyZ9nPgtt+YVHDl4cWP+F6uXmWHM0NievYA3/mQ=;
        b=fr2tIdIjwHv2HOHS/h40U5V1ERENk2Aw8jTrEAtS14hXtipHgTo0pxKvQEVY4FF+RI
         1C0CkvUPMHQbkm4ug1cPug2Zbf7zz8+pmRXMZ2tj5LTn4xRwLQvL26My8YuIv1Ua+edL
         +lnAc9HEki9rOVDsiY11tgH9cLRTh26+MOTm6t6smz3aO7tPv6nRqkDYRtYhd8P3od2W
         SSE3uiO4fsqT9f07UnBGptkUycQjvCXSyPZgiOWBSkT/spLyfLk8x+ZZxrFWwOdkaNeg
         cWYITXirZL3h1Q1fzDjrdjB0h91q/WUfGjIVIE4fdrDd3CPhDaGRTY80L9jPQ42/OQtI
         zruA==
X-Gm-Message-State: APjAAAXxx+OYKhaSb28IwF4FXiqKdtkVyb8lWJaAM6Jd6OgPAsqN2t8s
        GoE4otr4jXsteaLF1/CnWTgp5gV6hlJLnPLudN0OVw==
X-Google-Smtp-Source: APXvYqx24Fufs8kygldW8udN7qzYKu0xpi9B+mGtQ5uymR1YOJw2PzRkveUvacDSqSxOOr5eo6UFeHhjaqb2/JA/bRg=
X-Received: by 2002:a67:f318:: with SMTP id p24mr2792811vsf.240.1582814722123;
 Thu, 27 Feb 2020 06:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Feb 2020 15:45:10 +0100
Message-ID: <CACT4Y+b0LHp15GNchK_TPxaqX8zscqgBw-Jm2Y3yq8Bn=dRbeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
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

On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>  - Fail tests when KASAN reports an error that is not expected
>  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>  - KUnit struct added to current task to keep track of the current test
> from KASAN code
>  - Booleans representing if a KASAN report is expected and if a KASAN
>  report is found added to kunit struct
>  - This prints "line# has passed" or "line# has failed"
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

This does not build for me:

$ make
scripts/kconfig/conf  --syncconfig Kconfig
  CC      arch/x86/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      init/main.o
In file included from ./include/linux/uaccess.h:11,
                 from ./arch/x86/include/asm/fpu/xstate.h:5,
                 from ./arch/x86/include/asm/pgtable.h:26,
                 from ./include/linux/kasan.h:15,
                 from ./include/linux/slab.h:136,
                 from ./include/kunit/test.h:16,
                 from ./include/linux/sched.h:35,
                 from ./include/linux/ioprio.h:5,
                 from ./include/linux/fs.h:39,
                 from ./include/linux/proc_fs.h:9,
                 from init/main.c:18:
./arch/x86/include/asm/uaccess.h: In function =E2=80=98set_fs=E2=80=99:
./arch/x86/include/asm/uaccess.h:31:9: error: dereferencing pointer to
incomplete type =E2=80=98struct task_struct=E2=80=99
   31 |  current->thread.addr_limit =3D fs;
      |         ^~
make[1]: *** [scripts/Makefile.build:268: init/main.o] Error 1
make: *** [Makefile:1681: init] Error 2


On bfdc6d91a25f4545bcd1b12e3219af4838142ef1 config:
https://pastebin.com/raw/nwnL2N9w
