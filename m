Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0478C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAAC207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592373528;
	bh=AOwTdfSpriF0FvqePnLLcxueTJBdcldvZA/TA0sw/AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LeDvXi0sOkmze9TJid4ol56YgcNQcgv5XzDFm3EYDoThhtjSSlenyX3OFEq3VgtvE
	 yyIQxQtJc9UgAQAKmcyqmfbbN6KWFbue9APKtcJyIBo96yEuBU0MjVie2TvuhUigUk
	 O/kfahk0qT+0ZbCnxvlTPp66EeSVtuW4/v6FOuCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQF6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgFQF6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:58:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6883207DD;
        Wed, 17 Jun 2020 05:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592373526;
        bh=AOwTdfSpriF0FvqePnLLcxueTJBdcldvZA/TA0sw/AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raGwkuX7uTzn0qCk3C2mKruticMr6nUVkCQpd4ViXuESPG2N+ZiSCq9mtzJjrLBfC
         9m8FPYzrRcwrosFH9dSn4JZpAsMvmo1wNEFoEtz102A/fPsvqJlPU8l2Oazehn0Gm6
         k2kw2aOjvhznX1ElTHyCDTE91bdLLrVGqWhKpwOk=
Date:   Wed, 17 Jun 2020 07:58:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Message-ID: <20200617055843.GB25631@kroah.com>
References: <20200617092614.7897ccb2@canb.auug.org.au>
 <20200617092747.0cadb2de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617092747.0cadb2de@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> This is in preparation for removing the include of major.h where it is
> not needed.
> 
> These files were found using
> 
> 	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> 
> where /tmp/xx contains all the symbols defined in major.h.  There were
> a couple of files in that list that did not need the include since the
> references are in comments.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Any reason this had an RFC, but patch 2/2 did not?

They look good to me, I will be glad to take these, but do you still
want reviews from others for this?  It seems simple enough to me...

thanks,

greg k-h
