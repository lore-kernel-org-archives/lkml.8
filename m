Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E8C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA732072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="c2coSOf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:27:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:27:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id g18so4979304plq.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=udQjmbSJ36O+HqNOrsjvm6cKrTCrvSR90xSsUKaBnDA=;
        b=c2coSOf4u3BCL7mYGslAZY4kchmMvpkKmuzikRMmKnI6H4tJ1p+Hto/enirvjzra92
         B9FxZsTe5NfenaEsNNPp53xCL+uaAEuA62JfP+tyA5gD9AhIYkYLZ5LLneFxKhJz+iC6
         DGb0/e9cOjNoZB4CXtKpRKZxB22yDSbHFa5n/3f2Qw0Dlfhkj7m1pfltd4BuiBg7C8N2
         D6gLkAaccRzn92UOFBuSjv4yU1S1aszmD6aJqdJ3VWrHv8/7OKz+NRiB/F+Ed2atVPB9
         Ez7Cw9LjB4bgWNKgMgNvQOPFcmmZdPwsuo/wziTgn/akBWi0YEuOiGtzzugdtMSLf6xQ
         1/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=udQjmbSJ36O+HqNOrsjvm6cKrTCrvSR90xSsUKaBnDA=;
        b=IRIV3aICx2/PbYGWnT3GsX6mgZznz3WnbEwdkTtXV+LU2PTmIqZN5QEkur+UqRsAcQ
         gPgfUO3GQYRPCI5j7sobj57TgRscikRQlUy42s7h1sK+elArtm831hxEAmtszswSGFwz
         AywZVV1KMUlpfpT1gN2YvQKLQeqoA/oPhRXxlnjazpN1uKjzB/oYADp4UHrG55y15ukB
         2EltuwA4l41XZYeBNxlozwC9SZ9KE0/3ajpuzdmM0DFEt8zn/Up675HwVQXbwlG5oyK1
         yknwhASw+VJyq6KbLiD4T266uNlFz4iZixIF9672XfWhG6MUaVwszAM7r/WAf0h9XKKC
         2xoQ==
X-Gm-Message-State: ANhLgQ2p1SJQQSG4ZZEsIDobo7++LkZTDFqRkMJ1qEHCAhtzJcNKtDYm
        /MpQ02pdE/LEht64YADB7VW7yg==
X-Google-Smtp-Source: ADFU+vuZEk231KY5Z9GfyotP/hKepQG8x2LcuxY503yH+KeO/OX5Jng3EDgx/f4XDAJzM42KT25ssA==
X-Received: by 2002:a17:90b:3005:: with SMTP id hg5mr576836pjb.188.1584908820294;
        Sun, 22 Mar 2020 13:27:00 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:dcfc:542e:7597:19b6? ([2601:646:c200:1ef2:dcfc:542e:7597:19b6])
        by smtp.gmail.com with ESMTPSA id i2sm11234289pfr.151.2020.03.22.13.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 13:26:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] seccomp: Add a trace action that allows the syscall if ptracer absent
Date:   Sun, 22 Mar 2020 13:26:58 -0700
Message-Id: <94D9E55C-601F-4083-A01F-660DB5835F0B@amacapital.net>
References: <20200322062033.GA72532@juliacomputing.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, robert@ocallahan.org
In-Reply-To: <20200322062033.GA72532@juliacomputing.com>
To:     Keno Fischer <keno@juliacomputing.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2020, at 11:20 PM, Keno Fischer <keno@juliacomputing.com> wrote=
:
>=20
> =EF=BB=BF# Background
>=20
> One usecase for seccomp that has become more common is as a sort-of
> pre-filter for ptrace events. This is useful to reduce debugging
> overhead by avoiding traps to the ptracer for events that the
> ptracer is not interested in and is used extensively for this
> purpose in modern ptrace clients such as the rr debugger [1].

Hmm. My impression is that this patch takes an existing so-so trick and make=
s it a bit weirder and a bit less broken but still quite hackish.

I suggest a different solution: add something like PTRACE_BPF: it resumes th=
e target and passes each event through a BPF program.  The BPF program can d=
ecide whether to ignore the event or trap.  Or log it!

Sadly, unprivileged eBPF may still be stalled, so you may have to fudge it w=
ith classic BPF, which is doable but more awkward and less powerful.

