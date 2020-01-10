Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D896C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE3820842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YuCDXCY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgAJVOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:14:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42062 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgAJVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:14:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so1301295plk.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8bMlx3yVEv9zU0xDUT4JoQBf57pH4Aos3r9DWeX5bE=;
        b=YuCDXCY3hwa94AhsKBLyqdk6tp3fytvqMdvAlpRsi6RJMkk9dNCg58HHy+dJ6+1gj6
         4unrTP+4SPLWeLQJ6GdkHa/gKUHvXn/P4Exn0feaUcF/g9+e+6f02O2eKAdX00yj769x
         Y1kL5H08/Pk3mIqz+u3XLv5z4jIaIOFTqJKEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8bMlx3yVEv9zU0xDUT4JoQBf57pH4Aos3r9DWeX5bE=;
        b=VaJbplVCmMHFk6kyKZSPCFlS7XrVbH/lz5HrY575wNodSCLPrEX/GaH/dBVet0C7ni
         bLtDHUGYVZRsygdJpfvVr9xtRk9yFgnnqIfETgSjMn0cI2l2Pa02PWC74pI+1mKPofFU
         Ixggv/N7sD/UcF7QWssRfjtTw6d23gsIybZh2MtAXBWZWihccNMxW/w61sdg1R8VZSVT
         +/tzgjLAXnoZ/h4yOfLIDkcOFGbscmF30E2vV6otQAlNcPGjrxwzJr9CT52OHu6twG3R
         g/FgR326Brj+ifRIAgAYIwTlDiFLs+LVeeUAXsnxxD893hi9rpNw5T6o2ZFZXsYw9KoO
         0SVA==
X-Gm-Message-State: APjAAAV+yFEW3s9zXB762x4rSSiyYlzQ2d1QCZDZKXOvkha2HuXMpjs4
        ESd1y6P5Rn5rlLwv5vpeknZMng==
X-Google-Smtp-Source: APXvYqz/a2Sdedi3w+S100lUd7qvHi2cJ+hY7ny0vJsjzaBggSk70mhFVXKNpf47Zcovay05fqnB0Q==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr529932plo.339.1578690879634;
        Fri, 10 Jan 2020 13:14:39 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r7sm4278287pfg.34.2020.01.10.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:14:39 -0800 (PST)
Date:   Fri, 10 Jan 2020 16:14:38 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Message-ID: <20200110211438.GE128013@google.com>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
 <20191221035541.69fc05613351b8dabd6e1a44@kernel.org>
 <20200107211535.233e7ff396f867ee1348178b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107211535.233e7ff396f867ee1348178b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:15:35PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> Anyone have any comment on this series?
> Without this series, I still see the suspicious RCU warning for kprobe on -tip tree.

+Paul since RCU.

Hi Masami,

I believe I had commented before that I don't agree with this patch:
https://lore.kernel.org/lkml/157535318870.16485.6366477974356032624.stgit@devnote2/

The rationale you used is to replace RCU-api with non-RCU api just to avoid
warnings. I think a better approach is to use RCU api and pass the optional
expression to silence the false-positive warnings by informing the RCU API
about the fact that locks are held (similar to what we do for
rcu_dereference_protected()). The RCU API will do additional checking
(such as making sure preemption is disabled for safe RCU usage etc) as well.

Could you repost the latest versions?

thanks,

 - Joel


> 
> Thank you,
> 
> On Sat, 21 Dec 2019 03:55:41 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Ingo,
> > 
> > Could you pick this series to fix the false-positive RCU-list warnings?
> > 
> > Thank you,
> > 
> > On Tue,  3 Dec 2019 15:06:06 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > Here is a couple of patches which fix suspicious RCU
> > > usage warnings in kprobes.
> > > 
> > > Anders reported the first warning in kprobe smoke test
> > > with CONFIG_PROVE_RCU_LIST=y. While fixing this issue,
> > > I found similar issues and cleanups in kprobes.
> > > 
> > > Thank you,
> > > 
> > > ---
> > > 
> > > Masami Hiramatsu (2):
> > >       kprobes: Suppress the suspicious RCU warning on kprobes
> > >       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
> > > 
> > > 
> > >  kernel/kprobes.c |   32 ++++++++++++++++++++++----------
> > >  1 file changed, 22 insertions(+), 10 deletions(-)
> > > 
> > > --
> > > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
