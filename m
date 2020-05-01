Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A3C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B0424953
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgEAP5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:57:48 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:43472 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729008AbgEAP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:57:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B28FB182CF666;
        Fri,  1 May 2020 15:57:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: word42_60d7cded7bb3e
X-Filterd-Recvd-Size: 3042
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 15:57:45 +0000 (UTC)
Message-ID: <3aeb6ab5059ec753d922051d7732e13322188e7c.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Fri, 01 May 2020 08:57:42 -0700
In-Reply-To: <20200501154033.GA25730@udknight>
References: <20200501154033.GA25730@udknight>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 23:40 +0800, Wang YanQing wrote:
> According to submitting-patches.rst, 'Fixes:' tag has a little
> stricter condition about the one line summary than normal git
> commit description:
> “...
> Do not split the tag across multiple lines, tags are exempt from
> the "wrap at 75 columns" rule in order to simplify parsing scripts
> ...”
> 
> And there is no sanity check for 'Fixes:' tag format in checkpatch
> the same as GIT_COMMIT_ID for git commit description, so let's expand
> the GIT_COMMIT_ID to add 'Fixes:' tag format check support.
> 
> The check supports below formats:
> Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> Fixes: 85f7cd3a2aad ("Revert "media: Kconfig: better support hybrid TV devices"")
> Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
> Fixes: 878520ac45f9 ("ext4: save the error code which triggered")
> Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")

Hi again YanQing.

I think all the non-standard and incomplete forms
should have a warning emitted.

> The check doesn't support below formats:
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
> Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power amplifiers)
> Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes)
> Fixes: ba35f8588f47 (“ipvlan: Defer multicast / broadcast processing to a work-queue”)
> Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
> Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd completion")
> Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')


> Note: this patch also fixes double quotation mark issue for normal git
>       commit description, and now it supports double quotation mark in
>       title line, for example:
>       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by default
>       when checking usable channels"")

Nice.