>=20
> As a simpler, but illustrative example, consider perhaps an
> expression like `strace -e open`. An advanced strace implementation
> could set a seccomp filter that causes a SECCOMP_RET_TRACE option
> for open system calls only (or even only system calls involving a
> particular file descriptor).
>=20
> However, when used for this purpose, the persistent and inherited
> nature of the seccomp filter can present a problem (though
> perfectly sensible from the perspective of a security feature of
> course). Of course the ptracer could simply attach itself to the
> entire process tree, but this of course presents its own performance
> challenges negating the originall performance advantage (e.g.
> in the `strace` example above, strace may only want to trace its
> original child).
>=20
> The most desirable feature would probably be for the ptracer to have
> the capability to remove a seccomp filter from a child, but I
> understand that the design of seccomp as an immutable tree of filters
> makes this difficult, not to mention that such a feature is perhaps
> undesirable given seccomp's intention as a security feature (even
> if guarded behind a non-default flag). This instead implements an
> additional trace action, that I believe can achieve much the same
> effect while being significantly less invasive:
>=20
> # This patch
>=20
> The default behavior of the `SECCOMP_RET_TRACE` is to fail the system
> call with `ENOSYS` if no ptracer is attached to the process. This
> patch adds a similar option `SECCOMP_RET_TRACE_ALLOW`, that behaves
> identically to `SECCOMP_RET_TRACE` in all respects, except that it
> allows the system call to go forward unmodified in the case that no
> ptracer is attached (or that the ptracer does not have the seccomp
> event enabled).
>=20
> This remedies the situation discussed in the previous section by making
> it irrelevant whether or not the seccomp filter is installed in
> the children of the original initial task, as they will not see any
> difference in behavior from the presence of a properly-implemented
> seccomp filter as long as no ptracer is attached.
>=20
> I think another possible use of an interface like this would be ptracers
> that want to occaisionally attach to running processes for profiling
> or logging purposes, but otherwise do not want to disturb the
> functioning of the process.
>=20
> It is not entirely satisfying of course, as the new behavior will
> be re-activated by any new ptracer attaching to such a process,
> even if such a ptracer is unaware of the presence of the seccomp filter.
> Such a situation is probably fairly rare (esp. since the alternative
> is just to keep every child ptrace-attached, which would prevent
> other ptracers from attaching anyway), but it deserves pointing out
> nonetheless.
>=20
> # Alternatives considered
>=20
> As discussed above, I considered proposing some mechanism for the
> removal of seccomp filters after the fact, but rejected this approach
> because it seemed to invasive and counter to the design intent of the
> API.
>=20
> Another idea I considered was allowing the BPF filter to access some
> ptracer-writable metadata area that could be used to modify the behavior
> of the filter after the fact (if enabled by a flag). I still think
> this would potentially be a viable solution. However, I worried that
> this would get too far into the realm of allowing eBPF seccomp filters,
> which as far as I understand was previously rejected (though I did
> not completely research the history of this suggestion). A solution
> like this would of course address the shortcoming I mentioned above
> by allowing the ptracer to render the filter truly inert.
>=20
> Lastly I considered instead adding a field to the seccomp_data
> structure that would indicate whether or not the ptracer was available
> or not. However, that approached seemed a lot more likely to result
> in user confusion and incorrect filters than simply adding an additional
> action.
>=20
> [1] https://github.com/mozilla/rr
>=20
> Signed-Off-By: Keno Fischer <keno@juliacomputing.com>
>=20
> ---
> .../userspace-api/seccomp_filter.rst          |  5 ++++
> include/uapi/linux/seccomp.h                  |  1 +
> kernel/seccomp.c                              | 26 +++++++++++++------
> 3 files changed, 24 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentatio=
n/userspace-api/seccomp_filter.rst
> index bd9165241b6c..95098c20c3db 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -151,6 +151,11 @@ In precedence order, they are:
>    allow use of ptrace, even of other sandboxed processes, without
>    extreme care; ptracers can use this mechanism to escape.)
>=20
> +``SECCOMP_RET_TRACE_ALLOW``:
> +    Like ``SECCOMP_RET_TRACE``, but if no tracer is present (or the trace=
r is
> +    not listening to seccomp events), allow the syscall rather than retur=
ning
> +    ENOSYS.
> +
> ``SECCOMP_RET_LOG``:
>    Results in the system call being executed after it is logged. This
>    should be used by application developers to learn which syscalls their
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index be84d87f1f46..7d9997a98d06 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -39,6 +39,7 @@
> #define SECCOMP_RET_ERRNO     0x00050000U /* returns an errno */
> #define SECCOMP_RET_USER_NOTIF     0x7fc00000U /* notifies userspace */
> #define SECCOMP_RET_TRACE     0x7ff00000U /* pass to a tracer or disallow *=
/
> +#define SECCOMP_RET_TRACE_ALLOW     0x7ff30000U /* pass to a tracer or al=
low */
> #define SECCOMP_RET_LOG         0x7ffc0000U /* allow after logging */
> #define SECCOMP_RET_ALLOW     0x7fff0000U /* allow */
>=20
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b6ea3dcb57bf..af7d38666b6c 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -623,6 +623,7 @@ static void seccomp_send_sigsys(int syscall, int reaso=
n)
> #define SECCOMP_LOG_LOG            (1 << 5)
> #define SECCOMP_LOG_ALLOW        (1 << 6)
> #define SECCOMP_LOG_USER_NOTIF        (1 << 7)
> +#define SECCOMP_LOG_TRACE_ALLOW        (1 << 8)
>=20
> static u32 seccomp_actions_logged =3D SECCOMP_LOG_KILL_PROCESS |
>                    SECCOMP_LOG_KILL_THREAD  |
> @@ -630,6 +631,7 @@ static u32 seccomp_actions_logged =3D SECCOMP_LOG_KILL=
_PROCESS |
>                    SECCOMP_LOG_ERRNO |
>                    SECCOMP_LOG_USER_NOTIF |
>                    SECCOMP_LOG_TRACE |
> +                    SECCOMP_LOG_TRACE_ALLOW |
>                    SECCOMP_LOG_LOG;
>=20
> static inline void seccomp_log(unsigned long syscall, long signr, u32 acti=
on,
> @@ -646,6 +648,7 @@ static inline void seccomp_log(unsigned long syscall, l=
ong signr, u32 action,
>    case SECCOMP_RET_ERRNO:
>        log =3D requested && seccomp_actions_logged & SECCOMP_LOG_ERRNO;
>        break;
> +    case SECCOMP_RET_TRACE_ALLOW:
>    case SECCOMP_RET_TRACE:
>        log =3D requested && seccomp_actions_logged & SECCOMP_LOG_TRACE;
>        break;
> @@ -832,6 +835,7 @@ static int __seccomp_filter(int this_syscall, const st=
ruct seccomp_data *sd,
>        seccomp_send_sigsys(this_syscall, data);
>        goto skip;
>=20
> +    case SECCOMP_RET_TRACE_ALLOW:
>    case SECCOMP_RET_TRACE:
>        /* We've been put in this state by the ptracer already. */
>        if (recheck_after_trace)
> @@ -839,9 +843,12 @@ static int __seccomp_filter(int this_syscall, const s=
truct seccomp_data *sd,
>=20
>        /* ENOSYS these calls if there is no tracer attached. */
>        if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
> +            if (action =3D=3D SECCOMP_RET_TRACE_ALLOW)
> +                return 0;
> +
>            syscall_set_return_value(current,
> -                         task_pt_regs(current),
> -                         -ENOSYS, 0);
> +                        task_pt_regs(current),
> +                        -ENOSYS, 0);
>            goto skip;
>        }
>=20
> @@ -1374,6 +1381,7 @@ static long seccomp_get_action_avail(const char __us=
er *uaction)
>    case SECCOMP_RET_TRAP:
>    case SECCOMP_RET_ERRNO:
>    case SECCOMP_RET_USER_NOTIF:
> +    case SECCOMP_RET_TRACE_ALLOW:
>    case SECCOMP_RET_TRACE:
>    case SECCOMP_RET_LOG:
>    case SECCOMP_RET_ALLOW:
> @@ -1591,12 +1599,13 @@ long seccomp_get_metadata(struct task_struct *task=
,
> /* Human readable action names for friendly sysctl interaction */
> #define SECCOMP_RET_KILL_PROCESS_NAME    "kill_process"
> #define SECCOMP_RET_KILL_THREAD_NAME    "kill_thread"
> -#define SECCOMP_RET_TRAP_NAME        "trap"
> -#define SECCOMP_RET_ERRNO_NAME        "errno"
> -#define SECCOMP_RET_USER_NOTIF_NAME    "user_notif"
> -#define SECCOMP_RET_TRACE_NAME        "trace"
> -#define SECCOMP_RET_LOG_NAME        "log"
> -#define SECCOMP_RET_ALLOW_NAME        "allow"
> +#define SECCOMP_RET_TRAP_NAME            "trap"
> +#define SECCOMP_RET_ERRNO_NAME            "errno"
> +#define SECCOMP_RET_USER_NOTIF_NAME        "user_notif"
> +#define SECCOMP_RET_TRACE_NAME            "trace"
> +#define SECCOMP_RET_TRACE_ALLOW_NAME    "trace_allow"
> +#define SECCOMP_RET_LOG_NAME            "log"
> +#define SECCOMP_RET_ALLOW_NAME            "allow"
>=20
> static const char seccomp_actions_avail[] =3D
>                SECCOMP_RET_KILL_PROCESS_NAME    " "
> @@ -1620,6 +1629,7 @@ static const struct seccomp_log_name seccomp_log_nam=
es[] =3D {
>    { SECCOMP_LOG_ERRNO, SECCOMP_RET_ERRNO_NAME },
>    { SECCOMP_LOG_USER_NOTIF, SECCOMP_RET_USER_NOTIF_NAME },
>    { SECCOMP_LOG_TRACE, SECCOMP_RET_TRACE_NAME },
> +    { SECCOMP_LOG_TRACE_ALLOW, SECCOMP_RET_TRACE_ALLOW_NAME },
>    { SECCOMP_LOG_LOG, SECCOMP_RET_LOG_NAME },
>    { SECCOMP_LOG_ALLOW, SECCOMP_RET_ALLOW_NAME },
>    { }
> --=20
> 2.24.0
>=20
