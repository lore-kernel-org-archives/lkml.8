Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66F9C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9720702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582382515;
	bh=eKrjDcVPFGldXTKBfSEfT7EC9knttzmH0OoM9Oc5WtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uDqnUnp2vo1WlMdQf+hlaRhC+h/BZNESI4dW7QTOTx7NDiNDBYQD2dBFQlvWgqFqG
	 9HNLECWhIC+TXGqAxQXFEVa2Ka4JlBM+QxDmjgTFPB/wthkTKQ5El7Zx0ccSOiyz9A
	 G6zX3lUi+S9pqNQxQjAGuvv8tPee8GX/HIQw61ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgBVOlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 09:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbgBVOlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 09:41:52 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C332C20684;
        Sat, 22 Feb 2020 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582382512;
        bh=eKrjDcVPFGldXTKBfSEfT7EC9knttzmH0OoM9Oc5WtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hIqzfF6CKTPJQ+mjDtf8H4SHad6PWQO5TLRw5r8xInUl7Cv7f/1TYzl5kJ776CdcQ
         jr4/Ejw0T3B+Mjke5mqW4Q7GyLc8b9mg04ILmRxcOtme0yo2+qVPf2BvDOXSJDax08
         31tWeHtr9onWovsK58H8fLv4ySYsAm6dkTtFiyVA=
Date:   Sat, 22 Feb 2020 23:41:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/2] bootconfig: Prohibit re-defining value on same
 key
Message-Id: <20200222234147.7525a2d527ebbf53f06b5734@kernel.org>
In-Reply-To: <CAMuHMdURcRPXo7Q-2E7bS7X9w73NvYP8ffdJeNk37wdQgVxThw@mail.gmail.com>
References: <158227281198.12842.8478910651170568606.stgit@devnote2>
        <158227282199.12842.10110929876059658601.stgit@devnote2>
        <536c681d-a546-bb51-a6cb-2d39ed726716@infradead.org>
        <CAMuHMdURcRPXo7Q-2E7bS7X9w73NvYP8ffdJeNk37wdQgVxThw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 10:31:17 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Randy,
> 
> On Sat, Feb 22, 2020 at 5:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 2/21/20 12:13 AM, Masami Hiramatsu wrote:
> > > --- a/Documentation/admin-guide/bootconfig.rst
> > > +++ b/Documentation/admin-guide/bootconfig.rst
> > > @@ -62,7 +62,16 @@ Or more shorter, written as following::
> > >  In both styles, same key words are automatically merged when parsing it
> > >  at boot time. So you can append similar trees or key-values.
> > >
> > > -Note that a sub-key and a value can not co-exist under a parent key.
> > > +Same-key Values
> > > +---------------
> > > +
> > > +It is prohibited that two or more values or arraies share a same-key.
> >
> > I think (?):                                   arrays
> >
> > > +For example,::
> > > +
> > > + foo = bar, baz
> > > + foo = qux  # !ERROR! we can not re-define same key
> > > +
> > > +Also, a sub-key and a value can not co-exist under a parent key.
> > >  For example, following config is NOT allowed.::
> > >
> > >   foo = value1
> >
> >
> > I'm pretty sure that the kernel command line allows someone to use
> >   key=value1 ... key=value2
> > and the first setting is just overwritten with value2 (for most "key"s).
> >
> > Am I wrong?  and is this patch saying that bootconfig won't operate like that?
> 
> I think so. Both are retained.
> A typical example is "console=ttyS0 console=tty", to have the kernel output
> on both the serial and the graphical console.

Right, it actually depends on how the option is defined and its handler.
If the option is defined with module_param*() macros, those will be 
overwritten.
But if it is defined with __setup() or early_param(), the handler function
will be called repeatedly. Thus, overwrite or append or skip later one
depends on the option handler.

I think the bootconfig is a bit different from legacy command line at
this moment. The legacy command line can be modified by bootloader,
whereas the bootconfig is a single text file which user can update
each value. Of course bootloader will support the bootconfig to append
some key-values in the future.
So I would like to introduce another "overwrite" operator (":=") and
"assign default" operator ("?=") too. With those operators, the
bootloader can just add their own key-value without decoding the
current bootconfig.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
