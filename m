Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E4EC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C7B24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqKAjroW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAVXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:07:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579734475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuaeXpmKLY7fcB4dRtnCX1/pOPSIjn6PbEboWM9ZzOU=;
        b=XqKAjroW1Ej9kBJPZwt/jrx8Q9eSPU0Xwq8GhFsBaOwT+of0ZQREX3DWwK5GJ2BT1koUnw
        D3GGo9QPEm4wmEsIwR3ms3MPQkN/q2l0oqThYSAc22u6nJazINq+yQyLESh0fdAJJcvKVP
        21B3RyMBtz24bn7nfGZEp5x6Icz4dmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-A466OxLIP8CZruX5n3DKQw-1; Wed, 22 Jan 2020 18:07:53 -0500
X-MC-Unique: A466OxLIP8CZruX5n3DKQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 216CB8D4260;
        Wed, 22 Jan 2020 23:07:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6386A85735;
        Wed, 22 Jan 2020 23:07:45 +0000 (UTC)
Date:   Wed, 22 Jan 2020 18:07:42 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, nhorman@redhat.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca>
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-22 17:40, Paul Moore wrote:
> On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Log information about programs connecting to and disconnecting from the
> > audit netlink multicast socket. This is needed so that during
> > investigations a security officer can tell who or what had access to the
> > audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> > Criteria.  Here is the systemd startup event:
> >
> > type=UNKNOWN[1335] msg=audit(2020-01-17 10:30:33.731:6) : pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes
> >
> > And the events from the test suite:
> >
> > type=PROCTITLE msg=audit(2020-01-17 10:36:24.050:294) : proctitle=/usr/bin/perl -w amcast_joinpart/test
> > type=SOCKADDR msg=audit(2020-01-17 10:36:24.050:294) : saddr={ saddr_fam=netlink nlnk-fam=16 nlnk-pid=0 }
> > type=SYSCALL msg=audit(2020-01-17 10:36:24.050:294) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x55d65cb79090 a2=0xc a3=0x0 items=0 ppid=671 pid=674 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=3 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.050:294) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes
> >
> > type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.051:295) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes
> >
> > Please see the upstream issue tracker:
> >   https://github.com/linux-audit/audit-kernel/issues/28
> >   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-Socket-Join-Part
> >   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-join
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >
> > ---
> > Note: msg type 1334 was skipped due to BPF accepted in another tree.
> > Note: v5 due to previous 2014-10-07, 2015-07-23, 2016-11-30, 2017-10-13
> > Note: subj attrs included due to missing syscall record for systemd (audit=1)
> > Note: tried refactor of subj attrs, but this is yet another new order.
> > ---
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 3ad935527177..67fb24472dc2 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -116,6 +116,7 @@
> >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> >  #define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> >  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> > +#define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read socket */
> >
> >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 17b0d523afb3..478259f3fa53 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> >         audit_ctl_unlock();
> >  }
> >
> > +/* Log information about who is connecting to the audit multicast socket */
> > +static void audit_log_multicast_bind(int group, const char *op, int err)
> > +{
> > +       const struct cred *cred;
> > +       struct tty_struct *tty;
> > +       char comm[sizeof(current->comm)];
> > +       struct audit_buffer *ab;
> > +
> > +       if (!audit_enabled)
> > +               return;
> > +
> > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> > +       if (!ab)
> > +               return;
> > +
> > +       cred = current_cred();
> > +       tty = audit_get_tty();
> > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > +                        task_pid_nr(current),
> > +                        from_kuid(&init_user_ns, cred->uid),
> > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > +                        tty ? tty_name(tty) : "(none)",
> > +                        audit_get_sessionid(current));
> 
> Don't we already get all of that information as part of the syscall record?

Yes.  However, the syscall record isn't always present.  One example is
systemd, shown above.  The other is the disconnect record, shown above,
which may be asynchronous, or an unmonitored syscall (It could only be
setsockopt, close, shutdown.).

> > +       audit_put_tty(tty);
> > +       audit_log_task_context(ab); /* subj= */
> 
> Also part of the syscall record.
> 
> > +       audit_log_format(ab, " comm=");
> > +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> 
> Again.
> 
> > +       audit_log_d_path_exe(ab, current->mm); /* exe= */
> 
> Again.
> 
> > +       audit_log_format(ab, " nl-mcgrp=%d op=%s res=%d", group, op, !err);
> 
> This part is new ;)
> 
> > +       audit_log_end(ab);
> > +}
> 
> I'm pretty sure these are the same arguments I made when Steve posted
> a prior version of this patch.

You did.  I would really like to have dropped them, but they aren't
reliably available.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

