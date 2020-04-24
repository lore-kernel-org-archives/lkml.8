Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB60C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF9120736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QRKaD2CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgDXTGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:06:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23293 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgDXTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:06:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587755196; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=Y0Xh9YwcFuchacYRPmOt5mmHgQmhT+OyA1r+OZ9piB0=; b=QRKaD2CJGHgqPpFlWiiZ5fd2krVfg9T8KE1fMlTclEVmZxykQP0wCRngqtap6ygi7c9e4i+c
 WDk6mRgfFCtGogvHYPp2aOIswrAZoa22Q5hCdBOUQBpSB6UovzCrQl8L1g6X1vBsgv3z4nhj
 +tXA+0kt2pYkZ3t0QjTD1mDxpJ8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea338af.7fe1991a80a0-smtp-out-n01;
 Fri, 24 Apr 2020 19:06:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D18CC433D2; Fri, 24 Apr 2020 19:06:23 +0000 (UTC)
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8CE7C433CB;
        Fri, 24 Apr 2020 19:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8CE7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Masahiro Yamada'" <masahiroy@kernel.org>,
        <linux-hexagon@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>
References: <20200424161502.656103-1-masahiroy@kernel.org>
In-Reply-To: <20200424161502.656103-1-masahiroy@kernel.org>
Subject: RE: [PATCH] hexagon: suppress error message for 'make clean'
Date:   Fri, 24 Apr 2020 14:06:21 -0500
Message-ID: <009101d61a6b$71f93a70$55ebaf50$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKG+ktipLZoGTdJhMlkCcPdnKK3f6cm4gQw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Masahiro Yamada
...
> 'make ARCH=hexagon clean' emits an error message as follows:
> 
>   $ make ARCH=hexagon clean
>   gcc: error: unrecognized command line option '-G0'
> 
> You can suppress it by setting the correct CROSS_COMPILE=, but we should
> not require any compiler for cleaning.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Acked-by: Brian Cain <bcain@codeaurora.org>


> ---
> 
>  arch/hexagon/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile index
> 4c5858b80f0e..c168c6980d05 100644
> --- a/arch/hexagon/Makefile
> +++ b/arch/hexagon/Makefile
> @@ -30,7 +30,7 @@ TIR_NAME := r19
>  KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -
> DTHREADINFO_REG=$(TIR_NAME) -D__linux__  KBUILD_AFLAGS += -
> DTHREADINFO_REG=$(TIR_NAME)
> 
> -LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> +LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name
> +2>/dev/null)
>  libs-y += $(LIBGCC)
> 
>  head-y := arch/hexagon/kernel/head.o
> --
> 2.25.1

