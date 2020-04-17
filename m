Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E286A20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="G/zZASJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgDQVTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDQVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:19:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0060FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:19:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nv1so2622582ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CMi3udRNC1mfaNq6yT5DycC/95qeHzXCYjO0TexCTBg=;
        b=G/zZASJRQWW87kz4AkrJ0PMiRrgrX5owZGVQT24hbp1/ndSNRBEezQDvM9HKDeOCvx
         mSRcRo6frUkOrFdfY4HL8Zfmet3azSwIDwkQbkdSnjwYMt/zoohl/zUV8io9c4w1wwCR
         SF6AAa8GBb9QBjakl1hm4qT/Y8GdugCqnJ3z4SeC958dZ4TgnOPoel3j6GQ3l4XelgoP
         7YTfIOovdIMbGGSK+yD5wcHoAyjfQQCRdJhzwi4QC2MgqaeQjv7D3WG+/7RcslT32JpM
         IUBofLqVbrPrk6Gphhy4wlnfwuN4V4EDcSN5kuxkhZ0OGqmjojivVLvz7ign4Zvyv3AB
         dVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CMi3udRNC1mfaNq6yT5DycC/95qeHzXCYjO0TexCTBg=;
        b=qt1GbxYMqQaDjpaYNtIDqKTRV+M1hHMujiBp67R+7UoW0FjUKXvDhkLgYqxJEkQZhg
         0DeWQ/JX8MEMNrlf6Bd9k56XWQUcPp6WsxiX61neQdlplWSg9Ji/zqdaF6Va40Qyj8cn
         SvvSj5T7fSsWqHiDQYW3oh/OvcKIpXxD2EgFVlWLw1UhMDodV+DH04WWLy9sGSgJiLTr
         sqYlzR7+4x6QnGckOz1wiEy/+SpCOq3UUewYNFfJGXm685fz/LTJo4suOtQ3lTmtygwT
         x9bPX1aBDn7cr6Dhn0zYEOOYdSvmv/D8/X/PvgnVjo+X4/10Y3VoXlYcMz+1GhIHR52s
         eKyA==
X-Gm-Message-State: AGi0PubDFWfo+IZuF3B7t9OgCgTYoNVhj+YLPEW6OXOli1rbr3lLm5rx
        oOuoVX7BIBxlM86d92wMOSxUF9g7Kk2Z34MRRCZN
X-Google-Smtp-Source: APiQypJS0/alLMy7bq7ndJoDaDJwoqa1XyBmKZq+BvEnjQ8ZTz+/eJg171uRTBe9TJvvoGgXJ7npDm9CSyIvqPi3QxQ=
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr5166591ejb.271.1587158347435;
 Fri, 17 Apr 2020 14:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <82d85f72416560c155031375fb5b32ac06394c31.1584033222.git.rgb@redhat.com>
In-Reply-To: <82d85f72416560c155031375fb5b32ac06394c31.1584033222.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 17:18:56 -0400
Message-ID: <CAHC9VhRqytBECZ+bgo_OXavbRmPKEu0OOqS=xe=FQFhG+Qv=oA@mail.gmail.com>
Subject: Re: [PATCH ghak28 V7] audit: log audit netlink multicast bind and
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

On Tue, Mar 17, 2020 at 12:04 PM Richard Guy Briggs <rgb@redhat.com> wrote:
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
> type=3DPROCTITLE msg=3Daudit(2020-03-17 11:35:31.474:344) : proctitle=3D/=
usr/bin/perl -w amcast_joinpart/test
> type=3DSYSCALL msg=3Daudit(2020-03-17 11:35:31.474:344) : arch=3Dx86_64 s=
yscall=3Dsetsockopt success=3Dyes exit=3D0 a0=3D0x7 a1=3DSOL_NETLINK a2=3D0=
x2 a3=3D0x7ffee21ca5f0 items=3D0 ppid=3D686 pid=3D689 auid=3Droot uid=3Droo=
t gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot f=
sgid=3Droot tty=3DttyS0 ses=3D3 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-03-17 11:35:31.474:344) : pid=3D689=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D3 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Ddisconnect res=3Dyes
>
> type=3DUNKNOWN[1335] msg=3Daudit(2020-01-17 10:36:24.051:295) : pid=3D674=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D3 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Ddisconnect res=3Dyes

