Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A6C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBF420663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCRKTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:19:14 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCRKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:19:11 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MMGVE-1iyUZc2DLC-00JJln for <linux-kernel@vger.kernel.org>; Wed, 18 Mar
 2020 11:19:10 +0100
Received: by mail-qv1-f44.google.com with SMTP id z13so6393581qvw.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:19:10 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1yNay6j/PxkstgmXa5ejMcMzZ5hdsCRTmBit01Qd2ScNC9nYTs
        jhQ+C2R8dNKDIHiAtKywXslL6fl4VRztxwK9aWE=
X-Google-Smtp-Source: ADFU+vtuQuYp6iTjljzJz66bWfoHPbGkarNkqvjP4G4fPNAhxKACZ2qYupUXWqRWV+mHx0qdrwoL46bNg5mdhQxv53g=
X-Received: by 2002:a0c:b203:: with SMTP id x3mr3340934qvd.197.1584526749469;
 Wed, 18 Mar 2020 03:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200317083043.226593-1-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 11:18:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
Message-ID: <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
Subject: Re: clone3: allow creation of time namespace with offset
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9bf/+TYZkAaEp+9Cc/8X/2wDjONwsJhDkpThfDZE4LKluDMbwlT
 SMx0e9Sq2uQeHw1CQqjyKlANwmjLMgJXAJ7FwlO3XsKsL9e3UPvJxB3JMdv6DcrotXzAXSe
 p0DgQWnsL7zkxa576BcuC5a3LDygWgEJOAXyNJbxepcwYsbt1jXQr6Rt1KT8omgW7Ad6bqO
 49sE23xQxelUTnrm8AHdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PNcvG8R74hg=:nQq4PCjgKKSJP1B6Gg8NFB
 HNX+IEFH8Fncaymyd3nCR/qnfmtIgYE/qAXEq1VYYZw2IIY9pezyg/s0F36OXwYOhdk38oLOA
 tLneV/tv0HPTbKtx2Q3PQpe3pad5oVW3cF3vkHUEN+MqPNgiWBaNTegF8jCCoJ8LsVDz/F729
 mt4x4pcHLkPFHsgDA2VD82dcabJt2ojMxkmAVjZ2bid8iRqC5TLx0AKwqm2MoDm2SUIZAv54a
 7lprRzeyXfdaBM2YGNRgaIuNLMptRvJU5KwFlYF0AgMEXisqH0XirPdvUSjK9u+e/uORgmeSj
 08V1hVvOyKb/7sTmmZV6AQxCJRXR7Mj0nhu+ZeEZkOMj8NK9wkMPcPuTTLPecyoKcJsftFYuA
 WA2rxQcOWNfsgw+a9bpHD1LLDUA2LZBVxSRi98orZSYzwFcS95ypAKr9GGfhAte8UZviIKqzu
 Gbu7UWbalUlyhQXRS1+TQg3TC8bXA/2QBZXzgaQjQrs49aAfUlgR00xwa+uzORQoPzWntBqQb
 ditnGSxuEvbvoLv4lyOim97cH5cqM/XAzUFjhnfNnx3M2zZzig+Af+DmNPTHAJ+hPU7Wd21or
 1l1IUG1qnhkgECr3yG5QObuQUjrskh3EZHaTwlcmftb1jwxCoKIcuqEK8nAp130fp8933iyOk
 lIgzdJVwtpmYNfotDkfJebTZvKFgb5QkkZfcFSkQ7AMju+DMt11QPLcEw9/YUm4Dl0LvTOyTF
 RrdSY9yzhRWM87eOaPQ5IQWteDhf06QTriOh5KXyiTBp4XJlB4JB9M8gZgSDmGBiGb4QvnaCO
 6s41bLxwXWi4/WzkwU9wv7Mthz9AwslyzQPDNq9+8/kkDvnWbM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 9:32 AM Adrian Reber <areber@redhat.com> wrote:
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

Wouldn't it be sufficient to have the two nanosecond values, rather
than both seconds and nanoseconds? With 64-bit nanoseconds
you can represent several hundred years, and these would
always start at zero during boot.

Regardless of this, I think you need a signed offset, not unsigned.

          Arnd
