Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B521EC352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F6B2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgBOGOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:14:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:46250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgBOGOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06BA1AC8F;
        Sat, 15 Feb 2020 06:14:03 +0000 (UTC)
Date:   Sat, 15 Feb 2020 07:14:02 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.5 495/542] docs: i2c: writing-clients:
 properly name the stop condition
Message-ID: <20200215071402.027c9120@endymion>
In-Reply-To: <20200214154854.6746-495-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
        <20200214154854.6746-495-sashal@kernel.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 10:48:07 -0500, Sasha Levin wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
> 
> [ Upstream commit 4fcb445ec688a62da9c864ab05a4bd39b0307cdc ]
> 
> In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
> condition".
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/i2c/writing-clients.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
> index ced309b5e0cc8..3869efdf84cae 100644
> --- a/Documentation/i2c/writing-clients.rst
> +++ b/Documentation/i2c/writing-clients.rst
> @@ -357,9 +357,9 @@ read/written.
>  
>  This sends a series of messages. Each message can be a read or write,
>  and they can be mixed in any way. The transactions are combined: no
> -stop bit is sent between transaction. The i2c_msg structure contains
> -for each message the client address, the number of bytes of the message
> -and the message data itself.
> +stop condition is issued between transaction. The i2c_msg structure
> +contains for each message the client address, the number of bytes of the
> +message and the message data itself.
>  
>  You can read the file ``i2c-protocol`` for more information about the
>  actual I2C protocol.

I wouldn't bother backporting this documentation patch to stable and
longterm trees. That's a minor vocabulary thing really, it does not
qualify.

-- 
Jean Delvare
SUSE L3 Support
