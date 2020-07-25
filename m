Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC43C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B288620674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGYFGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:06:38 -0400
Received: from omta015.useast.a.cloudfilter.net ([34.195.253.206]:33642 "EHLO
        omta015.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgGYFGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:06:37 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jul 2020 01:06:37 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.148])
        by cmsmtp with ESMTP
        id zCAvj635BxItlzCHRj4ffd; Sat, 25 Jul 2020 04:59:29 +0000
Received: from ws ([68.106.48.162])
        by cmsmtp with ESMTPSA
        id zCHCjSjHrxMRGzCHEjMZC8; Sat, 25 Jul 2020 04:59:29 +0000
Authentication-Results: cox.net; auth=pass (LOGIN)
 smtp.auth=1i5t5.duncan@cox.net
X-Authority-Analysis: v=2.4 cv=CvABzl0D c=1 sm=1 tr=0 ts=5f1bbc31
 a=fEuF7Lzz1MGHEe1xFtqdOg==:117 a=fEuF7Lzz1MGHEe1xFtqdOg==:17
 a=kj9zAlcOel0A:10 a=sfOm8-O8AAAA:8 a=VwQbUJbxAAAA:8 a=9Cd_nbZdC8ucnf_FNXIA:9
 a=CjuIK1q_8ugA:10 a=TvTJqdcANYtsRzA46cdi:22 a=AjGcO6oz07-iQ99wixmX:22
Date:   Fri, 24 Jul 2020 21:59:14 -0700
From:   Duncan <1i5t5.duncan@cox.net>
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sunpeng.li@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        mphantomx@yahoo.com.br, regressions@leemhuis.info,
        anthony.ruhier@gmail.com
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <20200724215914.6297cc7e@ws>
In-Reply-To: <_vGVoFJcOuoIAvGYtkyemUvqEFeZ-AdO4Jk8wsyVv3MwO-6NEVtULxnZzuBJNeHNkCsQ5Kxn5TPQ_VJ6qyj9wXXXX8v-hc3HptnCAu0UYsk=@protonmail.com>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
        <202007231524.A24720C@keescook>
        <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
        <202007241016.922B094AAA@keescook>
        <3c92db94-3b62-a70b-8ace-f5e34e8f268f@molgen.mpg.de>
        <_vGVoFJcOuoIAvGYtkyemUvqEFeZ-AdO4Jk8wsyVv3MwO-6NEVtULxnZzuBJNeHNkCsQ5Kxn5TPQ_VJ6qyj9wXXXX8v-hc3HptnCAu0UYsk=@protonmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMOyWF+lgqFhfod06LAwUnkRPRHDXxXCpYb5boN5EhzZB7C7s44DLE44/O5KjX7Jrld57OdZsMN5bIRCnIXZjnwbaT4/ieJNTKG7VLmU8it+Hst31XoT
 hZ9bzjc0FIHbORAf+Ch0ibr55N6DFIWQ9/fET++K3Xse8DwqrzeOFjIilHM9aSTr8Dnd6PjzZBhkcNpDhcy7zjrqf9iy2wfp1aKzagNUtSJafY5dPEaCiTPi
 ahBHqR2wiOkrrOWh8FmzosjjXtR+HlEk1h7nJpMBiJUieGLjgxy7AoIiy2Fly7H2a2SCv4Gp6z9+2MQGidm3uSV+FMgPHOdQr1gyYw9EmY5Pc+oM3lEbWOSv
 MMsr2KKH1udWcb+RWyetv+xtYn930s6dGHeLj/+6l9qgU9lNqKegJYnOlFgaXSkieomKhJbGxmzOqrVGDWDN50dKYpLjMvhk73fvqlerFd0oOzEUsxKBXrov
 LFRLmK3pWdIv2jWHWBYQb3eIwGiAPZw///TwAcGhoArrQ+fQZlcPNgvCnpeh/3GiWv81ngAKBbfZ6lUyXvr4JLBO7bQeJsc6MRIZ/lOHbJp/hJj3+MTgGPAq
 NBVfUnmq216vL5rvNmR/U03gjp8erofgyVAOqW3yYEklX4DfPqROhBmP6EAfXCR/BZHEMxxxBkYqDzVifke0beKTNZe0rjICCuYnqsTrPyzZ2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 03:03:52 +0000
Mazin Rezk <mnrzk@protonmail.com> wrote:

> > Am 24.07.20 um 19:33 schrieb Kees Cook:
> >  
> > > There was a fix to disable the async path for this driver that
> > > worked around the bug too, yes? That seems like a safer and more
> > > focused change that doesn't revert the SLUB defense for all
> > > users, and would actually provide a complete, I think, workaround
> 
> That said, I haven't seen the async disabling patch. If you could
> link to it, I'd be glad to test it out and perhaps we can use that
> instead.

I'm confused.  Not to put words in Kees' mouth; /I/ am confused (which
admittedly could well be just because I make no claims to be a
coder and am simply reading the bug and thread, but I'd appreciate some
"unconfusing" anyway).

My interpretation of the "async disabling" reference was that it was to
comment #30 on the bug:

https://bugzilla.kernel.org/show_bug.cgi?id=207383#c30

... which (if I'm not confused on this point too) appears to be yours.
There it was stated...

>>>>
I've also found that this bug exclusively occurs when commit_work is on
the workqueue. After forcing drm_atomic_helper_commit to run all of the
commits without adding to the workqueue and running the OS, the issue
seems to have disappeared.
<<<<

Would not forcing all commits to run directly, without placing them on
the workqueue, be "async disabling"?  That's what I /thought/ he was
referencing.

OTOH your base/context swap idea sounds like a possibly "less
disturbance" workaround, if it works, and given the point in the
commit cycle... (But if it's out Sunday it's likely too late to test
and get it in now anyway; if it's another week, tho...)

-- 
Duncan - No HTML messages please; they are filtered as spam.
"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
