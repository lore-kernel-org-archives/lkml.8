Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A9EC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89965206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1EevHCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDUUNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:13:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDUUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587499992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9HeTSfyPlkVvW4ulq1b0jN/kd/pOyFPzUX/DLpGmmI=;
        b=Q1EevHCXiLYXUqH9Y2wQtfkMrAxsS6e63/gcUhUJG5ZIoS+9sGZwrJAc8W2SVd+oL7Q7+T
        g8ifFe270mbO8Mm7d2fKNLOxGpqOPWmjjxsKcYIhcvq3/Gi09T7p+VNMXFXUqoNsyKY72d
        FJUNPAZIa5I8lNHN1Oy1JY+x+uIwq0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-QT7j9eXYNO6AyaAv6And_A-1; Tue, 21 Apr 2020 16:13:10 -0400
X-MC-Unique: QT7j9eXYNO6AyaAv6And_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1417107ACC4;
        Tue, 21 Apr 2020 20:13:08 +0000 (UTC)
Received: from treble (ovpn-114-228.rdu2.redhat.com [10.10.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBAF85C219;
        Tue, 21 Apr 2020 20:13:07 +0000 (UTC)
Date:   Tue, 21 Apr 2020 15:13:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: optimize add_dead_ends for split sections
Message-ID: <20200421201305.66y2u473htzcuhfu@treble>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421180724.245410-4-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:07:24AM -0700, Sami Tolvanen wrote:
> @@ -338,15 +351,13 @@ static int add_dead_ends(struct objtool_file *file)
>  		if (insn)
>  			insn = list_prev_entry(insn, list);
>  		else if (rela->addend == rela->sym->sec->len) {
> -			found = false;
> -			list_for_each_entry_reverse(insn, &file->insn_list, list) {
> -				if (insn->sec == rela->sym->sec) {
> -					found = true;
> -					break;
> -				}
> -			}
> +			struct section_info *sec_info = (struct section_info *)
> +				rela->sym->sec->section_info;
> +
> +			if (sec_info)
> +				insn = sec_info->last_insn;
>  
> -			if (!found) {
> +			if (!insn) {
>  				WARN("can't find unreachable insn at %s+0x%x",
>  				     rela->sym->sec->name, rela->addend);
>  				return -1;

Instead of the 'section_info' abstraction I think I'd rather just store
the 'last_insn' pointer directly in the section struct.

Also, the unreachable annotation at the end of a section is really an
edge case.  I'm sort of wondering if there's a way to accomplish the
same thing without storing the last_insn.

For example, I wonder if we could use find_insn() for some bytes at the
end of the section.  Most of the time I _think_ there will be a two-byte
UD2 instruction there anyway.  So maybe we could do something like:

	for (offset = rela->sym->sec->len - 1;
	     offset > rela->sym->sec->len - 10;
	     offset --) {

	     insn = find_insn(file, rela->sym->sec, offset);
	     if (insn)
	     	break;
	}

It's kind of ugly, but then we could maybe avoid the need for the
last_insn thing.

BTW, just curious, what's your use case for -ffunction-sections?  Is it
for fgkaslr?

-- 
Josh

