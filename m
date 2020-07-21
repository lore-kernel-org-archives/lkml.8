Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9129DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF6C20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV31/m4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgGUXFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:05:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726555AbgGUXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595372698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kx0Hqea23204+1Vxqe4zJbIPov8gmWienWErS47JZPw=;
        b=JV31/m4udR6AcIfnthBj1CTr/8aQ1gWb3n1zRh6UcGpjms0CWgr9/2tLLH/lcKp4RCtCTQ
        5e3+8tA4RVepSG7FU5+1Vv67kfq1V5pS6+ojx2y+jgEnqZeHnD8wqoxufLl6RbXv0/Q1tG
        qV2LjxqjA3Lb5o4kWXBFgn6k0lv9KA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-sUelSXFeOdqLma5mtRQ2jw-1; Tue, 21 Jul 2020 19:04:54 -0400
X-MC-Unique: sUelSXFeOdqLma5mtRQ2jw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D3741005510;
        Tue, 21 Jul 2020 23:04:53 +0000 (UTC)
Received: from treble (ovpn-113-106.rdu2.redhat.com [10.10.113.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F279369316;
        Tue, 21 Jul 2020 23:04:49 +0000 (UTC)
Date:   Tue, 21 Jul 2020 18:04:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs/livepatch: Add new compiler considerations doc
Message-ID: <20200721230442.5v6ah7bpjx4puqva@treble>
References: <20200721161407.26806-1-joe.lawrence@redhat.com>
 <20200721161407.26806-2-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200721161407.26806-2-joe.lawrence@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:14:06PM -0400, Joe Lawrence wrote:
> Compiler optimizations can have serious implications on livepatching.
> Create a document that outlines common optimization patterns and safe
> ways to livepatch them.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

There's a lot of good info here, but I wonder if it should be
reorganized a bit and instead called "how to create a livepatch module",
because that's really the point of it all.

I'm thinking a newcomer reading this might be lost.  It's not
necessarily clear that there are currently two completely different
approaches to creating a livepatch module, each with their own quirks
and benefits/drawbacks.  There is one mention of a "source-based
livepatch author" but no explanation of what that means.

Maybe it could begin with an overview of the two approaches, and then
delve more into the details of each approach, and then delve even more
into the gory details about compiler optimizations.

Also the kpatch-build section can reference the patch author guide which
we have on github.

-- 
Josh

