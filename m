Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8442BC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B90620784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPgq5ZMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411808AbgDOT2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:28:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406313AbgDOT1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586978861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJS2xD/VOhghsaFkFFvHEazrHBxU5zPlf7mCEhLQdiQ=;
        b=JPgq5ZMxDt63VyNw++mPm4iVK9bRtpk8WL080VGHQiOO+BwJr5QE86BsorSa0kRXrkt1Du
        /wQ25lm7gD4kqCgLRDxu8ad7A/kSitLQXl5+BrxwKNwC6aOII+JbxpTeh5hviondvEi3mU
        cpXBOWPog2Hf4oOUS8LzuvPH8E1DLns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-9B1YcOYqM9-ip6w5Y6j5iQ-1; Wed, 15 Apr 2020 15:27:37 -0400
X-MC-Unique: 9B1YcOYqM9-ip6w5Y6j5iQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D62E8017F3;
        Wed, 15 Apr 2020 19:27:36 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DA471001DC2;
        Wed, 15 Apr 2020 19:27:26 +0000 (UTC)
Date:   Wed, 15 Apr 2020 15:27:23 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Amol Grover <frextrite@gmail.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20200415192723.rrdwtitiu3f2cd67@madcap2.tricolour.ca>
References: <20191128153203.GA23803@workstation-kernel-dev>
 <20191130020742.GF157739@google.com>
 <20200415153417.svpbimg66vbeuk7u@madcap2.tricolour.ca>
 <CAHC9VhTdfkxdiEwCZu-JCQGxJ_DNr0b_Ukm40VEUxq=Lc-zx1g@mail.gmail.com>
 <20200415161503.umujm6v4gadmf6qm@madcap2.tricolour.ca>
 <CAFqZXNuYnvru+pMhPwNTBn1+uB=MfYh1yWWBeAn+J-=LXrFgcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNuYnvru+pMhPwNTBn1+uB=MfYh1yWWBeAn+J-=LXrFgcg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-15 18:53, Ondrej Mosnacek wrote:
> On Wed, Apr 15, 2020 at 6:15 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-04-15 12:06, Paul Moore wrote:
> > > On Wed, Apr 15, 2020 at 11:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On 2019-11-29 21:07, Joel Fernandes wrote:
> > > > > On Thu, Nov 28, 2019 at 09:02:03PM +0530, Amol Grover wrote:
> > > > > > add __rcu notation to RCU protected global pointer auditd_conn
> > > > >
> > > > > Again, please use proper punctuation and captilization. This is unacceptable.
> > > > > Please put more effort into changelog.
> > > > >
> > > > > Otherwise the patch diff itself looks good to me, with the above nit
> > > > > corrected, you could add my tag to the next revision:
> > > > >
> > > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >
> > > > > thanks,
> > > > >
> > > > >  - Joel
> > > > >
> > > > > >
> > > > > > Fixes multiple instances of sparse error:
> > > > > > error: incompatible types in comparison expression
> > > > > > (different address spaces)
> > > >
> > > > Amol or Joel: Is there a reproducer recipe for this?
> > >
> > > The commit which was merged has a slightly better description which may help.
> >
> > I've already seen this.  Perhaps I should have replied to this message
> > instead to make that evident.  What really needed was Amol's original
> > message sent to this list, but it was Joel who included this list in his
> > reply (all 3 versions).
> >
> > I'm looking for the specific setup and commands that produced this error.
> 
> You can run make with "C=1", which will run sparse on all files that
> are rebuilt during that make run. For example, if I fully build the
> kernel and then revert commit
> cb5172d96d16df72db8b55146b0ec00bfd97f079, I get:
> 
> $ make [...] C=1
> [...]
>   CHECK   [...]/kernel/audit.c
> [...]/kernel/audit.c:218:14: error: incompatible types in comparison
> expression (different address spaces):
> [...]/kernel/audit.c:218:14:    struct auditd_connection [noderef] <asn:4> *
> [...]/kernel/audit.c:218:14:    struct auditd_connection *
> (...and a lot more errors like this + 2 different warnings)
> 
> And when I un-revert it again, I get only the 2 warnings.

Perfect, thanks Ondrej.

> Ondrej Mosnacek <omosnace at redhat dot com>

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

