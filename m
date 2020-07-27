Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B281C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC932075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMFfBxmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgG0LSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG0LSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:18:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63FAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:18:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so14376914wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ayi/e4qc8xsetgggFV1hGFKG2SY4MV5HUyFO2Mns7hA=;
        b=IMFfBxmDH9GeAp56UoH+TgHOtCIiUsNZQlRMuhPNR2+G6Zwp86/9MbqRT+5hTh47xv
         R9nBTL76EFjq8v3PQdXQ0BidZgDDDJOAO1RAflVBpHaJsdVlwtAf1SRZEqxZEtS6YQfr
         LxaCTVein0aWx2Gs87EjEy7GjkU5SePER0v9mjKisrOTw7hP7N2ytuez5fqEtSNfAb5G
         p6y1zLl2xVbkI5RL24b/psWd2L6OgSv0BxL45jKKat7HmncnEncoIzsv4fT+Wpw5Bl1g
         RwfIdJiw9oP9BBTbluqBzUnqTx9hWD3krEiuxhQWrxWo0r9bk3fkBTlwPqVG9R6p4ivg
         4Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ayi/e4qc8xsetgggFV1hGFKG2SY4MV5HUyFO2Mns7hA=;
        b=qLi3CmpmpqTGCjSDd4HrtOp0FY5tHjBNPwY01xNXn2ANYyQYONoNfg5G59oxPNZqAM
         If2DzF4XPQaSKDwYgUEtZK3MKtXXQc5IacOxJA6fJgM1bCVFgazbL1gdUuFtlrvLGHF1
         O7ehbZ1Jd8D/CgwWulFvIoxSAFsofS27ZKaBvURcuZ1CNgZleJFGhQcyCpC2PQV9DgF6
         j9F4yycUkVT9pmIdf0Oxu41n8BpWSRBqjnf9CW4u+4N4igdFNFsmvV8gWiIkeLY2Cj5Z
         vuHklsUqubzTDmz+Dc2rnlIaQzDwPTMmtwK3l5lyuxCxOtG9+KQgcd3JPswq4ghmhhc8
         eLCQ==
X-Gm-Message-State: AOAM533xmdDHAXO8xqAMO8t4m8OnXKxxVhogMlQHUOpnKIKJYiHbclGn
        egZ04k9JQaGc3rMPifrkgjW6QzYeOj77fg==
X-Google-Smtp-Source: ABdhPJyEVPTtaZkFD5puzMfIs+tGPWC79KREOCpaGAp8nx5iTohc4uOl5cs7PUgnZdn+9nAq+DobtA==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr19489176wmb.53.1595848685470;
        Mon, 27 Jul 2020 04:18:05 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id l1sm13038878wrb.12.2020.07.27.04.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:18:04 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:18:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 3/9] mfd: mt6360: Indicate sub-dev compatible name by
 using "-"
Message-ID: <20200727111802.GJ1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-4-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-4-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Indicate sub-dev compatible name by using "-".
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
