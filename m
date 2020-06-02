Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DC2206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLlypJ/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFBKcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFBKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:32:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30748C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 03:32:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so2844743wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KlmfffW2XSbkYvsmOsNbcsmnYUo/y3iq5oHmPHdTHaQ=;
        b=ZLlypJ/CuFsSyNV3DN2Ha4SZkMHS0N96qwx4Z0cqHcCC80a08KrXccPQwaKNTCewK/
         RE71Wz6C4rgZLQKM7/9kHctlMJvVXEGDf9dUKeNKSNWbHjUWvVaWUPMdFVGqE8vkP+uI
         hgZ3N+OKKn4TXeaEKmJgQ4AXdQS3+WpwtfMNVwaPqtzomZNZzFm2bFlQKBDnvta+sXZr
         Dfm7LE3j/ujA0UsLldLyz8i7+XdWCTuNtt2KBsHjm+4a62hTTI7hUiiQpciyGLA7VGmP
         E31at6jtNLz8/Q4WAh2OZHkHFHoTIRCK9KohU0sVdPgeP2WRv+LTCZB4bytSO8azymqJ
         f9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KlmfffW2XSbkYvsmOsNbcsmnYUo/y3iq5oHmPHdTHaQ=;
        b=DjRkNFUCfPPfcZ6zW6dwe6dXqCJMIrUons5PmKOdKwOrn8hfvCItKPMi4Mb8MpSe2O
         GTPzFTA5rHbZCEYNtvtoDirGUVKmYQf7EHZPyCtas2lOK2xBVnfShuXDhML7wnjKz727
         hnX3Q80CX7InW1eZBe5hDMI9CINWNPlTIFkWSSrHkuoNJRNLG0juxgDx00aao1w+GKtN
         hk0nMPWEbY8zA/AmkYSFmrcDb5A9RCOFvQAJ8jPPiBRIsJWetjKifSeMghF7nC4wzs7O
         jXnYA4K99PI+1dmrdloalJjdYNUBxAiDeQlGkzDScjZ3A3z1x8oV2y9Ff+vEOqZjYzbz
         rJfw==
X-Gm-Message-State: AOAM530EwCF+MiRGWhnoq76qCrQjqM0PvEfwD2gGvOowil51uLanX9/f
        +Ee30TDiz5kFpvpfoVLi3Hpkdw==
X-Google-Smtp-Source: ABdhPJxpOB9vo7otdW0hRZv3RvFPnuX5BR632FsJOEUd2/IuCmF0m4pQLOBikVssca89fSeFvE3hIw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr26141358wrt.341.1591093924698;
        Tue, 02 Jun 2020 03:32:04 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id r7sm2886185wmb.32.2020.06.02.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 03:32:03 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:32:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v10] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200602103202.GE3714@dell>
References: <1591070142-7653-1-git-send-email-gene.chen.richtek@gmail.com>
 <20200602082816.GC3714@dell>
 <2231bffe-27d1-6aee-4699-77d2f754beef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2231bffe-27d1-6aee-4699-77d2f754beef@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020, Matthias Brugger wrote:

> 
> 
> On 02/06/2020 10:28, Lee Jones wrote:
> > On Tue, 02 Jun 2020, Gene Chen wrote:
> > 
> >> From: Gene Chen <gene_chen@richtek.com>
> >>
> >> Add MFD driver for mt6360 pmic chip include Battery Charger/
> >> USB_PD/Flash, LED/RGB and LED/LDO/Buck
> >>
> >> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > I did not sign this off.
> > 
> 
> You are right, you provided your Acked-for-MFD-by and took an earlier version of
> the patch [1]. But as this didn't show up in linux-next I suppose you dropped it
> afterwards because of kbuild test errors (deducing from the changes log).

If the builders can see it, -next can pull from it.

It was never dropped.

> I suppose if this errors are fixed now, we should be fine :)

Indeed.  No more build errors. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
