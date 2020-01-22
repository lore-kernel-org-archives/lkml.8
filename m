Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7707C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B752253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zYaQovm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAVWkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:40:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46924 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:40:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id z26so808610lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cFI2KS3YTe8YnCNUCd4DQaJDpcrlKps9GUI04jPWB2g=;
        b=zYaQovm6YCupmEnkCK90GDsjA4mYqOjXtPbRkQ++ACbJK/dlpZl2hHP7fHIdrcZ70y
         rmPFb893W3B3P6bQAV+DduzsLI6GGS7uA1eWgSXoE878YzOhUP7w6Vi7ViVdvL7OHSQj
         QtpWyV5P+DFbHxO5OY0vVN/ZL9Ghy0GI02wbQutxspjHOcRacVjNz2qNscBN6gSdIlBP
         Fw81sG07hU5uWTTegyOZC1t6iTlr7b/5U1j+KF5jQeG58HZB3t/COKPTRS2RI3JoXh5u
         rDwO3YseUF8TaWnpXWUrlmQGnWf39FHXcv0lQmhQvJ/M7H1ZJmi+3zz0H6JPPOYQe+8I
         NOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cFI2KS3YTe8YnCNUCd4DQaJDpcrlKps9GUI04jPWB2g=;
        b=RgKs3uLsDTpQcpsJiCPVyrSxH79AyQkB0jWPYNREUwP4KqGSXsou/l2A0zPVfEBOmr
         nWtFb4MKi7yHPohtmojeV4OufTt1fgQB4c0cxa96C3kVGVhCDF+HNhBt5VVStanfHoS/
         pO+gYE4mlsKROuWIzEBUOtZG2hP9+D03d2KE/r5ik+ESU07IPAAYYWesOluIHdbMjdt5
         sFv9scI9qsQVCA9Z8o/q7va/mtxJWEWelUgT2MNZN/sfFHEWq8wZWkKfAysixjcMA7OZ
         DTVOd/OAXEJIcnvnB93qlbfXNnRYWhbzN+P2uG4l9W0YzkJXkOh6TDG4hue4maJ+XxHG
         nAXg==
X-Gm-Message-State: APjAAAWyC1qxZZKV8qx37tlzhmbO9nrFAI1neyhzCLtqQ1uWYOXvzG0X
        LJE0D145L72VZkTmpOG81VJGs6X7pg3y5PtYM1Xh
X-Google-Smtp-Source: APXvYqyexK+Tm0pUv/Rts6z5RtpWCOoQZNqh1gBcQARMjG6p1JR3DHk+wKmOp+F3fMZEQ2xOa8PN30ml9t6FPOELb6c=
X-Received: by 2002:a05:6512:3ac:: with SMTP id v12mr3007208lfp.205.1579732822163;
 Wed, 22 Jan 2020 14:40:22 -0800 (PST)
MIME-Version: 1.0
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
In-Reply-To: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 17:40:10 -0500
Message-ID: <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, nhorman@redhat.com,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Log information about programs connecting to and disconnecting from the
> audit netlink multicast socket. This is needed so that during
> investigations a security officer can tell who or what had access to the
> audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> Criteria.  Here is the systemd startup event:
>
> type=3DUNKNOWN[1335] msg=3Daudit(2020-01-17 10:30:33.731:6) : pid=3D1 uid=
=3Droot auid=3Dunset tty=3D(none) ses=3Dunset subj=3Dkernel comm=3Dsystemd =
exe=3D/usr/lib/systemd/systemd nl-mcgrp=3D1 op=3Dconnect res=3Dyes
>
> And the events from the test suite:
>
> type=3DPROCTITLE msg=3Daudit(2020-01-17 10:36:24.050:294) : proctitle=3D/=
usr/bin/perl -w amcast_joinpart/test
> type=3DSOCKADDR msg=3Daudit(2020-01-17 10:36:24.050:294) : saddr=3D{ sadd=
r_fam=3Dnetlink nlnk-fam=3D16 nlnk-pid=3D0 }
> type=3DSYSCALL msg=3Daudit(2020-01-17 10:36:24.050:294) : arch=3Dx86_64 s=
yscall=3Dbind success=3Dyes exit=3D0 a0=3D0x7 a1=3D0x55d65cb79090 a2=3D0xc =
a3=3D0x0 items=3D0 ppid=3D671 pid=3D674 auid=3Droot uid=3Droot gid=3Droot e=
uid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tt=
y=3DttyS0 ses=3D3 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-01-17 10:36:24.050:294) : pid=3D674=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D3 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Dconnect res=3Dyes
>
> type=3DUNKNOWN[1335] msg=3Daudit(2020-01-17 10:36:24.051:295) : pid=3D674=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D3 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Ddisconnect res=3Dyes
>
> Please see the upstream issue tracker:
>   https://github.com/linux-audit/audit-kernel/issues/28
>   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-So=
cket-Join-Part
>   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-j=
oin
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> ---
> Note: msg type 1334 was skipped due to BPF accepted in another tree.
> Note: v5 due to previous 2014-10-07, 2015-07-23, 2016-11-30, 2017-10-13
> Note: subj attrs included due to missing syscall record for systemd (audi=
t=3D1)
> Note: tried refactor of subj attrs, but this is yet another new order.
> ---
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 3ad935527177..67fb24472dc2 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -116,6 +116,7 @@
>  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
>  #define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
>  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> +#define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read soc=
ket */
>
>  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant *=
/
>  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 17b0d523afb3..478259f3fa53 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
>         audit_ctl_unlock();
>  }
>
> +/* Log information about who is connecting to the audit multicast socket=
 */
> +static void audit_log_multicast_bind(int group, const char *op, int err)
> +{
> +       const struct cred *cred;
> +       struct tty_struct *tty;
> +       char comm[sizeof(current->comm)];
> +       struct audit_buffer *ab;
> +
> +       if (!audit_enabled)
> +               return;
> +
> +       ab =3D audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_L=
ISTENER);
> +       if (!ab)
> +               return;
> +
> +       cred =3D current_cred();
> +       tty =3D audit_get_tty();
> +       audit_log_format(ab, "pid=3D%u uid=3D%u auid=3D%u tty=3D%s ses=3D=
%u",
> +                        task_pid_nr(current),
> +                        from_kuid(&init_user_ns, cred->uid),
> +                        from_kuid(&init_user_ns, audit_get_loginuid(curr=
ent)),
> +                        tty ? tty_name(tty) : "(none)",
> +                        audit_get_sessionid(current));

Don't we already get all of that information as part of the syscall record?

> +       audit_put_tty(tty);
> +       audit_log_task_context(ab); /* subj=3D */

Also part of the syscall record.

> +       audit_log_format(ab, " comm=3D");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));

Again.

> +       audit_log_d_path_exe(ab, current->mm); /* exe=3D */

Again.

> +       audit_log_format(ab, " nl-mcgrp=3D%d op=3D%s res=3D%d", group, op=
, !err);

This part is new ;)

> +       audit_log_end(ab);
> +}

I'm pretty sure these are the same arguments I made when Steve posted
a prior version of this patch.

--=20
paul moore
www.paul-moore.com
