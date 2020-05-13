Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CEBC2D11D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654EC24966
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589350020;
	bh=6qZpYcXUD5MiwOqEO1ZY0mCSOUXAEishXLv58UbUkb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jo1nbFQH/SxOHUzObulcEjJAp+iswBK8KecVRNeEgfJYDSkj70O66aB+R1Ur/qzpL
	 X4wFPmj3nKpp8GNKKgQQWgWiG5FdzjNbnfhAqwOZ+m5AvXPwhyChNeNZ2EYdNN0T42
	 yeBT5KW7TK4m6L80DdSdnRPpEQxoV8tkNCaXJDL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgEMGG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEMGGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:06:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE1820718;
        Wed, 13 May 2020 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589350015;
        bh=6qZpYcXUD5MiwOqEO1ZY0mCSOUXAEishXLv58UbUkb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlsesW/IxxtIRgOd2lQP0dqWv9yKqYmK7I0Pdb0PncShDHGqXe38IMwt5hHuJ+kOf
         dIxqCKtzwJuew0r94G4irCnmejKg94wHhnPbr+UD0EdFji1E6dp9EyMJNp0YL2HMWW
         Y2dzCbQdg/J8zQuX2IzJRvUBD4JBDdopZsCztJog=
Date:   Wed, 13 May 2020 07:55:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ashwin-h <ashwinh@vmware.com>
Cc:     x86@kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        rostedt@goodmis.org, srostedt@vmware.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
Message-ID: <20200513055548.GA743118@kroah.com>
References: <d29f87f3f3abb4e496866253bd170faad976f687.1589305630.git.ashwinh@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29f87f3f3abb4e496866253bd170faad976f687.1589305630.git.ashwinh@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:19:21AM +0530, ashwin-h wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> commit 594cc251fdd0d231d342d88b2fdff4bc42fb0690 upstream.
> 
> Originally, the rule used to be that you'd have to do access_ok()
> separately, and then user_access_begin() before actually doing the
> direct (optimized) user access.
> 
> But experience has shown that people then decide not to do access_ok()
> at all, and instead rely on it being implied by other operations or
> similar.  Which makes it very hard to verify that the access has
> actually been range-checked.
> 
> If you use the unsafe direct user accesses, hardware features (either
> SMAP - Supervisor Mode Access Protection - on x86, or PAN - Privileged
> Access Never - on ARM) do force you to use user_access_begin().  But
> nothing really forces the range check.
> 
> By putting the range check into user_access_begin(), we actually force
> people to do the right thing (tm), and the range check vill be visible
> near the actual accesses.  We have way too long a history of people
> trying to avoid them.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ashwin H <ashwinh@vmware.com>
> ---
>  arch/x86/include/asm/uaccess.h             | 11 ++++++++++-
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c | 15 +++++++++++++--
>  include/linux/uaccess.h                    |  2 +-
>  kernel/compat.c                            |  6 ++----
>  kernel/exit.c                              |  6 ++----
>  lib/strncpy_from_user.c                    |  9 +++++----
>  lib/strnlen_user.c                         |  9 +++++----
>  7 files changed, 38 insertions(+), 20 deletions(-)

Are you wanting this merged to a specific stable kernel tree?  If so, why?

thanks,

greg k-h
