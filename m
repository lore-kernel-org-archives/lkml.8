Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD253C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846072072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AL08sAvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGMKsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgGMKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:48:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:48:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so15773283wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5bHtRaUlLsvF5kQSlI5SGY+rxlkl09WZX0Y9N5VT6eY=;
        b=AL08sAvz5D7mQ0jO2w9ZYfbGWktviB95wSp9dceUKhEiOhZPwmB3Wm1KinN4RzvUcl
         +SSr0cuJLYYFC1AlMNiO+zu+jWHEORACYoo9z6PbKsHgc8XcEjzpdQBieU2RnAyMyeeA
         SRkFEj1wnrJDZHWRVllm7Y3UMhxeTDIjGyRpaJX943uib6YOSf+/ihOnoFul7xJuGwI8
         ZJ5f7U0cCv38lsHdK0337tc1pXUy5d6Wy/79xoHFdrTA8tr4DXchBo6XkYppQe9aTp2F
         8+/lWDY2jwo/6qHN3Ss3voHvKBq8Fl5qYGKaSOpu9K7l9y+e3BNO/Oi1S+Lpde2e/JRf
         dDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5bHtRaUlLsvF5kQSlI5SGY+rxlkl09WZX0Y9N5VT6eY=;
        b=IoeaMVyKS4HAzbKlZhShznMTkq159cvB7fzBiRF6JYPZ0Iaic1FDY4gsI1dZnA7S0d
         DwriaB08f2wnRMrqIINxsf7SbT0i+JfLOZvlAUWANzagvokWnmo4h7YVWjXb/R1s/es4
         oz6jCd9WTDDTZ0b5pahUhHmbwbi8cP+cwfqhtFSw2SvTTrxjVW4jMu63k6u6+elm1x1y
         YFoOUtZgK0v0EVd4+zL1/xXbrTyKJSZjNJa5nCOJnIWgldsoZKRTbB3RsaoJjQHJYeK9
         CKE4FIe/YRNMB1n4pvVQTbUHCIfJtHbUkziAm9JyPutjFXc9+MkFfmwgpdeIMbXRpaRv
         ZOXA==
X-Gm-Message-State: AOAM532FQchoeghyQYzUSJx0gQswTqYpMiY2Miqx4q941wYYgFszOpi+
        t5DEVLfzVHJioVU+cWSTuGNEbg==
X-Google-Smtp-Source: ABdhPJx7pyReXo1pStdRlzwAyeGpLPJW8L0Gp4kWOkffUi9qRF+WHeffZ0olYz7X7slJzdrvAfkakg==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr78292690wrw.223.1594637298900;
        Mon, 13 Jul 2020 03:48:18 -0700 (PDT)
Received: from dell ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id l1sm23647155wrb.12.2020.07.13.03.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 03:48:18 -0700 (PDT)
Date:   Mon, 13 Jul 2020 11:48:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH 1/4] mfd: mt6360: Refactor and fix code style
Message-ID: <20200713104816.GD3500@dell>
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
 <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com>
 <20200713065110.GB3500@dell>
 <CAE+NS36uRRqHetQE5QVJ94WX4g7CdQzvD-0VOnLfKAbqdHs3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36uRRqHetQE5QVJ94WX4g7CdQzvD-0VOnLfKAbqdHs3Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月13日 週一 下午2:51寫道：
> >
> > On Fri, 10 Jul 2020, Matthias Brugger wrote:
> >
> > >
> > >
> > > On 07/07/2020 12:30, Gene Chen wrote:
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Rearrange include file.
> > > > Remove brackets around raw numbers.
> > > > Indicate sub-dev compatible name by using "-"
> > > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > > > Rename mt6360_pmu_data by mt6360_data.
> > > > Rename mt6360_pmu by mt6360.
> > >
> > > That seems like a lot of cosmetics. Why is this needed?
> > > If you think that's needed it should be split up in different commits, each
> > > explaining in the commit message why you do that.
> >
> > Agreed.  This set is still not broken up enough.
> >
> > Please place each logical change into its own patch for review.
> >
> 
> 1. Rearrange include file.
> After check serveral file about coding style, include file seems sort
> by architecture, not by alphabet
> 2. Remove brackets around raw numbers.
> Due to redundant brackets, another reviewer recommended to delete them.
> 3. Indicate sub-dev compatible name by using "-"
> Suggestion by Lees when review mfd binding document.
> 4. Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> Simplify the similar resources object.
> 5. Rename mt6360_pmu_data by mt6360_data.
> Not only include pmu part, but also entire MT6360 IC.
> 6. Rename mt6360_pmu by mt6360.
> Same reason as above.
> 
> We try to make code more simpler and easier to understand
> We can also discard changes if patch 1,2,4,5,6 doesn't make any difference.

I'm not sure what you're trying to say.

Please place each on of these changes into their own patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
