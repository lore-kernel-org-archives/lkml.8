Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604F8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326C820723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593533939;
	bh=dTicqrGAqJYvU5F5OACn0DexTfdWgZmG06b7erbsdpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GUVWACFiwyAHoDFCnsIl1n8vsFOKfbgode6iHVziYhw0isoW7sXxm4vO06zKTHduX
	 P3Cpkwqqnls4s73Gikg3v7WTRxr/D/97SF7Dh1q4GfzHBNfQprwRWu7ou643OQsB0u
	 eAYGSy6DPk77eLIEc3onpbOyluyxfd/mEdEdvpFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgF3QS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgF3QSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:18:55 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C7820722;
        Tue, 30 Jun 2020 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593533934;
        bh=dTicqrGAqJYvU5F5OACn0DexTfdWgZmG06b7erbsdpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTk6Yz4ZHLFZ/QXk9b6+NxPFEu2htevoFjkGvU3KUlCshSj0JuWzw+48nFaqPtpEo
         XQGz9vzxhJpb75RsXc9xBrGFpn8uJJLPpThmjsPg5JeFev2MjhagZTaULU8HhbnBB3
         BYfnjklO8ocFYsozqV7veozKQpcGrgCP5lAjaNm4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqIyC-007nTv-SF; Tue, 30 Jun 2020 17:18:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 17:18:52 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] irqchip/gic-v3: Remove the unused register definition
In-Reply-To: <20200630134126.880-1-yuzenghui@huawei.com>
References: <20200630134126.880-1-yuzenghui@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <4d1319ffb0631f59bc5355b409331c42@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 14:41, Zenghui Yu wrote:
> As per the GICv3 specification, GIC{D,R}_SEIR are not assigned and the
> locations (0x0068) are actually Reserved. GICR_MOV{LPI,ALL}R are two 
> IMP
> DEF registers and might be defined by some specific micro-architecture,
> Linux doesn't use them.
> 
> As they're not used anywhere in the kernel, just drop all of them.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

To be clear, those were actually present in the spec back in the days
(in the 2013 time frame). It just shows how the architecture evolved...

I'll queue this for 5.9.

Thanks,

         M.

> ---
> 
> Compile tested on top of mainline.
> 
>  include/linux/irqchip/arm-gic-v3.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/irqchip/arm-gic-v3.h
> b/include/linux/irqchip/arm-gic-v3.h
> index 6c36b6cc3edf..f6d092fdb93d 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -19,7 +19,6 @@
>  #define GICD_CLRSPI_NSR			0x0048
>  #define GICD_SETSPI_SR			0x0050
>  #define GICD_CLRSPI_SR			0x0058
> -#define GICD_SEIR			0x0068
>  #define GICD_IGROUPR			0x0080
>  #define GICD_ISENABLER			0x0100
>  #define GICD_ICENABLER			0x0180
> @@ -119,14 +118,11 @@
>  #define GICR_WAKER			0x0014
>  #define GICR_SETLPIR			0x0040
>  #define GICR_CLRLPIR			0x0048
> -#define GICR_SEIR			GICD_SEIR
>  #define GICR_PROPBASER			0x0070
>  #define GICR_PENDBASER			0x0078
>  #define GICR_INVLPIR			0x00A0
>  #define GICR_INVALLR			0x00B0
>  #define GICR_SYNCR			0x00C0
> -#define GICR_MOVLPIR			0x0100
> -#define GICR_MOVALLR			0x0110
>  #define GICR_IDREGS			GICD_IDREGS
>  #define GICR_PIDR2			GICD_PIDR2

-- 
Jazz is not dead. It just smells funny...
