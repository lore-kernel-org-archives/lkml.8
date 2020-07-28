Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1485C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986C320759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgG1JKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:10:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgG1JKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:10:38 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mbj7g-1kVYFH1uRi-00dDxa for <linux-kernel@vger.kernel.org>; Tue, 28 Jul
 2020 11:10:37 +0200
Received: by mail-qk1-f182.google.com with SMTP id j187so17927360qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:10:37 -0700 (PDT)
X-Gm-Message-State: AOAM532QIUFAHTGiVuSvKnX3LhU6nx9e3o5NcAwWgxbo3HiPrxhsalGV
        A6W7zoieg/O5zYuE+aosLjM2qMjaIlfqEat4Bxw=
X-Google-Smtp-Source: ABdhPJymJqjcicEht8LqkBiv6yaJ2bLpwcqSBjI1PTvMTBwIfF6ZBFdWPtHdmydi6Ur0O1f8BkNloKyDta5kP4hQsBM=
X-Received: by 2002:a37:385:: with SMTP id 127mr25310801qkd.3.1595927436336;
 Tue, 28 Jul 2020 02:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200726220557.102300-1-yepeilin.cs@gmail.com>
 <20200726222703.102701-1-yepeilin.cs@gmail.com> <CAK8P3a3NB2BVo9fH-Wcinrhhs-QJ=9dK59Ds83TvgLmEkRy3qA@mail.gmail.com>
 <20200727131608.GD1913@kadam> <20200727223357.GA329006@PWN>
In-Reply-To: <20200727223357.GA329006@PWN>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jul 2020 11:10:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1QZxPfLF3-jYzPGmHR_TOUfET+92x_L_K4Tkqf+v9bDA@mail.gmail.com>
Message-ID: <CAK8P3a1QZxPfLF3-jYzPGmHR_TOUfET+92x_L_K4Tkqf+v9bDA@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v3] media/v4l2-core: Fix
 kernel-infoleak in video_put_user()
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q3fT1idtTBmO7YatuFmYT9rv/IcfaRQT+rnlaCCHLp+Nm6pT4KX
 aaeS5KiB5CnfNKGuo3M2tyuBiKy0fzEAFbY+y//fPH3ZbHVxXuMmsPAzjTDjadfxW3a8sSc
 B7xuuW+AzHrOJLI0KUoDhChxEzRZM1QbvSVs94EjMUoTOnY6ymAAm0PxIZRAWoNREmgRUpW
 838E/TbPf1n42gLakehag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P/TFOYHB+HI=:XbBqJ+bfikp7nEBAATyyrY
 zP34tuMgYKxwKT9Ent4mJSJlU3G85REmYML9KzAWAeAtjLzULz6gc9AdhapsLIE+KGdWxc05F
 fJiYPwVVFypJbAuzOlJw8hLKW7B2Ac6CqMiaw+yN6/a+xQio7FvEmSaJwzyOFfp9CzDCKJVyT
 wu4vnZfBTmQtcOtMjWFHdV2+1GJvvd1HNrhle36j0wWIAYgmLHv+eUcQ8AfKvKbAI5j6OfKQl
 HGI98S95pV3z3K9Sb4U6LFAcMzbauno5LWROHg1lTiBKQUlyOLO54URhpnqAiFtdBIhrHB1um
 wRo/JbsTyCLyrcs1GFHF5yaR9OAsvcJ9bz4tfE34v/6HycAVGimacU/tgyc8BjG0GzTEHyBAn
 fsTaX6pkrJfxWiVq8hZtpauic7ClRT1z5gUhJpib5cKFozXWf9cuLICCI05IgP3oJU6CJ/0G7
 zI1Az8OXwCIYQb/Xya/cqDe90tehDU0AYK+2+Rw0VPGizqXvNK40det6tjxC6rUQzJx3aaTJ/
 LCbkb0ShxjocazPBvQ/oLDG3QO6a+szA+zHq19a9hDvuvWd8sPr+OL+bSrOLDcZSHk4I8Rcqe
 rHzjAOqeFGhYLxUsX2ik3d4yQFyJ7aav3jGVNuoGbBHealhZUDkn7tWXzEwKT+CYreheJpGxU
 oGn1RXR2khjWlDf6eOFScUqeRgVRR4a+Z882QtfMcEp7tTTmfWeyd9Zt6kK4m/wQ/J6jfeZVd
 xTwN+9jDIzLgDspYtZPtHbYehSH7S0pbwz/bCiEse/25HzVtgfisRCmeIChKa3haNMEedsy3c
 uAv8H3aG7JX7OAxaWtoWapJDRpZNd2ne7sLyzbCA3rZjfYaRolr4axs0xRcHb+gM1Ym80R9i+
 CNlQ2JdlwAuP/FDX+6k48K+m86y9kJpQszNZPTvdW8FI4uFFvm9RJSjtlF2bG1JAqdEnImuQj
 9jhYfknkFJKQEZLRO7w4u89I5cbPvh/dI0gN1V/Ep+CJDmQjiIp2W
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:34 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Mon, Jul 27, 2020 at 04:16:08PM +0300, Dan Carpenter wrote:
> > drivers/block/floppy.c:3132 raw_cmd_copyout() warn: check that 'cmd' doesn't leak information (struct has a hole after 'flags')
>
> (Removed some Cc: recipients from the list.)
>
> I'm not very sure, but I think this one is also a false positive.
>
> Here Smatch is complaining about a linked list called `my_raw_cmd`
> defined in raw_cmd_ioctl():
>
> drivers/block/floppy.c:3249:
>
>         ret = raw_cmd_copyin(cmd, param, &my_raw_cmd);
>
> In raw_cmd_copyin(), each element of the linked list is allocated by
> kmalloc() then copied from user:
>
> drivers/block/floppy.c:3180:
>
> loop:
>         ptr = kmalloc(sizeof(struct floppy_raw_cmd), GFP_KERNEL);
>               ^^^^^^^
>         if (!ptr)
>                 return -ENOMEM;
>         *rcmd = ptr;
>         ret = copy_from_user(ptr, param, sizeof(*ptr));
>               ^^^^^^^^^^^^^^
>
> I think copy_from_user() is filling in the paddings inside `struct
> floppy_raw_cmd`?

I am not completely sure about this one either. copy_from_user()
would indeed fill the pad bytes in the structure, but there is another
problem:

                struct floppy_raw_cmd cmd = *ptr;
                cmd.next = NULL;
                cmd.kernel_data = NULL;
                ret = copy_to_user(param, &cmd, sizeof(cmd));

IIRC the struct assignment is allowed to be done per member
and skip the padding, so the on-stack copy can then again
contain a data leak. The compiler is likely to turn a struct
assignment into a memcpy(), but as the code then goes on
to set two members individually, I suppose doing a per-member
copy would not be unreasonable behavior either and doing
a memcpy() instead of an assignment would be the safe
choice.

If someone has a clearer understanding of what the compiler
is actually allowed to do here, please let us know.

       Arnd
