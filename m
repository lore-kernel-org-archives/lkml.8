Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B92246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582896196;
	bh=/xfaJMoeMDPFtvDaD6zvshgBCk2MToM3z6YB0J1XM6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e4QZrF2jZHnUbbgmuk/Th6HMSNJMn3MwNLbK72OOuX00V+02NJHDTI3KWr2DLnGMV
	 xMJugdzT1y1mEngym6FCS0FZRtbypkgY6uUseciBLhq1Kz3wieoIeGBBIvOUDOcCyV
	 7xp1t4o2hUR0QJKxzb8nlWQeYGmbmtRyMQA4c5ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1NXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1NXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:23:15 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552DC2469D;
        Fri, 28 Feb 2020 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896195;
        bh=/xfaJMoeMDPFtvDaD6zvshgBCk2MToM3z6YB0J1XM6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wUVgji7WOyczOtZlOltRQm/c7ah9cFPS6gN9u6p9VC9BlGbdKhavlPFqh9Ia8D2Ux
         1PMqjFTDjibH5oakjj6y+2efFfr+n2pWS8KH9W5mHqUwg+OMQeUre1/Hz1E3bGUy1I
         08CJRfcTDdkPP9gTBWOsUDfqRq/ymtjtVuAdO9OY=
Date:   Fri, 28 Feb 2020 22:23:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [v2 0/1] Documentation: bootconfig: Documentation updates
Message-Id: <20200228222311.f5b9448027031b16a3be372a@kernel.org>
In-Reply-To: <957cef56-04b0-3889-6c95-a8ed7606b68d@web.de>
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
        <957cef56-04b0-3889-6c95-a8ed7606b68d@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 10:00:55 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > I decided to drop EBNF (extended Backus–Naur form) patch
> > since the ISO/IEC 14977 EBNF seems not carefully defined
> 
> Significant efforts happened also for this standard.
> Does its revision refer still to the year 1996?
> 

Didn't you read the article I shared? I actually wrote up the EBNF
(ISO/IEC 14977) that was a good pazzle, but just a toy. I found
no one use it to define their data format, according to the
article, including ISO itself (lol!) and there are many local
extension, including W3C EBNF, and those say "I'm EBNF".
Well, to say the least, I feel it is quite confused.

So, if you are interested in it, I don't stop you to write it up.
I just keep away from it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

