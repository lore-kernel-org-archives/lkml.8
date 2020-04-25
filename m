Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22071C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB6C20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4RXn9ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYKNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:13:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgDYKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOgC2NRGVpcSLKpoq1LxQn9rzNcv8PVJhuPPFwFv8h4=;
        b=P4RXn9gePko44R6aZNVbrfgUqUDC+pjWKs6HKW+6KW5P+mBZOBpsxVlyZP4w1SSM5lAkAg
        Z6HVt36rOt/NTsnyBxLm2KwDoPDD26XKpyiHc1Bls6zV4Cmovq5Zdec3PC9LOeOUVmLPb0
        +BiVIRVN2nhS5F8VaryTuPe53Vj1urw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-9cq6eyfXNeWNGJOStwiqDw-1; Sat, 25 Apr 2020 06:12:59 -0400
X-MC-Unique: 9cq6eyfXNeWNGJOStwiqDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF798107ACCA;
        Sat, 25 Apr 2020 10:12:57 +0000 (UTC)
Received: from treble (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF89F5D70C;
        Sat, 25 Apr 2020 10:12:54 +0000 (UTC)
Date:   Sat, 25 Apr 2020 05:12:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 09/11] x86/unwind/orc: Prevent unwinding before ORC
 initialization
Message-ID: <20200425101247.l2xpp23vmmv7zfuv@treble>
References: <cover.1587808742.git.jpoimboe@redhat.com>
 <069d1499ad606d85532eb32ce39b2441679667d5.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <069d1499ad606d85532eb32ce39b2441679667d5.1587808742.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 05:03:08AM -0500, Josh Poimboeuf wrote:
> If the unwinder is called before the ORC data has been initialized,
> orc_find() returns NULL, and it tries to fall back to using frame
> pointers.  This can cause some unexpected warnings during boot.
> 
> Move the 'orc_init' check from orc_find() to __unwind_init(), so that it
> doesn't even try to unwind from an uninitialized state.
> 
> Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>

I got a weird error when sending this one:

  4.7.1 Error: too much mail from 10.10.114.29

If anybody didn't get it, let me know and I can bounce it.

> ---
>  arch/x86/kernel/unwind_orc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index e9f5a20c69c6..cb11567361cc 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -148,9 +148,6 @@ static struct orc_entry *orc_find(unsigned long ip)
>  {
>  	static struct orc_entry *orc;
>  
> -	if (!orc_init)
> -		return NULL;
> -
>  	if (ip == 0)
>  		return &null_orc_entry;
>  
> @@ -591,6 +588,9 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>  		    struct pt_regs *regs, unsigned long *first_frame)
>  {
> +	if (!orc_init)
> +		goto done;
> +
>  	memset(state, 0, sizeof(*state));
>  	state->task = task;
>  
> -- 
> 2.21.1
> 

-- 
Josh

