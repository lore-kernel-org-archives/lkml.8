Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ABEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4D22073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzXheBP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403902AbgDCQFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:05:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728126AbgDCQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585929946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHwQSmbMG4HnMxZ26bWvjSGCnlTSFj1c/dJ6cczgSfA=;
        b=dzXheBP2y1RTzsYkoZaecDgFajM1ArWmmN3nGa20Fpij78FfW94btEM6M3xCkJgmhzf3Da
        l7JQ3HxfjZY6e5egQRw1ywWUGQdoD8h69bCYZTUKn4yrtj34zFAyEiEOfr45l0Dll8kGcn
        lVHKwqz2aMei3/lyuybGe9y4PYmimAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-MXOCZQ6nPuKZKcSD2KNjWA-1; Fri, 03 Apr 2020 12:05:44 -0400
X-MC-Unique: MXOCZQ6nPuKZKcSD2KNjWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C525F8017CE;
        Fri,  3 Apr 2020 16:05:42 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8772F96B9B;
        Fri,  3 Apr 2020 16:05:41 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:05:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH 5/7] x86/speculation: Annotate intra-function calls
Message-ID: <20200403160538.qwu237amhanr6pyi@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-6-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402082220.808-6-alexandre.chartre@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:22:18AM +0200, Alexandre Chartre wrote:
>  .macro RETPOLINE_JMP reg:req
> -	call	.Ldo_rop_\@
> +	INTRA_FUNCTION_CALL .Ldo_rop_\@
>  .Lspec_trap_\@:
>  	pause
>  	lfence
> @@ -102,7 +116,7 @@
>  .Ldo_retpoline_jmp_\@:
>  	RETPOLINE_JMP \reg
>  .Ldo_call_\@:
> -	call	.Ldo_retpoline_jmp_\@
> +	INTRA_FUNCTION_CALL .Ldo_retpoline_jmp_\@
>  .endm

There's a catch: this is part of an alternative.  Which means if
X86_FEATURE_RETPOLINE isn't set at runtime, then the retpoline won't be
there and the ORC data will be wrong.

In fact objtool should probably be made smart enough to warn about this
situation, when an alternative changes the stack state.

The only way I can think of to fix this is to have ORC alternatives :-/

-- 
Josh

