Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BCEC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E969D2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZaUbKqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCaS1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:27:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33812 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCaS1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:27:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so8439714plm.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLVDD+NzMHaNk3lT9nXy779lPxGGvFl1BeZrYwA43Fw=;
        b=eZaUbKqBQsAGEDWohcgVWreqYFpuy1mtBi8+zOZFx4hKtYXVoodnXBRoqO5ffqHmyJ
         s+TE9G2H7Wez9Qr9x1vq0LGjzrhad/x5PKrJ1+UMhBbOBxRBDX7ry0dL3vIHj1k75YVv
         7NqwAL+5p8OUn3W7fOUI219Glds7agiAj/hLMgByUGeC2b9+fW2EpYPyKoQw6c1z9g3U
         KtK6Ia2Gx7k5g6CjE4Kc2Bo18fYpsJSHTS25OlRYlqeE/r4+8wLTDR9rmVMqcQ6Y2JtF
         sUNYHN8gSJS9S2L1MfGM/RZnGtHHdFTIfnHnyhceOUiyeOifHVSMKIDrD/KANnLQ7Th5
         O28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLVDD+NzMHaNk3lT9nXy779lPxGGvFl1BeZrYwA43Fw=;
        b=QJhwthn2E/gk4ooZxbRQLvVdp+schYtc1VptJ/Is76+snDnzJ/uu+Eb5LSnbMOnnnB
         LPMTkSNkCvgcjSm6eBMxHC25J6hj/zm7IugEyfPZKF/j01EGwfz3Sk5ZqeSJ/DAmcVuq
         f13+VpYTr5DbiVDBtOzKP1SYdURTVE6Yj7tSFriE/uCI2HZLlAAmyMpIVNG2fnFN6DI+
         zuB80QQSnYPQiBkSX3EAXwq1noQ99seM5shqmGNpTZAxRHP78KM2MB06qPQCa6ux7MS5
         1wR8/WypdjIcjmKBjbp+KaVm7Xyc7/6gpALOuAHZtz1rCs9zdeBfTalN/QaAHbLSAHzi
         RMyg==
X-Gm-Message-State: AGi0Pub4xB0V/0Fn0d8G0/dYoifEt8sacG7ybyBi+r6/fsmZrSIRWXQO
        xl+mORlNdNpmn40qYa8t5O468KhZJxOkb4ww6/ENjkUYedA=
X-Google-Smtp-Source: APiQypI7iAE735GgCKkeZusjs8UlrOmYraVum5tmyZ7a9ZtEskbpvk2jByn4JUjxs7U3xgaqUrYxkZIAf+J/001kv4E=
X-Received: by 2002:a17:90a:9f03:: with SMTP id n3mr209849pjp.29.1585679249825;
 Tue, 31 Mar 2020 11:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200330230256.28323-1-vitor@massaru.org>
In-Reply-To: <20200330230256.28323-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 31 Mar 2020 11:27:18 -0700
Message-ID: <CAFd5g47hiPf7Xy0f4YER+HzHHXyUV0dhiQ=2ZXfezEHBcrTuEQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kunit.py run --build_dir='<foo>' fails on
 "unclean" trees
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 4:03 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> For some reason, the environment variable ARCH is used instead of ARCH
> passed as an argument, this patch uses a copy of the env, but using
> ARCH=um and CROSS_COMPILER='' to avoid this problem.
>
> This patch doesn't change the user's environment variables, avoiding
> side effects.

Seems reasonable to me.

> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

I cannot test this as your patch doesn't apply to our for-next branch
(kselftest/kunit). You can find it here:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

> ---
>  tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index d99ae75ef72f..0cb1f81ac8f2 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -15,6 +15,7 @@ import kunit_config
>
>  KCONFIG_PATH = '.config'
>  kunitconfig_path = '.kunitconfig'
> +env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
>
>  class ConfigError(Exception):
>         """Represents an error trying to configure the Linux kernel."""
> @@ -36,22 +37,22 @@ class LinuxSourceTreeOperations(object):
>                         raise ConfigError(e.output)
>
>         def make_olddefconfig(self, build_dir):
> -               command = ['make', 'ARCH=um', 'olddefconfig']
> +               command = ['make', 'olddefconfig']
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command)
> +                       subprocess.check_output(command, env=env)
>                 except OSError as e:
>                         raise ConfigError('Could not call make command: ' + e)
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output)
>
>         def make(self, jobs, build_dir):
> -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> +               command = ['make', '--jobs=' + str(jobs)]
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command)
> +                       subprocess.check_output(command, env=env)
>                 except OSError as e:
>                         raise BuildError('Could not call execute make: ' + e)
>                 except subprocess.CalledProcessError as e:
> @@ -66,7 +67,8 @@ class LinuxSourceTreeOperations(object):
>                         [linux_bin] + params,
>                         stdin=subprocess.PIPE,
>                         stdout=subprocess.PIPE,
> -                       stderr=subprocess.PIPE)
> +                       stderr=subprocess.PIPE,
> +                       env=env)
>                 process.wait(timeout=timeout)
>                 return process
>
> --
> 2.21.1
>
