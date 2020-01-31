Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4838C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E772206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAaQkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:40:40 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:50769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgAaQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:40:39 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mw9oq-1jnL3A47W8-00s4Pb; Fri, 31 Jan 2020 17:40:37 +0100
Received: by mail-qk1-f177.google.com with SMTP id q15so7120854qke.9;
        Fri, 31 Jan 2020 08:40:36 -0800 (PST)
X-Gm-Message-State: APjAAAWgKjb21gIzs8vuRVFSUf6VWr2sV7yWIVVaAkMZkIA23qdo6WnT
        RFgmnjs7xUrvXgMKo2Qb2Fe4DyK1aZqt6/q68Sk=
X-Google-Smtp-Source: APXvYqyT9YBAi/mdhIxEPIRzlxWQrbWCq6Vcu0q5xXx1/TnrmK3BdTbK/eqLHNRbpZOgku8jc0z7LFT+Zf0XU4cbmCk=
X-Received: by 2002:a37:84a:: with SMTP id 71mr11360557qki.138.1580488835744;
 Fri, 31 Jan 2020 08:40:35 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqy3LNu=DW2Mn8G6E-Ewrg2Q4gDXbxFqJXyfcDom4YW_oQ@mail.gmail.com>
In-Reply-To: <CADxRZqy3LNu=DW2Mn8G6E-Ewrg2Q4gDXbxFqJXyfcDom4YW_oQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Jan 2020 17:40:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0eqbczcNJhNf9hXPBhUoscZD51d9PSs=vwH564u=7XSQ@mail.gmail.com>
Message-ID: <CAK8P3a0eqbczcNJhNf9hXPBhUoscZD51d9PSs=vwH564u=7XSQ@mail.gmail.com>
Subject: Re: [sparc64] stall on CPU with current git master
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a0657b059d723bc8"
X-Provags-ID: V03:K1:NnJ41ZWdEdILHdMHeyjYMw3ZCEleTuUlfce45+581HWCDhBKX7+
 ac+Rrhz4kxZowJ5fcyBXiF9pK9b9qaBz26HsecPpttSYapIBUDe9486jzxXZ1O53WkdNyqH
 qph8pqoqZlBO1UY1+4c4aWoSYg+AG2BIg7Rm7WWYyfpaPYduAEBjNHT1LDHsjAa5lqOYhZr
 aRYUtueQ5c+2pee2fs/rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9RHtMX888AI=:Un0usu1jBh78Q4mdEoSjJZ
 eGwOgP1u3zf/B+ID4YVn/sadOXFhKvTqWPUVDJLAbgD1MgU1IeyFTcTz2j8Kxnx74fVk/4RzO
 4FQeWgigcQGks5n9OqLZX6oElJSeQuR2Cbe7XHL4h59LfcdpqGR+gtggOK8ULSfUTWKO2NrCY
 ACmKmP5D4WlJVpqh8Drn/24Rgcdrtf5RfvgFHYP1EQztxVOSzIKvN78cz0fDJbidVwbxig+Jb
 dEBl9qWrDDvippTXd9EjGV/36Uy9W1qvXfB9EASG+eoCVHxgi5+y5nM8EnEUVqO9ktnYsLKsu
 MVcW7E91zeXDJwUnmgah7IO4rMD3WGcSBsywrzCKgaYX6XACgIxMrUI+rAikbJ7hE4Mzw5mw6
 3/6X//mYNHrbhOcE+pPpJ+bOw3dQnKGlWsOwlAnmftLZ2Vzz9WfNm6APyo0h9r5BjX2ay/fla
 dvwmhwp5S6gdizwQO3IRhManEXGOh/i2435g1zlVNIQ/2uDqgb3RvIYa8Os7uwV1P329hPVOo
 oZxtR6Go2ypWKApYmEpDI4nZ8VXT3oXuMezg/g4qWwKI6v7CuZ+Hy5O9TqjDrDYJuoXO3qbdO
 yR85+43RjsGQ/6rBki8h8x1j6oow3h9QOkz/CSa6mUedPE6HrzA38fTC/soBbkMWoa4r4JWCA
 /Xy6azv9qK6hbRClgJQDiF1b7R1d0Q+pxzpX3EsjSyhGylIJzQEpa6NNbtir0IrSMwBFx0ZWA
 Djzc/OhsrAJZDAWUKPliFElK1ZFIDzt3dol8YrvZ/+rC/ca+bNI4FWeEuopSQeKMo8Dtl88PL
 eDWwy6LeIoAohrpQGgBl1iTMxuXsazlMvDUQ0eSnQDBE7cdGRI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a0657b059d723bc8
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 31, 2020 at 4:07 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> Hello!
>
> Current git master branch (at the time of writing
> 5.5.0-07763-gccaaaf6fe5a5 ) started to hang on my sparc64 ldom.
> Bisected "stall on CPU" (which occasionally leads to machine hang) to
> this patch:
>
> $ git bisect bad
> 251ec1c159e4874fbede0c3c586e317e177c0c9b is the first bad commit
> commit 251ec1c159e4874fbede0c3c586e317e177c0c9b
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Dec 11 21:07:23 2019 +0100
>
>     y2038: sparc: remove use of struct timex
>
>     'struct timex' is one of the last users of 'struct timeval' and is
>     only referenced in one place in the kernel any more, to convert the
>     user space timex into the kernel-internal version on sparc64, with a
>     different tv_usec member type.
>
>     As a preparation for hiding the time_t definition and everything
>     using that in the kernel, change the implementation once more
>     to only convert the timeval member, and then enclose the
>     struct definition in an #ifdef.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>  arch/sparc/kernel/sys_sparc_64.c | 33 +++++++++++++++++----------------
>  include/uapi/linux/timex.h       |  2 ++
>  2 files changed, 19 insertions(+), 16 deletions(-)
>
> $ git desc 251ec1c159e4874fbede0c3c586e317e177c0c9b
> v5.5-rc1-19-g251ec1c159e4
>
> kernel 5.5.0-rc1-00018-g4f9fbd893fe8 - works perfectly (i.e. does not
> hang or produce "stall on CPU" )
>
> current master with the patch reverted -
> 5.5.0-07763-gccaaaf6fe5a5-dirty - works perfectly
>
> current master 5.5.0-07763-gccaaaf6fe5a5 - stalls, hangs
>
>
> Can someone look what is wrong with it and/or probably revert it ?!
> Thanks.

