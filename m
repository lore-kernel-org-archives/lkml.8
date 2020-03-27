Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F0DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8452E2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0MEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:35368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgC0MEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3F8FAE2B;
        Fri, 27 Mar 2020 12:04:45 +0000 (UTC)
Date:   Fri, 27 Mar 2020 13:04:44 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 03/17] module: Properly propagate MODULE_STATE_COMING
 failure
In-Reply-To: <20200325173519.GA5415@linux-8ccs>
Message-ID: <alpine.LSU.2.21.2003271257560.19979@pobox.suse.cz>
References: <20200324135603.483964896@infradead.org> <20200324142245.445253190@infradead.org> <20200325173519.GA5415@linux-8ccs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Jessica Yu wrote:

> +++ Peter Zijlstra [24/03/20 14:56 +0100]:
> >Now that notifiers got unbroken; use the proper interface to handle
> >notifier errors and propagate them.
> >
> >There were already MODULE_STATE_COMING notifiers that failed; notably:
> >
> > - jump_label_module_notifier()
> > - tracepoint_module_notify()
> > - bpf_event_notify()
> >
> >By propagating this error, we fix those users.
> >
> >Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >Cc: jeyu@kernel.org
> >---
> > kernel/module.c |   10 +++++++---
> > 1 file changed, 7 insertions(+), 3 deletions(-)
> >
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -3751,9 +3751,13 @@ static int prepare_coming_module(struct
> >  if (err)
> >   return err;
> >
> >-	blocking_notifier_call_chain(&module_notify_list,
> >-				     MODULE_STATE_COMING, mod);
> >-	return 0;
> >+	err = blocking_notifier_call_chain_robust(&module_notify_list,
> >+			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
> >+	err = notifier_to_errno(err);
> >+	if (err)
> >+		klp_module_going(mod);
> >+
> >+	return err;
> > }
> >
> > static int unknown_module_param_cb(char *param, char *val, const char
> > *modname,
> >
> 
> This looks fine to me - klp_module_going() is only called after
> successful klp_module_coming(), and klp_module_going() is fine with
> mod->state still being MODULE_STATE_COMING here. Would be good to have
> livepatch folks double check.

Yes, it is ok.

> Which reminds me - Miroslav had pointed
> out in the past that if there is an error when calling the COMING
> notifiers, the GOING notifiers will be called while the mod->state is
> still MODULE_STATE_COMING. I've briefly looked through all the module
> notifiers and it looks like nobody is looking at mod->state directly
> at least.

Thanks for double-checking. I triple-checked and yes, it should be fine. 
All module notifiers check the value from the function parameter and not 
mod->state directly.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
