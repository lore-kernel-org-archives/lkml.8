Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6342074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0fZT4bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDGUbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:31:22 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51116 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:31:21 -0400
Received: by mail-pj1-f66.google.com with SMTP id b7so106158pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKqZWyMQ8V8zQ20un6jU7HEK04ADqKGnxMMnNcQmdRY=;
        b=a0fZT4bKGAAC/shPL7O9e0uWZrLTjV2ylyJY2sfBmRY6B5ZvfW0dghucSOrpamWJPY
         JUCYKHnWorr9tUamq/iR4giSU6tjk4oCiShBGmL782UKl0DWVLzfSxGttgdlmHeSMD8n
         USEybio2T7VuUT2fLczo63Ru53sMFCVzfTlT+mU1Fa/ap6GWDg2VcjCg86jjpviYRHXc
         Iz7So5F7Udpr9Lbhc79nVirD0nmXaF25Itbm1mm1GG9t2QNB6iWyFMa5OAL092sfbgH8
         5AztG4ripU+6zZTSDZvgQZCVw8RocoC0t5NurWuTODsqnHquobk+085szhz7aVytbHti
         ZXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKqZWyMQ8V8zQ20un6jU7HEK04ADqKGnxMMnNcQmdRY=;
        b=jcVdqWDd3j4SyT3hI5hAWZ8MvBQxmy2usxMBKGMJzR04Fi9X8YEvPX3pmtdABqofOO
         wF83Lc/YXUOCxGiIvbJ8Cj8FLQzaaN9zN5z/kbKuPAuNqU6pz1tmNnyM/lfj6vla3/05
         u05W9ckHBPa/8DlIdgq5B9sSJj5WGNUgsM8Tp9d5zQEFi6z+fPxApdlBBicxVz76aac8
         vBlfYMvrGhLEPYi3d65MJ1wUaX9B3+p7RQ4isWBKrp1TPcpsbzMjdFYEuAU+bD/J5csg
         F6msBX8URte7kDSOyD3c6IKtmCIgyrcVvBUh57wMQR7Qu08ZdSb0wQKk7TUmFGRrWxQC
         v6IQ==
X-Gm-Message-State: AGi0PuazbK+wk1oGLDXmjTGPh/cKcJr+0pGVbOOC5a7d0fhNJmKY/U2j
        ymRFJQ/rsVPDNEyeHLHskVA80a768UpBT408AQ8rvQ==
X-Google-Smtp-Source: APiQypKi0NHL1kvG+6WjCjMqalM7lL+WN8MrRtbStR3FlzJY1khKq++r7+B0jHFKqM7izTL5ggeQhNjpij2BSWIXUw4=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr1246223pjb.18.1586291478614;
 Tue, 07 Apr 2020 13:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200406221916.50008-1-vitor@massaru.org>
In-Reply-To: <20200406221916.50008-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Apr 2020 13:31:07 -0700
Message-ID: <CAFd5g44EGCY0zHfZXekS8GAXHxrf5zeeTW=MHRz0NujKqTsRQg@mail.gmail.com>
Subject: Re: [PATCH v3, RESEND] kunit: Fix kunit.py run --build_dir='<foo>'
 fails on "unclean" trees
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

On Mon, Apr 6, 2020 at 3:19 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219

I am still seeing the error described in the bug.

Steps to reproduce:

1. tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig

2. make ARCH=um mrproper

3. tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig
--build_dir=.kunit

One other note: It should probably be done in another patch, but it
would be nice if kunit.py would tell you that you need to run mrproper
when the olddefconfig fails.

> For some reason, the environment variable ARCH is used instead of ARCH
> passed as an argument, this patch uses a copy of the env, but using
> ARCH=um and CROSS_COMPILER='' to avoid this problem.
>
> This patch doesn't change the user's environment variables, avoiding
> side effects.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
> v2:
>  - Use the correct next branch
>
> v3:
>  - Use torvalds/master branch
>  - Use base parameter on git send-email
> ---
>  tools/testing/kunit/kunit_kernel.py | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 63dbda2d029f..96216c699fde 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -20,6 +20,7 @@ import kunit_parser
>  KCONFIG_PATH = '.config'
>  kunitconfig_path = '.kunitconfig'
>  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> +env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
>
>  class ConfigError(Exception):
>         """Represents an error trying to configure the Linux kernel."""
> @@ -41,13 +42,15 @@ class LinuxSourceTreeOperations(object):
>                         raise ConfigError(e.output)
>
>         def make_olddefconfig(self, build_dir, make_options):
> -               command = ['make', 'ARCH=um', 'olddefconfig']
> +               command = ['make', 'olddefconfig']
>                 if make_options:
>                         command.extend(make_options)
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command, stderr=subprocess.PIPE)
> +                       subprocess.check_output(command,
> +                                               stderr=subprocess.PIPE,
> +                                               env=env)
>                 except OSError as e:
>                         raise ConfigError('Could not call make command: ' + e)
>                 except subprocess.CalledProcessError as e:
> @@ -57,9 +60,10 @@ class LinuxSourceTreeOperations(object):
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
>                 process = subprocess.Popen(
> -                       ['make', 'ARCH=um', 'allyesconfig'],
> +                       ['make', 'allyesconfig'],
>                         stdout=subprocess.DEVNULL,
> -                       stderr=subprocess.STDOUT)
> +                       stderr=subprocess.STDOUT,
> +                       env=env)
>                 process.wait()
>                 kunit_parser.print_with_timestamp(
>                         'Disabling broken configs to run KUnit tests...')
> @@ -71,13 +75,13 @@ class LinuxSourceTreeOperations(object):
>                         'Starting Kernel with all configs takes a few minutes...')
>
>         def make(self, jobs, build_dir, make_options):
> -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> +               command = ['make', '--jobs=' + str(jobs)]
>                 if make_options:
>                         command.extend(make_options)
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command)
> +                       subprocess.check_output(command, env=env)
>                 except OSError as e:
>                         raise BuildError('Could not call execute make: ' + e)
>                 except subprocess.CalledProcessError as e:
> @@ -91,7 +95,8 @@ class LinuxSourceTreeOperations(object):
>                 with open(outfile, 'w') as output:
>                         process = subprocess.Popen([linux_bin] + params,
>                                                    stdout=output,
> -                                                  stderr=subprocess.STDOUT)
> +                                                  stderr=subprocess.STDOUT,
> +                                                  env=env)
>                         process.wait(timeout)
>
>
>
> base-commit: 7e63420847ae5f1036e4f7c42f0b3282e73efbc2
> --
> 2.25.1
>
