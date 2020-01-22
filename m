Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C91C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E066421835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOA/PHvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAVXpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:45:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgAVXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579736707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAY6s3oSzBwgsfYGnfrrOuB8hcKAqI6Ku8nNKxgPboQ=;
        b=MOA/PHvWbkgFxxD7PtAJUkMBchVvsErZl7MWuPiitHjP+TBGxiJJ9g5SvYlTkWOUFucy+n
        rms5K/J6Ua4q3slMpJ3ShmOKwzssbqM+94xaZdGOLGOeXBitjJEwKYcW9mKIpJx32wPKDc
        mYbTi/gzThsq/DzfAYmIwo2yiVhvALU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-_-n7doyhOV-pNvXah0VwCg-1; Wed, 22 Jan 2020 18:45:05 -0500
X-MC-Unique: _-n7doyhOV-pNvXah0VwCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF04100550E;
        Wed, 22 Jan 2020 23:45:04 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06CD089D02;
        Wed, 22 Jan 2020 23:44:57 +0000 (UTC)
Date:   Wed, 22 Jan 2020 18:44:55 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, nhorman@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200122234455.jg7bxrazrjpiqpe7@madcap2.tricolour.ca>
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
 <1907590.3WuaD5rAFU@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1907590.3WuaD5rAFU@x2>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-22 18:12, Steve Grubb wrote:
> On Wednesday, January 22, 2020 5:40:10 PM EST Paul Moore wrote:
> > On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Log information about programs connecting to and disconnecting from the
> > > audit netlink multicast socket. This is needed so that during
> > > investigations a security officer can tell who or what had access to the
> > > audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> > > Criteria.  Here is the systemd startup event:
> > > 
> > > type=UNKNOWN[1335] msg=audit(2020-01-17 10:30:33.731:6) : pid=1 uid=root
> > > auid=unset tty=(none) ses=unset subj=kernel comm=systemd
> > > exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes
> > > 
> > > And the events from the test suite:
> > > 
> > > type=PROCTITLE msg=audit(2020-01-17 10:36:24.050:294) :
> > > proctitle=/usr/bin/perl -w amcast_joinpart/test type=SOCKADDR
> > > msg=audit(2020-01-17 10:36:24.050:294) : saddr={ saddr_fam=netlink
> > > nlnk-fam=16 nlnk-pid=0 } type=SYSCALL msg=audit(2020-01-17
> > > 10:36:24.050:294) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7
> > > a1=0x55d65cb79090 a2=0xc a3=0x0 items=0 ppid=671 pid=674 auid=root
> > > uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
> > > fsgid=root tty=ttyS0 ses=3 comm=perl exe=/usr/bin/perl
> > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > > type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.050:294) : pid=674
> > > uid=root auid=root tty=ttyS0 ses=3
> > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl
> > > exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes
> > > 
> > > type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.051:295) : pid=674
> > > uid=root auid=root tty=ttyS0 ses=3
> > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl
> > > exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes> 
> > > Please see the upstream issue tracker:
> > >   https://github.com/linux-audit/audit-kernel/issues/28
> > >   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-So
> > >   cket-Join-Part
> > >   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-> >   join> 
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > 
> > > ---
> > > Note: msg type 1334 was skipped due to BPF accepted in another tree.
> > > Note: v5 due to previous 2014-10-07, 2015-07-23, 2016-11-30, 2017-10-13
> > > Note: subj attrs included due to missing syscall record for systemd
> > > (audit=1) Note: tried refactor of subj attrs, but this is yet another
> > > new order. ---
> > > 
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.c             | 48
> > >  ++++++++++++++++++++++++++++++++++++++++++---- 2 files changed, 45
> > >  insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > index 3ad935527177..67fb24472dc2 100644
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -116,6 +116,7 @@
> > > 
> > >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> > >  #define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> > >  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> > > 
> > > +#define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read
> > > socket */> 
> > >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant
> > >  */
> > >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > > 
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 17b0d523afb3..478259f3fa53 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> > > 
> > >         audit_ctl_unlock();
> > >  
> > >  }
> > > 
> > > +/* Log information about who is connecting to the audit multicast socket
> > > */ +static void audit_log_multicast_bind(int group, const char *op, int
> > > err) +{
> > > +       const struct cred *cred;
> > > +       struct tty_struct *tty;
> > > +       char comm[sizeof(current->comm)];
> > > +       struct audit_buffer *ab;
> > > +
> > > +       if (!audit_enabled)
> > > +               return;
> > > +
> > > +       ab = audit_log_start(audit_context(), GFP_KERNEL,
> > > AUDIT_EVENT_LISTENER); +       if (!ab)
> > > +               return;
> > > +
> > > +       cred = current_cred();
> > > +       tty = audit_get_tty();
> > > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > > +                        task_pid_nr(current),
> > > +                        from_kuid(&init_user_ns, cred->uid),
> > > +                        from_kuid(&init_user_ns,
> > > audit_get_loginuid(current)), +                        tty ?
> > > tty_name(tty) : "(none)",
> > > +                        audit_get_sessionid(current));
> > 
> > Don't we already get all of that information as part of the syscall record?
> 
> We don't want or need a syscall record. It doesn't add anything to the 
> necessary information. Also, when we have syscall records, people expect that 
> they obey the syscall auditing. Especially wrt "never" audit rules.

Did both of you see the 4 "Note:" lines between the description and the
patch?  I'm caught in the middle here.

> > > +       audit_put_tty(tty);
> > > +       audit_log_task_context(ab); /* subj= */
> > 
> > Also part of the syscall record.
> > 
> > > +       audit_log_format(ab, " comm=");
> > > +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> > 
> > Again.
> > 
> > > +       audit_log_d_path_exe(ab, current->mm); /* exe= */
> > 
> > Again.
> > 
> > > +       audit_log_format(ab, " nl-mcgrp=%d op=%s res=%d", group, op,
> > > !err);
> > This part is new ;)
> > 
> > > +       audit_log_end(ab);
> > > +}
> > 
> > I'm pretty sure these are the same arguments I made when Steve posted
> > a prior version of this patch.
> 
> No. You didn't mind it then. What you objected to was that I wrote a helper 
> function that could be used by future audit events to start a format 
> standardization process.

Again, see the 4 notes.  I was not able to refactor any of the subject
attributes since this is yet another audit subject attributes order
(YAASAO) that hasn't been seen yet.  Why are we creatting YAASAO?

> The event looks good to me. Ack for the format being acceptable to existing 
> tools.
> 
> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

