Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B5C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D4022CF6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgGSIlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 04:41:37 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:34376 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSIlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 04:41:37 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id ED607BC065;
        Sun, 19 Jul 2020 08:41:33 +0000 (UTC)
Subject: Re: [PATCH] m68k: Replace HTTP links with HTTPS ones
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     geert@linux-m68k.org, funaho@jurai.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20200717184240.79799-1-grandmaster@al2klimov.de>
 <alpine.LNX.2.23.453.2007181258320.92@nippy.intranet>
 <d4c73203-56ed-820f-82ee-c239d7976d33@al2klimov.de>
 <alpine.LNX.2.23.453.2007191659150.8@nippy.intranet>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <98c2eed7-8d3e-a542-84af-492cf3efc313@al2klimov.de>
Date:   Sun, 19 Jul 2020 10:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2007191659150.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 19.07.20 um 09:51 schrieb Finn Thain:
> On Sat, 18 Jul 2020, Alexander A. Klimov wrote:
> 
>> *Sigh* ... yes, doing everything one nice day is better that doing just
>> something right now.
> 
> I wasn't saying "do everything possible or else do nothing". I was trying
> to point to the larger problem. The http links in the kernel source hardly
> seem to matter when nothing I read on HTTPS links is trustworthy.
> 
>> But doing just something right now is better that doing nothing at all.
>>
> 
> HTTPS is not new. MITM attack is as old as the Byzantian hills. Your
> rationale for doing "something right now" is apparently that you trust the
> people who maintain "kernel developers" browsers but mistrust the people
> who maintain some network links and switches. That's fine and you should
> set your policy accordingly. But you should not be surprised if others
> have different threat models -- especially when you fail to offer an
> actual case where this patch might have helped.
> 
Really, I'm not interested in debates on principles here.

Just tell me either of these:

* You'll apply these changes of mine as-is
* You won't apply these changes of mine at all
* I shall undo particular changes (which ones?) and/or change the commit 
message (how?) before you apply the others

Thx.
