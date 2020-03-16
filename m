Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E838C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434B520663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipb6E7Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgCPQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:30:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53835 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731950AbgCPQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584376208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ol3uttBRJ37x7dv7ttuM2uxzIa+QLAkpS77LLTrAwcI=;
        b=ipb6E7LoulaV2yxQwHCv/Vv8Nt+Jlp1gx0khc/lGvdKuWVgrA+wCPJbvUrVIXgER5RsBVc
        c8LbZArjYXyo5mlOHHs0AkXMyNCwAi+bAAIQ6DINZKTvZToOfXkZX4EbW5t+TmVsOAwCW0
        jb6VUmbwMpeX1PVQyp7B9RMBRV9eadU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Lvl71snpP2mM_I4z-vqjGA-1; Mon, 16 Mar 2020 12:21:53 -0400
X-MC-Unique: Lvl71snpP2mM_I4z-vqjGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC1378DF792;
        Mon, 16 Mar 2020 16:21:51 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1EB19C58;
        Mon, 16 Mar 2020 16:21:50 +0000 (UTC)
Date:   Mon, 16 Mar 2020 11:21:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200316162147.xufxhddz5ztqq5q3@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
 <20200315180320.cgy2ealklbjlx4g7@treble>
 <20200316132419.GF12521@hirez.programming.kicks-ass.net>
 <20200316161904.zouwkwup6vwsmxgp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316161904.zouwkwup6vwsmxgp@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:19:07AM -0500, Josh Poimboeuf wrote:
> > And I was hoping to get vmlinux.o objtool clean, surprisingly there
> > really aren't that many complaints. But the -i thing makes it run
> > significantly faster without duplicating all the bits we've already
> > checked.
> 
> My suggestion is that the "-i" option would be hard-coded (for now).  So
> nothing extra would get checked.

If that wasn't clear, I mean that for vmlinux.o we'd only do the
instr-checking.  For individual .o's we'd do everything else.

-- 
Josh

