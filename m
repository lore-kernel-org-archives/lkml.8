Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB53C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59822224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QThCNrkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgHFTCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgHFTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:02:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:02:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id di22so28748151edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yQz8jNT7jbM1zvtc9MWwIejDFC/8b3Ez/9JWOSG7lno=;
        b=QThCNrkJPHr7s8iGlc4uJowP3s2qbSNAZJpUW7ELidrJUK4mRke6zh9BN727pTaUcX
         s0Zdlw7Yaz2UO4I4m0bPU7i0qJgki0oxGA9nHGGa22RnjGxdNU/ZrqiH1bjNEtU3n0T7
         QhloKmQ7m8OCCX86CWv9iFnezJNfb5LboVOUqU1SoQOpM4AATGJUIwltweLLiPN/Wtqc
         KkE97A0v/Ob2s+fW8cVjdA1WCYb3a1f/aXSSns2Q3rWqgu1JGZm8ZFM910hEHPuSupIQ
         fDDi8TRxAAbWx9P0lLKwFYnP0XEPve49vOaD80w93nLM17VQ5XiNOGJq6SWp+38D1SO+
         +a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQz8jNT7jbM1zvtc9MWwIejDFC/8b3Ez/9JWOSG7lno=;
        b=hlTlYBELYSooFk69z34642OEXBxFD2dX7fuWqJAGVk06VASpaoDUxJ92k/ju+LTC89
         0qui+cdL5yfq7picE3qXDgGDO856q8PWxrrRAMXivm4r8/q2EkqaxVymxrE+yJDnfCqL
         8fIbU0PuLyPSjhDulWm8Nr2zpIX49K0bdE786ypa4WJlMvpiF7MygJbWGaY9Ngq+vTvl
         r4PfYL4rkdZrcqJS9eVFsL2moNzl+2JhGUumdN6WoJm/ZCy98vmytfTiJ7Ny39h2t/7V
         z2X1dAlYdZMK6Ay40lL/P3txqJF5J7mqhEHZEqQAU7qswkyvxY78PvpftYfwrauEMokx
         uCmg==
X-Gm-Message-State: AOAM532dT7oNSR215X109NOd1/+AvIhcU+SQNzAdjkuIAByD/DUYwx16
        nRz5hZ2d7TPg8v5XV6GbU1o=
X-Google-Smtp-Source: ABdhPJzm3Zj+ASLTF3FMTFHWlkAVgt69skwnKs2qqEcaZxXLYEOnyqK4lKXFT9L3QRgSHWdh9CG7uA==
X-Received: by 2002:aa7:db10:: with SMTP id t16mr5281903eds.196.1596740551235;
        Thu, 06 Aug 2020 12:02:31 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id w19sm4262655ejv.92.2020.08.06.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:02:30 -0700 (PDT)
Date:   Thu, 6 Aug 2020 21:02:29 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 6/6] openrisc: uaccess: Add user address space check
 to access_ok
Message-ID: <20200806190229.b7jbmkavu7qqzegy@ltop.local>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-7-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805210725.310301-7-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:07:25AM +0900, Stafford Horne wrote:
> Now that __user annotations are fixed for openrisc uaccess api's we can
> add checking to the access_ok macro.  This patch adds the __chk_user_ptr
> check, on normal builds the added check is a nop.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> index 85a55359b244..53ddc66abb3f 100644
> --- a/arch/openrisc/include/asm/uaccess.h
> +++ b/arch/openrisc/include/asm/uaccess.h
> @@ -57,7 +57,8 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
>  
>  #define access_ok(addr, size)						\
>  ({ 									\
> -	__range_ok((unsigned long)(addr), (size));			\
> +	__chk_user_ptr(addr);						\
> +	__range_ok((__force unsigned long)(addr), (size));		\
>  })

Just for info, __force is not needed when casting a pointer to
unsigned long (or uintptr_t). It's not incorrect to use one
but I think it's to avoid __force as much as possible.

-- Luc
