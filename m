Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F0BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935142054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X52MOy3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgHQPNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:13:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:13:08 -0400
Received: from zn.tnic (p200300ec2f26be00b1bb9962444976f9.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:b1bb:9962:4449:76f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD8A81EC0242;
        Mon, 17 Aug 2020 17:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597677184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i8MVmyah1Fs8KfXU9N/awUAHhqMXH1WZUfiLuvVrNJE=;
        b=X52MOy3NrN1+LRV78et6GuwdpO/kQSocJZyY1p18gEkt3UZ6K8NodJo6PcvBHqjJuny3zQ
        jKIQtPjlbCiMXnOFf/HjzIyUZqx7c1Q3W3WniEIkeAy1bJD06TnTdbHGCQ/cVdEZJequgE
        u5v8Mvt8wcFPWrgHDMcgpbEZ/VCYMvU=
Date:   Mon, 17 Aug 2020 17:13:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
Message-ID: <20200817151357.GK549@zn.tnic>
References: <20200805045955.GB9127@nazgul.tnic>
 <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
 <20200812210909.GA3283093@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812210909.GA3283093@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:09:09PM -0700, Sami Tolvanen wrote:
> The type mismatch broke allyesconfig in my test tree and your patch
> fixes the issue.

How are you building your allyesconfigs? Because allyesconfig works here
fine on latest Linus tree.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
