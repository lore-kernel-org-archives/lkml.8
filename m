Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D663C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7154E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595868314;
	bh=Y+WD95sdH0wkH5EJvEWNHVBOc12vKJ3VFxESA0EXbJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QreifU8G5NYUgLIWlWxjQLbNpgEBhEuHk6O4RtjK+dM/qbrDVRIUnL2m/50Q+y93Y
	 STz2KsqFdyx37zw/NRHnxTJQlzP8GlVxjR+2/29JeNz444wNhO5iPszW4qDXsP6rHk
	 7Kqz8A0/zjZHMV6rYs0q3EHn4NPaxPAVRVBYEkUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgG0QpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgG0QpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:45:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D2C20729;
        Mon, 27 Jul 2020 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595868310;
        bh=Y+WD95sdH0wkH5EJvEWNHVBOc12vKJ3VFxESA0EXbJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05yBUaSDAOP3S38lPECXjCakK/MCIToC7TOXpsu91VGhjXm7eVriyBOClN2zzXa2q
         V1jAjxYNkpVyPN3PGRU5H+Ra1LBAITD3yMT9MG8w1C1DScvyxtYQyFKzFwEM9RVZ8P
         CKxGsmqi8KNPkQVmmpj9NdHYV50J6dO6CH0nUiSo=
Date:   Mon, 27 Jul 2020 09:45:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Rosenberg <drosen@google.com>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption
 patches
Message-ID: <20200727164508.GE1138@sol.localdomain>
References: <20200708091237.3922153-1-drosen@google.com>
 <20200720170951.GE1292162@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720170951.GE1292162@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:09:51AM -0700, Eric Biggers wrote:
> On Wed, Jul 08, 2020 at 02:12:33AM -0700, Daniel Rosenberg wrote:
> > This lays the ground work for enabling casefolding and encryption at the
> > same time for ext4 and f2fs. A future set of patches will enable that
> > functionality.
> > 
> > These unify the highly similar dentry_operations that ext4 and f2fs both
> > use for casefolding. In addition, they improve d_hash by not requiring a
> > new string allocation.
> > 
> > Daniel Rosenberg (4):
> >   unicode: Add utf8_casefold_hash
> >   fs: Add standard casefolding support
> >   f2fs: Use generic casefolding support
> >   ext4: Use generic casefolding support
> > 
> 
> Ted, are you interested in taking this through the ext4 tree for 5.9?
> 
> - Eric

Ping?
