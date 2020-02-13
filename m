Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D2FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D3224670
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSioyUaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgBMWSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:18:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727594AbgBMWSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581632289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qi71n+eauOK1OSXi8ZkVfgUb7+wXkbcDfLtR5AJoSms=;
        b=YSioyUaVPsB5icC03M223TQ/33iAuCbDn7G0W4Omlo3CyCDi+pDgIQLT+VhBJuzhYD2kdP
        JV1muXPSVYGPbcIHKPR0JXb8PQs77A+g8EFYhYibNAae78e6/55z44wOPlskIKjZBwppnw
        WJ37c2qs47bhHp1fSZrrmiFdhkEsS28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-DupnYgKvNvSJ6uPJg0My1A-1; Thu, 13 Feb 2020 17:18:05 -0500
X-MC-Unique: DupnYgKvNvSJ6uPJg0My1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2E318A6EC0;
        Thu, 13 Feb 2020 22:18:03 +0000 (UTC)
Received: from treble (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47C1C1001B28;
        Thu, 13 Feb 2020 22:18:01 +0000 (UTC)
Date:   Thu, 13 Feb 2020 16:17:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200213221758.i6pchz4gsiy2lsyc@treble>
References: <20200213184708.205083-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213184708.205083-1-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:47:08AM -0800, Nick Desaulniers wrote:
> Top of tree LLVM has optimizations related to
> -fno-semantic-interposition to avoid emitting PLT relocations for
> references to symbols located in the same translation unit, where it
> will emit "local symbol" references.
> 
> Clang builds fall back on GNU as for assembling, currently. It appears a
> bug in GNU as introduced around 2.31 is keeping around local labels in
> the symbol table, despite the documentation saying:
> 
> "Local symbols are defined and used within the assembler, but they are
> normally not saved in object files."
> 
> When objtool searches for a symbol at a given offset, it's finding the
> incorrectly kept .L<symbol>$local symbol that should have been discarded
> by the assembler.
> 
> A patch for GNU as has been authored.  For now, objtool should not treat
> local symbols as the expected symbol for a given offset when iterating
> the symbol table.
> 
> commit 644592d32837 ("objtool: Fail the kernel build on fatal errors")
> exposed this issue.

Since I'm going to be dropping 644592d32837 ("objtool: Fail the kernel
build on fatal errors") anyway, I wonder if this patch is still needed?

At least the error will be downgraded to a warning.  And while the
warning could be more user friendly, it still has value because it
reveals a toolchain bug.

-- 
Josh

