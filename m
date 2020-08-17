Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80122C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D042072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JLyHtJuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgHQSxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgHQSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:53:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D0C061389;
        Mon, 17 Aug 2020 11:53:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 594151EC026E;
        Mon, 17 Aug 2020 20:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597690421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R9rpQQ3QHK65dGeiLDAY9hsv8ikqXlZFeTV49qjDFhs=;
        b=JLyHtJuMAboC+cV46FCxtaqv6/HVYof2SrVxT377a4nEjVxBhWTBBZjvB2FWruvZeCoftT
        oxmab1CVK7Y+XDzb2G9AU00CkuADnq9K0D8MoBmdemyZFos51X34b5zQcoYRY1jtNV0Gnn
        wuCneV/LpbFQyLhQPohnFbuIoPkCjPA=
Date:   Mon, 17 Aug 2020 20:54:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
Message-ID: <20200817185436.GO549@zn.tnic>
References: <20200805045955.GB9127@nazgul.tnic>
 <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
 <20200812210909.GA3283093@google.com>
 <20200817151357.GK549@zn.tnic>
 <CABCJKuccY-wOEuQm--TQYgJvErOXu5u-jBMgCrM7JYsNqYK=gg@mail.gmail.com>
 <20200817174102.GN549@zn.tnic>
 <CABCJKud6M+u-TUZ2w5zdPPnwJQ1b7wxXwg8Rnoc=rBC6zMvRxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKud6M+u-TUZ2w5zdPPnwJQ1b7wxXwg8Rnoc=rBC6zMvRxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:11:02AM -0700, Sami Tolvanen wrote:
> Not the toolchain, the tree has patches for LTO+CFI, which tends to
> break with type mismatches. This doesn't affect just building the
> kernel with Clang without other changes.

Ok, that explains it.

As for why I'm still chasing down the exact reason for the reported
breakage: this will determine the urgency with which this fix is handled
and to which trees it needs to go so please be more precise next time
when saying "it broke". :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
