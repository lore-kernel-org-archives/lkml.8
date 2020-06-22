Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC660C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FF920707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592845870;
	bh=HJacg1CswmNF3NpHWMoLOKu4HVPQzSnkMZkipiswgmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bOtILC+0Z4Bwn8sPYgs9VHrGR+fLaTjb16EW6eoxCyWXu1r1E2edvbO/vOmuZUWR6
	 4rkSUqIMRZ3en9L4kixZ2pftaRBmgNjk58UqxSh4YAF3RnBr9hn+P6GiTiLoEtaYfs
	 HUuK34N6PPi/pWFn2wO3FPzFbHsPpsUhBeb3G1Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgFVRLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbgFVRLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:11:08 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B05B206BE;
        Mon, 22 Jun 2020 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592845868;
        bh=HJacg1CswmNF3NpHWMoLOKu4HVPQzSnkMZkipiswgmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUiIvmsEv5eUAyUmW+zTnuaaQQgmi00zA8f7EqyvKapnD+rSfpYaOrcnJ4ZONfAMR
         qCOC//YNf7AGFyv9UhWjzEDBnLNoA/b7crpdkflQL8QjFmGJiFiFcokHl8KvHu2uHw
         +af/ORyLIdekoLm2Xbkk6opyRRuYkR+6B1CaA2Es=
Date:   Mon, 22 Jun 2020 10:11:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] docs: f2fs: fix a broken table
Message-ID: <20200622171106.GA192855@gmail.com>
References: <20200622073907.7608a73a@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622073907.7608a73a@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 07:39:07AM -0600, Jonathan Corbet wrote:
> Commit ed318a6cc0b6 ("fscrypt: support test_dummy_encryption=v2") added an
> entry to the massive option table in Documentation/filesystems/f2fs.txt.
> The option was too wide for the formatting of the table, though, leading to
> a verbose and ugly docs-build warning starting with:
> 
>     Documentation/filesystems/f2fs.rst:229: WARNING: Malformed table.
>     Text in column margin in table line 126.
> 
> Fixing this requires formatting the whole table; let's hear it for Emacs
> query-replace-regexp.  No changes were made to the actual text.
> 
> Fixes: ed318a6cc0b6 ("fscrypt: support test_dummy_encryption=v2")
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/filesystems/f2fs.rst | 312 ++++++++++++++---------------
>  1 file changed, 156 insertions(+), 156 deletions(-)
> 

Someone already sent out a fix for this:
https://lkml.kernel.org/linux-doc/52f851cb5c9fd2ecae97deec7e168e66b8c295c3.1591137229.git.mchehab+huawei@kernel.org/

Is it intentional that you're sending out a different fix rather than applying
that one?

- Eric
