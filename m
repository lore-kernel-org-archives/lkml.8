Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01262065D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594760045;
	bh=LrI6TvbFj8VaPzxpp5ekzeAMl8autdFdnS/2bB9ZGF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lcqs2nvlL+G/tg13C64MzdAeks5LpWniqU1FPSoHEKCnlZPsrshBXIPms2+JZidJ4
	 H9zGq3JsZgIYlWVu38bJAI5lkyXW5iWnoMdUc1m3utK0UlckEdnnNRG5KEQfFnH4it
	 /rRCwL0fn33B8KjhP8nqChHBWxnkYjFOsjz5PGg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGNUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGNUyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:54:03 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CA220658;
        Tue, 14 Jul 2020 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594760043;
        bh=LrI6TvbFj8VaPzxpp5ekzeAMl8autdFdnS/2bB9ZGF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3+1RnT8+rDhVNw2EQLq8U3lJLOrZp7oVzOLMqPaKBEK9GVdooPlmF++zdcsk1+X1
         ejPQLSrHEcog43UBm0ufElUp7iBgBfPN2WPd/z+mu9ANozuJF/2lkbh7NzC5lb2yuu
         wDiQUxF+13uMOFxohJUKI0OXfaaMqX3v/Q9oUyJ0=
Date:   Tue, 14 Jul 2020 13:54:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Victor Hsieh <victorhsieh@google.com>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Fix TCREATE's fid in protocol
Message-ID: <20200714205401.GE1064009@gmail.com>
References: <20200713215759.3701482-1-victorhsieh@google.com>
 <20200714121249.GA21928@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714121249.GA21928@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:12:49PM +0200, Dominique Martinet wrote:
> 
> > Fixes: 5643135a2846 ("fs/9p: This patch implements TLCREATE for 9p2000.L protocol.")
> > Signed-off-by: Victor Hsieh <victorhsieh@google.com>
> > Cc: stable@vger.kernel.org
> 
> (afaiu it is normally frowned upon for developers to add this cc (I can
> understand stable@ not wanting spam discussing issues left and right
> before maintainers agreed on them!) ; I can add it to the commit itself
> if requested but they normally pick most such fixes pretty nicely for
> backport anyway; I see most 9p patches backported as long as the patch
> applies cleanly which is pretty much all the time.
> Please let me know if I understood that incorrectly)
> 

Some people assume this, but the stable maintainers themselves say that Cc'ing
stable@vger.kernel.org on in-development patches is fine:
https://lkml.kernel.org/r/20200423184219.GA80650@kroah.com

And doing so is pretty much inevitable, since the tag gets picked up by
'git send-email'.  (Yes, there's also "stable@kernel.org", but it's not actually
what is documented.)

- Eric
