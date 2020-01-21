Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B41206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkU8pzFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAUQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:30:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51124 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726555AbgAUQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579624218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mxflqPtTzg3Ku1VbkLyyrn7MV7M3mR8q27sY9MnBA2o=;
        b=CkU8pzFdFImRSWI76gxeNkQ65ju4U28Zz+B7r6t3DkRDyWjkJhTtGUUupgr1QecMRrkXac
        EyOmoPwwBzxQwkcOaMXpA0WjwQMCicxv9KN/awcZ+ajDuDbKSqjIDJPrXeTHRS9sLPoe5n
        c5yrZcg/l5ll20kE8VSQZSbP02umpv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-6-u4abFTOKCN3lU35lN2Fg-1; Tue, 21 Jan 2020 11:30:16 -0500
X-MC-Unique: 6-u4abFTOKCN3lU35lN2Fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09BCB101FEAF;
        Tue, 21 Jan 2020 16:30:14 +0000 (UTC)
Received: from treble (ovpn-122-154.rdu2.redhat.com [10.10.122.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08DCA48;
        Tue, 21 Jan 2020 16:30:12 +0000 (UTC)
Date:   Tue, 21 Jan 2020 10:30:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 04/57] objtool: check: Ignore empty alternative groups
Message-ID: <20200121163011.tk5koyg24gzuhoaa@treble>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-5-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-5-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:07PM +0000, Julien Thierry wrote:
> Atlernative section can contain entries for alternatives with no
> instructions. Objtool will currently crash when handling such an entry.
> 
> Just skip that entry, but still give a warning to discourage useless
> entries.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/check.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5968e6f08891..27e5380e0e0b 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -866,6 +866,13 @@ static int add_special_section_alts(struct objtool_file *file)
>  		}
>  
>  		if (special_alt->group) {
> +			if (!special_alt->orig_len) {
> +				WARN("empty alternative entry at %s+0x%lx",
> +				     orig_insn->sec->name,
> +				     orig_insn->offset);
> +				continue;
> +			}
> +

I think WARN_FUNC() can be used here instead.

-- 
Josh

