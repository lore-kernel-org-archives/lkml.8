Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ABCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A8E206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDVwphBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391057AbgDCOuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:50:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727431AbgDCOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585925449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVuhW4T2nVV7nJd21PZ+m4iAMcpuBsAwHlOi0Sjvo/g=;
        b=ZDVwphBfzKsjp4+PtJ5elEio6Ak8w4EVdQUBItFeIVU753RIzQPtdmHWEqDVypY7LrS/xV
        OnaeWQdzkeuYwkpRdvoTlxdIIXkE39CD374+PpMG2+0LQpt0wGwa+/6NoD1ispJI6Qav3H
        QXr9NidRmCoDdwLIuOWtXZhPWusWmI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-nqkSTX6APm6YGq1UGAl9LA-1; Fri, 03 Apr 2020 10:50:48 -0400
X-MC-Unique: nqkSTX6APm6YGq1UGAl9LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CB288018A2;
        Fri,  3 Apr 2020 14:50:47 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C7850BEE;
        Fri,  3 Apr 2020 14:50:46 +0000 (UTC)
Date:   Fri, 3 Apr 2020 09:50:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: Re: [PATCH] objtool: Fix off-by-one in symbol_by_offset()
Message-ID: <20200403145044.fzdrywxbs7k6sq7p@treble>
References: <20200403131730.32618-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403131730.32618-1-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 02:17:30PM +0100, Julien Thierry wrote:
> Sometimes, WARN_FUNC() and other users of symbol_by_offset() will
> associate the first instruction of a symbol with the symbol preceding
> it.
> This is because symbol->offset + symbol->len is already outside of the
> symbol's range.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 09ddc8f1def3..c4857fa3f1d1 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -105,7 +105,7 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
>  
>  	if (*o < s->offset)
>  		return -1;
> -	if (*o > s->offset + s->len)
> +	if (*o >= s->offset + s->len)
>  		return 1;
>  
>  	return 0;

Thanks - looks like this fixes 2a362ecc3ec9 ("objtool: Optimize
find_symbol_*() and read_symbols()").

-- 
Josh

