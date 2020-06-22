Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F133C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D8E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h23TU+Uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgFVWsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:48:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731022AbgFVWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592866099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mv8fpARqu3lji8M5/uXJdQHFtDF893EsJNB3F97WKyo=;
        b=h23TU+Uump2nrXq3RyJqNcpoaAbSj8WG5/HwnwjtZqKTemXlJjnAlzXy7lIz/Ixfbv9PVo
        JmgafsQhapSQUrWmRArnk6VA/pfyq72dCarRwRA0i22IuPkQsYV1lRcl8TJaXjq8HAAteq
        P8G+FPQwJh1Fq+XbIybzMk5kQHv4wJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-KnK5czC2P66Zj4vRZH2CuQ-1; Mon, 22 Jun 2020 18:48:15 -0400
X-MC-Unique: KnK5czC2P66Zj4vRZH2CuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2A18031CB;
        Mon, 22 Jun 2020 22:48:14 +0000 (UTC)
Received: from treble (ovpn-112-215.rdu2.redhat.com [10.10.112.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F2547168B;
        Mon, 22 Jun 2020 22:48:14 +0000 (UTC)
Date:   Mon, 22 Jun 2020 17:48:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [objtoo] fix memory leak in special_get_alts
Message-ID: <20200622224811.ske5jxc3s32yhgsp@treble>
References: <20200622020434.18159-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622020434.18159-1-gaurav1086@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 10:04:34PM -0400, Gaurav Singh wrote:
> Free alt before returning to avoid memory leak.
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>

Hi Gaurav,

Since objtool is a short-lived (and performance sensitive) process, we
don't care about memory leaks.  In fact we intentionally don't fix them.

-- 
Josh

