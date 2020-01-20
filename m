Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67545C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF3F22314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgATNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:50:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgATNuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:50:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 854D9B04C;
        Mon, 20 Jan 2020 13:50:50 +0000 (UTC)
Date:   Mon, 20 Jan 2020 14:50:49 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] docs: i2c: i2c-protocol: use proper names for ACK
 and NACK
Message-ID: <20200120145049.32239ee2@endymion>
In-Reply-To: <20200105225012.11701-10-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-10-luca@lucaceresoli.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 23:49:56 +0100, Luca Ceresoli wrote:
> Use the proper ACK and NACK naming from the I2C specification instead of
> "accept" and "reverse accept".
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/i2c-protocol.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/i2c/i2c-protocol.rst b/Documentation/i2c/i2c-protocol.rst
> index 66adac3a5afd..9a4ac944cf9d 100644
> --- a/Documentation/i2c/i2c-protocol.rst
> +++ b/Documentation/i2c/i2c-protocol.rst
> @@ -11,7 +11,7 @@ Key to symbols
>  S               Start condition
>  P               Stop condition
>  Rd/Wr (1 bit)   Read/Write bit. Rd equals 1, Wr equals 0.
> -A, NA (1 bit)   Accept and reverse accept bit.
> +A, NA (1 bit)   Acknowledge (ACK) and Not Acknowledge (NACK) bit
>  Addr  (7 bits)  I2C 7 bit address. Note that this can be expanded as usual to
>                  get a 10 bit I2C address.
>  Comm  (8 bits)  Command byte, a data byte which often selects a register on

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
