Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34DFC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DB9205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKd335BS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgCOQlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:41:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728682AbgCOQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584290506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJr/5VwKlS1q5gn4GdEeh76WaOebJpHy3FSu4Tims2o=;
        b=TKd335BS6MnsLZ6ri5ERbKobl6VwIcXH3EQlB0TTBqy/WepjBDs7CEYV25/M7ULijcmKnJ
        14K5RuP9QxRWF+3gwdih7OPoa3wnIojPGojm/dSwAfSn6jD9DHkGSoBM3ItyvZAVncGZEr
        84oiggEOPqGPseqZe//5rwbrm3J3HdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-I8ZsNOLdNjyyWWQm1C_lmw-1; Sun, 15 Mar 2020 12:41:42 -0400
X-MC-Unique: I8ZsNOLdNjyyWWQm1C_lmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D17107ACCA;
        Sun, 15 Mar 2020 16:41:41 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E81F60BFB;
        Sun, 15 Mar 2020 16:41:40 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:41:37 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 09/16] objtool: Optimize find_symbol_*() and
 read_symbols()
Message-ID: <20200315164137.cni4vswi4wyl33s6@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.935633394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.935633394@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:16PM +0100, Peter Zijlstra wrote:
>  struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>  {
> -	struct symbol *sym;
> +	struct rb_node *node;
>  
> -	list_for_each_entry(sym, &sec->symbol_list, list)
> -		if (sym->type != STT_SECTION &&
> -		    sym->offset == offset)
> -			return sym;
> +	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
> +		struct symbol *s = rb_entry(node, struct symbol, node);
> +
> +		if (s->offset != offset)
> +			continue;
> +
> +		if (s->type != STT_SECTION)
> +			return s;
> +	}

Can be simplified to:

		if (s->offset == offset && s->type != STT_SECTION)
			return s;

-- 
Josh

