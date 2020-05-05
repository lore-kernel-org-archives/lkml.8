Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA8C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003A62068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgEEWOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:14:49 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:49857 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:14:48 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A7F6F200003;
        Tue,  5 May 2020 22:14:46 +0000 (UTC)
Date:   Wed, 6 May 2020 00:14:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        Per =?iso-8859-1?Q?N=F8rgaard?= Christensen 
        <per.christensen@prevas.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: battery switch-over detection on pcf2127
Message-ID: <20200505221446.GX34497@piout.net>
References: <a0ed6b56-33b1-b5ab-00d1-268fcd61b754@prevas.dk>
 <20200505200744.GV34497@piout.net>
 <CAH+2xPB7LJSxsr1vYhc=u+Qweu6_-S5oEQETUVZSVu1ATW=BYw@mail.gmail.com>
 <62944a2d-f593-5a98-34be-f1f86ac6111c@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62944a2d-f593-5a98-34be-f1f86ac6111c@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 23:01:19+0200, Rasmus Villemoes wrote:
> Thanks for the quick replies, both. Unfortunately, being able to read BF
> from linux is not relevant to us - all the handling happens early in the
> bootloader (including clearing BF, so that we can detect that the
> previous boot failed only because of power fail - hence whether the
> linux driver clears BF or not is not relevant). We really just want
> linux to not touch the bits in CTRL3 at all.
> 

Well, in that case, Linux doesn't touch the BF bit anymore unless
userspace uses the ioctls so you should be ok using it from your
bootloader.

> Hm, wait. Re-reading the above suggests that BF can get set even if BTSE
> is not, and a quick experiment shows that is true - I must have misread
> the data sheet. While I think that's fine for now (currently I only
> print the time of last switch-over as a diagnostic), I did have some use
> case in mind for comparing that timestamp to the current time and make
> decisions based on that. But until I figure out exactly what I want to
> use it for, and until we actually upgrade to 5.4+, there's no rush.
> 

Configuring the timestamps is something else I want to do but I still
didn't finish to design the proper interface.

It is definitively on the todo list.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
