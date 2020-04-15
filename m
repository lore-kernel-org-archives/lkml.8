Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C0C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286F520768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441604AbgDOTJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:09:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416830AbgDOSg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:36:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72637AC22;
        Wed, 15 Apr 2020 18:36:25 +0000 (UTC)
Date:   Wed, 15 Apr 2020 20:36:20 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86 <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Message-ID: <20200415183620.GJ31362@zn.tnic>
References: <20200214222720.13168-4-tony.luck@intel.com>
 <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
 <3908561D78D1C84285E8C5FCA982C28F7F5E6485@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5E6485@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:19:47PM +0000, Luck, Tony wrote:
> Minor nit. You moved the #defines for the kflags bits to internal.h (which
> was a good thing), but left the "See below" comment here.

Yeah, can't rebase anymore but I'd take a fix ontop.

;-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
