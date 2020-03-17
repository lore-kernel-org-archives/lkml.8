Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDFAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65192051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af13D/Jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCQVAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:00:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53102 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgCQVAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584478833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4lv1khPzgvPepOXblNxUbTvMHk/cb3nmCWzuqrFCSw=;
        b=af13D/JnjY2M/523sDplLK3xHIjeL+trvK1IAAhSN/R3+vginVOF0K1zYuuaGMKLOvVryY
        iaydG0z+HAO6/SQuHdn9F/DsZaNkR3xuubjATDwLZxkaoVy6hS632zYVFQuxZOF2oKKgic
        OLsbCE+enbYy23MEzwbl0PoIHStzXxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-GoyOgvPJPqq27qbNUBul1Q-1; Tue, 17 Mar 2020 17:00:28 -0400
X-MC-Unique: GoyOgvPJPqq27qbNUBul1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8CAD8CA0AC;
        Tue, 17 Mar 2020 21:00:12 +0000 (UTC)
Received: from treble (unknown [10.10.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9755710027AB;
        Tue, 17 Mar 2020 21:00:10 +0000 (UTC)
Date:   Tue, 17 Mar 2020 16:00:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v2 16/19] objtool: Implement noinstr validation
Message-ID: <20200317210008.bda4c542b5lu7juf@treble>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.730949374@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317170910.730949374@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:02:50PM +0100, Peter Zijlstra wrote:
> Validate that any call out of .noinstr.text is in between
> instr_begin() and instr_end() annotations.
> 
> This annotation is useful to ensure correct behaviour wrt tracing
> sensitive code like entry/exit and idle code. When we run code in a
> sensitive context we want a guarantee no unknown code is ran.
> 
> Since this validation relies on knowing the section of call
> destination symbols, we must run it on vmlinux.o instead of on
> individual object files.
> 
> Add two options:
> 
>  -d/--duplicate "duplicate validation for vmlinux"
>  -l/--vmlinux "vmlinux.o validation"

I'm not sure I see the point of the --vmlinux option, when it will be
autodetected anyway?

> @@ -46,5 +49,9 @@ int cmd_check(int argc, const char **arg
>  
>  	objname = argv[0];
>  
> +	s = strstr(objname, "vmlinux.o");
> +	if (s && !s[9])
> +		vmlinux = true;
> +

I think this would be slightly cleaner:

	if (!strcmp(basename(objname), "vmlinux.o"))
		vmlinux = true;

-- 
Josh

