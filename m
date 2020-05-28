Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9F0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60852084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7YpP8yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391173AbgE1OY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:24:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52513 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390932AbgE1OYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590675863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8lVaUXox57ggEnjMJi0j+06kub1m1d4QvouQKu1sHk=;
        b=I7YpP8yvp0PaOosPmfk5/YD1sL71rjyJ3h+x0obkuTvHpp11i4wU747eAMaAk+3uOUcyxZ
        e7k2Pjt5WD33O7AHWs+Y9Si/wfoXwkGoQzFvvm0aLBm9LU7jz155bkOHlPyXeDnHzdCC3I
        +PXj7K1gGluWUaGmxrqEqpsrkUI0RZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-665ktRubNOSPyk6TEM-yZA-1; Thu, 28 May 2020 10:24:18 -0400
X-MC-Unique: 665ktRubNOSPyk6TEM-yZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BEC1054FA4;
        Thu, 28 May 2020 14:24:17 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1FEE5DA27;
        Thu, 28 May 2020 14:24:16 +0000 (UTC)
Date:   Thu, 28 May 2020 09:24:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/3] objtool: Add support for relocations without
 addends
Message-ID: <20200528142414.rzk5mvz4nwhsjcwp@treble>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <933488b79c91ba040e68847fe53531fd97b18e07.1590597288.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <933488b79c91ba040e68847fe53531fd97b18e07.1590597288.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:42:33AM -0700, Matt Helsley wrote:
> @@ -525,16 +556,8 @@ static int read_relocs(struct elf *elf)
>  				return -1;
>  			}
>  			memset(reloc, 0, sizeof(*reloc));
> -
> -			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
> -				WARN_ELF("gelf_getrela");
> +			if (read_reloc(sec, i, reloc, &symndx))
>  				return -1;
> -			}

I try to avoid function pointers, them being slow and ugly and all.

Since it's just a single call site, I'd rather a direct call.  For
example, call read_reloc(), which has an if-then to decide which
subfunction to call.

-- 
Josh

