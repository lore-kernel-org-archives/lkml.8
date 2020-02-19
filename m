Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C7C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C645F24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582079207;
	bh=h4h/IaaS7snfCo9r+Z4eK9kYpfUuZjgQ5x/0ifJFzrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TYsL9FwsEpB0G4wSAmvwZbzQZInib3idVsHOKYyUY08CWW/sZRPgyjCzVAP2gJV50
	 2l4Sf18KUHGdUe25YCJKuzIBZJBfBdH7+WFzQcs2XaAFm8abspPHJNwrmaxIgI0U5w
	 hC+POm31juCsWYSNg8yLf0/tjkQsY7+pQ/Hn0zxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBSC0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgBSC0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:26:46 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A0E2176D;
        Wed, 19 Feb 2020 02:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582079205;
        bh=h4h/IaaS7snfCo9r+Z4eK9kYpfUuZjgQ5x/0ifJFzrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gUV/7JSal0sfxF+4K3jFWVRgRRX7WgZ65MojRNNzqlnWYCAG3HNObcn7oN++ewAns
         pBdslAfzZMo4969mLfGuF+tnZJRoG/7R68GPE9/OZOSlVSQ+5NEWFT1IBgyDFxb5Qb
         qUD1y5eNqoxtE9U8fwei9gvgODy9N+ZFKDlLkr0I=
Date:   Wed, 19 Feb 2020 11:26:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200219112641.11ab27dbba172a371829160d@kernel.org>
In-Reply-To: <20200218125748.5085929c@gandalf.local.home>
References: <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
        <20200208000648.3383f991fee68af5ee229d65@kernel.org>
        <20200210112512.GA29627@zn.tnic>
        <20200211001007.62290c743e049b231bdd7052@kernel.org>
        <20200210174053.GD29627@zn.tnic>
        <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
        <20200218132724.GC14449@zn.tnic>
        <20200218125748.5085929c@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 12:57:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Feb 2020 14:27:24 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > Btw, if you remove the boot config with the tool (-d) and still boot
> > with "bootconfig" it says:
> > 
> > [    0.043958] bootconfig size -23483140 greater than max size 32767
> 
> I was aware of this but after you reported this, I don't like it.

Yeah, it should be avoided.

> 
> Masami,
> 
> Can you add code to insert "magic" text at the start of the bootconfig
> appended to the initrd file? Perhaps just have "BOOTCONFIG", and then
> if it's not there we warn "bootconfig on command line but not found in
> the initrd". I'm starting to not like relying on the size and checksum
> only to determine if the bootconfig exists. We need to get this patch
> before 5.6 is released.

OK, that's a good idea. I also considering to add support bootconfig
chain-loading support (allowing user to append several bootconfigs to
initrd), for making bootloaders to support bootconfig easier. That
will need a magic code too.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
