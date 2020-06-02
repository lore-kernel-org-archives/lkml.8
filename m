Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B8BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914E0206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3J4/69u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFBN1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:27:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgFBN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591104439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0pQY5Ii8PXeO0UpV8bNoE8fyQdiCbwa63Xrsl6aXGw=;
        b=M3J4/69uzJlpy1DD0MIujhf0G2fDySUMvFUv4UQHufoEBN6Mipy8yPRAzOlBeweP4Yhkl8
        pxuGD5TS7MapTJp52EKSqTS3xEbZTqK2u4pg6q7g/6ofXmRJdjQKWqMztr1JycP9F+bs/3
        OmzylAMV8nH/3lPzfp33po/2LA/lxko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ZM46vsn1NMyeIoHsDFXStw-1; Tue, 02 Jun 2020 09:27:14 -0400
X-MC-Unique: ZM46vsn1NMyeIoHsDFXStw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FAF107ACCD;
        Tue,  2 Jun 2020 13:27:10 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E6F76C776;
        Tue,  2 Jun 2020 13:27:04 +0000 (UTC)
Date:   Tue, 2 Jun 2020 08:27:02 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Bob Haarman <inglorion@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alistair Delva <adelva@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Baoquan He <bhe@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86_64: fix jiffies ODR violation
Message-ID: <20200602132702.y3tjwvqdbww7oy5i@treble>
References: <20200515180544.59824-1-inglorion@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515180544.59824-1-inglorion@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 11:05:40AM -0700, Bob Haarman wrote:
> `jiffies`
[...]
> `jiffies_64`
[...]
> ```
> In LLD, symbol assignments in linker scripts override definitions in
> object files. GNU ld appears to have the same behavior. It would
> probably make sense for LLD to error "duplicate symbol" but GNU ld is
> unlikely to adopt for compatibility reasons.
> ```

Kernel commit logs shouldn't be in Markdown.

Symbol names can just be in single quotes (not back-quotes!) like
'jiffies'.

Quotes can be indented by a few spaces for visual separation, like

  In LLD, symbol assignments in linker scripts override definitions in
  object files. GNU ld appears to have the same behavior. It would
  probably make sense for LLD to error "duplicate symbol" but GNU ld is
  unlikely to adopt for compatibility reasons.

or can be formatting like an email quote:

> In LLD, symbol assignments in linker scripts override definitions in
> object files. GNU ld appears to have the same behavior. It would
> probably make sense for LLD to error "duplicate symbol" but GNU ld is
> unlikely to adopt for compatibility reasons.


With Markdown-isms removed from the patch description:

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

