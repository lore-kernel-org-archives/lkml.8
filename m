Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F1C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F27320730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="Hfwezzhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDGViy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:38:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36053 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDGViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:38:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id l25so1069463qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=isuLobyDtt6EFpFjL8LiFOi1CRIfA1D/367XhIHg364=;
        b=HfwezzhcKfEVjhsWnYuE+MOwB43m0F5LU/ypxx0eZ+y229VT2wHow55nM/MWJvF7vE
         KDxFReBiJci6sow5QVNmADUlPNOsA8JJ04CYmAGy1rLGLxLBmnmOysRFqAccjr+sz8cu
         QR8nuPXJgsqHD/luOvmgr3Dmmr2fiEpx+H568cGpnWCeYP2eR1TQ4E+6CFoby2MED4ky
         QFZLNyxOQOK/qxeoPO1eNN+B78irxg01lKJtBw1Az8KfaFbnhabIXtb0fNi1iGtLZ3hQ
         UDo7nq1z6RseGH/V02uty5ZxA7yt9Z4CLaaFcORe+sxANwbM/txD6UvmELaWWa9JowuR
         jflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=isuLobyDtt6EFpFjL8LiFOi1CRIfA1D/367XhIHg364=;
        b=kq3canqAepgvTwkaG49OFA8waCHwvVFWValV7+ejFZ1YlGTJP33V9WIncRsb1gOmzv
         kAHyU1yzj17DUT31bJMZBzAHoQ/2XYHHYGHD20drgeIHtiZd3TNqHMz8kRVAOEdKePqa
         kT/JVF5iw5F3RsMzTOi/kpn6OhomR3I9NGPIjj8l0ymaTQn130wDIIl0FIacbc8KZwkn
         tEMmaKTALu+BCNgOklZduCHFrEcW3I4uwd9mHJLgsbwrJ8rtA0Goh0vSXDUSem4aKJw+
         BJDld+l5tpK89YBCrybzaqEKmV/A3kFNVxKc50GSrYICBHW1kUlWS//CJqREzB4PMRNw
         KrIA==
X-Gm-Message-State: AGi0Pub+njsWBYavNsYeZMUaEn5QtcvrbkhdoI79We9zkf7ZGO5K1hIP
        WoFLbt91oWExZEfL2rnqtcfdhQ==
X-Google-Smtp-Source: APiQypL9AU+nfBTB36SMyId+ZGOO1XL78KfsEhAHnGSpMqGnUwgpqsUAfmwwldXnBPU3DakKXJm/uA==
X-Received: by 2002:a37:8044:: with SMTP id b65mr4457520qkd.238.1586295531751;
        Tue, 07 Apr 2020 14:38:51 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id p38sm18811316qtf.50.2020.04.07.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 14:38:51 -0700 (PDT)
Message-ID: <0d7d447764a67536885f38b032f888e91db43997.camel@massaru.org>
Subject: Re: [PATCH v3, RESEND] kunit: Fix kunit.py run --build_dir='<foo>'
 fails on "unclean" trees
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 07 Apr 2020 18:38:48 -0300
In-Reply-To: <CAFd5g44EGCY0zHfZXekS8GAXHxrf5zeeTW=MHRz0NujKqTsRQg@mail.gmail.com>
References: <20200406221916.50008-1-vitor@massaru.org>
         <CAFd5g44EGCY0zHfZXekS8GAXHxrf5zeeTW=MHRz0NujKqTsRQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On Tue, 2020-04-07 at 13:31 -0700, Brendan Higgins wrote:
> On Mon, Apr 6, 2020 at 3:19 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> > Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
> 
> I am still seeing the error described in the bug.
> 
> Steps to reproduce:
> 
> 1. tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig
> 
> 2. make ARCH=um mrproper
> 
> 3. tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig
> --build_dir=.kunit

Thanks. I managed to reproduce the bug. I'm working on it.

> One other note: It should probably be done in another patch, but it
> would be nice if kunit.py would tell you that you need to run
> mrproper
> when the olddefconfig fails.

Sure, I can work on it.

