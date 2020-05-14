Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC68C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA88C20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgENH5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:57:16 -0400
Received: from elvis.franken.de ([193.175.24.41]:53043 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgENH5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:57:10 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jZ8js-0005U5-04; Thu, 14 May 2020 09:57:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5C1C5C0493; Thu, 14 May 2020 09:44:14 +0200 (CEST)
Date:   Thu, 14 May 2020 09:44:14 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] KVM: MIPS/Emulate: Remove unneeded semicolon
Message-ID: <20200514074414.GE5880@alpha.franken.de>
References: <1588216776-62161-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588216776-62161-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:19:36AM +0800, Zou Wei wrote:
> Fixes coccicheck warnings:
> 
> arch/mips/kvm/emulate.c:1793:3-4: Unneeded semicolon
> arch/mips/kvm/emulate.c:1968:3-4: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  arch/mips/kvm/emulate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
