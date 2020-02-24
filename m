Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F72C11D29
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475B2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waifu.club header.i=@waifu.club header.b="luBUxXAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBXIAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:00:01 -0500
Received: from mx1.cock.li ([185.10.68.5]:48559 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbgBXIAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:00:01 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=waifu.club; s=mail;
        t=1582531198; bh=+RYp5w7nTvZrdCFnc7G5TlYKlGNP7JgXLabNqYMThng=;
        h=Date:From:To:Subject:From;
        b=luBUxXAie0zOY/hc7JOox59dYOXrLNLnv5vznSY1akLcUIwrRe9Hm6DboM1FoxARC
         XJifxcX1yoflrMLbRG3qBdCQBrwYPtfVoLCG6jx4O/E3TIPt6VV5PUhkHEczf4IwYo
         surtfTSPpD0fkjd/hTAtg69Aq7So38PlmVXk9OQMyrnMvT+tOsQwqTjU9DBRKg+Nrl
         2lmdfhfNU9YdS2fxlQ/xjIjPdJJbQ8XhIN1UG0Uf+IUmwN8kweul089SANC27hkjAn
         qQH8/8Z1OjLGhQr+WWnjqF5d8AezVzcXfj4Byo4HKZ0eH1CMFCioWL3xadCKuNtlrt
         ZGdv8Rjaehy5A==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Feb 2020 07:59:58 +0000
From:   whywontyousue@waifu.club
To:     linux-kernel@vger.kernel.org
Subject: LKRG: "there won't be a grsecurity alike situation where everything
 gets closed down".  (Linux Kernel Runtime Guard)
Message-ID: <b91eda4a1a5184e11c9c11161fc7ea51@waifu.club>
X-Sender: whywontyousue@waifu.club
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> "there won't be a grsecurity alike situation where everything gets 
> closed down".

(from: www whonix org/wiki/Linux_Kernel_Runtime_Guard_LKRG )

First of all, linux copyright holder: why don't you sue Grsecurity. They 
are violating your copyright license. They proffer additional terms and 
enforce additional restrictions. That's both a violation of section 4 
and section 6 of GPL v2.

Now onto this Linux Kernel Runtime Guard:

>    LKRG performs runtime integrity checking of the Linux kernel and 
> detection of security vulnerability exploits against the kernel.
> 
>    As controversial as this concept is, LKRG attempts to post-detect 
> and hopefully promptly respond to unauthorized modifications to the 
> running Linux kernel (integrity checking) or to credentials such as 
> user IDs of the running processes (exploit detection). For process 
> credentials, LKRG attempts to detect the exploit and take action before 
> the kernel would grant access (such as open a file) based on the 
> unauthorized credentials.
> 
>    LKRG defeats many pre-existing exploits of Linux kernel 
> vulnerabilities, and will likely defeat many future exploits (including 
> of yet unknown vulnerabilities) that do not specifically attempt to 
> bypass LKRG. While LKRG is bypassable by design, such bypasses tend to 
> require more complicated and/or less reliable exploits.


Allright, so it interferes with the running kernel, your copyrighted 
work.

Thus, if we imagine a court would use the same analysis as in Universal 
City Studios Inc v Reimerdes, whatever this is has to abide your 
copyright, just as the app in that case could not modify the running 
RealPlayer without the permission of the copyright owners of RealPlayer.

> We will likely use GPLv2 at least for LKRG free. We might or might not 
> use a different license for LKRG Pro, if we ever make it.

You don't have a choice in this matter. If RealPlayer cannot be modified 
when running except as directed by it's copyright owners, by another 
entity's program; neither can Linux kernel. You have to obey the 
copyright owners permissions here.

Now: will the linux copyright owners ever sue you if you ignore their 
terms? Lol, comon, let's be reasonable. They fall into two camps 1) 
scared little wageslaves, and 2) some corporations that feel the GPL is 
too restrictive.

Nothing to worry about: the wageslaves have shown themselves to be 
worthless people with no fight in them.
