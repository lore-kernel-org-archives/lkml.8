Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04CA20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAgofQIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgICQNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:13:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47569 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728830AbgICQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599149579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jb6az/wiJ7iQDSTih1JXhdvoZ61BGF79Va40zCSQyzA=;
        b=ZAgofQIpm89lpbuUTRZr3QjMZhvWV81ABMMQxmwmsI+SlcvAHcpxOzHAJCllb3j3OufcNr
        v021jPd2BEQUvmEHA8K0c5SQT2vhi7B0feT6M9l2oxsDW1y+Si89Q+4SDtjjQd8sPEtTiD
        sr/WcM6ASlNJvwUGvu7ki05no1y2hOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-vX8ldPkDOVm1ZQ9ioxF1lw-1; Thu, 03 Sep 2020 12:12:54 -0400
X-MC-Unique: vX8ldPkDOVm1ZQ9ioxF1lw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A5480B702;
        Thu,  3 Sep 2020 16:12:52 +0000 (UTC)
Received: from treble (ovpn-117-249.rdu2.redhat.com [10.10.117.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 067215C1C2;
        Thu,  3 Sep 2020 16:12:47 +0000 (UTC)
Date:   Thu, 3 Sep 2020 11:12:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 02/13] x86/debug: Allow a single level of #DB recursion
Message-ID: <20200903161245.dp56m3p3oimgppcf@treble>
References: <20200902132549.496605622@infradead.org>
 <20200902133200.726584153@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902133200.726584153@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:25:51PM +0200, Peter Zijlstra wrote:
> @@ -863,6 +849,18 @@ static void handle_debug(struct pt_regs
>  static __always_inline void exc_debug_kernel(struct pt_regs *regs,
>  					     unsigned long dr6)
>  {
> +	/*
> +	 * Disable breakpoints during exception handling; recursive exceptions
> +	 * are exceedingly 'fun'.
> +	 *
> +	 * Since this function is NOKPROBE, and that also applies to
> +	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
> +	 * HW_BREAKPOINT_W on our stack)
> +	 *
> +	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
> +	 * includes the entry stack is excluded for everything.
> +	 */

I know this comment was copy/pasted, but I had to stare at the last
paragraph like one of those 3D paintings they used to have at the mall.

Recommended rewording:

	 * HW_BREAKPOINT_X is disallowed for entry text; all breakpoints
	 * are disallowed for cpu_entry_area (which includes the entry
	 * stack).

-- 
Josh

