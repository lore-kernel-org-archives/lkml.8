Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E325C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8D3206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgGGUhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:37:17 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:58292 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGGUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:37:17 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jsuKy-0005md-NI; Tue, 07 Jul 2020 20:37:09 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jsuKw-0007dV-Pc; Tue, 07 Jul 2020 21:37:08 +0100
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: user-mode Linux
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        jdike@addtoit.com, richard@nod.at, corbet@lwn.net,
        johannes.berg@intel.com, brendanhiggins@google.com,
        erelx.geron@intel.com, linux@roeck-us.net, arnd@arndb.de,
        linux-um@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200707203246.53158-1-grandmaster@al2klimov.de>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <1d1838b0-91f6-e821-32f6-abb8d497cd74@cambridgegreys.com>
Date:   Tue, 7 Jul 2020 21:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707203246.53158-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2020 21:32, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>            If both the HTTP and HTTPS versions
>            return 200 OK and serve the same content:
>              Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>   Continuing my work started at 93431e0607e5.
>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>   If there are any URLs to be removed completely or at least not HTTPSified:
>   Just clearly say so and I'll *undo my change*.
>   See also: https://lkml.org/lkml/2020/6/27/64
> 
>   If there are any valid, but yet not changed URLs:
>   See: https://lkml.org/lkml/2020/6/26/837
> 
>   If you apply the patch, please let me know.
>   Rationale:
>   I'd like not to submit patches much faster than you maintainers apply them.
> 
>   Documentation/virt/uml/user_mode_linux.rst | 2 +-
>   arch/um/drivers/Kconfig                    | 2 +-
>   arch/um/drivers/harddog_kern.c             | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux.rst b/Documentation/virt/uml/user_mode_linux.rst
> index de0f0b2c9d5b..775d3de84331 100644
> --- a/Documentation/virt/uml/user_mode_linux.rst
> +++ b/Documentation/virt/uml/user_mode_linux.rst
> @@ -3753,7 +3753,7 @@ Note:
>   
>   
>     Documentation on IP Masquerading, and SNAT, can be found at
> -  http://www.netfilter.org.
> +  https://www.netfilter.org.
>   
>   
>     If you can reach the local net, but not the outside Internet, then
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 9160ead56e33..85e170149e99 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -259,7 +259,7 @@ config UML_NET_VDE
>   	To use this form of networking, you will need to run vde_switch
>   	on the host.
>   
> -	For more information, see <http://wiki.virtualsquare.org/>
> +	For more information, see <https://wiki.virtualsquare.org/>
>   	That site has a good overview of what VDE is and also examples
>   	of the UML command line to use to enable VDE networking.
>   
> diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
> index e6d4f43deba8..7a39b8b7ae55 100644
> --- a/arch/um/drivers/harddog_kern.c
> +++ b/arch/um/drivers/harddog_kern.c
> @@ -3,7 +3,7 @@
>    *	SoftDog	0.05:	A Software Watchdog Device
>    *
>    *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
> - *				http://www.redhat.com
> + *				https://www.redhat.com
>    *
>    *	This program is free software; you can redistribute it and/or
>    *	modify it under the terms of the GNU General Public License
> 

We should really try to finish the new documentation. The one in the 
kernel tree is very out of date.

The draft is here: https://github.com/kot-begemot-uk/uml-howto-v2


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
