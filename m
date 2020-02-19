Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBACC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EA220578
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582132923;
	bh=Yn/+34fvZYH5l3fOZqUmD6Kr2SuPFwwBXj14MLQvIM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZcrDntBK7qxbfro/++kh/uEPILs+kRGPLLSSZ+RTXLuxMHSf6IlfG6T1/xBDCeyD/
	 7cHaA7NyFObKzdvZy2oIJPrILq8ZO5+ZTfgx+LZZXtWSkHlvu/1KEN76Ud3iopaLqW
	 RbLTbsQWDKzASXy0DL4umnUamsUitUo5mlFxFZLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSRWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSRWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:22:02 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589F24681
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132921;
        bh=Yn/+34fvZYH5l3fOZqUmD6Kr2SuPFwwBXj14MLQvIM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JtJtTo8o0HAJsOZIdAMmqcvG/sAz9Ul5OsGboMOA0G+WddDrzl+XprSfsoneDg/85
         TiHp1clAwU/AiBK3Fs4wUTh0Pog/C6lUOAVPsls+/p1Z07LLIEPLS2ltb46M7nFRop
         ZAYDxkltDJswLXJXLadLMLAqrRBe1uE6lmGejnr0=
Received: by mail-wm1-f41.google.com with SMTP id a5so1556846wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:22:01 -0800 (PST)
X-Gm-Message-State: APjAAAU7hMDTrLkG0F6Wb4WuSFJGZnrQTiPX3tSk4gsaLnCd0YB/Tt5O
        obdr2OKIyw+vjZ79fgJYCTh6lbMuyhQ1DK9kNeHONA==
X-Google-Smtp-Source: APXvYqxaMCnOp9eEFB/pgZJKHCYo9pXwEVYibCsXO5wpOBypeyOO1/bfgd2YRs5gxUOPj25rw/PfQIj/zksmb0elXus=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr11329215wml.138.1582132919822;
 Wed, 19 Feb 2020 09:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
In-Reply-To: <20200219171309.GC32346@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Feb 2020 09:21:48 -0800
X-Gmail-Original-Message-ID: <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
Message-ID: <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> > Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
>
> x86/mce: ...
>
> > It is an abomination; and in prepration of removing the whole
> > ist_enter() thing, it needs to go.
> >
> > Convert #MC over to using task_work_add() instead; it will run the
> > same code slightly later, on the return to user path of the same
> > exception.
>
> That's fine because the error happened in userspace.

Unless there is a signal pending and the signal setup code is about to
hit the same failed memory.  I suppose we can just treat cases like
this as "oh well, time to kill the whole system".

But we should genuinely agree that we're okay with deferring this handling.
