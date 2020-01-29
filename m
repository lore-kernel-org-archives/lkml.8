Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0101C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 07:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B811420702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKnTYTdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgA2H6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 02:58:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726068AbgA2H6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 02:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580284720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHk1aL7hxo7ZoRJFzbI0fjtox7s7pKir+bxT3CuVjSA=;
        b=RKnTYTdSu7ib1lp9lsJ9kt6TRO2BCP7VmlGImSdNbeuiPOM8v80m1c6GBYPYV7zEfVFZBu
        XJ+Urab/v4PrCFCbRDifBD9GrvE/3zzyITSf07gQpOUPr/LQlAdUpwbz1QgBQi3Vz9nDuA
        TX6WabO8uNehkFmnXZ0+vYcjQJOoPsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-_gYidbK1Nfi2dGIEd0p8WA-1; Wed, 29 Jan 2020 02:58:33 -0500
X-MC-Unique: _gYidbK1Nfi2dGIEd0p8WA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C9B184BBD3;
        Wed, 29 Jan 2020 07:58:32 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B555D10018FF;
        Wed, 29 Jan 2020 07:58:31 +0000 (UTC)
Date:   Wed, 29 Jan 2020 08:58:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Make perf able to build with latest libbfd
Message-ID: <20200129075829.GB1256499@krava>
References: <20200128152938.31413-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128152938.31413-1-changbin.du@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:29:38PM +0800, Changbin Du wrote:
> libbfd has changed the bfd_section_* macros to inline functions
> bfd_section_<field> since 2019-09-18. See below two commits:
>   o http://www.sourceware.org/ml/gdb-cvs/2019-09/msg00064.html
>   o https://www.sourceware.org/ml/gdb-cvs/2019-09/msg00072.html
> 
> This fix make perf able to build with both old and new libbfd.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> ---
>  tools/perf/util/srcline.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 6ccf6f6d09df..5b7d6c16d33f 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -193,16 +193,30 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
>  	bfd_vma pc, vma;
>  	bfd_size_type size;
>  	struct a2l_data *a2l = data;
> +	flagword flags;
>  
>  	if (a2l->found)
>  		return;
>  
> -	if ((bfd_get_section_flags(abfd, section) & SEC_ALLOC) == 0)
> +#ifdef bfd_get_section_flags
> +	flags = bfd_get_section_flags(abfd, section);
> +#else
> +	flags = bfd_section_flags(section);
> +#endif
> +	if ((flags & SEC_ALLOC) == 0)
>  		return;
>  
>  	pc = a2l->addr;
> +#ifdef bfd_get_section_vma
>  	vma = bfd_get_section_vma(abfd, section);
> +#else
> +	vma = bfd_section_vma(section);
> +#endif
> +#ifdef bfd_get_section_size
>  	size = bfd_get_section_size(section);
> +#else
> +	size = bfd_section_size(section);
> +#endif
>  
>  	if (pc < vma || pc >= vma + size)
>  		return;
> -- 
> 2.24.0
> 

