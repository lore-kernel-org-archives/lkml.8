Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4652085B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JrJuCY8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgFPUhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPUhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:37:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:37:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c005d574143de1de924.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:5d57:4143:de1d:e924])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FE4E1EC0298;
        Tue, 16 Jun 2020 22:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592339870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4zT/WRletl+Xsh+/UZge/BuZpW+JSMfQvx7YHZ4aIH8=;
        b=JrJuCY8izwJs3Gxf8LqmIvQpgwI1pFsofZnxgf4NcySXCcdRClwc0WBShCBYJ93vRAPx+S
        r2TrTF/l0WmtPVAIqXIctOt1BjrDQ+1TMZpql9k/gfu9V7iRqp9J3rm0Tw8akOXldU6VFq
        WipXx/5OypznaZ8/xlFJ8VhsDe56Nhg=
Date:   Tue, 16 Jun 2020 22:37:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Linux 5.8-rc1
Message-ID: <20200616203741.GA13437@zn.tnic>
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:11:46PM +0200, Gabriel C wrote:
> I didn't look closer at that but from the error, it seems to be,
> some missing -fstack-protector* vs -fno-stack-protector* checks
> somewhere.

Can you give exact .config?

Also, what compiler exactly?

I have

CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_KEXEC_FILE=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y

here and gcc9 builds it fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
