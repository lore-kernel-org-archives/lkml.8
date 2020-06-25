Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB75C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125E82076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406047AbgFYVY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403817AbgFYVY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:24:28 -0400
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Jun 2020 14:24:27 PDT
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 120EAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:24:26 -0700 (PDT)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 05PLGAuu015400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 25 Jun 2020 21:16:17 GMT
Date:   Thu, 25 Jun 2020 21:16:10 +0000 (UTC)
From:   Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To:     Kees Cook <keescook@chromium.org>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        klibc@lists.zytor.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] process '/usr/bin/rsync' started with executable stack
In-Reply-To: <202006251253.2893D4F67@keescook>
Message-ID: <Pine.BSM.4.64L.2006252115450.4838@herc.mirbsd.org>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam> <202006241238.E9CB1CE85B@keescook>
 <20200625100429.GB2571@kadam> <202006251253.2893D4F67@keescook>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook dixit:

>3) fix the use of trampolines in klibc

AIUI done in klibc, but post-2.0.7

bye,
//mirabilos
-- 
FWIW, I'm quite impressed with mksh interactively. I thought it was much
*much* more bare bones. But it turns out it beats the living hell out of
ksh93 in that respect. I'd even consider it for my daily use if I hadn't
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mksh
