Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79BC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B662072F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNjWqWiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgEIQ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgEIQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 12:28:51 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C0C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 09:28:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r2so4359755ilo.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q+G3n0BC6hJndjVqlDDRUwRFiTvwE59s/Dv1p0GcOKU=;
        b=cNjWqWivzOhFHzLnDSnGrNqHbuOmY40pyxLu5KvDXpmYi1Yo63eDrhCaMQsKYl8/y9
         8sdBVYDJuuguXIu8gQcII/1SGRVbEfUcPYSc0N6Q4OpAa2lseunrVGnivuYgC5B1w5BL
         MEzq6CtG+a1PI0HTLkwZCSRpTuRra2wlWaRKUcFmmwgpaqxY6uI2lBv9jy1Qklvzl0ie
         N0qVyUiylgcwpIqvcpSE18yYzFE2o4d91r56Nut/Z3H7GskROdJ31EkFb1WggUL7S/k3
         3i+dx65cc7RCgY6T5ZYTjtkzZCkXdEu2SLUuuNKJkDod6EUL6rj8iu/X5qfUrTDcI4ge
         jVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q+G3n0BC6hJndjVqlDDRUwRFiTvwE59s/Dv1p0GcOKU=;
        b=qz9UVKGJ5/EmNf+RctEonNvBk9/PG5xIVBd1zde4GFnb+sYvYTnp6YQFDHc9y2CBvt
         wW8cGPCwBwt1+iQtvfbdK2Q8FKSAqg5iIFqJ6BvROgpXAZerE49+dFC8uu0owCQFJwdb
         a+QtxW1p6Y3mG37kGqe0SrXSEmBzvSwP8s/e/02KBm1DCBQekaHzDO5unz3doIzNiH7q
         q2aMIMGrc35qS/1vC4JyRvHW6NZFz25JK6OlhJe1FEUNwwhYja+e4PgVvbRRo7jd8thA
         Od9e0XiE/NoLVhP+/HsTIT9yQayLi1ZqLlDfD/Vad0qDKWWZRL9/U9wFvV38Qf6Y4Wmx
         FhpA==
X-Gm-Message-State: AGi0PuZywMXtxqnAcCmRDE26sGnjfmtoQjcaGlVCf+HbJwpBru9y+5pT
        PstxqR5z6fRTkUM3kbC6mtddwdmbSkTd+Y4Y558=
X-Google-Smtp-Source: APiQypLbie3SZ0jbR++PomgLTh6NayJLBGJx2NpUasMR4UkTmHMfU0UB8UKVJ2mcC0XbthoAMMeEWf8tS0OF6Zc24z8=
X-Received: by 2002:a92:507:: with SMTP id q7mr3078878ile.150.1589041729849;
 Sat, 09 May 2020 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com> <CAJiuCcfrMhu5Mi7YZTttw2k+hGui0GFAmOhPh_9fv4Te27M0+A@mail.gmail.com>
 <13285d84-5a5e-c695-2a8b-7ca50c976b90@arm.com>
In-Reply-To: <13285d84-5a5e-c695-2a8b-7ca50c976b90@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 9 May 2020 18:28:38 +0200
Message-ID: <CAJiuCcduOw1jZ60j+i8GnAda6HACUeCD-DyqoY1aYisSOcuiXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, 7 May 2020 at 16:30, Steven Price <steven.price@arm.com> wrote:
>
> On 02/05/2020 23:07, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Steven,
> >
> > On Tue, 14 Apr 2020 at 15:10, Steven Price <steven.price@arm.com> wrote=
:
> >>
> >> Hi Cl=C3=A9ment,
> >>
> >> On 13/04/2020 18:28, Cl=C3=A9ment P=C3=A9ron wrote:
> >>> Hi Steven,
> >>>
> >
<snip>
>
> Since you've got a reproduction - can you get a backtrace where the
> regulator is getting disabled?

Regulator is disabled from regulator_late_cleanup()

[   33.757650] vdd-gpu: disabling
[   33.760718] CPU: 2 PID: 31 Comm: kworker/2:1 Not tainted
5.7.0-rc2-next-20200424 #8
[   33.768362] Hardware name: Beelink GS1 (DT)
[   33.772553] Workqueue: events regulator_init_complete_work_function
[   33.778813] Call trace:
[   33.781261]  dump_backtrace+0x0/0x1a0
[   33.784922]  show_stack+0x18/0x30
[   33.788238]  dump_stack+0xc0/0x114
[   33.791638]  regulator_late_cleanup+0x164/0x1f0
[   33.796165]  class_for_each_device+0x64/0xe0
[   33.800431]  regulator_init_complete_work_function+0x4c/0x60
[   33.806084]  process_one_work+0x19c/0x330
[   33.810090]  worker_thread+0x4c/0x430
[   33.813748]  kthread+0x138/0x160
[   33.816973]  ret_from_fork+0x10/0x24

the use_count is at 0...

I have check and the regulator_get is called and regulator_put is
never called for vdd-gpu.
Not sure what is happening here...


>
> >   - The Cooling map is not probe correctly :
> > [    2.545756] panfrost 1800000.gpu: [drm:panfrost_devfreq_init
> > [panfrost]] Failed to register cooling device
> > Introduce in this commit :
> > https://github.com/clementperon/linux/commit/0252c38fd55ad78366ac4b1714=
e285c88db34557
> >
> > Do you have an hint about what I'm missing ?
>
> Sorry, my knowledge of the cooling framework is very limited. What
> you've got looks plausible, but I'm afraid I can't really help beyond
> that! As before - can you try adding some printk()s in e.g.
> of_devfreq_cooling_register_power() and find out where it is bailing out?

Dumb issue, I was missing the CONFIG_DEVFREQ_THERMAL -_-, I will make
a patch to enable it in arm64 defconfig.

Regards,
Clement

>
> Steve
