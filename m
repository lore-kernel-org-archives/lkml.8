Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D57C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A3A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgclrFHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCYQk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:40:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52204 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbgCYQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585154457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inE1lIeTra36wMSLrt0bqLRjIvA4EjTAaoQsY08CUCg=;
        b=DgclrFHiMAWJ2+yWpFdOuxP1nDYGUFzoiFEpvWMBAqRKqU7S8s3elyVPgAaTtQ8SnRe/tT
        W9TJHDOG//d1Q4nTbtCgkAKDKC+CfBlBw361kJkvl1DDc9JthLAt1QcXGGYw2QaE0Lnkgq
        Dm0JD6ylDl5zuvd5iviNpdNABWHVDzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-5TcUci5ON8-5fE3wTcwPfg-1; Wed, 25 Mar 2020 12:40:53 -0400
X-MC-Unique: 5TcUci5ON8-5fE3wTcwPfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F40F800D4E;
        Wed, 25 Mar 2020 16:40:49 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58E3360BE0;
        Wed, 25 Mar 2020 16:40:48 +0000 (UTC)
Date:   Wed, 25 Mar 2020 11:40:46 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
Message-ID: <20200325164046.p2oxemcjnj2tnxbz@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
 <20200324221616.2tdljgyay37aiw2t@treble>
 <20200324223455.GV2452@worktop.programming.kicks-ass.net>
 <20200325144211.irnwnly37fyhapvx@treble>
 <20200325155348.GA20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200325155348.GA20696@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 04:53:48PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 25, 2020 at 09:42:11AM -0500, Josh Poimboeuf wrote:
> > Sure, but couldn't validate_unwind_hints() and
> > validate_reachable_instructions() be changed to *only* run on
> > .noinstr.text, for the vmlinux case?  That might help converge the
> > vmlinux and !vmlinux paths.
> 
> You're thinking something like so then?

Not exactly.  But I don't want to keep churning this patch set.  I can
add more patches later, so don't worry about it.

But I was thinking it would eventually be good to have the top-level
check() be like

	sec = NULL;
	if (!validate_all)
		sec = find_section_by_name(file->elf, ".noinstr.text");

	ret = validate_functions(&file, sec);
	if (ret < 0)
		goto out;
	warnings += ret;

	ret = validate_unwind_hints(&file, sec);
	if (ret < 0)
		goto out;
	warnings += ret;

	if (!warnings) {
		ret = validate_reachable_instructions(&file, sec);
		if (ret < 0)
			goto out;
		warnings += ret;
	}

	if (!validate_all)
		goto out;

	ret = validate_retpoline(&file);
	....

that way the general flow is the same regardless...

-- 
Josh

