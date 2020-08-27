Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DFE22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tYxmWHhG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cXh3H2oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgH0ScS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:32:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56100 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgH0ScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:32:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8CC8F8EE119;
        Thu, 27 Aug 2020 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1598553137;
        bh=eYZG2X+x0TFOwkl/HfsO2QFElq5sw75da5er1mYDlEk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tYxmWHhG6BAEQiVHMsCA7B2s4KWYhSBJS1oWfItmzIQLOWBsVQse0G4OT3cVs6T4O
         DqE0r6/loHrd2IijFOhzddlBQ9TBYlBtfrbbbI8j0rujrR7qMB33/PrZGhDzogvoep
         4KVbZyEi2kjZksnEVDP9PCnGs6H4ipvpcaWZ/Idk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xBWXnSaZook7; Thu, 27 Aug 2020 11:32:16 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C3DCA8EE105;
        Thu, 27 Aug 2020 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1598553136;
        bh=eYZG2X+x0TFOwkl/HfsO2QFElq5sw75da5er1mYDlEk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cXh3H2oyT7bN/UGPe185OteeIg7+ouZnly4zeMUGWHD/AHs4oO/+n2bPTyJEVotJZ
         MdLqByWn6pGXGmR7qkvjewNNysamaLQrAp4C7DW653RsskkjIpVhhm1/jQgO3t0YO2
         nv2ZwDABXSqitRrB5TBz4+JQ5GJNIMtKYCj4injc=
Message-ID: <1598553133.4237.8.camel@HansenPartnership.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Allen Pais <allen.lkml@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Date:   Thu, 27 Aug 2020 11:32:13 -0700
In-Reply-To: <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
         <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 11:04 -0700, Linus Torvalds wrote:
> On Wed, Aug 26, 2020 at 6:36 PM Allen Pais <allen.lkml@gmail.com>
> wrote:
> > 
> > Introduce container_from() as a generic helper instead of
> > sub-systems defining a private from_
> 
> NAK.
> 
> This seems completely broken.
> 
> The documentation comment doesn't even match the macro, and claims
> that "container" is a type.
> 
> Which it isn't. That's what container_of()" already takes.
> 
> And if the argument is that a broken commit introduced a broken
> macro,
> then that's not a great argument. Yes, we have that broken
> "from_tasklet()" macro, but it's not even *USED* anywhere.
> 
> So instead of adding a broken new concept that adds absolutely no
> value, let's just remove the broken macro that isn't even used.

The argument is more over the tasklet rework adding from_tasklet that
was effectively completely generic.

https://lore.kernel.org/dri-devel/20200817091617.28119-1-allen.cryptic@gmail.com/

The tasklet rework people don't want to use container_of, which was our
first suggestion, because it produces lines which are "too long".  So
container_from is a compromise that takes the actual structure pointer
as a second argument instead of the structure type, thus being
completely generic and suitable for line length reduction in the
tasklet rework code.

James

