Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B038AC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787542469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VKq8ycZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgB1BSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:18:35 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37216 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1BSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:18:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id j34so900824qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrpFr+6B3oCxyd0DiabeEBzNw/bSmCxGpvBi8A5aZsM=;
        b=VKq8ycZLUHbZkIJ7fqNRqLHskbo3Nccf8pVFCP2A+J7iWMYocYd9Jut2denPCtA2pr
         9fWoxec6McX0tPjjjyv6TE5tkj2Qh0YfSS/+e6EwapRo8B4R+aVMCi8lueECcaOykFFB
         n/9BLnqtcPxkOJxj9mE4aVK3MPv61Dt4INmUUq1BLBRDQZznOw/puUiDobCciNX/vyPK
         E5GYU59AMR0otPqifwsKL0Jzik4vWX0vr+rkpGybHOxtFVe+6K8KIuaaYG0fUfX3JRQI
         QEvF9fwRdQkGTBGvmGexEdy32ZXeuaDk3iuyN34wEEWIVcPFpe4C8NlxCsOI487mU2yW
         F0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrpFr+6B3oCxyd0DiabeEBzNw/bSmCxGpvBi8A5aZsM=;
        b=n6j7moVf9aB42F1nGcIESU/4AbN1uGNqnNF5mOQiifNrrBxcWzvcAaRi+wQLI8V5Oh
         BZ8sCSHkgDacnLDqxck4qdXVryc2ZQcrD8v2wQW6l+hlFUtgeITk/vCcdVe29fDHi9rP
         XtfliBt8hwDmq4S1V5IqpCOggpUml/or1MzH1bvjqdmHzVUyk7yZdfVHLbcQRverCVCT
         cLUlokVmp9wImum3lG6HLpFH3el9KxJmeGWD9R7uJ1tRGe5OnLIsZJD7JTxyaGPIq2QY
         7VfU+cJwlh9HwAMu5CuqyqH8+7MxyIJpMwW23WC2Jv6NuHTdG90WQGKQ+MRInNnwJqZl
         xZ8A==
X-Gm-Message-State: APjAAAWmt5rL4RxS20UdQdf+eZKvA4V7AC0bq6byLvB0GEHfYnT+QjWe
        BwM6aFW8uXq8ZPToQxPuZdmWSlYZs9GPWWsZ/ody
X-Google-Smtp-Source: APXvYqylfKS11fJiLyTUzfHz0YNa7SNLC9pqv/Pt7PsRUJbDSNR6f+WMoPH51vpB0I2LGMfQlmL2sQ9oAbCq4YfkYcg=
X-Received: by 2002:ac8:777b:: with SMTP id h27mr2105555qtu.251.1582852713396;
 Thu, 27 Feb 2020 17:18:33 -0800 (PST)
MIME-Version: 1.0
References: <857c76090363b6316a89d292cf9cccd0db54c079.1582058914.git.rgb@redhat.com>
In-Reply-To: <857c76090363b6316a89d292cf9cccd0db54c079.1582058914.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Feb 2020 20:18:22 -0500
Message-ID: <CAHC9VhT_o7P5G0FMWpOq0rwQb_V5E8Xrqk5Pq_DhQgYVBC2+=Q@mail.gmail.com>
Subject: Re: [PATCH ghak28 V6] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Log information about programs connecting to and disconnecting from the
> audit netlink multicast socket. This is needed so that during
> investigations a security officer can tell who or what had access to the
> audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> Criteria.  Here is the systemd startup event:
>
> type=3DPROCTITLE msg=3Daudit(2020-02-18 15:26:50.775:10) : proctitle=3D/i=
nit
> type=3DSYSCALL msg=3Daudit(2020-02-18 15:26:50.775:10) : arch=3Dx86_64 sy=
scall=3Dbind success=3Dyes exit=3D0 a0=3D0x19 a1=3D0x55645c369b70 a2=3D0xc =
a3=3D0x7fff9fedec24 items=3D0 ppid=3D0 pid=3D1 auid=3Dunset uid=3Droot gid=
=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=
=3Droot tty=3D(none) ses=3Dunset comm=3Dsystemd exe=3D/usr/lib/systemd/syst=
emd subj=3Dkernel key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-02-18 15:26:50.775:10) : pid=3D1 ui=
d=3Droot auid=3Dunset tty=3D(none) ses=3Dunset subj=3Dkernel comm=3Dsystemd=
 exe=3D/usr/lib/systemd/systemd nl-mcgrp=3D1 op=3Dconnect res=3Dyes
>
> And the events from the test suite:
>
> type=3DPROCTITLE msg=3Daudit(2020-02-18 15:28:01.594:307) : proctitle=3D/=
usr/bin/perl -w amcast_joinpart/test
> type=3DSOCKADDR msg=3Daudit(2020-02-18 15:28:01.594:307) : saddr=3D{ sadd=
r_fam=3Dnetlink nlnk-fam=3D16 nlnk-pid=3D0 }
> type=3DSYSCALL msg=3Daudit(2020-02-18 15:28:01.594:307) : arch=3Dx86_64 s=
yscall=3Dbind success=3Dyes exit=3D0 a0=3D0x7 a1=3D0x558ebc428be0 a2=3D0xc =
a3=3D0x0 items=3D0 ppid=3D642 pid=3D645 auid=3Droot uid=3Droot gid=3Droot e=
uid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tt=
y=3DttyS0 ses=3D1 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-02-18 15:28:01.594:307) : pid=3D645=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfined_=
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

...

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

Since this is logging both bind and unbind, let's change the name to
something a bit more generic, e.g. audit_log_multicast().

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
> +       audit_put_tty(tty);
> +       audit_log_task_context(ab); /* subj=3D */
> +       audit_log_format(ab, " comm=3D");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +       audit_log_d_path_exe(ab, current->mm); /* exe=3D */
> +       audit_log_format(ab, " nl-mcgrp=3D%d op=3D%s res=3D%d", group, op=
, !err);
> +       audit_log_end(ab);
> +}

--=20
paul moore
www.paul-moore.com
