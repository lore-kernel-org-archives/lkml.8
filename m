Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F75C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D3E20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU7bqkTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbgFXDI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:08:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30984 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388356AbgFXDI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592968106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsWu8ZUl1jE3k6DJkKHds2eB9NM/YRkkX3/ygvqR5AE=;
        b=PU7bqkTKTBeVnGVSy2I0PYfBIrSN/3OSFoQtrJbX/B0GijcP0sHeaqYoEVm9DlNDOlJnJ5
        BG0XITGxFK/hJWxvA9kUgaJsMwKTc3KDqc6St7kklIskAZCq6/sJyZNIMZeFbVGHUitIZh
        yFlBnNBJZSGO8xpPw3mYSeq+OGMDEWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-gIuNpAsLNoSQXCKeSxl5rQ-1; Tue, 23 Jun 2020 23:08:24 -0400
X-MC-Unique: gIuNpAsLNoSQXCKeSxl5rQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F66C18585A1;
        Wed, 24 Jun 2020 03:08:22 +0000 (UTC)
Received: from treble (ovpn-113-107.rdu2.redhat.com [10.10.113.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 214CB1A836;
        Wed, 24 Jun 2020 03:08:20 +0000 (UTC)
Date:   Tue, 23 Jun 2020 22:08:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, Peter Zijlstra <peterz@infradead.org>,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v3 01/10] objtool: Do not assume order of parent/child
 functions
Message-ID: <20200624030818.bvv3kld63sguqxxm@treble>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-2-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-2-kristen@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:18AM -0700, Kristen Carlson Accardi wrote:
> If a .cold function is examined prior to it's parent, the link
> to the parent/child function can be overwritten when the parent
> is examined. Only update pfunc and cfunc if they were previously
> nil to prevent this from happening.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

FYI, this patch is now in the tip tree.

-- 
Josh

