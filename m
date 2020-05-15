Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91412C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AD9205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN/hLDPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgEOUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:51:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589575903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHPcJo3/hUrokZL+DP7WLakvS6EX9QMKXwY5VRZtidY=;
        b=CN/hLDPVem+NeRmh3E4uw5biXn9uWqf7qVkG7stxEi7WKzETl7zVE1yig2Cl2eDCLwFkPS
        nyh3w8Z8DbZe5/x9LTkyJbbZ0bWNKpUl2gzDPMyAVjkqZO//ucAtZIqq49vxNPudJMU0hw
        FzEoWthv7NCdZ6sQ8Q3IhfNox8SLjEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-ZKC5u3TfPteBbGqUTTJjEQ-1; Fri, 15 May 2020 16:51:39 -0400
X-MC-Unique: ZKC5u3TfPteBbGqUTTJjEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 084C4460;
        Fri, 15 May 2020 20:51:38 +0000 (UTC)
Received: from treble (ovpn-117-151.rdu2.redhat.com [10.10.117.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FAFC5D9C9;
        Fri, 15 May 2020 20:51:37 +0000 (UTC)
Date:   Fri, 15 May 2020 15:51:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200515205135.5pknexlld53oicu5@treble>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <f9eedb02-54fe-fb96-fbcc-5f40f41e571a@redhat.com>
 <20200513155948.GI9040@rlwimi.vmware.com>
 <e369f0a9-30fc-5754-8cff-bf238ab0b716@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e369f0a9-30fc-5754-8cff-bf238ab0b716@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:55:31PM +0100, Julien Thierry wrote:
> > > Since the stuff under arch/missing is only weak symbols to make up for
> > > missing subcmd implementations, can we put everything in a file
> > > subcmd_defaults.c (name up for debate!) that would be always be compiled an
> > > linked. And some SUBCMD_XXX is set to "y", the corresponding object file
> > > gets compiled and overrides the weak symbols from subcmd_defaults.c .
> > 
> > Hmm, I like keeping them separated along similar lines to the other
> > code because it makes it easier to see the intended correspondence and
> > likely will keep the files more readable / smaller. I could
> > just move them out of arch/missing and into missing_check.c and so forth.
> > 
> > What do you think of that?
> > 
> 
> I do prefer that to the introduction of an arch/missing.
> 
> Still, I'm not sure I see much benefit in splitting those small
> implementations in separate files, but it's not a problem either. This seems
> more a matter of taste rather than one approach working better than the
> other. So it's more up to what the maintainer prefer! :)

For now I'd prefer getting rid of the 'missing' arch and just having a
single top-level weak.c which has all the weak functions in it.  Keeps
the clutter down :-)

Down the road, if the number of weak functions got out of hand then we
could look at splitting them up into multiple files.

-- 
Josh

