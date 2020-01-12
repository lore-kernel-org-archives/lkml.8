Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F0BC33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66C32084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 02:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="anEzNSbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgALCFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 21:05:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41599 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbgALCFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 21:05:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so2395663plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 18:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vVeJPhpkTW4yoCOsTaOhTcxfQjQBu5G74B3l9bZMFMY=;
        b=anEzNSbEnQBay+Vjd3y92ZSHSIKRhPQssY42FpCL2w+EcIq3wcwsgGiFPuT/C3v3md
         ivWcHVs3W8fCJBXpDZLmH7mbWREwY09Ul7/gQTPGWcddyWjrPVAHpFTy48z8TnLB53oO
         tF7UFtkeOIpSXc5zxKD6sVI1MjhKe0qyV6Wgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVeJPhpkTW4yoCOsTaOhTcxfQjQBu5G74B3l9bZMFMY=;
        b=VvkxB653QoNcD84eszRR1baEPm5UFIOoOkfceINoX93HiknqQdSqX0SlFJOgfafEwc
         GlbTzGFIkYdIb/R4zLWmodScpAYvi/f6siI5lElt4eu9pXSytUHIy9aX+MKeQlYqaGbx
         pxaZ7FmMAXrDgS8nwPIaRSc3ganiM/sIeUdVgrlLELqOQPKeUhtZ6RdJmPCSJ5zdRGaZ
         40y7gJsXN0sKF2QXIv2GdM6EiQeCKtaGazchwVET0CV0s6giNZ5qaR9RPPJRu2v+YMxj
         D7YRkpMESrbib+bdr8BuGq7mE0jeHRKPhih58nrzA8JbhHTBTlyI4TV1jWfNO0figeIH
         QaSg==
X-Gm-Message-State: APjAAAVLLkshiZ0XzRYPMv+iqoQZieSVSpn1Uh/qZ9HklgSGHgrFPhwp
        DCHIKIAW0NNcEbtv98Tn6Qq3nPS9vb8=
X-Google-Smtp-Source: APXvYqzrFSsO9HkV3J1kBkpMW0FISl2QnZJdD5cBr5a/fvz/RjiB7nXVJ6E3Rc9PWlsBli/A7ivIqA==
X-Received: by 2002:a17:902:be0c:: with SMTP id r12mr13811865pls.148.1578794739366;
        Sat, 11 Jan 2020 18:05:39 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d21sm7751435pjs.25.2020.01.11.18.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 18:05:38 -0800 (PST)
Date:   Sat, 11 Jan 2020 21:05:37 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Message-ID: <20200112020537.GJ128013@google.com>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
 <20191221035541.69fc05613351b8dabd6e1a44@kernel.org>
 <20200107211535.233e7ff396f867ee1348178b@kernel.org>
 <20200110211438.GE128013@google.com>
 <20200111083507.c32b85b1d47aa69928de530b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111083507.c32b85b1d47aa69928de530b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 08:35:07AM +0900, Masami Hiramatsu wrote:
> Hi Joel and Paul,
> 
> On Fri, 10 Jan 2020 16:14:38 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Tue, Jan 07, 2020 at 09:15:35PM +0900, Masami Hiramatsu wrote:
> > > Hello,
> > > 
> > > Anyone have any comment on this series?
> > > Without this series, I still see the suspicious RCU warning for kprobe on -tip tree.
> > 
> > +Paul since RCU.
> > 
> > Hi Masami,
> > 
> > I believe I had commented before that I don't agree with this patch:
> > https://lore.kernel.org/lkml/157535318870.16485.6366477974356032624.stgit@devnote2/
> > 
> > The rationale you used is to replace RCU-api with non-RCU api just to avoid
> > warnings. I think a better approach is to use RCU api and pass the optional
> > expression to silence the false-positive warnings by informing the RCU API
> > about the fact that locks are held (similar to what we do for
> > rcu_dereference_protected()). The RCU API will do additional checking
> > (such as making sure preemption is disabled for safe RCU usage etc) as well.
> 
> Yes, that is what I did in [1/2] for get_kprobe().
> Let me clarify the RCU list usage in [2/2].
> 
> With the careful check, other list traversals never be done in non-sleepable
> context, those are always runs with kprobe_mutex held.
> If I correctly understand the Documentation/RCU/listRCU.rst, we should/can use
> non-RCU api for those cases, or do I miss something?

Yes, that is fine. However personally I prefer not to mix usage of
list_for_each_entry_rcu() and list_for_each_entry() on the same pointer
(kprobe_table). I think it is more confusing and error prone. Just use
list_for_each_entry_rcu() everywhere and pass the appropriate lockdep
expression, instead of calling lockdep_assert_held() independently. Is this
not doable?

thanks,

 - Joel

> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
