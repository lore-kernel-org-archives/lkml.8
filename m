Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72ED021744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596573947;
	bh=IsGGbZDqwVSdrx08mN8MiNfmLHPAXTc8CpjLyRYm0PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ccZqN0hFe8J4ELmURv9ZM3wz8oYHCxX7FZ6vVqXScL+zWhZINoMpbH+Haf5wxu6tk
	 N1XqA7/E5sL5nao0BidEEonPdTOCneNu9UMZrO8jkV9Fn9z0VdQ6FCjgnarwIc8PUF
	 pRIXc/35gYZBNwbHB9bTWNIfiYS6c8cyIvd1wm30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHDUpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgHDUpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:45:45 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B7920842;
        Tue,  4 Aug 2020 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596573945;
        bh=IsGGbZDqwVSdrx08mN8MiNfmLHPAXTc8CpjLyRYm0PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2RYgdBKRUZvYgyXaVkxI8tIV9M60Ul5vpeFSWkbA6mYNzNXbdFZe+/fRj/AcZNdn
         Oc+boojGMwh1YfBWUsY2MnjY9quPxdG9/jl7c7lhkNXKUyVtVMayworct1WUEyMmVK
         vXEszlOdY79qUbEtjI3wfBf7j1/A5vn32NCZKPBY=
Date:   Tue, 4 Aug 2020 13:45:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     viro@zeniv.linux.org.uk, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, jmorris@namei.org, kaleshsingh@google.com,
        dancol@dancol.org, surenb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nnk@google.com, jeffv@google.com, calin@google.com,
        kernel-team@android.com, yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
Message-ID: <20200804204543.GA1992048@gmail.com>
References: <20200804203155.2181099-1-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804203155.2181099-1-lokeshgidra@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:31:55PM -0700, Lokesh Gidra wrote:
> when get_unused_fd_flags returns error, ctx will be freed by
> userfaultfd's release function, which is indirectly called by fput().
> Also, if anon_inode_getfile_secure() returns an error, then
> userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> 
> Also, the O_CLOEXEC was inadvertently added to the call to
> get_unused_fd_flags() [1].
> 
> Adding Al Viro's suggested-by, based on [2].
> 
> [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
> [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/
> 
> Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

What branch does this patch apply to?  Neither mainline nor linux-next works.

- Eric
