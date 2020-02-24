Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22140C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0048C20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBXRQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:16:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:47482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgBXRQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:16:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC40BAC44;
        Mon, 24 Feb 2020 17:16:24 +0000 (UTC)
Date:   Mon, 24 Feb 2020 18:16:18 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: x86/boot] x86/boot/compressed: Remove .eh_frame section
 from bzImage
Message-ID: <20200224171618.GA29636@zn.tnic>
References: <20200109150218.16544-2-nivedita@alum.mit.edu>
 <158254422067.28353.10866888120950973607.tip-bot2@tip-bot2>
 <20200224164129.GA312716@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224164129.GA312716@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:41:29AM -0500, Arvind Sankar wrote:
> Hi Boris, apologies for the confusion and unnecessary work I've created,
> but I think the preference is to merge the 2-patch series I posted
> yesterday [1] instead of this.
> 
> [1] https://lore.kernel.org/lkml/20200223193715.83729-1-nivedita@alum.mit.edu/

What guarantees this would work and we won't hit some corner case or
toolchain configuration this hasn't been tested on?

If that happens, I need to have a state to revert back to, i.e., this
patch, discarding .eh_frame explicitly.

So I'll pick up [1] too, but give people a couple of days - a chance to
complain about. :)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
