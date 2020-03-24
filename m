Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2BC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066B32077D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eW+qNvo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCXVmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:42:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54136 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgCXVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585086126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NT1rJDXEx+JBvZRwjbf6ZyZM9e3SrBa+P0+hMLICRDM=;
        b=eW+qNvo01Eo6rhr3gkeXRRHZ+fuZsm8c9oBugQBkknj4ilCde8wvRdyWwPyFkOnnHqzMB+
        ajbxZIkKOAkgrz+INhrULs84MDDoiz+mzgUBykyW2bSTwUCem9rLN8047MjflDDKG8/ogT
        KdzPOOwQD2ci6vLGRljZNTIO3UdS9VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-MjVXxRrDNECn9w06pfgr_g-1; Tue, 24 Mar 2020 17:42:04 -0400
X-MC-Unique: MjVXxRrDNECn9w06pfgr_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 815F9CF9BF;
        Tue, 24 Mar 2020 21:41:55 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF8B65DA7B;
        Tue, 24 Mar 2020 21:41:54 +0000 (UTC)
Date:   Tue, 24 Mar 2020 16:41:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 19/26] objtool: Implement noinstr validation
Message-ID: <20200324214152.zzd4bvm65x3w3v2h@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.047300866@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160925.047300866@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:32PM +0100, Peter Zijlstra wrote:
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
> 
> Where the latter auto-detects when objname ends with "vmlinux.o" and
> the former will force all validations, also those already done on
> !vmlinux object files.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