> 
> > For some reason, the environment variable ARCH is used instead of
> > ARCH
> > passed as an argument, this patch uses a copy of the env, but using
> > ARCH=um and CROSS_COMPILER='' to avoid this problem.
> > 
> > This patch doesn't change the user's environment variables,
> > avoiding
> > side effects.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> > v2:
> >  - Use the correct next branch
> > 
> > v3:
> >  - Use torvalds/master branch
> >  - Use base parameter on git send-email
> > ---
> >  tools/testing/kunit/kunit_kernel.py | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/kunit/kunit_kernel.py
> > b/tools/testing/kunit/kunit_kernel.py
> > index 63dbda2d029f..96216c699fde 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -20,6 +20,7 @@ import kunit_parser
> >  KCONFIG_PATH = '.config'
> >  kunitconfig_path = '.kunitconfig'
> >  BROKEN_ALLCONFIG_PATH =
> > 'tools/testing/kunit/configs/broken_on_uml.config'
> > +env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
> > 
> >  class ConfigError(Exception):
> >         """Represents an error trying to configure the Linux
> > kernel."""
> > @@ -41,13 +42,15 @@ class LinuxSourceTreeOperations(object):
> >                         raise ConfigError(e.output)
> > 
> >         def make_olddefconfig(self, build_dir, make_options):
> > -               command = ['make', 'ARCH=um', 'olddefconfig']
> > +               command = ['make', 'olddefconfig']
> >                 if make_options:
> >                         command.extend(make_options)
> >                 if build_dir:
> >                         command += ['O=' + build_dir]
> >                 try:
> > -                       subprocess.check_output(command,
> > stderr=subprocess.PIPE)
> > +                       subprocess.check_output(command,
> > +                                               stderr=subprocess.P
> > IPE,
> > +                                               env=env)
> >                 except OSError as e:
> >                         raise ConfigError('Could not call make
> > command: ' + e)
> >                 except subprocess.CalledProcessError as e:
> > @@ -57,9 +60,10 @@ class LinuxSourceTreeOperations(object):
> >                 kunit_parser.print_with_timestamp(
> >                         'Enabling all CONFIGs for UML...')
> >                 process = subprocess.Popen(
> > -                       ['make', 'ARCH=um', 'allyesconfig'],
> > +                       ['make', 'allyesconfig'],
> >                         stdout=subprocess.DEVNULL,
> > -                       stderr=subprocess.STDOUT)
> > +                       stderr=subprocess.STDOUT,
> > +                       env=env)
> >                 process.wait()
> >                 kunit_parser.print_with_timestamp(
> >                         'Disabling broken configs to run KUnit
> > tests...')
> > @@ -71,13 +75,13 @@ class LinuxSourceTreeOperations(object):
> >                         'Starting Kernel with all configs takes a
> > few minutes...')
> > 
> >         def make(self, jobs, build_dir, make_options):
> > -               command = ['make', 'ARCH=um', '--jobs=' +
> > str(jobs)]
> > +               command = ['make', '--jobs=' + str(jobs)]
> >                 if make_options:
> >                         command.extend(make_options)
> >                 if build_dir:
> >                         command += ['O=' + build_dir]
> >                 try:
> > -                       subprocess.check_output(command)
> > +                       subprocess.check_output(command, env=env)
> >                 except OSError as e:
> >                         raise BuildError('Could not call execute
> > make: ' + e)
> >                 except subprocess.CalledProcessError as e:
> > @@ -91,7 +95,8 @@ class LinuxSourceTreeOperations(object):
> >                 with open(outfile, 'w') as output:
> >                         process = subprocess.Popen([linux_bin] +
> > params,
> >                                                    stdout=output,
> > -                                                  stderr=subproces
> > s.STDOUT)
> > +                                                  stderr=subproces
> > s.STDOUT,
> > +                                                  env=env)
> >                         process.wait(timeout)
> > 
> > 
> > 
> > base-commit: 7e63420847ae5f1036e4f7c42f0b3282e73efbc2
> > --
> > 2.25.1
> > 

