Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB84C2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MRrfXOOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbgDCOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:35:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:33286 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585924552;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=xWGcb/l7SldX2juZaR8V+bjOtkYI2pMNM28oAI3XPqQ=;
        b=MRrfXOOieZKawrtFR0unAIALIKSs47Y1EX+ozjaxrNMMmk0hlCUq4ByhKJjUQax9ro
        23xObzVb/fgppbdD+wZYHC9xTGqc1/1YCsAGNt73D78bvPvHQ0EZ88Q7tSwo+t2tJQBZ
        lzRCyELT9yoTlNep1LtnolKx6YXdOGCZFhLgvun2a+5CR+AX8xul5Bv7EKI3r3+yhW9F
        VGwR4J8DAEIynobufzjB0QU78i05OqQPIKsbkPK3BTpedMgq2O4zoHWtnH8f8nW5MuX/
        grWhnl/zQvDqgSLO+2HU6csWb3fUYh+me0MsQzUF+0Pf/AJUV8CgRVTqFuFvNPJ/nlhs
        Op8Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h5mUrT"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id D07898w33EZZORH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 3 Apr 2020 16:35:35 +0200 (CEST)
Subject: Re: [PATCH] net: can: remove "WITH Linux-syscall-note" from SPDX tag
 of C files
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20200403073741.18352-1-masahiroy@kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f45febfa-a19a-0d76-d545-6427e5f1ce1e@hartkopp.net>
Date:   Fri, 3 Apr 2020 16:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403073741.18352-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2020 09.37, Masahiro Yamada wrote:
> The "WITH Linux-syscall-note" exception is intended for UAPI headers.
> 
> See LICENSES/exceptions/Linux-syscall-note
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Masahiro!


> ---
> 
>   net/can/bcm.c  | 2 +-
>   net/can/gw.c   | 2 +-
>   net/can/proc.c | 2 +-
>   net/can/raw.c  | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index c96fa0f33db3..d94b20933339 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /*
>    * bcm.c - Broadcast Manager to filter/send (cyclic) CAN content
>    *
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 65d60c93af29..49b4e3d91ad6 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /* gw.c - CAN frame Gateway/Router/Bridge with netlink interface
>    *
>    * Copyright (c) 2019 Volkswagen Group Electronic Research
> diff --git a/net/can/proc.c b/net/can/proc.c
> index e6881bfc3ed1..a4eb06c9eb70 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /*
>    * proc.c - procfs support for Protocol family CAN core module
>    *
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 59c039d73c6d..ab104cc18562 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /* raw.c - Raw sockets for protocol family CAN
>    *
>    * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
> 
