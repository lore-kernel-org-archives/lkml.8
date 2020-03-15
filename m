Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F5C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B7206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXd6vsro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgCOQxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:53:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54043 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbgCOQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584291218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpvFDjuHFQyzad8SUb8awmaqk0WHVby5q2u1oNhYx0E=;
        b=hXd6vsroqrShvx7Yn1kiTaKaVcGn53Ufsd+3rNGnlzjbMC/o7RtY4iTVf/mOpJiJOMn/tJ
        gEqHoTxUxa63VnT5cY+6JwvXpGjemH5J6xW1JVRG4oKVbpq+EyMSqkGN6iHIyWWTq5hpSg
        ORtGGrNMy9KTrmqutBkuHarqTmb20xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-IIBvbmglMoe-YwVP9xtt8Q-1; Sun, 15 Mar 2020 12:53:37 -0400
X-MC-Unique: IIBvbmglMoe-YwVP9xtt8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9EB1800EBD;
        Sun, 15 Mar 2020 16:53:35 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3625DA2C;
        Sun, 15 Mar 2020 16:53:34 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:53:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 12/16] objtool: Optimize read_sections()
Message-ID: <20200315165332.xhspzupbebzyc3ud@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.112144649@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135042.112144649@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:19PM +0100, Peter Zijlstra wrote:
> +++ b/tools/objtool/elf.h
> @@ -25,6 +25,8 @@
>  #define ELF_C_READ_MMAP ELF_C_READ
>  #endif
>  
> +struct elf;
> +
>  struct section {
>  	struct list_head list;
>  	struct hlist_node hash;
> @@ -33,7 +35,7 @@ struct section {
>  	struct rb_root symbol_tree;
>  	struct list_head symbol_list;
>  	struct list_head rela_list;
> -	DECLARE_HASHTABLE(rela_hash, 16);
> +	struct elf *elf;

Instead of adding 'elf' here I'd rather just add it as an argument to
the find_rela_by_dest*() functions.

-- 
Josh

