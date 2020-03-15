Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE0C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C750320658
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0W1Gukm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgCOSNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:13:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728999AbgCOSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584295987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeCdt5T97Lygr8UsrQjU/t+rBPrs1AekBhk6md4r860=;
        b=f0W1GukmH3oayPiaV6E/+gdlAwmi2fm5sP11pWAkK1A3cVkOS0IdVVHkhWDLyZXiec1SKt
        Xks3xU+H43gpcmGtody5zr+xbPp2zXmYKIT/ECfRQ+T4DaJ/t1AutmrJvIiWNmgDKTjPxZ
        OgxsWonslYWBNQK+X8FObAzON2nnt2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-V72OHWnHOc6691grriGfug-1; Sun, 15 Mar 2020 14:13:00 -0400
X-MC-Unique: V72OHWnHOc6691grriGfug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42312189D6C0;
        Sun, 15 Mar 2020 18:12:59 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F5EA385;
        Sun, 15 Mar 2020 18:12:58 +0000 (UTC)
Date:   Sun, 15 Mar 2020 13:12:56 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-ID: <20200315181256.dwj6izb7mdb3v7bq@treble>
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312134107.700205216@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:07PM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> These patches extend objtool to be able to run on vmlinux.o and validate
> Thomas's proposed noinstr annotation:
> 
>   https://lkml.kernel.org/r/20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org
> 
>  "That's why we want the sections and the annotation. If something calls
>   out of a noinstr section into a regular text section and the call is not
>   annotated at the call site, then objtool can complain and tell you. What
>   Peter and I came up with looks like this:
> 
>   noinstr foo()
> 	do_protected(); <- Safe because in the noinstr section
> 	instr_begin();  <- Marks the begin of a safe region, ignored
> 			   by objtool
> 	do_stuff();     <- All good
> 	instr_end();    <- End of the safe region. objtool starts
> 			   looking again
> 	do_other_stuff();  <- Unsafe because do_other_stuff() is
> 			      not protected
> 
>   and:
> 
>   noinstr do_protected()
> 	bar();          <- objtool will complain here
>   "
> 
> It should be accompanied by something like the below; which you'll find in a
> series by Thomas.

Awesome work!

This is also a big step towards other eventual objtool features, like
LTO compatibility.

I did have a few concerns about the overall "noinstr" implementation,
mentioned in my reply to patch 15.

Other than that, and the minor comments I sent, the code looks great.

-- 
Josh

