Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7ADC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B745020786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgECNCAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHRQyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgHRQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E4C061389;
        Tue, 18 Aug 2020 09:54:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so22177558ljo.12;
        Tue, 18 Aug 2020 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lPIWo2NeK+L4V9brwkJLRapLBnNyx/xaLX/K9uVYdxM=;
        b=ZgECNCAkk3B8lk/fAw6iMFOE5H2BR46xjKJiQMeVnkHyBmCjVTOxb0EcXLXkNeUdug
         8cTDLECRzSlrI8fTgbzE3Ci9uQTraDnEyYW77n+T91YPO5SeIrVu4JEo7BxSU/plqPHO
         9Dr/ozz2Yn4F8OOLGx0mb42pn3+Gs0XrS9y+ohg3837XcZjIQLBXZZPjUVb2+wipujEW
         MJ+mcOOZXj6yktTuddx7IJJN5xxDRQ7x1cSBsLyyO2IM+iqxlKlNLn8G7oFqeaTDVU/e
         gc2mZvDZ6SDKui20rZ0SWN5CLw7ADal3/+IgF2MfUz97KEFl/3m3chSew8pb+n2+Vh70
         zHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lPIWo2NeK+L4V9brwkJLRapLBnNyx/xaLX/K9uVYdxM=;
        b=Do4SW2tPw8xM2Udc7yjvav7dgG03pShjC5PlHE42qS5jRBcFlPaFDm8SxA1nL5b0au
         /lm+B3W6PDCvBlrfSdWGwF+Q0ilIa6jtfcarhJodfXXmYEAgM0fX9P8ckjy8F9nkjITO
         TCLJPxovTpisTN4EJpZKsq2PIbBKUWJ9AA4K1QfuUoEJqjeS6goKunZlpPqxO3jcvh2L
         38InVOleEc+WlLDjUM9DTTAEoOmadU63tXZi8Kyb/DEpZo1M+vrMxiSa5LX0lozotUcE
         Pec5FtiUmhAtuh57gcLYFuJvJ+7pZr7cggUDAn1+CzbXl4uQTX0bi3KQN546cvixgz2x
         d99g==
X-Gm-Message-State: AOAM532MN5zljtLHFA1eUAutSRnLnn7kBfJS+XPmFwtwccRtsdmCjQ5B
        yiLt6RJdyTNk5pwkWaN0UFy5YzRK+L07vAzPjeY=
X-Google-Smtp-Source: ABdhPJzJsMu7vODfNWLgrFRano7BCz3aoqmr5CNj+VSyh2XUgMbbEBRDJVqa4dnJqdf1o+W6b5aDolX31nyVTFil2OQ=
X-Received: by 2002:a2e:1418:: with SMTP id u24mr9850592ljd.120.1597769665005;
 Tue, 18 Aug 2020 09:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
In-Reply-To: <20200818143633.GA628293@kroah.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 18 Aug 2020 22:24:13 +0530
Message-ID: <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
Subject: Re: Scheduler benchmarks
To:     Greg KH <greg@kroah.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > Hi all,
> >
> > I=E2=80=99ve two identical Linux systems with only kernel differences.
>
> What are the differences in the kernels?
>
> > While doing kernel profiling with perf, I got the below mentioned
> > metrics for Scheduler benchmarks.
> >
> > 1st system (older kernel version compared to the other system) benchmar=
k result:
> >
> > $ perf bench sched messaging -g 64
> > # Running 'sched/messaging' benchmark:
> > # 20 sender and receiver processes per group
> > # 64 groups =3D=3D 2560 processes run
> >
> >      Total time: 2.936 [sec]
> >
> >
> > 2nd system benchmark result:
> >
> > $ perf bench sched messaging -g 64
> > # Running 'sched/messaging' benchmark:
> > # 20 sender and receiver processes per group
> > # 64 groups =3D=3D 2560 processes run
> >
> >      Total time: 10.074 [sec]
> >
> >
> > So as per scheduler benchmark results, clearly a huge difference
> > between two systems.
> > Can anyone suggest to me how to dive deeper to know the root cause for
> > it.
>
> Look a the differences between your different kernels, that would be a
> great start :)
I created the difference between two kernel config files and then
tried to spot the CONFIG*SCHED* differences.
Interestingly I see the difference in I/O scheduler config, 1st system
is set to =E2=80=9Cdeadline=E2=80=9D and other one is set to =E2=80=9Ccfq=
=E2=80=9D. So I made it equal
by echoing to =E2=80=9C/sys/block/<disk device>/queue/scheduler" but still =
no
change in scheduler benchmark metrics.

Is it the correct way to find the differences between kernels? If so,
what other important CONFIG_* variables need to consider?


$ cat config.patch | grep -i sched

 CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
 CONFIG_CGROUP_SCHED=3Dy
 CONFIG_FAIR_GROUP_SCHED=3Dy
 # CONFIG_RT_GROUP_SCHED is not set
 # IO Schedulers
@@ -369,10 +434,14 @@ CONFIG_IOSCHED_NOOP=3Dy
 CONFIG_IOSCHED_DEADLINE=3Dy
 CONFIG_IOSCHED_CFQ=3Dy
 CONFIG_CFQ_GROUP_IOSCHED=3Dy
-CONFIG_DEFAULT_IOSCHED=3D"deadline"
+CONFIG_DEFAULT_IOSCHED=3D"cfq"
+CONFIG_MQ_IOSCHED_DEADLINE=3Dm
+CONFIG_MQ_IOSCHED_KYBER=3Dm
+CONFIG_IOSCHED_BFQ=3Dm
+CONFIG_BFQ_GROUP_IOSCHED=3Dy
 CONFIG_SCHED_SMT=3Dy
 CONFIG_SCHED_MC=3Dy
+CONFIG_SCHED_MC_PRIO=3Dy
+# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy


>
> good luck!
>
> greg k-h



--=20
Thanks,
Sekhar
