Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3285C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A643922B40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="BH+HaXco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jR3R0+94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHTFLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:11:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35707 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgHTFLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:11:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id AF7D35C0199;
        Thu, 20 Aug 2020 01:11:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Aug 2020 01:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        qb+mCp0+4Ji9umLMBVjHosMeZEnBLxEOXmbaqA2ZQjQ=; b=BH+HaXcoHeFz5Dqy
        tyKn/5HBEEfS4dqi+GizBF3KgvQNb3P4/UFDyttp8qE9YNvGh5RYaLWeL8wZdm2H
        Fu+srhCFN7j75dWeKKD3DxBXhnYNRyGT22GG91NgoARGkUX03d03EVraHKrdIvXo
        0BZ4WAfQvzof4Zofgt05BE9i1BtnQBKWvZAJNp6N5T1Col3BLDxaojPWFxw1p+Nm
        qJ4h9cNW9PnVdSmfkzOn3I6RfghFuv4QRCniHQoJeK3NM6trI0bZtiavRHLK0FXy
        fBQTz4YOk4MzQFDJ/bP9FUyxdQ+uSLVVgFkqz1WldPM0uz2UHDajJJVMZ8CthwZc
        /WJoWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=qb+mCp0+4Ji9umLMBVjHosMeZEnBLxEOXmbaqA2ZQ
        jQ=; b=jR3R0+94F/5mjIWrx678KAZ7ht1yFrHkX9S+S6LefVNGMYYKiZaA4ooYB
        wqzn8oQZrdQvgG7F/2yccF6SjDq5U3xAMwqrL51P3+HNbdsy4OW/AfDmnECXFIJT
        SSeod6nL+Hs2OCISFHySAMqdU0DlJlTuum9mlYs+PveGYKiC26cmHP9Ovcii4YRG
        yx91L+FlBxdQH1CRbfO85XQPh3e1ifNpFyotNsH9YttNMyedAZeUENJ+pXhzN6HF
        M52wNHPH08pZXVk0Oe/cp96QtTtWxMTfJJgOb70IcnbSX8BVGOjnA5H+8bcdLtYs
        8UL/Fu/Z837v/SWyrXBtQXgI+6KVA==
X-ME-Sender: <xms:9AU-X3ptlZZdn5-BkLSwsmTe249-7mXKiVYNtrDhpgpddwY3unNtxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtledgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtje
    ertddtreejnecuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidr
    nhgvtheqnecuggftrfgrthhtvghrnhepfeefteetvdeguddvveefveeftedtffduudehue
    eihfeuvefgveehffeludeggfejnecukfhppeehkedrjedrvdefhedrvddvnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvg
    hmrgifrdhnvght
X-ME-Proxy: <xmx:9AU-XxpVaV51EDri7OTslzqP9M3ejTthQuAR2ca6XAiQqtj9YXd3Mw>
    <xmx:9AU-X0PwpswZ9cY-oOSc71cakaYrfjRx_SVzp2CBVVtSGeUfUVH11A>
    <xmx:9AU-X67ql_uPoS0jrsbruYXO38nJ1vlybSkVpnRthF-MAIuV8Yz7Bw>
    <xmx:9AU-XzVR9XmviwHqe67wlpBmnqvLvD8yupN0G8HBp9X_VPo7HGzxww>
Received: from mickey.themaw.net (58-7-235-22.dyn.iinet.net.au [58.7.235.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94AD630600A3;
        Thu, 20 Aug 2020 01:11:14 -0400 (EDT)
Message-ID: <5ce39603821b0108a58d3be547d97b65b9c31fdb.camel@themaw.net>
Subject: Re: [PATCH] Harden autofs ioctl table
From:   Ian Kent <raven@themaw.net>
To:     Matthew Wilcox <willy@infradead.org>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 20 Aug 2020 13:11:11 +0800
In-Reply-To: <20200818122203.GO17456@casper.infradead.org>
References: <20200818122203.GO17456@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 13:22 +0100, Matthew Wilcox wrote:
> The table of ioctl functions should be marked const in order to put
> them
> in read-only memory, and we should use array_index_nospec() to avoid
> speculation disclosing the contents of kernel memory to userspace.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Ian Kent <raven@themaw.net>

Thanks Matthew, I certainly want to know about changes to autofs
made by others so thanks for sending this to me.

At the same time I need to send my patches via someone else as
Linus asked me to do ages ago now.

So, once again Andrew, if you would be so kind as to include this
in your tree please.

Ian

> 
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index 75105f45c51a..322b7dfb4ea0 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -8,6 +8,7 @@
>  #include <linux/compat.h>
>  #include <linux/syscalls.h>
>  #include <linux/magic.h>
> +#include <linux/nospec.h>
>  
>  #include "autofs_i.h"
>  
> @@ -563,7 +564,7 @@ static int autofs_dev_ioctl_ismountpoint(struct
> file *fp,
>  
>  static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
>  {
> -	static ioctl_fn _ioctls[] = {
> +	static const ioctl_fn _ioctls[] = {
>  		autofs_dev_ioctl_version,
>  		autofs_dev_ioctl_protover,
>  		autofs_dev_ioctl_protosubver,
> @@ -581,7 +582,10 @@ static ioctl_fn lookup_dev_ioctl(unsigned int
> cmd)
>  	};
>  	unsigned int idx = cmd_idx(cmd);
>  
> -	return (idx >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[idx];
> +	if (idx >= ARRAY_SIZE(_ioctls))
> +		return NULL;
> +	idx = array_index_nospec(idx, ARRAY_SIZE(_ioctls));
> +	return _ioctls[idx];
>  }
>  
>  /* ioctl dispatcher */

