Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE80206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgGMRec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:34:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:36130 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbgGMRec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:34:32 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 76EC12E2;
        Mon, 13 Jul 2020 17:34:31 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:34:30 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, openrisc@lists.librecores.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with HTTPS
 ones
Message-ID: <20200713113430.1c1777bb@lwn.net>
In-Reply-To: <20200710062019.28755-1-grandmaster@al2klimov.de>
References: <20200710062019.28755-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 08:20:19 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/openrisc/openrisc_port.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
> index 4b2c437942a0..657ac4af7be6 100644
> --- a/Documentation/openrisc/openrisc_port.rst
> +++ b/Documentation/openrisc/openrisc_port.rst
> @@ -8,7 +8,7 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
>  For information about OpenRISC processors and ongoing development:
>  
>  	=======		=============================
> -	website		http://openrisc.io
> +	website		https://openrisc.io
>  	email		openrisc@lists.librecores.org
>  	=======		=============================

Applied, thanks.

jon
