Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADDA22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGTNE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:04:58 -0400
Received: from verein.lst.de ([213.95.11.211]:46827 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgGTNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:04:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9224168BFE; Mon, 20 Jul 2020 15:04:56 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:04:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] uuid: Remove unused uuid_le_to_bin() definition
Message-ID: <20200720130456.GA715@lst.de>
References: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:53:55AM +0300, Andy Shevchenko wrote:
> There is no more user, so remove it.

Thanks,

applied to the uuid tree.
