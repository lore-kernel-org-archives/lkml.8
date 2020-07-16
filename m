Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE2C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E9D20809
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGPKB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:01:58 -0400
Received: from elvis.franken.de ([193.175.24.41]:38164 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgGPKB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:01:57 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jw0iB-0008Mc-02; Thu, 16 Jul 2020 12:01:55 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A5E8EC080E; Thu, 16 Jul 2020 11:55:58 +0200 (CEST)
Date:   Thu, 16 Jul 2020 11:55:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Peng Fan <fanpeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips/vdso: Fix resource leaks in genvdso.c
Message-ID: <20200716095558.GF8455@alpha.franken.de>
References: <1594729818-7859-1-git-send-email-fanpeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594729818-7859-1-git-send-email-fanpeng@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:30:18PM +0800, Peng Fan wrote:
> Close "fd" before the return of map_vdso() and close "out_file"
> in main().
> 
> Signed-off-by: Peng Fan <fanpeng@loongson.cn>
> ---
> 
> v2:
>   - add one missing fclose()
> 
> ---
>  arch/mips/vdso/genvdso.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