This patch looks fine to me, but this line is curious ... I'm assuming
this is just a stray/cut-n-paste-error from the last time you updated
the commit description?  If so, just let me know and I can drop it
while merging, otherwise there is something odd going on ....

> Please see the upstream issue tracker at
>   https://github.com/linux-audit/audit-kernel/issues/28
> With the feature description at
>   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-So=
cket-Join-Part
> The testsuite support is at
>   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-j=
oin
>   https://github.com/linux-audit/audit-testsuite/pull/93
> And the userspace support patch is at
>   https://github.com/linux-audit/audit-userspace/pull/114
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> ---
> Note: subj attrs included due to missing syscall record for disconnect on=
 close
> Note: tried refactor of subj attrs, but this is yet another new order.
>
> Changelog:
> v7:
> - rename audit_log_multicast_bind to audit_log_multicast
>
> v6:
> - rebased on 5.6-rc1 audit/next and audit log BPF
> - updated patch description sample records
>
> v5:
> - rebased on 5.5-rc1 audit/next
> - group bind/unbind ops
> - add audit context
> - justify message number skip
> - check audit_enabled
> - change field name from nlnk-grp to nl-mcgrp
> - fix whitespace issues
>
> v4:
> - 2017-10-13 sgrubb
> - squash to 1 patch
> - rebase on KERN_MODULE event
> - open code subj attrs
>
> v3:
> - 2016-11-30 sgrubb
> - rebase on REPLACE event
> - minimize audit_log_format calls
> - rename audit_log_bind to audit_log_multicast_bind
>
> v2:
> - 2015-07-23 sgrubb
> - spin off audit_log_task_simple in seperate patch
>
> v1:
> - 2014-10-07 rgb
> ---
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index a534d71e689a..9b6a973f4cc3 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -117,6 +117,7 @@
>  #define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
>  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
>  #define AUDIT_BPF              1334    /* BPF subsystem */
> +#define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read soc=
ket */
>
>  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant *=
/
>  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index b96331e1976d..612bd818f6d7 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
>         audit_ctl_unlock();
>  }
>
> +/* Log information about who is connecting to the audit multicast socket=
 */
> +static void audit_log_multicast(int group, const char *op, int err)
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
> +       audit_put_tty(tty);
> +       audit_log_task_context(ab); /* subj=3D */
> +       audit_log_format(ab, " comm=3D");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +       audit_log_d_path_exe(ab, current->mm); /* exe=3D */
> +       audit_log_format(ab, " nl-mcgrp=3D%d op=3D%s res=3D%d", group, op=
, !err);
> +       audit_log_end(ab);
> +}
> +
>  /* Run custom bind function on netlink socket group connect or bind requ=
ests. */
> -static int audit_bind(struct net *net, int group)
> +static int audit_multicast_bind(struct net *net, int group)
>  {
> +       int err =3D 0;
> +
>         if (!capable(CAP_AUDIT_READ))
> -               return -EPERM;
> +               err =3D -EPERM;
> +       audit_log_multicast(group, "connect", err);
> +       return err;
> +}
>
> -       return 0;
> +static void audit_multicast_unbind(struct net *net, int group)
> +{
> +       audit_log_multicast(group, "disconnect", 0);
>  }
>
>  static int __net_init audit_net_init(struct net *net)
>  {
>         struct netlink_kernel_cfg cfg =3D {
>                 .input  =3D audit_receive,
> -               .bind   =3D audit_bind,
> +               .bind   =3D audit_multicast_bind,
> +               .unbind =3D audit_multicast_unbind,
>                 .flags  =3D NL_CFG_F_NONROOT_RECV,
>                 .groups =3D AUDIT_NLGRP_MAX,
>         };
> --
> 1.8.3.1
>


--=20
paul moore
www.paul-moore.com
