Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B013CC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEB720777
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585157730;
	bh=uoqoCTnzrI1QvRiPoGYOHLfI25++lyJvjrMQ4QB/UTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nbcCNU+jp56Mg0T7a8h1ibKzGeQaQo03VaYvQ7z6R9NbOHZ475QpJT/KsBVTr4evn
	 rfKmjIWK8SZGaNWZHZNBf+d7TjEOgGcWLNqcoakDQe6k0SUKjQxYko7eATO3oi8T3+
	 +X9hALZIkTCDFOq28En4U9Kr8WfXSMV4pIaKQQx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgCYRf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYRf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:35:29 -0400
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0CA20740;
        Wed, 25 Mar 2020 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585157728;
        bh=uoqoCTnzrI1QvRiPoGYOHLfI25++lyJvjrMQ4QB/UTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpFspdu5nq1sGD8h5Ph531tuDJOEzmeuHg2VBJLfG6Gsbd5Dz9ZH4tGJY1cdD2WnE
         +tOmSNrA8X67i/nCyaICUtIf/e/beNuVl6SGS29e3o2LeXLuYWLBNB+zyyBqXSD5/k
         f8cwagp8KdMs1YkI2vwTniIyWfMOLR3HxeRjtEV4=
Date:   Wed, 25 Mar 2020 18:35:22 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 03/17] module: Properly propagate
 MODULE_STATE_COMING failure
Message-ID: <20200325173519.GA5415@linux-8ccs>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.445253190@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200324142245.445253190@infradead.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [24/03/20 14:56 +0100]:
>Now that notifiers got unbroken; use the proper interface to handle
>notifier errors and propagate them.
>
>There were already MODULE_STATE_COMING notifiers that failed; notably:
>
> - jump_label_module_notifier()
> - tracepoint_module_notify()
> - bpf_event_notify()
>
>By propagating this error, we fix those users.
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>Cc: jeyu@kernel.org
>---
> kernel/module.c |   10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3751,9 +3751,13 @@ static int prepare_coming_module(struct
> 	if (err)
> 		return err;
>
>-	blocking_notifier_call_chain(&module_notify_list,
>-				     MODULE_STATE_COMING, mod);
>-	return 0;
>+	err = blocking_notifier_call_chain_robust(&module_notify_list,
>+			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
>+	err = notifier_to_errno(err);
>+	if (err)
>+		klp_module_going(mod);
>+
>+	return err;
> }
>
> static int unknown_module_param_cb(char *param, char *val, const char *modname,
>

This looks fine to me - klp_module_going() is only called after
successful klp_module_coming(), and klp_module_going() is fine with
mod->state still being MODULE_STATE_COMING here. Would be good to have
livepatch folks double check. Which reminds me - Miroslav had pointed
out in the past that if there is an error when calling the COMING
notifiers, the GOING notifiers will be called while the mod->state is
still MODULE_STATE_COMING. I've briefly looked through all the module
notifiers and it looks like nobody is looking at mod->state directly
at least.

Acked-by: Jessica Yu <jeyu@kernel.org>
