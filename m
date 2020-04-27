Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36070C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E2420661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh//qDpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgD0Ooq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:44:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgD0Oop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587998684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEqjYdrkdLqGjzEAPC59/etTU8La1rlKtJG+KVhtUAk=;
        b=Kh//qDpu6jMcSvko5MNJWg4/lQuNgBVEpgLCYfWihaYfk0Oai3r/kCEGqchwk1dLXdgysz
        DMqB/CcH4sErmbithKJmoc7XjjlkX6rTTD4YWQ7/LB2AhgVYA0eLBGXzkcS7mVF9MP/yNx
        snDtalNKQl9KLYPZe1CnbxV8hfvREIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-udzRVfYiOPeUN4GhD48OyQ-1; Mon, 27 Apr 2020 10:44:42 -0400
X-MC-Unique: udzRVfYiOPeUN4GhD48OyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C43E3189952F;
        Mon, 27 Apr 2020 14:44:41 +0000 (UTC)
Received: from treble (ovpn-112-186.rdu2.redhat.com [10.10.112.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF5327CD0;
        Mon, 27 Apr 2020 14:44:41 +0000 (UTC)
Date:   Mon, 27 Apr 2020 09:44:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: orc_gen: Fix memory leak in create_orc_entry
Message-ID: <20200427144439.rrywv56mjfypupgh@treble>
References: <20200427133533.GA20830@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427133533.GA20830@embeddedor>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:35:33AM -0500, Gustavo A. R. Silva wrote:
> In case memory resources for rela were allocated, release them before
> return.
> 
> Addresses-Coverity-ID: 1462331 ("Resource leak")
> Fixes: e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Hi Gustavo,

For performance reasons, our policy is to allow memory leaks in error
and exit paths.  So you may want to turn off Coverity resource leak
checking for objtool.

-- 
Josh

