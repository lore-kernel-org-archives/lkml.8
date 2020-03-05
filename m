Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E52C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96521739
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583404375;
	bh=sr30sqa4SuM2XE80uZeHb0R8Wbi8yOclxBaVYaYJwn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ecjD7wBtxTB4H5sIvqdLuz/MRBWfL8n+0+ROQ6vOcxmwUuh/FmLuqF/TTPpjqyDPU
	 TmYlmCJfzknZSi+2SRmgUus8cUD9pxriTpy+AbXIXfqXZrw3n7nCuY581P7EYjmF/6
	 the0uWVNlakJSzy51f+n6WCagGtTj3SY5S3ZmzLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgCEKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCEKcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:32:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC4F2073D;
        Thu,  5 Mar 2020 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583404373;
        bh=sr30sqa4SuM2XE80uZeHb0R8Wbi8yOclxBaVYaYJwn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JdKxasopQqSxschhodSYnvdN8iO9+f6N5a72gnc4p4TfzFl8BDmuvun1BESUVOELF
         bLNbifmeXRR33qwpXBWnwfc5nZ1zOUEwkoabuHarWiFi+f2GRYpC8/k0/NGWKIt9i2
         3omCdgs/mbrHYoFavUhLpmsOOPfqkNuiu2ooXpyE=
Date:   Thu, 5 Mar 2020 19:32:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v5] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200305193249.4c5f993bb52e5874cd2df627@kernel.org>
In-Reply-To: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
References: <158339065180.26602.26457588086834858.stgit@devnote2>
        <158339066140.26602.7533299987467005089.stgit@devnote2>
        <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 23:01:21 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/4/20 10:44 PM, Masami Hiramatsu wrote:
> > Update boot configuration documentation.
> > 
> >  - Not using "config" abbreviation but configuration or description.
> >  - Rewrite descriptions of node and its maxinum number.
> >  - Add a section of use cases of boot configuration.
> >  - Move how to use bootconfig to earlier section.
> >  - Fix some typos, indents and format mistakes.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Hi Masami,
> 
> I swear that I am not trying to cause another version...

Oh, no problem. I'll go along with your reviews.

> 
> > ---
> > Changes in v5:
> >  - Elaborate the document.
> >  - Fix some typos.
> > Changes in v4:
> >  - Remove O= option from examples.
> > Changes in v3:
> >  - Specify that comments also count in size.
> >  - Fix a confusing sentence.
> >  - Add O=<builddir> to make command.
> > Changes in v2:
> >  - Fixes additional typos (Thanks Markus and Randy!)
> >  - Change a section title to "Tree Structured Key".
> > ---
> >  Documentation/admin-guide/bootconfig.rst |  201 +++++++++++++++++++-----------
> >  Documentation/trace/boottime-trace.rst   |    2 
> >  2 files changed, 131 insertions(+), 72 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > index cf2edcd09183..3bfc9ddf68e1 100644
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -11,25 +11,106 @@ Boot Configuration
> 
> > +When to Use the Boot Configuration?
> > +-----------------------------------
> > +
> > +The boot configuration supports kernel command line options and init daemon
> > +boot options. All sub-keys under "kernel" root key are passed as a part of
> > +the kernel command line [1]_, and ones under "init" root key are passed as
> > +a part of the init daemon's command line. For example, ::
> > +
> > +   root=UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82 ro quiet splash console=ttyS0,115200n8 console=tty0
> > +
> > +This can be written as following boot configuration file.::
> > +
> > +   kernel {
> > +      root = "UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82" # nvme0n1p3
> > +      ro       # mount rootfs as read only
> > +      quiet    # No console log
> > +      splash   # show splash image on boot screen
> > +      console = "ttyS0,115200n8" # 1st console to serial device
> > +      console += tty0            # add 2nd console
> > +   }
> > +
> > +If you think that kernel/init options becomes too long to write in boot-loader
> 
>                                          become

OK.

> 
> > +configuration file or you want to comment on each option, the boot
> > +configuration may be suitable. If unsure, you can still continue to use the
> > +legacy kernel command line.
> 
> 
> > +Boot Configuration Syntax
> > +=========================
> > +
> > +The boot configuration syntax is a simple structured key-value. Each key
> > +consists of dot-connected-words, and key and value are connected by ``=``.
> > +The value has to be terminated by semicolon (``;``) or newline (``\n``).
> > +For an array, its entries are separated by comma (``,``). ::
> > +
> > +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> >  
> >  Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
> >  
> >  Each key word must contain only alphabets, numbers, dash (``-``) or underscore
> >  (``_``). And each value only contains printable characters or spaces except
> > -for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
> > +for delimiters such as semicolon (``;``), new-line (``\n``), comma (``,``),
> 
>             usually called:                  newline

Yeah, I wonder why I have written so...

> 
> >  hash (``#``) and closing brace (``}``).
> >  
> >  If you want to use those delimiters in a value, you can use either double-
> 
> 
> >  Comments
> >  --------
> >  
> > -The config syntax accepts shell-script style comments. The comments starting
> > -with hash ("#") until newline ("\n") will be ignored.
> > -
> > -::
> > +The boot configuration accepts shell-script style comments. The comments,
> > +beginning with hash (``#``) continues until newline (``\n``), will be
> 
>                                and continuing until newline

OK.

> 
> > +skipped.::
> >  
> >   # comment line
> >   foo = value # value is set to foo.
> 
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
