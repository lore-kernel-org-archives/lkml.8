Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9ED720772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591319303;
	bh=J/UgPloqDehOpWWxRSezIJjhVQzLn6+WD/FsIH7lUys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n1BjujLdwqBedyFPKrcYXklPgU0vdyqgdXiAzpZGTjFdmRL+/Axy+4zFd70uYNjQT
	 cSEzlQF+o6yBc9ZBW+MzZPrV0LOA1P3UnFWAYnHoalpYW67r+0SQfsnN49HYkHI+jK
	 VMSt8gAgsGE6DKzxxTgjiKyrARGjsOUqcmtXPDAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFEBIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 21:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgFEBIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 21:08:22 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDC206A2;
        Fri,  5 Jun 2020 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591319302;
        bh=J/UgPloqDehOpWWxRSezIJjhVQzLn6+WD/FsIH7lUys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfW/oP5L+l9jNe2zJ8+cWu5rYbGWN7u6hgqNF+5bT1eCfr+yPaMETizKTwipuVHYO
         uVT+7T3mIETXizvvhCCCtIIRRkyvHq3SQqiLuCvahiUvV0wu9KEbb7nPGqRD24B8Cc
         /VhADm6odczU5uZBX8/51NPYkbJXDb5R3UVfaZvU=
Date:   Thu, 4 Jun 2020 18:08:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20200605010821.GA100890@google.com>
References: <20200605100430.0ed7de60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605100430.0ed7de60@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   35942e2134fa ("f2fs: attach IO flags to the missing cases")
> 
> Fixes tag
> 
>   Fixes: d58f2f658159 ("f2fs: add node_io_flag for bio flags likewise data_io_flag")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 4a6183fb7db6 ("f2fs: add node_io_flag for bio flags likewise data_io_flag")

Ah, both are in dev branch. Let me drop the Fixes tag.

> 
> -- 
> Cheers,
> Stephen Rothwell


