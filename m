Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AD3206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoD1fwnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgDQVek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:34:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgDQVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587159277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9HdYhQvJYfsq5z3VTAKCzcuyh3PssVzja8lUvj0dVNo=;
        b=LoD1fwncYu60tjUoCZ2FDkXjyDOBEl26hB9bzquBKT9Zqv/79ZJ4JZXhntN13aIriZmX0O
        mBaOr6sDeGQsGQaJ/2GmQUO6MlaT/JhLKIKMrLWcDPnfUiF29I5WQ+4QnlWGswlKH4h9zi
        Nj+l38heLFIFmr6TkAA6InaoKlVUroQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-oUgzutDoPPmFDnGfXJLPww-1; Fri, 17 Apr 2020 17:34:33 -0400
X-MC-Unique: oUgzutDoPPmFDnGfXJLPww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A01813FF;
        Fri, 17 Apr 2020 21:34:32 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBA1D5DA7C;
        Fri, 17 Apr 2020 21:34:25 +0000 (UTC)
Date:   Fri, 17 Apr 2020 17:34:23 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak28 V7] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200417213423.leermiriy4jzgwf4@madcap2.tricolour.ca>
References: <82d85f72416560c155031375fb5b32ac06394c31.1584033222.git.rgb@redhat.com>
 <CAHC9VhRqytBECZ+bgo_OXavbRmPKEu0OOqS=xe=FQFhG+Qv=oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRqytBECZ+bgo_OXavbRmPKEu0OOqS=xe=FQFhG+Qv=oA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 17:18, Paul Moore wrote:
> On Tue, Mar 17, 2020 at 12:04 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Log information about programs connecting to and disconnecting from the
> > audit netlink multicast socket. This is needed so that during
> > investigations a security officer can tell who or what had access to the
> > audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> > Criteria.  Here is the systemd startup event:
> >
> > type=PROCTITLE msg=audit(2020-02-18 15:26:50.775:10) : proctitle=/init
> > type=SYSCALL msg=audit(2020-02-18 15:26:50.775:10) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x19 a1=0x55645c369b70 a2=0xc a3=0x7fff9fedec24 items=0 ppid=0 pid=1 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=systemd exe=/usr/lib/systemd/systemd subj=kernel key=(null)
> > type=UNKNOWN[1335] msg=audit(2020-02-18 15:26:50.775:10) : pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes
> >
> > And the events from the test suite:
> >
> > type=PROCTITLE msg=audit(2020-02-18 15:28:01.594:307) : proctitle=/usr/bin/perl -w amcast_joinpart/test
> > type=SYSCALL msg=audit(2020-02-18 15:28:01.594:307) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x558ebc428be0 a2=0xc a3=0x0 items=0 ppid=642 pid=645 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > type=UNKNOWN[1335] msg=audit(2020-02-18 15:28:01.594:307) : pid=645 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes
> >
> > type=PROCTITLE msg=audit(2020-03-17 11:35:31.474:344) : proctitle=/usr/bin/perl -w amcast_joinpart/test
> > type=SYSCALL msg=audit(2020-03-17 11:35:31.474:344) : arch=x86_64 syscall=setsockopt success=yes exit=0 a0=0x7 a1=SOL_NETLINK a2=0x2 a3=0x7ffee21ca5f0 items=0 ppid=686 pid=689 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=3 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > type=UNKNOWN[1335] msg=audit(2020-03-17 11:35:31.474:344) : pid=689 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes
> >
> > type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.051:295) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes
> 
> This patch looks fine to me, but this line is curious ... I'm assuming
> this is just a stray/cut-n-paste-error from the last time you updated
> the commit description?  If so, just let me know and I can drop it
> while merging, otherwise there is something odd going on ....

That last line is the result of close() from an earlier version of the
testsuite, rather than setsockopt(..., NETLINK_DROP_MEMBERSHIP, ...).

This is why we need the subject attributes, as noted in the first note
above the changelog below.

> > Please see the upstream issue tracker at
> >   https://github.com/linux-audit/audit-kernel/issues/28
> > With the feature description at
> >   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-Socket-Join-Part
> > The testsuite support is at
> >   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-join
> >   https://github.com/linux-audit/audit-testsuite/pull/93
> > And the userspace support patch is at
> >   https://github.com/linux-audit/audit-userspace/pull/114
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >
> > ---
> > Note: subj attrs included due to missing syscall record for disconnect on close
> > Note: tried refactor of subj attrs, but this is yet another new order.
> >
> > Changelog:
> > v7:
> > - rename audit_log_multicast_bind to audit_log_multicast
> >
> > v6:
> > - rebased on 5.6-rc1 audit/next and audit log BPF
> > - updated patch description sample records
> >
> > v5:
> > - rebased on 5.5-rc1 audit/next
> > - group bind/unbind ops
> > - add audit context
> > - justify message number skip
> > - check audit_enabled
> > - change field name from nlnk-grp to nl-mcgrp
> > - fix whitespace issues
> >
> > v4:
> > - 2017-10-13 sgrubb
> > - squash to 1 patch
> > - rebase on KERN_MODULE event
> > - open code subj attrs
> >
> > v3:
> > - 2016-11-30 sgrubb
> > - rebase on REPLACE event
> > - minimize audit_log_format calls
> > - rename audit_log_bind to audit_log_multicast_bind
> >
> > v2:
> > - 2015-07-23 sgrubb
> > - spin off audit_log_task_simple in seperate patch
> >
> > v1:
> > - 2014-10-07 rgb
> > ---
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index a534d71e689a..9b6a973f4cc3 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -117,6 +117,7 @@
> >  #define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> >  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> >  #define AUDIT_BPF              1334    /* BPF subsystem */
> > +#define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read socket */
> >
> >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index b96331e1976d..612bd818f6d7 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> >         audit_ctl_unlock();
> >  }
> >
> > +/* Log information about who is connecting to the audit multicast socket */
> > +static void audit_log_multicast(int group, const char *op, int err)
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
> > +       audit_put_tty(tty);
> > +       audit_log_task_context(ab); /* subj= */
> > +       audit_log_format(ab, " comm=");
> > +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> > +       audit_log_d_path_exe(ab, current->mm); /* exe= */
> > +       audit_log_format(ab, " nl-mcgrp=%d op=%s res=%d", group, op, !err);
> > +       audit_log_end(ab);
> > +}
> > +
> >  /* Run custom bind function on netlink socket group connect or bind requests. */
> > -static int audit_bind(struct net *net, int group)
> > +static int audit_multicast_bind(struct net *net, int group)
> >  {
> > +       int err = 0;
> > +
> >         if (!capable(CAP_AUDIT_READ))
> > -               return -EPERM;
> > +               err = -EPERM;
> > +       audit_log_multicast(group, "connect", err);
> > +       return err;
> > +}
> >
> > -       return 0;
> > +static void audit_multicast_unbind(struct net *net, int group)
> > +{
> > +       audit_log_multicast(group, "disconnect", 0);
> >  }
> >
> >  static int __net_init audit_net_init(struct net *net)
> >  {
> >         struct netlink_kernel_cfg cfg = {
> >                 .input  = audit_receive,
> > -               .bind   = audit_bind,
> > +               .bind   = audit_multicast_bind,
> > +               .unbind = audit_multicast_unbind,
> >                 .flags  = NL_CFG_F_NONROOT_RECV,
> >                 .groups = AUDIT_NLGRP_MAX,
> >         };
> > --
> > 1.8.3.1
> >
> 
> 
> -- 
> paul moore
> www.paul-moore.com
> 
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

