Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC5620575
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQDmYhOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgCOPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:48:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbgCOPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584287306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHaALVUDu0M20Hyki2g2rh+A4DYEhy7YLnL4SmvPJS8=;
        b=gQDmYhOhKscbb90tQGkgq8gvjPiLeD8ychDvB7lZjyWaEKjLo81hW58PwN/+eqA2YL/zho
        7SJkk1n9tibadhnQezCJy1DtTPwWqQ/3lAcpuGCPhGlhd5eA+2oq1d7lpMnEWR65q+NKVm
        zZ0RfAnRWB/eaiOIBV4SQ8LXYTvI5+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-VmheJdoRPa6UvDE6Ei3D3Q-1; Sun, 15 Mar 2020 11:48:25 -0400
X-MC-Unique: VmheJdoRPa6UvDE6Ei3D3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D27361005512;
        Sun, 15 Mar 2020 15:48:23 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EC9C7388B;
        Sun, 15 Mar 2020 15:48:22 +0000 (UTC)
Date:   Sun, 15 Mar 2020 10:48:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 09/16] objtool: Optimize find_symbol_*() and
 read_symbols()
Message-ID: <20200315154819.bjkjrzprtbyf3zsj@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.935633394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.935633394@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:16PM +0100, Peter Zijlstra wrote:
> All of:
> 
>   read_symbols(), find_symbol_by_offset(), find_symbol_containing(),
>   find_containing_func()
> 
> do a linear search of the symbols. Add an RB tree to make it go
> faster.
> 
> This about halves objtool runtime on vmlinux.o, from 34s to 18s.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This one also doesn't apply on latest tip.

I assume we also need to optimize the new find_func_by_offset().

-- 
Josh

