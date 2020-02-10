Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D9C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40FF214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581319014;
	bh=/6cxKBThRZTqraEt22L56fCJKgcPzcS1pcT8+oik2+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PtZ9lRch7uU/+X1PtyBub+TIGPhvJ/CMd2AKRSp2Aaa3/JeDDfjV8/IciAW+4Sgiq
	 JDuD83T+wSB32VgWfg3G4EotGvhr86Q0C1MIpz7MTzOFFRN+1ZFbJMtVZ3iOI3ZUfw
	 7vISWCcj81etFHuPvyKX2deC3ba0pYELFGtkY8Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJHQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:16:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgBJHQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:16:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8072820838;
        Mon, 10 Feb 2020 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581319012;
        bh=/6cxKBThRZTqraEt22L56fCJKgcPzcS1pcT8+oik2+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bkmMpaSM1ksPOMAwYdsOtRHTXSI4dy4cCI/OgvQZSt/EsiDkhuwdnwDBA6uB/3aZl
         TcAX4y1zFnOYKFIvKCx+5C852zBtOveiwEqnnI1X+5clK1OIHPGLmdmiZObu95A+Lt
         njiQ8aLlbjnaYBGUUBERzAFAFL5Ip/cEcZsF3DPQ=
Date:   Mon, 10 Feb 2020 16:16:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation: bootconfig: fix Sphinx block warning
Message-Id: <20200210161647.416ce0dcd0710f4349a665b1@kernel.org>
In-Reply-To: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
References: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2020 19:53:17 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Sphinx format warning:
> 
> lnx-56-rc1/Documentation/admin-guide/bootconfig.rst:26: WARNING: Literal block expected; none found.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for the fix!

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/admin-guide/bootconfig.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-56-rc1.orig/Documentation/admin-guide/bootconfig.rst
> +++ lnx-56-rc1/Documentation/admin-guide/bootconfig.rst
> @@ -23,7 +23,7 @@ of dot-connected-words, and key and valu
>  has to be terminated by semi-colon (``;``) or newline (``\n``).
>  For array value, array entries are separated by comma (``,``). ::
>  
> -KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
>  
>  Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
