Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EA4C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C602F2072F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgEIOIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:08:06 -0400
Received: from verein.lst.de ([213.95.11.211]:57108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgEIOIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:08:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 607A168C7B; Sat,  9 May 2020 16:08:03 +0200 (CEST)
Date:   Sat, 9 May 2020 16:08:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Christoph Hellwig <hch@lst.de>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20200508 - build failure in kernel/resource.c w/
 SPARSEMEM=n
Message-ID: <20200509140802.GA26307@lst.de>
References: <17362.1589022588@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17362.1589022588@turing-police>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the problem is the select of CONFIG_DEVICE_PRIVATE.  Jason is
looking into it already.
