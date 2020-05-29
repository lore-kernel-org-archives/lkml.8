Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4492075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG4rFKoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE2M00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgE2M00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:26:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9FFC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:26:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d7so1878976eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Oq58YQ7K3U+VFAHOwMAEPCB3pfR9X0Yod8nFGMe+Pdw=;
        b=UG4rFKoAgWmq9WpIszGNHsVYP2LhOV2zl4bDkuhefY28GIhZFNwN0NEn3boutHt3ho
         s1iTdaqixhlnAtK5P2gaisektUDlV4FIfbvR3T7dawMsw70DlwycAtadJ1pjfesWgow0
         O2GHys3hiaiDugZGhP2tVTo9dlQv4O8/khFjtR2p3tFe86B5YoUtPA8VjVzjf9uGDIJq
         rYlgdkzyoG24fA/mY0fMPEQzrk6Izt5dZAr9H/T+h/RM7s7tBRSWk6hCxhzaN5qmzM1K
         T+GlOadAe+lXl3f9xKrG1aeBoVQfmdSAeUkynvvtoc7Z61KBwZyB8O5XUYW4q9EqKWzB
         f0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Oq58YQ7K3U+VFAHOwMAEPCB3pfR9X0Yod8nFGMe+Pdw=;
        b=iB7UhZd6GivoAtBXxj9fsIAEEN0jkGoBlzbfp+Ek1F5jkBzhTo51B/1OukNIUmbhze
         dMZIIFs38/Qz+mSJkvKp2J8onUJAcE2wRedvGkzSIsIqHHMIPcLzKTL3K8h267yJHXao
         4QLzuURsmvSWU4hOGaCVi5jwl1UvLDpNhc6jzldSdvgMsKVz4DV6sU9Y9ncSfSWlA8wa
         wbxaEMJPv5/oTKb1FHydn+Kp4XLJymEFOGQboLExVrtq2chxzfEXkP2pBrCojQhY0NvC
         CbFi+COIkp/BtGjZIk8uaCXn8rPBNncDJ1K8TuwebJooC9A2HqWsulhCephv5YOzTNaU
         jPhg==
X-Gm-Message-State: AOAM5310VjCNEsVbP/oUXCLSXJgN3/BzXbHh6rEU7NCoveBtDFgGknYF
        PbmULSoTVcSHk2dTtbOJR8M5mfHQ4I8usFbaZ1I=
X-Google-Smtp-Source: ABdhPJzuoYUrQpi7x7Mt9SZcOh97+gFIvj+uLrbZT5cl1meeU655If9UAJ7U0cAQRh9XpMEiHaNsoJpAQPxzL7Pig7o=
X-Received: by 2002:a17:906:51b:: with SMTP id j27mr7018425eja.246.1590755184371;
 Fri, 29 May 2020 05:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200317083043.226593-1-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 29 May 2020 14:26:13 +0200
Message-ID: <CAKgNAkip8nuFHCHEL2NUZXo91+8Q4w1zXKz4aFjj=TwXMuBxcA@mail.gmail.com>
Subject: Re: clone3: allow creation of time namespace with offset
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

If there was a revision to this patch, I missed it. Is there still a
plan to bring CLONE_NEWTIME to clone3()?

Thanks,

Michael

On Tue, 17 Mar 2020 at 09:32, Adrian Reber <areber@redhat.com> wrote:
>
> This is an attempt to add time namespace support to clone3(). I am not
> really sure which way clone3() should handle time namespaces. The time
> namespace through /proc cannot be used with clone3() because the offsets
> for the time namespace need to be written before a process has been
> created in that time namespace. This means it is necessary to somehow
> tell clone3() the offsets for the clocks.
>
> The time namespace offers the possibility to set offsets for
> CLOCK_MONOTONIC and CLOCK_BOOTTIME. My first approach was to extend
> 'struct clone_args` with '__aligned_u64 monotonic_offset' and
> '__aligned_u64 boottime_offset'. The problem with this approach was that
> it was not possible to set nanoseconds for the clocks in the time
> namespace.
>
> One of the motivations for clone3() with CLONE_NEWTIME was to enable
> CRIU to restore a process in a time namespace with the corresponding
> offsets. And although the nanosecond value can probably never be
> restored to the same value it had during checkpointing, because the
> clock keeps on running between CRIU pausing all processes and CRIU
> actually reading the value of the clocks, the nanosecond value is still
> necessary for CRIU to not restore a process where the clock jumps back
> due to CRIU restoring it with a nanonsecond value that is too small.
>
> Requiring nanoseconds as well as seconds for two clocks during clone3()
> means that it would require 4 additional members to 'struct clone_args':
>
>         __aligned_u64 tls;
>         __aligned_u64 set_tid;
>         __aligned_u64 set_tid_size;
> +       __aligned_u64 boottime_offset_seconds;
> +       __aligned_u64 boottime_offset_nanoseconds;
> +       __aligned_u64 monotonic_offset_seconds;
> +       __aligned_u64 monotonic_offset_nanoseconds;
>  };
>
> To avoid four additional members to 'struct clone_args' this patchset
> uses another approach:
>
>         __aligned_u64 tls;
>         __aligned_u64 set_tid;
>         __aligned_u64 set_tid_size;
> +       __aligned_u64 timens_offset;
> +       __aligned_u64 timens_offset_size;
>  };
>
> timens_offset is a pointer to an array just as previously done with
> set_tid and timens_offset_size is the size of the array.
>
> The timens_offset array is expected to contain a struct like this:
>
> struct set_timens_offset {
>        int clockid;
>        struct timespec val;
> };
>
> This way it is possible to pass the information of multiple clocks with
> seconds and nanonseconds to clone3().
>
> To me this seems the better approach, but I am not totally convinced
> that it is the right thing. If there are other ideas how to pass two
> clock offsets with seconds and nanonseconds to clone3() I would be happy
> to hear other ideas.
>
>                 Adrian
>
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
