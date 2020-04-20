Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39477C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCEB2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDTIm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:38366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:42:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E370FAE0F;
        Mon, 20 Apr 2020 08:42:54 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:42:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>
Subject: Re: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Message-ID: <20200420084242.GA20918@zn.tnic>
References: <20200214222720.13168-4-tony.luck@intel.com>
 <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
 <20200420080640.GB32592@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420080640.GB32592@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 01:06:40AM -0700, Christoph Hellwig wrote:
> Err, how can you add a new field to an uapi structure and not break
> things?

By adding it to the end of the structure. The mcelog tool gets the
record length first, before doing anything with the records.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
