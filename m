Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1EDC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAAF222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582684501;
	bh=JhCEVeDFXJdMR838T0u81Xg3kHk4An75sj2PC5EQ3ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KWTLoLZASaol7ncwyi/esy5s8227enOvq+7LhGLvhNfdl3bJioV5GstM7lFkBhY1S
	 HlXs8+Xdj7AryHpjxHT6ztH4TaJhF+Z/JqkWdLznQiiAJmjm+wJgepvGBgYzkLRtmd
	 eKskwqFU1O3RJG2ivaedA8MLmmw+D9I+Fxo/wqb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgBZCfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgBZCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:35:00 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7A821D7E;
        Wed, 26 Feb 2020 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582684499;
        bh=JhCEVeDFXJdMR838T0u81Xg3kHk4An75sj2PC5EQ3ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E41DcHsi9w5s7qSvhMdEnFgIzPi3Zn0cxXHpbHfP9ELT5QIPpCZ2gLypzAofsZv0n
         kzOqBw8cegdWtVFwiPLJAcujP/8Lzyx+L2cH7duIIQbC7MeDcLgKE5/8reP6uf5zd+
         eM3rP+3meboTEqOeCCjP7gfCJl3mIrhdz25qUZrI=
Date:   Tue, 25 Feb 2020 18:34:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: Re: [PATCH 3/3] erofs: handle corrupted images whose decompressed
 size less than it'd be
Message-ID: <20200226023458.GB1053@sol.localdomain>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
 <20200226023011.103798-3-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226023011.103798-3-gaoxiang25@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:30:11AM +0800, Gao Xiang wrote:
> As Lasse pointed out, "Looking at fs/erofs/decompress.c,
> the return value from LZ4_decompress_safe_partial is only
> checked for negative value to catch errors. ... So if
> I understood it correctly, if there is bad data whose
> uncompressed size is much less than it should be, it can
> leave part of the output buffer untouched and expose the
> previous data as the file content. "
> 
> Let's fix it now.
> 
> Cc: Lasse Collin <lasse.collin@tukaani.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Shouldn't fixes like this have a Fixes tag and Cc stable?

- Eric
