Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BE4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288E120748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjiyS6se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCZN42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:56:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53697 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbgCZN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585230987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXv3fMoVKY2zuGHET+HIX0s7UbodBDHLQThNOb8pISg=;
        b=IjiyS6sevBJ1Oe73lBaMfAMzWtdrOThiMuFeK4OvXmVCATFFuiC/C6nrRMn1r2ev88bXIc
        8ZB31BUSvIBFwnhQGz9AJPTfWWDS29txrm8tH+XuPnL7yxG/9pNXNM7zJMhND36ioMyqld
        ZrrEjWu/1bTzfLMKVB7STUkqSV/n8D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-cpyZBhleMH20OQhTkwuzoQ-1; Thu, 26 Mar 2020 09:56:25 -0400
X-MC-Unique: cpyZBhleMH20OQhTkwuzoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD9AB189F764;
        Thu, 26 Mar 2020 13:56:23 +0000 (UTC)
Received: from treble (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DFD25C1B0;
        Thu, 26 Mar 2020 13:56:22 +0000 (UTC)
Date:   Thu, 26 Mar 2020 08:56:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326135620.tlmof5fa7p5wct62@treble>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326113049.GD20696@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:30:49PM +0100, Peter Zijlstra wrote:
> This isn't ideal either; stuffing code with NOPs just to make
> annotations work is certainly sub-optimal, but given that sync_core()
> is stupid expensive in any case, one extra nop isn't going to be a
> problem here.

/me puts his hardened objtool maintainer's glasses on...

The problem is, when you do this kind of change to somebody else's code
-- like adding a NOP to driver code -- there's a 90% chance they'll NACK
it and tell you to fix your shit.  Because they'll be happy to tell you
the code itself should never be changed just to "make objtool happy".

And honestly, they'd be right, and there's not much you can say in
reply.  And then we end up having to fix it in objtool again anyway.

The 'insn == first' check isn't ideal, but at least it works (I think?).

Maybe there's some cleaner approach.  I'll need to think about it later
after I make some progress on the massive oil well fire I call my INBOX.

-- 
Josh

