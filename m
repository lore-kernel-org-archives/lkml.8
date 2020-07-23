Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D794C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C14A20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O87D55zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgGWRVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgGWRVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:21:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56DC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:21:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so1738562wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6NzrDM0ds5Yq5Je7cF0j6pK/Nn47qBuFSLY+rgHwqcM=;
        b=O87D55zOerszxleRneUW3MsL3Zcd/jynvRl4ZJp2B9KRGsqryhhzayQiv8NTtDZpP4
         qZdrNrHTVRay+czuHzrs2CZcwVK/M87/PfEqZ/7/R3ITkIjH1NDgIIOgjPkz5CEAvh8p
         Hc9RP/pNzBGnSpgurklYAWeixQYDOi3HFUJ+OGaW4azU8OVv08rUxYFNbJbl6Tm+iBdt
         2Ln/c+ZUxnroc64F6RakcttGTMeFnzRfatLcHEsrKvwtnfFn/yRdAPLT8a+WBhSF1f6+
         3fLvJl2HIkK2TJNPssEUsyFM5RuNLqccpqlfkJcVH+GrquDvwzJGhUrUq0M4SQPRMAtH
         h7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6NzrDM0ds5Yq5Je7cF0j6pK/Nn47qBuFSLY+rgHwqcM=;
        b=dc4WkbvSCdoRlbjM85bSsI1KXca6ylVAgEFdwzH6GDrOZ0PEcEKbPZwBUVbyKxDixq
         GW7d7/bs+9TmeyZVI49VzST6BuNXGO925ZtsWEUfb3Amw6O2/1UlhHPfXyXz+R6XO1Mx
         u7sKoAOMlam/mQMuicmwFUk5SBgpyhNBgk35/IH3X52cebocF5Qgw3N4bi82IN12dqli
         +qQLF+dAke+uD1bIyV0aGCW0qNUxYPZBRRt/yV8mWN6Nao9lBe37/B74ws5cBGXg4psn
         iO49F0xli4nZDm5cBm2/vJ2D1RUh/VljpApYSIv8D67WQkuIY57+GeDHPekj6968AiE+
         aGrA==
X-Gm-Message-State: AOAM530ZYqIbRcxyzQC8Ihx0+Wx/aAdWSKIYEUTkdGLbK5861FTsbVie
        n8YWSPGkN3hhIstUFufpwdCaoQ==
X-Google-Smtp-Source: ABdhPJwQCI0nkTlQ5dq9lK678xybKH15GLIY+72H7Gu/eRtHbRJyKIU6hxiqf2dlcWvEAZztEcQ6oQ==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr4785936wmg.184.1595524904039;
        Thu, 23 Jul 2020 10:21:44 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id s19sm4982242wrb.54.2020.07.23.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:21:43 -0700 (PDT)
Date:   Thu, 23 Jul 2020 18:21:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max14577: remove redundant initialization of
 variable current_bits
Message-ID: <20200723172141.GB1126023@dell>
References: <20200723161541.994669-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723161541.994669-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable current_bits is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mfd/max14577.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
