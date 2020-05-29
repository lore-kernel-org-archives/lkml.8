Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CF9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D505E207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763579;
	bh=PTcudGkQlxs5GmPidtQXzhIo/iu9BqsWKC/ypA5RqWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vworqGHscFzIWu0eeLeq+sR5653nM0LL8Xtf9hZKsmtXzvsTxF8RTgZ7GbDiNnYOf
	 HxCQpGDIMGbxyrO0JZNFe6rKM5drS3+GDMwOc6HX411P6SuPT8iHHUdTeu8DWtdHRP
	 o8A7LbefRZD+Ly+njKF7LvXgHsjeb02wUREA+uts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgE2OqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2OqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:46:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4BB620721;
        Fri, 29 May 2020 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763578;
        bh=PTcudGkQlxs5GmPidtQXzhIo/iu9BqsWKC/ypA5RqWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZqGz0cqdYF13kt3KpKmZ9nT7SCbfil3VF3OrR9+ViXvOemDoiiNrPzIF1gaOCP9k
         lIYPZHUbKe08WT/nopp1OZnOBMXpPhu2QosQF30a2xBH25FwkxofzeyhRP4edAF8El
         hbnMEZjn09QFwFSMtNm8BF2MQ6cx77ERni4TlA4E=
Date:   Fri, 29 May 2020 16:46:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: please revert "Revert "media: staging: atomisp: Remove driver""
Message-ID: <20200529144615.GA2168030@kroah.com>
References: <20200529140907.GA2916@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529140907.GA2916@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:09:07PM +0200, Christoph Hellwig wrote:
> Hi Mauro and Greg,
> 
> the commit mentioned in the subject (commit id ad85094b293e in
> linux-next) contains the grave offense of adding a new set_fs address
> space override in "new" code.  It also doesn't have an Ack from Greg
> despite showing up in drives/staging, which looks very suspicious.
> 
> Please don't just add crap like this back if it doesn't pass the
> most basic sanity tests.

Mauro "owns" drivers/staging/media/ which is where this ended up in,
right?  And I thought he had a bunch of follow-on patches that fixed up
crud like set_fs and friends.

Mauro, is your fixes not pushed in your tree as well?

thanks,

greg k-h
