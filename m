Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2A2C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813532075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579179702;
	bh=v9Po416KwW4s4njLFElwLgFMcq7ajvjcLbyC7QhnKjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=thwUA+Q9i22U6VbVpnzwVaLjpQCa0rkqmJw6NWcHgXrbjYgQRWfCEF0wRendg/MqI
	 vJsDd57FigLl5LtXE2qaSb1b7r1JqVISoaVZBx8eSzKIMzZ/I+bLKVV0AadIUxUo3Y
	 70k/8NC6gGlPA6uc8GP+nknB/0PhHvEICrQBN4Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgAPNBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgAPNBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:01:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7122E20730;
        Thu, 16 Jan 2020 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579179700;
        bh=v9Po416KwW4s4njLFElwLgFMcq7ajvjcLbyC7QhnKjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjnAAyILSY9QT+fId0MJTQK4p5sFJh7R8BwyUjVFuQ4uYLqn/Qt1ya/wlcmxGWz0n
         5V1ZBtnG45rGUvmvxivu63LyXTLoCOAwgH9TDNFSqpm5G5t6Prwku5zyRAJUgpR/Kv
         //YUfK1h38QnH9bIHVLtgEXjrnALcG8FDd+2w2DA=
Date:   Thu, 16 Jan 2020 14:01:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com,
        linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
Message-ID: <20200116130138.GA214226@kroah.com>
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115094732.bou23s3bduxpnr4k@pali>
 <20200116105108.GA16924@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116105108.GA16924@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:51:08AM +0100, Christoph Hellwig wrote:
> > * After applying this patch series, remote staging exfat implementation.
> 
> I think Greg wants to do that separately.  I still hope we can do that
> in the same merge window, though.

I will be glad to do it in the same merge window, just let me know when
this gets accepted and I'll drop the staging version.

thanks,

greg k-h
