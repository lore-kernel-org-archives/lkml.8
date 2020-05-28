Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5188C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A27207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE1HEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:04:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39234 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:04:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id d7so1619097ote.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdXhULZCsWnd9ZBra4O7WZx0uYPQk7obmGdAookvhaE=;
        b=nI5ct+GCtOmGysCm4Iq/j74sLHU2DqjPTnfjVQpzCRqfHLX3ObA7fBbfqze4o5WRzP
         7mWRRRklbLcZKnd3D4F0elAuzMjH2vhMAx0IMTd65dqxvssiZTh4R46RvSYi+X5Za03m
         lgPb6DDZ2ATL1h5xo+GwGRTURngD6HRTcGCSHuDN+9CVn20aMEmHfPKy6a2fSL32SguC
         CGiLNjYpyraLtUUf3gi265mgEpwFc2bwkdZcXOUzR4vEU8bPN8AMRpD5GZI48aOxUJrZ
         +eRv5x+Fho8OAP5s+kd26ANT0U+4Gqty6GuXd+asg1C8eA+/O5Gb9e0GORD5lcEhqIEl
         S8kw==
X-Gm-Message-State: AOAM53317Cd+bhQMdipYYZ/L741WqQ4VnhZTN1mS+C6UI4rTassL6Xlx
        x6Q/UOzEKwF/ygOU3exYIYz52kXXUw2QRY0ua2Bff++b
X-Google-Smtp-Source: ABdhPJw9ktxhc/1RZj737exrcmY+mHB5qZySRAFf71C7jzCHmy/LB6b4RXJZklst7SCbwU69mPZDD2cVIqjpynaIjQI=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr1197730ote.107.1590649490231;
 Thu, 28 May 2020 00:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <202005280819.lJ4qjCcP%lkp@intel.com>
In-Reply-To: <202005280819.lJ4qjCcP%lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 May 2020 09:04:38 +0200
Message-ID: <CAMuHMdUsD=xGa97tHmHZhohHiEqn5eD0QaOEwGNW7DGibkhB+g@mail.gmail.com>
Subject: Re: [rcu:dev.2020.05.26a 56/72] refperf.c:undefined reference to `__umoddi3'
To:     kbuild test robot <lkp@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 5:26 AM kbuild test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.26a
> head:   63fdce1252f16032c9e1eb7244bb674ba4f84855
> commit: bd5b16d6c88da451a46d068a25fafad8e83d14a6 [56/72] refperf: Allow decimal nanoseconds
> config: m68k-allyesconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout bd5b16d6c88da451a46d068a25fafad8e83d14a6
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> m68k-linux-ld: kernel/rcu/refperf.o: in function `main_func':
> >> refperf.c:(.text+0x762): undefined reference to `__umoddi3'
> >> m68k-linux-ld: refperf.c:(.text+0x8f2): undefined reference to `__udivdi3'
> m68k-linux-ld: refperf.c:(.text+0x97c): undefined reference to `__udivdi3'

| --- a/kernel/rcu/refperf.c
| +++ b/kernel/rcu/refperf.c
| @@ -375,7 +375,7 @@ static int main_func(void *arg)
|                 if (torture_must_stop())
|                         goto end;
|
| -               reader_tasks[exp].result_avg =
process_durations(exp) / ((exp + 1) * loops);
| +               reader_tasks[exp].result_avg = 1000 *
process_durations(exp) / ((exp + 1) * loops);

div64_ul() for 64-by-unsigned-long division

|         }
|
|         // Print the average of all experiments
| @@ -386,7 +386,7 @@ static int main_func(void *arg)
|         strcat(buf, "Threads\tTime(ns)\n");
|
|         for (exp = 0; exp < nreaders; exp++) {
| -               sprintf(buf1, "%d\t%llu\n", exp + 1,
reader_tasks[exp].result_avg);
| +               sprintf(buf1, "%d\t%llu.%03d\n", exp + 1,
reader_tasks[exp].result_avg / 1000,
(int)(reader_tasks[exp].result_avg % 1000));

do_div() for 64-by-32 division/modulo

|                 strcat(buf, buf1);
|         }


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
