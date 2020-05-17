Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26E6206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEQIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 04:55:49 -0400
Received: from elvis.franken.de ([193.175.24.41]:56357 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgEQIzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 04:55:48 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jaF5B-0003F8-05; Sun, 17 May 2020 10:55:41 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7AA8AC04D6; Sun, 17 May 2020 10:43:00 +0200 (CEST)
Date:   Sun, 17 May 2020 10:43:00 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Guoyun Sun <sunguoyun@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips/mm: Add page soft dirty tracking
Message-ID: <20200517084300.GF3939@alpha.franken.de>
References: <1588149872-9780-1-git-send-email-sunguoyun@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588149872-9780-1-git-send-email-sunguoyun@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:44:32PM +0800, Guoyun Sun wrote:
> User space checkpoint and restart tool (CRIU) needs the page's change
> to be soft tracked. This allows to do a pre checkpoint and then dump
> only touched pages.
> 
> Signed-off-by: Guoyun Sun <sunguoyun@loongson.cn>
> ---
>  arch/mips/include/asm/pgtable-bits.h | 20 +++++++++++++--
>  arch/mips/include/asm/pgtable.h      | 48 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 64 insertions(+), 4 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
