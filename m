Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D722C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C542166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583306310;
	bh=0rCt2r9mfFhBAcVs16psgL7w47RyVgyV5F8qh9nI3BY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VMeivvDMUnHlY8EYkkpIgJTx54EQ7nh/7/D2haYg2gWOq61w+x4s2UNINglMjNNdt
	 oDj7a9zc+jtgji1pkRvQjlYMlHEphxDhKipsgyalGsG9RJX2+wMVj5K3zFjd2ddzMF
	 +4FLi3AakEkno7vBetJwDB8WYRJqkAn0aksx9WJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgCDHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgCDHS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:18:28 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26B9214D8;
        Wed,  4 Mar 2020 07:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583306308;
        bh=0rCt2r9mfFhBAcVs16psgL7w47RyVgyV5F8qh9nI3BY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=khXHERl7dtPVEfszlXXkRxwv3T3rq01nfX8KdtTPSu/MLWVTVLcq3jrlxBZc1zWcE
         YSCLJCEt42KVGCItM6CQBuJvzz6VwKEYWYJkz2j6owxEMTFyVxFTPqkT/Z5+oCiHXY
         s7w4mthSOFdYtasvVa1CPRwNKdXt9KNZYv0zoOWQ=
Date:   Wed, 4 Mar 2020 16:18:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V4 3/4] kprobes: Fix to protect
 kick_kprobe_optimizer() by kprobe_mutex
Message-Id: <20200304161823.afe5ed2b47029e55531329ea@kernel.org>
In-Reply-To: <20200303185236.23db2ebc@gandalf.local.home>
References: <158270755997.18966.3544449431956918068.stgit@devnote2>
        <158270759113.18966.8938334321921933993.stgit@devnote2>
        <20200303185236.23db2ebc@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 18:52:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Feb 2020 17:59:51 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > In kprobe_optimizer() kick_kprobe_optimizer() is called
> > without kprobe_mutex, but this can race with other caller
> > which is protected by kprobe_mutex.
> > 
> > To fix that, expand kprobe_mutex protected area to protect
> > kick_kprobe_optimizer() call.
> > 
> 
> Should we add
> 
>  Cc: stable@vger.kernel.org
>  Fixes: cd7ebe2298ff ("kprobes: Use text_poke_smp_batch for optimizing")
> 
> tags?

Good catch! Yes, it is correct commit to be fixed.

Thank you!

> 
> -- Steve
> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 38d9a5d7c8a4..6d76a6e3e1a5 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -592,11 +592,12 @@ static void kprobe_optimizer(struct work_struct *work)
> >  	mutex_unlock(&module_mutex);
> >  	mutex_unlock(&text_mutex);
> >  	cpus_read_unlock();
> > -	mutex_unlock(&kprobe_mutex);
> >  
> >  	/* Step 5: Kick optimizer again if needed */
> >  	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
> >  		kick_kprobe_optimizer();
> > +
> > +	mutex_unlock(&kprobe_mutex);
> >  }
> >  
> >  /* Wait for completing optimization and unoptimization */
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
