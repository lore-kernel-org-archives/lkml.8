Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41899C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8F72075E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586158548;
	bh=aNoZkMJveg+ENTUCrIEXfGnyqRiDMSwKqfMcazI1uX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMKeDb0oSaJ+UCUeib5dKZkxqBzpBE7ZPDAEcPNkr22efQEaNQ/MtAXEvf7dFFjzG
	 37shYNg6FJam94f4apHcGMcoFmiPg62oPZ3SmNdvt5vuSjCBgZ5+OhXgv3hRoEt/Gl
	 wehLY7l2B9U3xaMRskGjVtPIUJWkXnpMlmvCSd9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDFHfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDFHfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:35:46 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531B920672;
        Mon,  6 Apr 2020 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586158546;
        bh=aNoZkMJveg+ENTUCrIEXfGnyqRiDMSwKqfMcazI1uX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSpweM2BaQ/kOvr21ZEsPsIoVLsacljsyrkv0waCLs5gJx79/0p/8GIHz9MmGubfV
         NiRjC6QlLl0rvO2Nzq/0ryjJ5aeIJptzVJfGod5fnDdZ5X4HGxXCqcA/j1BRGO/gW4
         FnqCMuo1bvJn+1EycGq5IojtQ8hoKmRK6t3QgBlw=
Received: by pali.im (Postfix)
        id D61CD8A7; Mon,  6 Apr 2020 09:35:43 +0200 (CEST)
Date:   Mon, 6 Apr 2020 09:35:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        Arnd Bergmann <arnd@arndb.de>, linkinjeon@gmail.com
Subject: Re: [PATCH v14 11/14] exfat: add Kconfig and Makefile
Message-ID: <20200406073543.rkxnsgegunlv3lkt@pali>
References: <CGME20200302062625epcas1p200c53fabe17996e92257a409b7a9c857@epcas1p2.samsung.com>
 <20200302062145.1719-1-namjae.jeon@samsung.com>
 <20200302062145.1719-12-namjae.jeon@samsung.com>
 <CAMuHMdXdGDnvGYi1v1OhjCz=61moVRZQdZOtiKLG3m8q7vwkTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXdGDnvGYi1v1OhjCz=61moVRZQdZOtiKLG3m8q7vwkTg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 April 2020 09:27:01 Geert Uytterhoeven wrote:
> I tried to do it myself:
> 
>           Set this to the default input/output character set to use for
>           converting between the encoding that is used for user visible
>           filenames, and the UTF-16 character set that the exFAT filesystem
>           uses.  This can be overridden with the "iocharset" mount option for
>           the exFAT filesystems.
> 
> but then I got puzzled by the _3_ encodings that are part of it:
>   1. the default input/output character set to use for conversion,
>   2. encoding that is used for user visible filenames,
>   3. UTF-16 character set that the exFAT filesystem uses.
> I assume 1 == 2, but there may be more to it?

It is encoding between user visible filenames in VFS and UTF-16, so 1 == 2.
