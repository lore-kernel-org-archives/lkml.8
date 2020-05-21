Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E4720748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgEUHSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:18:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:32937 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgEUHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:18:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jbfTA-0001b7-00; Thu, 21 May 2020 09:18:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3B807C0155; Thu, 21 May 2020 09:11:11 +0200 (CEST)
Date:   Thu, 21 May 2020 09:11:11 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/14] mips: MAAR: Use more precise address mask
Message-ID: <20200521071111.GA7309@alpha.franken.de>
References: <20200521003443.11385-1-Sergey.Semin@baikalelectronics.ru>
 <20200521003443.11385-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521003443.11385-9-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:34:37AM +0300, Serge Semin wrote:
> Indeed according to the MIPS32 Privileged Resource Architecgture the MAAR
> pair register address field either takes [12:31] bits for non-XPA systems
> and [12:55] otherwise. In any case the current address mask is just
> wrong for 64-bit and 32-bits XPA chips. So lets extend it to 59-bits
> of physical address value. This shall cover the 64-bits architecture and
> systems with XPA enabled, and won't cause any problem for non-XPA 32-bit
> systems, since address values exceeding the architecture specific MAAR
> mask will be just truncated with setting zeros in the unsupported upper
> bits.
> 
> Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v3:
> - In accordance with MIPS32/64 Privileged Resource Architecture Extend
>   the MAAR Addr mask to value [12:55] instead of P5600-specific [12:35].
> ---
>  arch/mips/include/asm/mipsregs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
