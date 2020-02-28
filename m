Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F25BC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0435A246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582868141;
	bh=N3NjPRzUoSycjVekZ9YJ5FEUvU7t598vWu1DoHOvfp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vwgpAOnu6jBoyZc2eGbi/9w3woxtPYq84Hj6HrgGjSWKBKp/MExLSQ5L+cFunQCVw
	 7nT+uy3XbN89CoIXd7GE3S4PLIVRcn6J/zWqmAgKibUjZ6YUQl1iYEH/EVvifa29oz
	 iKeuAhF3U1zoyNYlpgghrgnOk1D8rR8LVyzhmUgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgB1Ffe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgB1Ffd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:35:33 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3558D246A0;
        Fri, 28 Feb 2020 05:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582868132;
        bh=N3NjPRzUoSycjVekZ9YJ5FEUvU7t598vWu1DoHOvfp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z0iAn1fXvV2LrfcaiS49w/EshL+0Rwx6GDoDY7xlkuwpmtT2APdNJGdLf6sND45p4
         po89FOaZ3sjNLsXpO0stR2M3cYsVIsVOpO2DEoEH/wDYbxiBAQfbXVsHwiuDY7H2ep
         DBu6YzcZVKkU9wh8wVzMMcl+NPZ1TiugBJAEa25Q=
Date:   Fri, 28 Feb 2020 14:35:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: bootconfig: Update boot
 configuration documentation
Message-Id: <20200228143528.209db45e5f0f78474ef83387@kernel.org>
In-Reply-To: <8514c830-319b-33e9-025a-79d399674fb3@web.de>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
        <158278835238.14966.16157216423901327777.stgit@devnote2>
        <8514c830-319b-33e9-025a-79d399674fb3@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 20:12:17 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > +This allows administrators to pass a structured-Key configuration file
> 
> Does capitalisation matter here for the word “Key”?

Oops, thanks! that's a typo of key.

> > +If you think that kernel/init options becomes too long to write in boot-loader
> > +configuration file or want to comment on each options, you can use this
> 
> Can the following wording variant be a bit nicer?
> 
> +… or you want to comment on each option, …

OK, since the previous sentence is too long, it is more readable to put the
subject there.

> > +Also, some subsystem may depend on the boot configuration, and it has own
> > +root key.
> 
> Would you like to explain the influence of a key hierarchy any further?

Please read the example (boot time tracer) carefully :)

> > +The boot configuration syntax allows user to merge partially same word keys
> >  by brace. For example::
> 
> “by braces.
> For example::”?

I think current one is shorter and compact.

> > +The file /proc/bootconfig is a user-space interface to the configuration
> 
> “… is an user-…”?

Hm, it seems "a user" is correct wording.
https://www.quora.com/Which-is-the-correct-usage-a-user-or-an-user

> > +Currently the maximum configuration size is 32 KiB and the total number
> > +of key-words and values must be under 1024 nodes.
> 
> * How were these constraints chosen?
> 
> * Can such system limits become more configurable?

No.

> > +(Note: Each key consists of words separated by dot, and value also consists
> > +of values separated by comma. Here, each word and each value is generally
> > +called a "node".)
> 
> I would prefer the interpretation that nodes contain corresponding attributes.

No. Node is a node. It is merely generic.

> 
> How do you think about to add a link to a formal file format description?

Oh, nice idea. Please contribute it :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