Thanks for the report, I think I found the problem! Can you try this patch?

      Arnd

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 34917617f258..6b92fadb6ec7 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -551,7 +551,7 @@ SYSCALL_DEFINE2(getdomainname, char __user *,
name, int, len)
 SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
 {
        struct __kernel_timex txc;
-       struct __kernel_old_timeval *tv = (void *)&txc_p->time;
+       struct __kernel_old_timeval *tv = (void *)&txc.time;
        int ret;

        /* Copy the user data space into the kernel copy
@@ -576,7 +576,7 @@ SYSCALL_DEFINE2(sparc_clock_adjtime, const
clockid_t, which_clock,
                struct __kernel_timex __user *, txc_p)
 {
        struct __kernel_timex txc;
-       struct __kernel_old_timeval *tv = (void *)&txc_p->time;
+       struct __kernel_old_timeval *tv = (void *)&txc.time;
        int ret;

        if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {

--000000000000a0657b059d723bc8
Content-Type: text/x-patch; charset="US-ASCII"; name="sparc64-timex-fix.patch"
Content-Disposition: attachment; filename="sparc64-timex-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k62e6sd80>
X-Attachment-Id: f_k62e6sd80

ZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMva2VybmVsL3N5c19zcGFyY182NC5jIGIvYXJjaC9zcGFy
Yy9rZXJuZWwvc3lzX3NwYXJjXzY0LmMKaW5kZXggMzQ5MTc2MTdmMjU4Li42YjkyZmFkYjZlYzcg
MTAwNjQ0Ci0tLSBhL2FyY2gvc3BhcmMva2VybmVsL3N5c19zcGFyY182NC5jCisrKyBiL2FyY2gv
c3BhcmMva2VybmVsL3N5c19zcGFyY182NC5jCkBAIC01NTEsNyArNTUxLDcgQEAgU1lTQ0FMTF9E
RUZJTkUyKGdldGRvbWFpbm5hbWUsIGNoYXIgX191c2VyICosIG5hbWUsIGludCwgbGVuKQogU1lT
Q0FMTF9ERUZJTkUxKHNwYXJjX2FkanRpbWV4LCBzdHJ1Y3QgX19rZXJuZWxfdGltZXggX191c2Vy
ICosIHR4Y19wKQogewogCXN0cnVjdCBfX2tlcm5lbF90aW1leCB0eGM7Ci0Jc3RydWN0IF9fa2Vy
bmVsX29sZF90aW1ldmFsICp0diA9ICh2b2lkICopJnR4Y19wLT50aW1lOworCXN0cnVjdCBfX2tl
cm5lbF9vbGRfdGltZXZhbCAqdHYgPSAodm9pZCAqKSZ0eGMudGltZTsKIAlpbnQgcmV0OwogCiAJ
LyogQ29weSB0aGUgdXNlciBkYXRhIHNwYWNlIGludG8gdGhlIGtlcm5lbCBjb3B5CkBAIC01NzYs
NyArNTc2LDcgQEAgU1lTQ0FMTF9ERUZJTkUyKHNwYXJjX2Nsb2NrX2FkanRpbWUsIGNvbnN0IGNs
b2NraWRfdCwgd2hpY2hfY2xvY2ssCiAJCXN0cnVjdCBfX2tlcm5lbF90aW1leCBfX3VzZXIgKiwg
dHhjX3ApCiB7CiAJc3RydWN0IF9fa2VybmVsX3RpbWV4IHR4YzsKLQlzdHJ1Y3QgX19rZXJuZWxf
b2xkX3RpbWV2YWwgKnR2ID0gKHZvaWQgKikmdHhjX3AtPnRpbWU7CisJc3RydWN0IF9fa2VybmVs
X29sZF90aW1ldmFsICp0diA9ICh2b2lkICopJnR4Yy50aW1lOwogCWludCByZXQ7CiAKIAlpZiAo
IUlTX0VOQUJMRUQoQ09ORklHX1BPU0lYX1RJTUVSUykpIHsK
--000000000000a0657b059d723bc8--
