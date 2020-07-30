Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E179E2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq0uPZJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgG3PFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:05:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728352AbgG3PFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596121545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOQ9FSQfUiXWjfWTA7IgBgxS2I+Nkr/Qn9lmVPgPvoA=;
        b=Lq0uPZJdu8sSKE8klf/TLd8IWXbwEaF52KLZ+xL9s+exE5ONY8e9QTbSGjpSMxPXxBA2U0
        PenbkHy2aTS8qS+iT8RL1FegyUO0YdzntDcP/LqibTd7zucKm065U1PZYsbzmIuTxBG+pt
        aN8Xc+mO/LfzyV/b09y4Rkl53hRnUjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-_BVvCz09Pde4s1Hzp6HbEA-1; Thu, 30 Jul 2020 11:05:43 -0400
X-MC-Unique: _BVvCz09Pde4s1Hzp6HbEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5EF13E5;
        Thu, 30 Jul 2020 15:05:42 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 403021975F;
        Thu, 30 Jul 2020 15:05:42 +0000 (UTC)
Date:   Thu, 30 Jul 2020 10:05:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: Re: [PATCH v3 0/4] Remove dependency of check subcmd upon orc
Message-ID: <20200730150540.75lm5p5kqdncxpsg@treble>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730140623.5aw7lm57j7qof5pm@treble>
 <f63f8472-8b05-7457-f9ea-2a9f34e5d486@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f63f8472-8b05-7457-f9ea-2a9f34e5d486@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:42:09PM +0100, Julien Thierry wrote:
> 
> 
> On 7/30/20 3:06 PM, Josh Poimboeuf wrote:
> > On Thu, Jul 30, 2020 at 10:41:39AM +0100, Julien Thierry wrote:
> > > Hi,
> > > 
> > > Matt Helsley's change[1] provided a base framework to opt-in/out
> > > objtool subcommands at compile time. This makes it easier for
> > > architectures to port objtool, one subcommand at a time.
> > > 
> > > Orc generation relies on the check operation implementation. However,
> > > the way this is done causes the check implementation to depend on the
> > > implementation of orc generation functions to call if orc generation is
> > > requested. This means that in order to implement check subcmd, orc
> > > subcmd also need to be implemented.
> > > 
> > > These patches aim at removing that dependency, having orc subcmd
> > > being built on top of the check subcmd.
> > > 
> > > 
> > > Changes since v2 [2]:
> > > - Rebased on recent tip/objtool/core
> > 
> > tip/objtool/core is slightly outdated, I got a conflict with patch 1.
> > 
> > I guess linus/master would be best.
> 
> It looks like linus/master is missing the rela -> reloc rework that is
> present in tip/objtool/core, which will conflict with other patches from
> this series.
> 
> How shall I proceed?

Hm.  I guess we'll need guidance from Peter, he's the branch wrangler.
Maybe tip/objtool/core needs to be rebased onto linus/master.

-- 
Josh

