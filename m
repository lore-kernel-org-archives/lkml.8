Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEEAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A522522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si7QSMUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWSwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:52:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgAWSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579805523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6oq2qvlEZi4HWKP2S2peReezRB7+IOuQiKw6h5DhZJ4=;
        b=Si7QSMUJYRmUGETMzYcNA7ugqkSanQvHb3eF4BJvYcqtQUVI7Lq+Cq6cEGn5nBPHYo3p+r
        bfrh/DvO+DU6daEOOyTsPUI97csY5MBgtGdVNwQmxxkbpSFXrxW8ZXL5yQN0wSQN++bg2X
        GqxjXwV/MXXITauLh722Bquf2PlnyT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-sHPc3dulOHeTYCLFwZ_nmQ-1; Thu, 23 Jan 2020 13:52:01 -0500
X-MC-Unique: sHPc3dulOHeTYCLFwZ_nmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E82800D41;
        Thu, 23 Jan 2020 18:51:59 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 635E519C69;
        Thu, 23 Jan 2020 18:51:52 +0000 (UTC)
Date:   Thu, 23 Jan 2020 13:51:50 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>, nhorman@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200123185149.sr4b4u4s2ec7renc@madcap2.tricolour.ca>
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
 <CAHC9VhR9p+aOTzv7g-ujuMsMtLvOZKkoKJWsthZnj38rzJe1TA@mail.gmail.com>
 <20200122230742.7vwtvmhhjerray5f@madcap2.tricolour.ca>
 <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com>
 <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca>
 <CAHC9VhTEfZXCV6TwJ4KOoDCea3x5i85_gBmMi=cygGG9OQCGOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTEfZXCV6TwJ4KOoDCea3x5i85_gBmMi=cygGG9OQCGOQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-23 11:57, Paul Moore wrote:
> On Thu, Jan 23, 2020 at 11:14 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-01-23 09:32, Paul Moore wrote:
> > > On Wed, Jan 22, 2020 at 6:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On 2020-01-22 17:40, Paul Moore wrote:
> > > > > On Fri, Jan 17, 2020 at 3:21 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > ...
> > >
> > > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > > index 17b0d523afb3..478259f3fa53 100644
> > > > > > --- a/kernel/audit.c
> > > > > > +++ b/kernel/audit.c
> > > > > > @@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
> > > > > >         audit_ctl_unlock();
> > > > > >  }
> > > > > >
> > > > > > +/* Log information about who is connecting to the audit multicast socket */
> > > > > > +static void audit_log_multicast_bind(int group, const char *op, int err)
> > > > > > +{
> > > > > > +       const struct cred *cred;
> > > > > > +       struct tty_struct *tty;
> > > > > > +       char comm[sizeof(current->comm)];
> > > > > > +       struct audit_buffer *ab;
> > > > > > +
> > > > > > +       if (!audit_enabled)
> > > > > > +               return;
> > > > > > +
> > > > > > +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
> > > > > > +       if (!ab)
> > > > > > +               return;
> > > > > > +
> > > > > > +       cred = current_cred();
> > > > > > +       tty = audit_get_tty();
> > > > > > +       audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
> > > > > > +                        task_pid_nr(current),
> > > > > > +                        from_kuid(&init_user_ns, cred->uid),
> > > > > > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > > > > > +                        tty ? tty_name(tty) : "(none)",
> > > > > > +                        audit_get_sessionid(current));
> > > > >
> > > > > Don't we already get all of that information as part of the syscall record?
> > > >
> > > > Yes.  However, the syscall record isn't always present.  One example is
> > > > systemd, shown above.
> > >
> > > Assuming that the system supports syscall auditing, the absence of a
> > > syscall record is a configuration choice made by the admin.  If the
> > > system doesn't support syscall auditing the obvious "fix" is to do the
> > > work to enable syscall auditing on that platform ... but now we're
> > > starting to get off topic.
> >
> > Well, the system did spit out a syscall record with the example above,
> > so it has support for syscall auditing.
> >
> > I'm testing on f30 with an upstream kernel, the standard 30-stig ruleset and
> > with kernel command line audit=1.  What else is needed to support a syscall
> > record on systemd before any audit rules have been put in place?  We may still
> > have a bug here that affects early process auditing.  What am I missing?
> >
> > If we can get that sorted out, we don't need subject attributes in this record.
> 
> It looks like some debugging is in order.  There must be some sort of
> action initiated by userspace which is causing the multicast
> "op=connect", right?  Find out what that is and why it isn't
> generating a syscall record (maybe it's not a syscall? I don't know
> what systemd is doing here).

