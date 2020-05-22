Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0D02072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feSSqWcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgEVQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:34:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbgEVQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590165284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOMkKJ07J37Hoz1dBPRLJd+gqZ2B5lqQxY83xP7h034=;
        b=feSSqWcS1nTUenoygAb0mHYfy+Xi/175H7rCxTAYUWTk9kriuXzjb5LggNIF8jZ8InBnOO
        XoToXqqRja2STVbNK0pZG04tgWMVxllGVGf7lgKTGskcG+JyXbUs2vkrtOFiCayA2hK4VT
        ad5t7XNYCaEUODVWcgPDc6NFiZfrJGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-c4U8KhTxOECgKM9Ieo-oAg-1; Fri, 22 May 2020 12:34:43 -0400
X-MC-Unique: c4U8KhTxOECgKM9Ieo-oAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2164835B42;
        Fri, 22 May 2020 16:34:41 +0000 (UTC)
Received: from treble (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DC4675262;
        Fri, 22 May 2020 16:34:40 +0000 (UTC)
Date:   Fri, 22 May 2020 11:34:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: linux-next: Tree for May 21 (objtool warnings)
Message-ID: <20200522163438.s6klcxhdduljg2d5@treble>
References: <20200522001209.07c19400@canb.auug.org.au>
 <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 07:34:38PM -0700, Randy Dunlap wrote:
> On 5/21/20 7:12 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200519:
> > 
> 
> on x86_64:
> 
> fs/open.o: warning: objtool: chmod_common()+0x104: unreachable instruction
> fs/namei.o: warning: objtool: do_renameat2()+0x482: unreachable instruction
> kernel/exit.o: warning: objtool: __ia32_sys_exit_group()+0x2e: unreachable instruction
> 
> 
> Full randconfig file is attached.

I think these are more -flive-patching related warnings.  Adding
Miroslav in case he gets to fixing them before I do :-)

-- 
Josh

