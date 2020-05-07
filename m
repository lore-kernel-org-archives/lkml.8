Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26163C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CEE20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5pVgRBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgEGX3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:29:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45954 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgEGX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588894187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7j8TEe3O7UjA+dXISCFnANVQJEFZiX8yWPLzttx088=;
        b=c5pVgRBbvmd1qoMpUmCgzosgaHM4M9UF1EDML9EJ/J4VBLrmkYh89ZJsiM5CRSNBP0mtS0
        L4m1W9ldnkDhY5V1NuWBewfpFzHORcIN6INhPOahGX3yE74Wf5SkYs8Us96B85ITHeK003
        Hbm79nPA8zb8HbMqBo9jIcMx84O+dZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-na4DKXKVOo2M5X0pPXRysw-1; Thu, 07 May 2020 19:29:45 -0400
X-MC-Unique: na4DKXKVOo2M5X0pPXRysw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 164161009600;
        Thu,  7 May 2020 23:29:44 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 883A360CD1;
        Thu,  7 May 2020 23:29:43 +0000 (UTC)
Date:   Thu, 7 May 2020 18:29:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200507232941.jccuywl56bppxfyp@treble>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:07:25PM +0200, Arnd Bergmann wrote:
> Hi,
> 
> During randconfig testing with clang-10 I came across a number
> of additional objtool warnings, I'll send another mail about those
> when I have collected more information and some object files.
> 
> This one sticks out however, as objtool returns an error code that
> stops the build:

> fs/dlm/lock.o: warning: objtool: __receive_convert_reply()+0x1e5: can't find jump dest instruction at .text+0xcaa7

Thanks for sending the patch for this one.  Objtool always gets confused
by new compiler versions, I really think we need to revert
 
  644592d32837 ("objtool: Fail the kernel build on fatal errors")

because objtool is never going to be reliable enough such that we can be
confident that failing the build is the right thing to do.

-- 
Josh