One clue is that subj=kernel and auid, ttye and ses are unset, despite
the rest checking out:
	pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd

> > > > The other is the disconnect record, shown above,
> > > > which may be asynchronous, or an unmonitored syscall (It could only be
> > > > setsockopt, close, shutdown.).
> > >
> > > An unmonitored syscall still falls under the category of a
> > > configuration choice so I'm not too concerned about that, but the
> > > async disconnect record is legitimate.  Can you provide more
> > > information about when this occurs?  I'm guessing this is pretty much
> > > just an abrupt/abnormal program exit?
> >
> > Again, what configuration choice are you talking about?
> > "-a task,never"?  That isn't active on this system.
> >
> > The output was produced by the test case quoted in the patch description.
> >
> > I should not have had to put a rule in place to do syscall auditing on connect,
> > bind, setsockopt, close, shutdown.
> >
> > The disconnect would have been due to a perl close() call.  I would not have
> > expected that to be async, but I don't know the details of what the perl
> > implementation does.
> 
> You mentioned two cases: unmonitored syscalls and async records (I
> assumed these were just "disconnect").  Monitoring a syscall is a
> configuration choice, regardless of what the defaults may be, and
> since the folks likely to care about these multicast events are the
> same sort of folks that care deeply about audit, asking them to do
> some additional configuration tweaks seems like a reasonable thing to
> get this new record with the proper information.  The async records
> are potentially more interesting, but less clear, which is why I asked
> for more info.

I don't know what other config choices are going to make a difference
for pid=1 which is the primary user of this multicast socket other than
audit=1 unless we add another kernel boot parameter.

I'm puzzled why the production of this record doesn't automatically
trigger a syscall record on exit since that act of producing this record
will populate the audit context.

> Regardless, all of this is pretty moot if we decide we don't care
> about duplicate information.  Let's make a decision on duplicate
> fields across multiple records before we worry too much about the rest
> of what we are discussing.

I don't have a problem with duplicate information, but I'm not the
consumer.  I can fix situations where that duplicate information turns
out to be inconsistent though.

> > > > > I'm pretty sure these are the same arguments I made when Steve posted
> > > > > a prior version of this patch.
> > > >
> > > > You did.  I would really like to have dropped them, but they aren't
> > > > reliably available.
> > >
> > > Personally I'm not too worried if we have duplicate information spread
> > > across records in a single event, as long as they are consistent.
> > > However, I remember Steve complaining rather loudly about duplicated
> > > fields across records in a single event some time back; perhaps that
> > > is not a concern of his anymore (perhaps it was a narrow case at the
> > > time), I don't know.
> > >
> > > Here is the deal, either duplicated information is something we are
> > > okay with, or it is something to avoid; we need to pick one.  As
> > > mentioned above, I don't really care that much either way (I have a
> > > slight preference, but I don't feel strongly enough to fight for it),
> > > so let's hear the arguments both for and against and decide - whatever
> > > we pick I'll enforce so long as we are stuck with this string format.
> >
> > Steve, can you say why this order should be the standard?  From:
> >         http://people.redhat.com/sgrubb/audit/record-fields.html
> >
> > I get:
> >         SYSCALL/ANOM_LINK/FEATURE_CHANGE
> >                 ppid    pid     auid    uid     gid     euid    suid    fsuid   egid    sgid    fsgid   tty     ses     comm    exe     subj
> 
> Oh man, let's please not have *another* debate about field ordering
> before we answer the duplicate field question.  If history has shown
> us anything, it is that debates around audit record field ordering
> tend to kill progress.  Let's try to stay focused.

I agree that is a different thread.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

