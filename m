Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F15C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320B7214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="tnM+lKKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436666AbgFSSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388608AbgFSSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:41:13 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57412C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:41:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 799311500319;
        Fri, 19 Jun 2020 20:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592592071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L1X5Wlz0l9aM5xeJbCoKmndqKOAybV/aM+tduBgsy70=;
        b=tnM+lKKfcH+Fe9ZsKjPPrbUeMTF+z4QRgOodKLmriay6UlIvA9UoWxL83V5IML087BothY
        2wEl66IreG7hHVU9191mopMDy+lm/cH/HLVkmGD8JpKQ94pArH13QG/hJqIneKwSBUMGf6
        WIBF5kZrkUrsAy7KQz4cytCiJsFs4gfa600JAc+RKQiBGkfSv9Bl8Lkiyzxp7+vIjlQSl0
        T2gPM6FZEP7JNu/pHcHPJu2JszZuTPDTlb2kPQ7+8hkuFBgYnZ+9wIKBfOnXQ6HS+9B/ma
        D0k36Hzgnr8CzO66KQNyAHxN3iEMm9JliinLplkBYMQDEXBttVMP5D/i2t3bhQ==
Date:   Fri, 19 Jun 2020 20:41:04 +0200
From:   Simao Gomes Viana <devel@superboring.dev>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 1/2] drivers: cdrom: fix all errors reported by
 checkpatch
Message-ID: <20200619184049.4fn2rljaay6v7bjy@simao-arch.localdomain>
References: <20200619180834.8032-1-devel@superboring.dev>
 <f6102c402ae3f4232aebf4e102953f21fdb86cf6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6102c402ae3f4232aebf4e102953f21fdb86cf6.camel@perches.com>
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:29:59AM -0700, Joe Perches wrote:
> On Fri, 2020-06-19 at 20:08 +0200, Simao Gomes Viana wrote:
> > This fixes all errors that scripts/checkpatch.pl
> > reports about drivers/cdrom/*.c and a lot of warnings
> > as well. I skipped warnings that I don't know whether
> > fixing them will break anything.
> 
> This is too many changes in a single patch to verify
> them easily.
> 
> If you really want to change this file, and it's likely
> not particularly necessary, I suggest that you send a
> patch series that where each patch individually does:
> 
> 1: Horizontal whitespace only changes
>    o Trim trailing whitespace
>    o Add alignment whitespace
>    o Add operator spacing whitespace
> 2: Vertical whitespace changes if any
> 3: Convert embedded assignments to multiple lines
> 4: Comment style updates
> 
> And whatever other specific style changes necessary
> to properly and easily identify them as correct.
> 
>

Thank you for your feedback.
I will follow up with a proper set of patches as you 
described in your response.

I'm fairly new to submitting patches. Although I have read
through some of the guidelines there is always room for
improvement so it's great to get feedback like that.

