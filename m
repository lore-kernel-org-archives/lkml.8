Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98755C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5392080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apGA2nFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgCaWEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:04:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728493AbgCaWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585692251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nfgOy3O0fCtYT2cXHRPJbltzLgwVrys56KLhZQvEmo=;
        b=apGA2nFZDo5l//pr/b1urooiD9mFAlatg998H6F34m84LP5Jzev9dNOSHInUz4JaOl9umo
        n9NKmX6Sxuue71q/ZclY2ATZWGlcpxNvs4Ctzt/DSP/FqJ3u/faqjFoMsXqjDXrQASF7ew
        lMW4ZyIgksH6KVZn3ENVVd5IR3IML7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-U6jGcOySMmC0H04j8ali1A-1; Tue, 31 Mar 2020 18:04:09 -0400
X-MC-Unique: U6jGcOySMmC0H04j8ali1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 127798017CE;
        Tue, 31 Mar 2020 22:04:08 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F5721001B09;
        Tue, 31 Mar 2020 22:04:07 +0000 (UTC)
Date:   Tue, 31 Mar 2020 17:04:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: check: Fix NULL pointer dereference
Message-ID: <20200331220405.2zopmakvcgytfze5@treble>
References: <20200331002040.GA11302@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331002040.GA11302@embeddedor>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:20:40PM -0500, Gustavo A. R. Silva wrote:
> In case func is null, there is a null pointer dereference at 2029:
> 
> 2029                 WARN("%s uses BP as a scratch register",
> 2030                      func->name);
> 
> Fix this by null-checking func.
> 
> Addresses-Coverity-ID: 1492002 ("Dereference after null check")
> Fixes: c705cecc8431 ("objtool: Track original function across branches")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e3bb76358148..182cc48fa892 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2025,7 +2025,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
>  		return 1;
>  	}
>  
> -	if (state->bp_scratch) {
> +	if (func && state->bp_scratch) {
>  		WARN("%s uses BP as a scratch register",
>  		     func->name);
>  		return 1;

We should still do the warning even if there's no func.  I'll make a
slightly different patch which unconditionally uses WARN_FUNC().

I'll give you Reported-by credit and keep the coverity tag.  Thanks!

-- 
Josh

