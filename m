Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68862C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44020578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgCKT1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:27:43 -0400
Received: from elvis.franken.de ([193.175.24.41]:34837 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbgCKT1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:27:43 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jC713-0008JO-00; Wed, 11 Mar 2020 20:27:41 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 34B1EC102F; Wed, 11 Mar 2020 20:19:50 +0100 (CET)
Date:   Wed, 11 Mar 2020 20:19:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joe Perches <joe@perches.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 014/491] DECSTATION PLATFORM SUPPORT: Use
 fallthrough;
Message-ID: <20200311191950.GA3588@alpha.franken.de>
References: <cover.1583896344.git.joe@perches.com>
 <79ddf8b6b0d77cd6489711e817fce622f8a85d0b.1583896348.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ddf8b6b0d77cd6489711e817fce622f8a85d0b.1583896348.git.joe@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 09:51:28PM -0700, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/mips/dec/tc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/dec/tc.c b/arch/mips/dec/tc.c
> index 732027c..dba583 100644
> --- a/arch/mips/dec/tc.c
> +++ b/arch/mips/dec/tc.c
> @@ -52,7 +52,7 @@ int __init tc_bus_get_info(struct tc_bus *tbus)
>  	case MACH_DS5900:
>  		tbus->ext_slot_base = 0x20000000;
>  		tbus->ext_slot_size = 0x20000000;
> -		/* fall through */
> +		fallthrough;
>  	case MACH_DS5000_1XX:
>  		tbus->num_tcslots = 3;
>  		break;

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
