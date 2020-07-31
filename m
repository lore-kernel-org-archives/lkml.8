Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1111EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48EB2245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPU0S8RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgGaLMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:12:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C52C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 04:12:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so24670326wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SAJ/B5vlycsw95obezE/2ESChFtR1rGop3GZL1mr6Lo=;
        b=BPU0S8RALM+4SBkU/ZFFEL3yo2qQphBGZUs+LshQF7KlODLeCvfG4d/JmT+U9ly/rs
         W15FjoBZLQwg/HTpX0n/dZJcmeRnpoi1dtFF6Y91gg28NgbZolEHiuot9hYMuM6YOZ8u
         twVVDL1Vtesepv3ut0O5olUjb+pzArd1T0Y7Nuut8AgObrEH8O6iIa2AgXU7RsPAj1it
         ErQm+5MU3eIdG5EefdCKDWWNS2ej67t1BsZodVcp55+UOi5Rlbe0kYNYqncMRYs26DSp
         O1mSR0Y4vONAczHDpGrGK3UQ97vSqxOCi+/ZtkE/opPOUCY7Pt5QjGhc/O+T1lUqDXL8
         4QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SAJ/B5vlycsw95obezE/2ESChFtR1rGop3GZL1mr6Lo=;
        b=kVSlSoNRb7py/akqGyIQMT6GWTulUMoQPGsZwr00JviYZPQIKHciRfxqkEQH1fDea5
         i/JIdf6XUUsBw59nV+szBEXrjRjyJdgTaMIhn6KfT1aZdPajRAYIsK1XK8cT+fqQYYZh
         Vf2L19Yihvv++NnagE5DX+usW2WxlA5qBDCXQ8B0E/0RwEVebTs/+JqldEnG2p2aPUIK
         9zMWcsxZET/hu/rg9Lj7/dUK5CwVAANbTYYDgXf9pCBGYP6npdZyX31Sc2aUImdwQPBF
         imViNJTypT4WefCTVtTZRBQNzmhxab5y7m8CNAtugpo3okxgII6lDy94sEDPUt5DXFaD
         L/xA==
X-Gm-Message-State: AOAM532TFrIvTmlZJZO4QorNHqDmJ+dWHJF3Tq5wLfqltUDwRAR5H/Ps
        l+/LLcAsYSrqDMF44aTLtVM8CPA+r4s=
X-Google-Smtp-Source: ABdhPJyPGJOocU0OBLIk1fAQ0XbvtfJ/7/7qXWo5zswrtd805FbFvKYD9kgSAcyUo4x7eobsLiv+sA==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr3148164wrm.352.1596193952052;
        Fri, 31 Jul 2020 04:12:32 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id w2sm15366588wre.5.2020.07.31.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 04:12:31 -0700 (PDT)
Date:   Fri, 31 Jul 2020 12:12:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resouces
 into mt6360 regulator resources
Message-ID: <20200731111229.GL2419169@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com>
 <20200727112921.GK1850026@dell>
 <CAE+NS36cxY9KqxxcmuctK_W_3ZmZnC_xK8VVVaTZqC3vSoqbUw@mail.gmail.com>
 <20200728065422.GB1850026@dell>
 <CAE+NS34OFVf36zp7Nn0ETZ5KEaTet-P_VdPMuiZgqo1HfNxeYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS34OFVf36zp7Nn0ETZ5KEaTet-P_VdPMuiZgqo1HfNxeYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月28日 週二 下午2:54寫道：
> >
> > On Tue, 28 Jul 2020, Gene Chen wrote:
> >
> > > Lee Jones <lee.jones@linaro.org> 於 2020年7月27日 週一 下午7:29寫道：
> > > >
> > > > On Fri, 17 Jul 2020, Gene Chen wrote:
> > > >
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > >
> > > > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
> > > > > to simplify the similar resources object.
> > > >
> > > > Do the sub-devices actually share these resources, or are you doing
> > > > this just to make the code simpler?
> > > >
> > >
> > > They are different resources used by different bucks and ldos without
> > > sharing relations.
> > > I just to make the code simpler.
> >
> > I don't think that's sensible.
> >
> > You should only share resources with child devices that consume them.
> >
> 
> At first, I separated regulators into two drivers, mt6360-pmic.c and
> mt6360-ldo.c, according to default-on power or not.
> Then, I merged two drivers into mt6360-regulator.c and merged their
> resources as well.
> Therefore, for every device of BUCK/LDO, I'll find resources according
> to their name and request IRQs.

Okay, so all of the resources are consumed by a single driver?

That is fine then.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
