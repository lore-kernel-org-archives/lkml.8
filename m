Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4466C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959752073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa+Wbgb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgE2RzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:55:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgE2RzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590774903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6pCXUfjW+d3N2uTjEy5DSCilxOcTrAyjKzAzbQibfk=;
        b=Xa+Wbgb06r390vvYfxw+UC6XBpfWK4IbVDjzCg/+g98UQzFJ+N0lmyLpwctAjxv7GkU1ek
        7s1IX7LaSZs7PFQzhj3tHi+64x2UWjXXblKtHacTmBx2haVgSmY+dLwi9MFvD7uKcc1Zgc
        JVqaDOLRCLLgr9PeHqEmsjdYD96InK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-1Oaqm4M1MQaW3Y5RBGXAOg-1; Fri, 29 May 2020 13:55:00 -0400
X-MC-Unique: 1Oaqm4M1MQaW3Y5RBGXAOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59A71100A68C;
        Fri, 29 May 2020 17:54:59 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C1525C1B5;
        Fri, 29 May 2020 17:54:58 +0000 (UTC)
Date:   Fri, 29 May 2020 12:54:56 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 14 (objtool 2/2)
Message-ID: <20200529175456.tbedus7okjrlkao7@treble>
References: <20200514210716.30b416ee@canb.auug.org.au>
 <742521db-1e8c-0d7a-1ed4-a908894fb497@infradead.org>
 <20200528154404.74sjv4bdj3myacn6@treble>
 <202005282258.94570AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005282258.94570AF@keescook>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:06:32PM -0700, Kees Cook wrote:
> On Thu, May 28, 2020 at 10:44:04AM -0500, Josh Poimboeuf wrote:
> > On Thu, May 14, 2020 at 09:04:36AM -0700, Randy Dunlap wrote:
> > > On 5/14/20 4:07 AM, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Changes since 20200512:
> > > > 
> > > 
> > > on x86_64:
> > > 
> > > drivers/ide/ide-tape.o: warning: objtool: ide_tape_discard_merge_buffer.constprop.7()+0x4e: unreachable instruction
> > > drivers/scsi/sd.o: warning: objtool: sd_pr_clear()+0x1e: unreachable instruction
> > > drivers/scsi/sd_zbc.o: warning: objtool: sd_zbc_update_wp_offset_workfn()+0xec: unreachable instruction
> > > drivers/target/target_core_xcopy.o: warning: objtool: target_xcopy_do_work()+0xdd6: unreachable instruction
> > > 
> > > 
> > > randconfig file is attached.
> > 
> > Kees,
> > 
> > More UBSAN_TRAP fun.  This randconfig has:
> > 
> > CONFIG_UBSAN_TRAP=y
> > CONFIG_UBSAN_ALIGNMENT=y
> > # CONFIG_COMPILE_TEST is not set
> 
> Ugh, I thought CONFIG_COMPILE_TEST always gets set for randconfig and
> the all*config choices, but now I see that CONFIG_COMPILE_TEST is
> enabled due to the "all" part of the all*config choices. Okay. Big
> hammer:

Yeah, I didn't realize that either... /me wonders if that should change.

> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 929211039bac..27bcc2568c95 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -63,7 +63,7 @@ config UBSAN_SANITIZE_ALL
>  config UBSAN_ALIGNMENT
>         bool "Enable checks for pointers alignment"
>         default !HAVE_EFFICIENT_UNALIGNED_ACCESS
> -       depends on !X86 || !COMPILE_TEST
> +       depends on !UBSAN_TRAP
>         help
>           This option enables the check of unaligned memory accesses.
>           Enabling this option on architectures that support unaligned
> 
> How about that?

But I thought you said the alignment traps might be useful on other
arches?  Should it be

	depends on !X86 || !UBSAN_TRAP

?

-- 
Josh

