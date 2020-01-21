Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDF6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441272253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9PZg8HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAUQh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:37:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729080AbgAUQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579624677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yf4F2Q+jP5jpb9BsV98BXepooKGbqCkOI9lfShBlAeQ=;
        b=X9PZg8HO1/T0iLnm2bUaCaf46MVsQELz/8OFLSL3xgR0PJ5VBWgmtkAA+QnmLXNqzSVc6E
        t/eXu1Wob6OO7Pk2kdhnUZlmocHH6W7nPybuCxBAvBTJAkt49efynWkUlP2vcV6ftT6RlI
        Ax3dtQU8rOFjCxDorkHaPk/tdqaQtHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-VrUfivWiNLS7ip51Icjx2g-1; Tue, 21 Jan 2020 11:37:52 -0500
X-MC-Unique: VrUfivWiNLS7ip51Icjx2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB33C2F2E;
        Tue, 21 Jan 2020 16:37:50 +0000 (UTC)
Received: from treble (ovpn-122-154.rdu2.redhat.com [10.10.122.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 309105C1BB;
        Tue, 21 Jan 2020 16:37:49 +0000 (UTC)
Date:   Tue, 21 Jan 2020 10:37:47 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 08/57] objtool: Make ORC support optional
Message-ID: <20200121163747.kbasjd2wn4q44vcf@treble>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-9-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-9-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:11PM +0000, Julien Thierry wrote:
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index d2a19b0bc05a..24d653e0b6ec 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -6,6 +6,10 @@ ifeq ($(ARCH),x86_64)
>  ARCH := x86
>  endif
>  
> +ifeq ($(ARCH),x86)
> +OBJTOOL_ORC := y
> +endif

I think this should check SRCARCH instead, a la:

  https://lkml.kernel.org/r/d5d11370ae116df6c653493acd300ec3d7f5e925.1579543924.git.jpoimboe@redhat.com

-- 
Josh

