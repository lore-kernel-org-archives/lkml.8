Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5797C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B57206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+n5pwj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgDANqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:46:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41536 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbgDANqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:46:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so25810112lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=id2LgVdX5Zbt9LUjt9m/iHuBybgTZCyiEkTXJT43HH0=;
        b=a+n5pwj80vxevLVnTRMIx4qWSuxW3589cCII700Sn26rl8XSxthgUsEG6dTmoGB7vt
         0k53FXKC/jOR9z2QXlU3tsKSJ35NYNtKx0sSec158mg+VDWseor1rT7oGZQnGhDj1iE7
         XtW44XqLXjZAyJjvwPC2tTk3pkr4PdMBMK4tjgDwkBBmR/ctr995EOcjxt20GxFuvOmm
         VZ+WJ/oO5vcaHLJiZYz3yTdPieEqBiNfOY6ryPLv6bpjvI2hvsz4VPQ2600QHjtzbvMY
         qhe4mY58TpGb31ulHf/AuWe4vuJLJhWUXYeKs7xaAl8nK7RND5J4gsN48ZZJl7yeksGW
         Hj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=id2LgVdX5Zbt9LUjt9m/iHuBybgTZCyiEkTXJT43HH0=;
        b=be1Pj0EGqJAeXyc19plSu6ANLBfN+oLjgzJDxF3r2camWQ2x6R2pWF0+YzrzfzHJE+
         z2tL3FiojUvf87T63fztcMbz+xjp0UU3RLItkwEiMVh9mUTuOhddzsMMEk/Ds0bZZ2Om
         WvmIDybOarocbcH3DUyk3+QWv1jxmuXYqRajPpWs9WM7xw0uRzJlnQvZH+eoOMpyLAAG
         j3oDzCl4HlzlvT+YKr1Ko7DbR7BqRc8jd7gJ7fVMn/tk/J5Pd+MkDRDjd2Km5Owx8mcx
         6Ct2jz63W+zOBkylai5JUoJNRcrnlBNtPDRVBOxpssZ7Oz/6pPaesZNvOijqweLK9DR1
         maGw==
X-Gm-Message-State: AGi0PuboB15FwXnoD5zlynJxH5XsuiUzXEvYagoQoJ3tVSsH6oBZaOJ9
        699uP4pe5wcqYA+1VkCfxy9/oN9fkUIlVMPjziV0eA==
X-Google-Smtp-Source: APiQypL5fQIT3NYdmUUYCoB3bNsaYBvOwXo555DW5cy8GjYmcdui0/psmUX23p16XcJsMoObjMXsCJ96gbNf1YQPmjY=
X-Received: by 2002:a2e:868b:: with SMTP id l11mr13154273lji.247.1585748765088;
 Wed, 01 Apr 2020 06:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200331085308.098696461@linuxfoundation.org> <CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com>
 <CAHk-=whyW9TXfYxyxUW6hP9e0A=5MnOHrTarr4_k0hiddxq69Q@mail.gmail.com>
 <20200331192949.GN9917@kernel.org> <CAEUSe7_f8m0dLQT1jdU+87fNThnxMKuoGJkFuGpbT4OmpmE4iA@mail.gmail.com>
 <20200401124037.GA12534@kernel.org>
In-Reply-To: <20200401124037.GA12534@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 1 Apr 2020 07:45:53 -0600
Message-ID: <CAEUSe7-ercqbofx93m-d0RNW_dQqr1U7F7JYQ5X81CHSkq4KDw@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/23] 5.6.1-rc1 review
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
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


On Wed, 1 Apr 2020 at 06:40, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Can you please try the one-liner at the end of this message?
[...]
>
> From 2a88ba6ddf54a4340f5a5f896705d5e42561e210 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 1 Apr 2020 09:33:59 -0300
> Subject: [PATCH 1/1] perf python: Fix clang detection to strip out option=
s
>  passed in $CC
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The clang check in the python setup.py file expected $CC to be just the
> name of the compiler, not the compiler + options, i.e. all options were
> expected to be passed in $CFLAGS, this ends up making it fail in systems
> where CC is set to, e.g.:
>
>  "aarch64-linaro-linux-gcc --sysroot=3D/oe/build/tmp/work/juno-linaro-lin=
ux/perf/1.0-r9/recipe-sysroot"
>
> Like this:
>
>   $ python3
>   >>> from subprocess import Popen
>   >>> a =3D Popen(["aarch64-linux-gnu-gcc --sysroot=3D/oe/build/tmp/work/=
juno-linaro-linux/perf/1.0-r9/recipe-sysroot", "-v"])
>   Traceback (most recent call last):
>     File "<stdin>", line 1, in <module>
>     File "/usr/lib/python3.6/subprocess.py", line 729, in __init__
>       restore_signals, start_new_session)
>     File "/usr/lib/python3.6/subprocess.py", line 1364, in _execute_child
>       raise child_exception_type(errno_num, err_msg, err_filename)
>   FileNotFoundError: [Errno 2] No such file or directory: 'aarch64-linux-=
gnu-gcc --sysroot=3D/oe/build/tmp/work/juno-linaro-linux/perf/1.0-r9/recipe=
-sysroot': 'aarch64-linux-gnu-gcc --sysroot=3D/oe/build/tmp/work/juno-linar=
o-linux/perf/1.0-r9/recipe-sysroot'
>   >>>
>
> Make it more robust, covering this case, by passing cc.split()[0] as the
> first arg to popen().
>
> Reported-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/setup.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 8a065a6f9713..347b2c0789e4 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -3,7 +3,7 @@ from subprocess import Popen, PIPE
>  from re import sub
>
>  cc =3D getenv("CC")
> -cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE).std=
err.readline()
> +cc_is_clang =3D b"clang version" in Popen([cc.split()[0], "-v"], stderr=
=3DPIPE).stderr.readline()
>
>  def clang_has_option(option):
>      return [o for o in Popen([cc, option], stderr=3DPIPE).stderr.readlin=
es() if b"unknown argument" in o] =3D=3D [ ]
> --
> 2.21.1

This worked on top of torvalds/master and linux-stable-rc/linux-5.6.y.

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
