Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1B0C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9EE206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVPLv+vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgD1QgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:36:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21541 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgD1QgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588091775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZSw0sfOhbTd86X0ZOrS/ZklbxGAUUDJETsqCkW2xtY=;
        b=MVPLv+vjhSJiNZPO7avRK76s7ZxtnetMOmqJn+tUho+F7vEdgV8TFMvzFhfW1x9DmELBHX
        5c5vYvkNxpXJYyTc7TTGTk9gFz3dOzl4+TvRb9QCNFKGfXAHLeGO3+jBpUs0x/Ye1doNPq
        6Ki+cS/Y7rKFcfuF7RACFxvbqXtITzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-RCilwnemN2G38vNQJbAwOA-1; Tue, 28 Apr 2020 12:36:10 -0400
X-MC-Unique: RCilwnemN2G38vNQJbAwOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDD6618FE860;
        Tue, 28 Apr 2020 16:36:09 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B0BB1002396;
        Tue, 28 Apr 2020 16:36:04 +0000 (UTC)
Date:   Tue, 28 Apr 2020 11:36:02 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v3 09/10] module: Remove module_disable_ro()
Message-ID: <20200428163602.77t6s2qeh4xeacdq@treble>
References: <cover.1587812518.git.jpoimboe@redhat.com>
 <33089a8ffb2e724cecfa51d72887ae9bf70354f9.1587812518.git.jpoimboe@redhat.com>
 <20200428162505.GA12860@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428162505.GA12860@linux-8ccs.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 06:25:05PM +0200, Jessica Yu wrote:
> +++ Josh Poimboeuf [25/04/20 06:07 -0500]:
> > module_disable_ro() has no more users.  Remove it.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Hm, I guess this means we can also remove the module_enable_ro() stubs
> in module.h and make it a static function again (like the other
> module_enable_* functions) as there are no more outside users. I have to
> remind myself after this patchset is merged :-)

Ah, true.  I'm respinning the patch set anyway, I can just add this as a
another patch.

-- 
Josh

