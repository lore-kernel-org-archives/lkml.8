Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A5E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7bDos5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416308AbgDOQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:54:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1416286AbgDOQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586969626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OcF7TWn34i9EQblMYEKpClfav9C/6cS7BZfVRtY1ig=;
        b=Y7bDos5wO2M4VbCFu32z2ZPVL4HIN8IM0T1ibBJQkfB9YY4DfImcNeCmktGxXWuqQaBjOl
        WJRunKnP9dGn9Q2z1nogc1BQ/60wL+ZaLIQpUyCUZlu8oslXNlS5hW2LgVXF0QJ1RFfQ+Y
        T56MX/bCUbpQs7fSw2nO5oFeRMUWy0Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-mpjXo2FdOpWDLE7xQgcAIA-1; Wed, 15 Apr 2020 12:53:45 -0400
X-MC-Unique: mpjXo2FdOpWDLE7xQgcAIA-1
Received: by mail-ot1-f70.google.com with SMTP id f3so381386otf.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OcF7TWn34i9EQblMYEKpClfav9C/6cS7BZfVRtY1ig=;
        b=Poz7eM77gJHDEeNZb1ttqMRrZQbWty3ZM2LvA5yg/LfC3XN7co05FmbjtiA7n/esj+
         aiXWh375GXL9/BPkU3rQefaB6EOJ6dlitPWc/A2Z6SOPWtKafGSNGBqSApqFSGnduFqK
         H1MPNwXNyixvjPzMo654Y0Pwu+H3aGwb+WG8goRGCn9B+0q98XAaDmT8JwBaxPHcfRV3
         n1mWuKX4VS1HX3gRGscNMX7OH0QoDDuBEOEYXUZsVqJcOFomXqleqsesXrKKLNfgsDoH
         Na+L0DfK1jFaACH26MeWpNzRp9PnPH9XFrx+9v4bcfbNnA1TfVnytDUwfgdJTWLEQKYm
         LuuQ==
X-Gm-Message-State: AGi0PuZrSRr+C2HZscJkrrvae5zq9qc+43Z1h36XkmM6KxD/2iQlERH2
        AiqpdfnJHFkXUtKZtGnNa1WSJ2RqvcyzVH7I/kStA7vpgFwNJrTZunQxCiiEnfxIKVyxIOSEDji
        JICIxP12UkInJGWXAYh/8eIOzMkeGz7zhX10cddWM
X-Received: by 2002:aca:b104:: with SMTP id a4mr98038oif.103.1586969623612;
        Wed, 15 Apr 2020 09:53:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLkvY6tKCCKHK+4XBaEZP1jLaOUmd+3Gz8TobGRm5I4yu2oGVOna4Zb5zyid5UxSIVu1Z9+oaZs2SxeDRP40G8=
X-Received: by 2002:aca:b104:: with SMTP id a4mr98019oif.103.1586969623350;
 Wed, 15 Apr 2020 09:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191128153203.GA23803@workstation-kernel-dev>
 <20191130020742.GF157739@google.com> <20200415153417.svpbimg66vbeuk7u@madcap2.tricolour.ca>
 <CAHC9VhTdfkxdiEwCZu-JCQGxJ_DNr0b_Ukm40VEUxq=Lc-zx1g@mail.gmail.com> <20200415161503.umujm6v4gadmf6qm@madcap2.tricolour.ca>
In-Reply-To: <20200415161503.umujm6v4gadmf6qm@madcap2.tricolour.ca>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 15 Apr 2020 18:53:32 +0200
Message-ID: <CAFqZXNuYnvru+pMhPwNTBn1+uB=MfYh1yWWBeAn+J-=LXrFgcg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Amol Grover <frextrite@gmail.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 6:15 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-04-15 12:06, Paul Moore wrote:
> > On Wed, Apr 15, 2020 at 11:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2019-11-29 21:07, Joel Fernandes wrote:
> > > > On Thu, Nov 28, 2019 at 09:02:03PM +0530, Amol Grover wrote:
> > > > > add __rcu notation to RCU protected global pointer auditd_conn
> > > >
> > > > Again, please use proper punctuation and captilization. This is unacceptable.
> > > > Please put more effort into changelog.
> > > >
> > > > Otherwise the patch diff itself looks good to me, with the above nit
> > > > corrected, you could add my tag to the next revision:
> > > >
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > thanks,
> > > >
> > > >  - Joel
> > > >
> > > > >
> > > > > Fixes multiple instances of sparse error:
> > > > > error: incompatible types in comparison expression
> > > > > (different address spaces)
> > >
> > > Amol or Joel: Is there a reproducer recipe for this?
> >
> > The commit which was merged has a slightly better description which may help.
>
> I've already seen this.  Perhaps I should have replied to this message
> instead to make that evident.  What really needed was Amol's original
> message sent to this list, but it was Joel who included this list in his
> reply (all 3 versions).
>
> I'm looking for the specific setup and commands that produced this error.

You can run make with "C=1", which will run sparse on all files that
are rebuilt during that make run. For example, if I fully build the
kernel and then revert commit
cb5172d96d16df72db8b55146b0ec00bfd97f079, I get:

$ make [...] C=1
[...]
  CHECK   [...]/kernel/audit.c
[...]/kernel/audit.c:218:14: error: incompatible types in comparison
expression (different address spaces):
[...]/kernel/audit.c:218:14:    struct auditd_connection [noderef] <asn:4> *
[...]/kernel/audit.c:218:14:    struct auditd_connection *
(...and a lot more errors like this + 2 different warnings)

And when I un-revert it again, I get only the 2 warnings.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

