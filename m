Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8717220809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393411AbgFSP1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:27:07 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:37699 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393432AbgFSPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:25:33 -0400
Received: (qmail 29577 invoked by uid 1019); 19 Jun 2020 15:18:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2020 15:18:50 -0000
Date:   Fri, 19 Jun 2020 15:18:50 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Chen Tao <chentao107@huawei.com>
cc:     tony@atomide.com, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix possible memory leak in
 omap_hwmod_allocate_module
In-Reply-To: <20200619104240.55978-1-chentao107@huawei.com>
Message-ID: <alpine.DEB.2.21.999.2006191518380.26224@utopia.booyaka.com>
References: <20200619104240.55978-1-chentao107@huawei.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020, Chen Tao wrote:

> Fix memory leak in omap_hwmod_allocate_module not freeing in
> handling error path.
> 
> Fixes: 8c87970543b17("ARM: OMAP2+: Add functions to allocate module data from device tree")
> Signed-off-by: Chen Tao <chentao107@huawei.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul
