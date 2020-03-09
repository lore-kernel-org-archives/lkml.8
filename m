Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92981C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6014C20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCqn9JRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCIUbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:31:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbgCIUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583785882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATkyb03OLdE3OhyuwgYM8tORFI+eYvYvJ/8I1hIaKlU=;
        b=PCqn9JRC9Zg3OgYHzunJJQ9Wsslp/jCr5M6pbdZqnanmGXoVevTFJD/dNntTuZxw9wQccE
        LMXr9ggIkMg61smRMJYjjXf+QZwp0PmOH5s3/n2e/gBTE0OBMtPfe9YiayHYveQctsVP8S
        Zs+jreoJ77rfLPXNrsq3dvsH42gITWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-bCiNAc5MOuCc5JymQpJMUA-1; Mon, 09 Mar 2020 16:31:18 -0400
X-MC-Unique: bCiNAc5MOuCc5JymQpJMUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CFF4107ACC9;
        Mon,  9 Mar 2020 20:31:17 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.rdu2.redhat.com [10.10.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7166A5C28E;
        Mon,  9 Mar 2020 20:31:10 +0000 (UTC)
Date:   Mon, 9 Mar 2020 16:31:07 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak120] audit: trigger accompanying records when no
 rules present
Message-ID: <20200309203107.lzhshn6uzknhmosu@madcap2.tricolour.ca>
References: <e75e80e820f215d2311941e083580827f6c1dbb6.1582059594.git.rgb@redhat.com>
 <CAHC9VhTXFg_w8xJChPZZFY=HMpF722p-_NYy=06xjSkLFSCzbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTXFg_w8xJChPZZFY=HMpF722p-_NYy=06xjSkLFSCzbg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-27 20:02, Paul Moore wrote:
> On Tue, Feb 18, 2020 at 4:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > When there are no audit rules registered, mandatory records (config,
> > etc.) are missing their accompanying records (syscall, proctitle, etc.).
> >
> > This is due to audit context dummy set on syscall entry based on absence
> > of rules that signals that no other records are to be printed.
> >
> > Clear the dummy bit in auditsc_set_stamp() when the first record of an
> > event is generated.
> >
> > Please see upstream github issue
> > https://github.com/linux-audit/audit-kernel/issues/120
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/auditsc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 4effe01ebbe2..31195d122344 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2176,6 +2176,8 @@ int auditsc_get_stamp(struct audit_context *ctx,
> >         t->tv_sec  = ctx->ctime.tv_sec;
> >         t->tv_nsec = ctx->ctime.tv_nsec;
> >         *serial    = ctx->serial;
> > +       if (ctx->dummy)
> > +               ctx->dummy = 0;
> 
> Two comments:
> 
> * Why even bother checking to see if ctx->dummy is true?  If it is
> true you set it to false/0; if it is already false you leave it alone.
> Either way ctx->dummy is going to be set to false when you are past
> these two lines, might as well just always set ctx->dummy to false/0.

Ok, no problem.

> * Why are you setting ->dummy to false in auditsc_get_stamp() and not
> someplace a bit more obvious like audit_log_start()?  Is it because
> auditsc_get_stamp() only gets called once per event?  I'm willing to
> take the "hit" of one extra assignment in audit_log_start() to keep
> this in a more obvious place and not buried in auditsc_get_stamp().

It is because the context is only available when syscall logging is
enabled (which is on most platforms and hopefully eventually all) and
makes for cleaner code and lack of need to check existance of the
context.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

