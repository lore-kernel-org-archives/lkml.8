Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39EEC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25B420781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmbG5VuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgDWTv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:51:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbgDWTvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587671484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/ZRfwaJsWeMlmhaE0MLI9ibN/qDljihHXGQSca7pOw=;
        b=ZmbG5VuO4vW5ywhGslaG9LDsCJZuGC/EPjNg+96J5K7BU3Y44kfFFv6U0+qCEceiJd0j2c
        3x0BXGvD7oMs85z1XkeaUbrPkZ5+XIIX6q6zLWtKBi9MuTwEN94dFIG2+MvBWaxqOEhQMz
        IbufzvyLIokvxkldQ9Oh4ke4JHFh/DE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-WSk22hD4M6uOAnRC_nsvuw-1; Thu, 23 Apr 2020 15:51:22 -0400
X-MC-Unique: WSk22hD4M6uOAnRC_nsvuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF539107BEF5;
        Thu, 23 Apr 2020 19:51:20 +0000 (UTC)
Received: from treble (ovpn-118-207.rdu2.redhat.com [10.10.118.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1146084C;
        Thu, 23 Apr 2020 19:51:19 +0000 (UTC)
Date:   Thu, 23 Apr 2020 14:51:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: linux-next: Tree for Apr 22 (objtool warnings)
Message-ID: <20200423195116.ftpqx6ff5ydy2jpp@treble>
References: <20200422171016.484b031d@canb.auug.org.au>
 <2bf0635d-1406-23db-28c7-e55da9a07e05@infradead.org>
 <20200422164406.qhvd2my35wnjlzyg@treble>
 <202004231053.5E4F16C3E8@keescook>
 <20200423182845.u7rthm67mqdqtuq5@treble>
 <202004231224.D6B3B650@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202004231224.D6B3B650@keescook>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:32:32PM -0700, Kees Cook wrote:
> On Thu, Apr 23, 2020 at 01:28:45PM -0500, Josh Poimboeuf wrote:
> > On Thu, Apr 23, 2020 at 11:06:14AM -0700, Kees Cook wrote:
> > > Regardless, the type_mismatch it triggered for misalignment and
> > > object-size checks, and the alignment check is likely going to always
> > > misfire on x86. The randconfig includes that config:
> > > 
> > > CONFIG_UBSAN_ALIGNMENT=y
> > > 
> > > So perhaps the config should be strengthened to disallow it under
> > > COMPILE_TEST?
> > > 
> > > config UBSAN_ALIGNMENT
> > >         def_bool !UBSAN_NO_ALIGNMENT
> > > 	depends on !COMPILE_TEST
> > 
> > But this issue basically makes UBSAN_TRAP unusable, right?  Should
> > UBSAN_ALIGNMENT and UBSAN_TRAP be made mutually exclusive?
> 
> Well, no, not UBSAN_TRAP alone. It seems that -fsanitize=alignment (and
> possibly -fsanitize=object-size) is likely to produce false positives. And
> that was already well understood. With UBSAN_TRAP, though, those functions
> become unusable. Part of the goal of adding UBSAN_TRAP was to be able to
> extract the non-false-positive sanitizer options out of UBSAN_MISC so
> they could be used in production without the large debug text overhead.
> (And the "alignment" checker had long since already been separate and
> set to false by default on x86, since it's going to trip over everything
> since it shouldn't get run on such hardware for any sane reason that
> I know of.) So, while UBSAN_TRAP with UBSAN_ALIGNMENT is going to be
> especially bad, UBSAN_ALIGNMENT at all is likely bad enough on x86, so
> I think it'd be best to make it a negative depends on COMPILE_TEST (but
> leave it available if someone is doing some really unusual UBSAN work).

I think I'm still missing why UBSAN_ALIGNMENT is even possible on x86.
But at least it sounds like your fix will keep the objtool reports from
coming in :-)

-- 
Josh

