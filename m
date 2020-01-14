Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC498C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920BB2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANQ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:57:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57072 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726195AbgANQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:57:56 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00EGvdbn022943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 11:57:40 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0B01E4207DF; Tue, 14 Jan 2020 11:57:39 -0500 (EST)
Date:   Tue, 14 Jan 2020 11:57:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: linux-next: Signed-off-by missing for commit in the random tree
Message-ID: <20200114165739.GB140865@mit.edu>
References: <20200108113953.1a92a90f@canb.auug.org.au>
 <20200114001832.GP76141@mit.edu>
 <20200114012221.GC202391@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114012221.GC202391@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:22:21AM +0900, Sergey Senozhatsky wrote:
> 
> Oh, I didn't realize I was the author. Sorry!
> 
> Sure, confirmed
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
>

Hmm... the e-mail in question[1] was sent by Qian Cai, but there was a

   From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

in the first line of the body which attributed the patch to you.  But
then e-mail continues:

   Sergey didn't like the locking order .... but those code is so old,
   and I have no clue how to de-couple it after checking other locks in
   the splat. There is an onging effort to make all printk() as deferred,
   so until that happens, workaround it for now as a short-term fix.

So did Qian Cai author the patch, and this should have been
"Reported-by Sergey Senozhatsky"?  In which case I need a
Signed-off-by from Qian Cai.

This is a pretty trivial patch, but it would be good to get the
attributions and credit correct!

						- Ted

[1] https://lore.kernel.org/linux-arm-kernel/1573679785-21068-1-git-send-email-cai@lca.pw/
