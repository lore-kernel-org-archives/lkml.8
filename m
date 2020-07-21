Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE02C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12862176B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGUE7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:59:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50457 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUE7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:59:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF8566736F; Tue, 21 Jul 2020 06:59:31 +0200 (CEST)
Date:   Tue, 21 Jul 2020 06:59:31 +0200
From:   christoph hellwig <hch@lst.de>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     christoph hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicore32: use get_kernel_nofault in dump mem and
 dump_instr
Message-ID: <20200721045931.GA9672@lst.de>
References: <20200720114358.201161-1-hch@lst.de> <1fdc8e7c.4dfcd.1736f21e98b.Coremail.gxt@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fdc8e7c.4dfcd.1736f21e98b.Coremail.gxt@pku.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:09:20AM +0800, Guan Xuetao wrote:
> Very good to remove ds/fs in unicore arch.
> Could u send me full patch for test?

This is the full patch for now.  The actual removal will need
more core instrastructure and at least one more merge window.
