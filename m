Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE2EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B8C2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592273169;
	bh=Gidjz2z413BnEyhZQWUEtTYIY1LtOHmUnhXr+gU3mQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BTRxo3bL9O8uXLam8gyvRsQ8Z4EImEyQmaknACs/DSXVcyI+Cw/a58NZLTlNAcN8B
	 frZtIeAxjwfF6zn2LWt7hCijucmDkCtFA7R3l+Y8/y+XX65mWQfoKwdoriF4YdYXXC
	 0HCL2jTFuA0rDDH808cwa4SbfjvTEZC6E6u/v8LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgFPCGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgFPCGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:06:07 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CFDE2071A;
        Tue, 16 Jun 2020 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592273166;
        bh=Gidjz2z413BnEyhZQWUEtTYIY1LtOHmUnhXr+gU3mQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIXJ9QSTWXOIDT5DKeikMaFmDuKcapcRJd6o2Gq9Gj7RNCD4PHKf11UOPTa0MqmlB
         X9VXuDPd/WT7JY0catw6qiw7eOZ8k+PJ3ymhIBy6qbMZcsE6QC1qYGfjnc6YV5rIty
         ZoiXgWecJakQ2oz1ChwRZCh5Wld6trGBD6kjUvV0=
Date:   Mon, 15 Jun 2020 21:11:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] flexible-array member conversion patches for 5.8-rc2
Message-ID: <20200616021126.GK10051@embeddedor>
References: <20200615203917.GA15876@embeddedor>
 <CAHk-=wiSQV3nxTkQwO55qaLsW9CdkROFqwc1S6RX3PXe8ONPaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSQV3nxTkQwO55qaLsW9CdkROFqwc1S6RX3PXe8ONPaQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:07:28PM -0700, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 1:34 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > flexible-array member conversion patches for 5.8-rc2
> 
> Gaah. I merged this, and even spent some time trying to make the merge
> message look better, and then when I started looking at the end
> result, I ended up unpulling it.
> 
> It's all been recently rebased, which I might be willing to ignore for
> something like this, but all these one-liner patches then come with a
> boiler-plate commit message that is something like 50 lines long and
> is actively misleading as it talks about "this tree-wide patch" and
> just repeats the generic issues that were presented (better) in the
> merge message anyway.
> 
> The individual commit messages literally add nothing specific to that
> commit AT ALL except for the very first line, which is also
> boiler-plate but at least mentions the subsystem.
> 
> End result: when I do "git log" after having merged this, the result
> is basically two *thousand* lines of repeated noise.
> 
> Some repetition is fine. But 2000 lines of repeated boiler-plate makes
> me go "that's actively detrimental to any use of 'git log'" and I
> undid my pull.
> 

Yep, you're right. We made the mistake of not having something to point
people to, from the beginning; which we are trying to fix by adding the
following documentation to deprecated.rst:

https://lore.kernel.org/lkml/20200608213711.GA22271@embeddedor/

That's the reason why the log for these sorts of patches ended up being
so repetitive: as a way to compensate for not having proper documentation
in place from the beginning.

And yes, it was my mistake not to remove part of the log from the changelog
text when I turned the treewide patch into separate per-subsystem patches
--for they to be properly tested by the 0-day CI Kernel Test Service.

I will modify the changelog text of the separate patches and send you the
pull-request once again.

BTW, the commit message is the exact same text we are planning to add to
the deprecated.rst file, which will be used for both zero-length and
one-element array conversions. It might be better to to remove the part
for the one-element arrays, in this case.

Thanks
--
Gustavo
