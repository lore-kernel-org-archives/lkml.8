Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693FC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1904206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgAXQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:01:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:55554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgAXQBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:01:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66FA0ACE3;
        Fri, 24 Jan 2020 16:01:11 +0000 (UTC)
Date:   Fri, 24 Jan 2020 17:01:10 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 28/28] docs: i2c: writing-clients: properly name the
 stop condition
Message-ID: <20200124170110.0a6110b2@endymion>
In-Reply-To: <20200123145626.8102-15-luca@lucaceresoli.net>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
        <20200123145626.8102-1-luca@lucaceresoli.net>
        <20200123145626.8102-15-luca@lucaceresoli.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 15:56:26 +0100, Luca Ceresoli wrote:
> In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
> condition".
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reported-by: Jean Delvare <jdelvare@suse.de>
> 
> ---
> 
> This patch is new in v2.
> ---
>  Documentation/i2c/writing-clients.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
> index 82aa33c964d3..978cc8210bf3 100644
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

Reviewed-by: Jean Delvare <jdelvare@suse.de>

I have reviewed the whole v2 series, so any patch to which I did not
reply to retains my Reviewed-by tag.

Thanks Luca!

-- 
Jean Delvare
SUSE L3 Support
