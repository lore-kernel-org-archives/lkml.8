Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B991C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNqDj9JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgD1Vnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:43:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgD1Vnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588110228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=795C5khWU64BH0APkyNGodE4Ma/7J5+bvPbGE8BS3RA=;
        b=LNqDj9JUVWf2kx1P1PGguqTdnXvi1s+KzhHG7Il/F+oBWshn1k0D6lhwG/WFyrhvh9MnSl
        phthqI3WL2uciYqVBHG39j7virPmOMYBlNqscC+Th88Wp8KtxUnZa0RSEY0XffHrTM1pqM
        lTqtG/t1WpumLprxxibNglqC+qhE1qQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-C_COGXFNMt6U13140gqJXA-1; Tue, 28 Apr 2020 17:43:41 -0400
X-MC-Unique: C_COGXFNMt6U13140gqJXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1E780058A;
        Tue, 28 Apr 2020 21:43:38 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7CB95D9E5;
        Tue, 28 Apr 2020 21:43:36 +0000 (UTC)
Date:   Tue, 28 Apr 2020 16:43:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/unwind/orc: fix unused function warnings
Message-ID: <20200428214334.dl7ywmggikpsq354@treble>
References: <20200428213618.3587684-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428213618.3587684-1-arnd@arndb.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:36:09PM +0200, Arnd Bergmann wrote:
> Without CONFIG_MODULES, these two variables are unused:
> 
> arch/x86/kernel/unwind_orc.c:29:26: error: 'cur_orc_table' defined but not used [-Werror=unused-variable]
>    29 | static struct orc_entry *cur_orc_table = __start_orc_unwind;
>       |                          ^~~~~~~~~~~~~
> arch/x86/kernel/unwind_orc.c:28:13: error: 'cur_orc_ip_table' defined but not used [-Werror=unused-variable]
>    28 | static int *cur_orc_ip_table = __start_orc_unwind_ip;
>       |             ^~~~~~~~~~~~~~~~
> 
> Move them into the #ifdef section.
> 
> Fixes: 153eb2223c79 ("x86/unwind/orc: Convert global variables to static")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I posted a similar patch yesterday (I also moved the mutex; not sure why
GCC didn't complain about that one).

https://lkml.kernel.org/r/20200428071640.psn5m7eh3zt2in4v@treble

> ---
>  arch/x86/kernel/unwind_orc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 0ebc11a8bb45..ea8f2aba663f 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -25,8 +25,6 @@ static bool orc_init __ro_after_init;
>  static unsigned int lookup_num_blocks __ro_after_init;
>  
>  static DEFINE_MUTEX(sort_mutex);
> -static int *cur_orc_ip_table = __start_orc_unwind_ip;
> -static struct orc_entry *cur_orc_table = __start_orc_unwind;
>  
>  static inline unsigned long orc_ip(const int *ip)
>  {
> @@ -191,6 +189,8 @@ static struct orc_entry *orc_find(unsigned long ip)
>  }
>  
>  #ifdef CONFIG_MODULES
> +static int *cur_orc_ip_table = __start_orc_unwind_ip;
> +static struct orc_entry *cur_orc_table = __start_orc_unwind;
>  
>  static void orc_sort_swap(void *_a, void *_b, int size)
>  {
> -- 
> 2.26.0
> 

-- 
Josh

