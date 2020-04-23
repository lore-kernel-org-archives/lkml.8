Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89506C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6977D2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOhUIpyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgDWS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:29:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24390 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730213AbgDWS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587666538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WY4j4xLXoEjjO+FSxypLaQudF35FLTSLr260CLOzwdA=;
        b=MOhUIpyB9Mvjg8OVmK338GwHqW3ABpn5VjQHoBzf7w4jCsZyM4AQBQKyRDnYKPjR6WAKeN
        ClyDhyLMbvAwKKQIveCu4LkLXwY3G/74hPjblpgRjmYvFdC8qS6BB1+uocFtKfVIhQ7Gd8
        loWpIY6UNicj7rZu3shLZV1dtlVZpOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-0_iayr00MD2eHKzBZi7y0g-1; Thu, 23 Apr 2020 14:28:56 -0400
X-MC-Unique: 0_iayr00MD2eHKzBZi7y0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D524645F;
        Thu, 23 Apr 2020 18:28:54 +0000 (UTC)
Received: from treble (ovpn-118-207.rdu2.redhat.com [10.10.118.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BC065D706;
        Thu, 23 Apr 2020 18:28:50 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:28:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Apr 22 (objtool warnings)
Message-ID: <20200423182845.u7rthm67mqdqtuq5@treble>
References: <20200422171016.484b031d@canb.auug.org.au>
 <2bf0635d-1406-23db-28c7-e55da9a07e05@infradead.org>
 <20200422164406.qhvd2my35wnjlzyg@treble>
 <202004231053.5E4F16C3E8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202004231053.5E4F16C3E8@keescook>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:06:14AM -0700, Kees Cook wrote:
> On Wed, Apr 22, 2020 at 11:44:06AM -0500, Josh Poimboeuf wrote:
> > On Wed, Apr 22, 2020 at 08:35:29AM -0700, Randy Dunlap wrote:
> > > On 4/22/20 12:10 AM, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Changes since 20200421:
> > > > 
> > > 
> > > on x86_64:
> > 
> > In both cases the unreachable instruction happens immediately after a
> > call to a function which is truncated with a UD2 (because of
> > UBSAN_TRAP).
> > 
> > When I remove UBSAN_TRAP, the UD2s are replaced with calls to
> > __ubsan_handle_type_mismatch_v1().
> 
> Hrm, these are coming out of CONFIG_UBSAN_MISC, yes? It seems that the
> UBSAN checks that are non-recoverable all inject unreachable checks
> afterwards, from what I can see.
> 
> > Kees, any idea?
> 
> Isn't this another version of the earlier unreachable-ud2 issue?

Yes, basically.  Objtool has figured out that these are calls to
functions which never return.  So the instruction after the call is
unreachable.  Usually GCC also knows that, and knows not to emit the
extra unusuable instructions, but I guess this plugin is different.

> Regardless, the type_mismatch it triggered for misalignment and
> object-size checks, and the alignment check is likely going to always
> misfire on x86. The randconfig includes that config:
> 
> CONFIG_UBSAN_ALIGNMENT=y
> 
> So perhaps the config should be strengthened to disallow it under
> COMPILE_TEST?
> 
> config UBSAN_ALIGNMENT
>         def_bool !UBSAN_NO_ALIGNMENT
> 	depends on !COMPILE_TEST

But this issue basically makes UBSAN_TRAP unusable, right?  Should
UBSAN_ALIGNMENT and UBSAN_TRAP be made mutually exclusive?

-- 
Josh

