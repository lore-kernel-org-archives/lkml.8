Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD2C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbtS2S4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410244AbgDOQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:15:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24191 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410307AbgDOQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586967324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9AiOSf2Ndp9zP+cv9L50OpP/JFrww4WbmeVKZKeKQk=;
        b=gbtS2S4owyoWxYpsT9vjU+A8UHaMyjM5arF/uBdFuXe71L7bDQRGh/KRxn/+322ahVQaIp
        2cISBLKLJGam2bb1Rco5TgpYclsIsQQh15N2M889/GFYdt7D6omCOBkVeIMN/hto3qwII8
        t9I2N1LWEg3sg7c9MTNb4TUYyQDyQQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-HVLJSW-cNR2Y5uo-GPBh_A-1; Wed, 15 Apr 2020 12:15:20 -0400
X-MC-Unique: HVLJSW-cNR2Y5uo-GPBh_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 982DB13F6;
        Wed, 15 Apr 2020 16:15:18 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8D0119F56;
        Wed, 15 Apr 2020 16:15:06 +0000 (UTC)
Date:   Wed, 15 Apr 2020 12:15:03 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-audit@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20200415161503.umujm6v4gadmf6qm@madcap2.tricolour.ca>
References: <20191128153203.GA23803@workstation-kernel-dev>
 <20191130020742.GF157739@google.com>
 <20200415153417.svpbimg66vbeuk7u@madcap2.tricolour.ca>
 <CAHC9VhTdfkxdiEwCZu-JCQGxJ_DNr0b_Ukm40VEUxq=Lc-zx1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTdfkxdiEwCZu-JCQGxJ_DNr0b_Ukm40VEUxq=Lc-zx1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-15 12:06, Paul Moore wrote:
> On Wed, Apr 15, 2020 at 11:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-11-29 21:07, Joel Fernandes wrote:
> > > On Thu, Nov 28, 2019 at 09:02:03PM +0530, Amol Grover wrote:
> > > > add __rcu notation to RCU protected global pointer auditd_conn
> > >
> > > Again, please use proper punctuation and captilization. This is unacceptable.
> > > Please put more effort into changelog.
> > >
> > > Otherwise the patch diff itself looks good to me, with the above nit
> > > corrected, you could add my tag to the next revision:
> > >
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > thanks,
> > >
> > >  - Joel
> > >
> > > >
> > > > Fixes multiple instances of sparse error:
> > > > error: incompatible types in comparison expression
> > > > (different address spaces)
> >
> > Amol or Joel: Is there a reproducer recipe for this?
> 
> The commit which was merged has a slightly better description which may help.

I've already seen this.  Perhaps I should have replied to this message
instead to make that evident.  What really needed was Amol's original
message sent to this list, but it was Joel who included this list in his
reply (all 3 versions).

I'm looking for the specific setup and commands that produced this error.

>   commit cb5172d96d16df72db8b55146b0ec00bfd97f079
>   Author: Amol Grover <frextrite@gmail.com>
>   Date:   Mon Dec 2 00:03:48 2019 +0530
> 
>    audit: Add __rcu annotation to RCU pointer
> 
>    Add __rcu annotation to RCU-protected global pointer auditd_conn.
> 
>    auditd_conn is an RCU-protected global pointer,i.e., accessed
>    via RCU methods rcu_dereference() and rcu_assign_pointer(),
>    hence it must be annotated with __rcu for sparse to report
>    warnings/errors correctly.
> 
>    Fix multiple instances of the sparse error:
>    error: incompatible types in comparison expression
>    (different address spaces)
> 
>    Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>    Signed-off-by: Amol Grover <frextrite@gmail.com>
>    [PM: tweak subject line]
>    Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> -- 
> paul moore
> www.paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

