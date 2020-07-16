Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6CE207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z92LEFwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgGPNoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:44:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE08EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:44:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so5386195wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tPvUD+Jzvv3iWRg8/7rpNm8CjGwz7MHu7BZfaoonDng=;
        b=Z92LEFwTgmxAxCLyNA3Gi79kTX3HrUWTFsX2kFVvI7Hb9M6mIORxgS63z3ujToztg3
         aQQutln4iOa07LH8xB0zLGZ/WuGZd/kjwcFKxBpP1e5fvTu7EeqHnwxAQEM4OXjBIzYg
         ZiQEwStwucWsJec/27BCGM8AM8JvwDL0MhRnWOt3Om9oF3B2wRvKq8C7QG/rsr6m23IF
         wJuBEyL3myH6qPrx3wam1/6PTJxxAislUBhtuVvTOfzlMp9jct+uR+VuzDcK5Jnk7Fu/
         tidT3OQ10yxXWQWMgsBkgjBiwwljyvW76xAFZv6AO5nbzZh5qs0DuqrhmIvUF/Qz6yqw
         FJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tPvUD+Jzvv3iWRg8/7rpNm8CjGwz7MHu7BZfaoonDng=;
        b=K5Oy6jhkHeCXAeB53jM9amAh16bsrlBB4nHHlanxN4duzPU422R91q3QSzZgqrdHAJ
         J4q2nXleNsS6UP1ETYR1F2aHBzEdzemr0ZugSOItOQfAXnJvT9QKNGNtpouwV5M13vIb
         Yqb1njVZA9R89djYo1jAXp4A+VeFCBxcR4v+kaWoxNv7B24fr2TbR+uiN6zvBsrly9C6
         2aj6RbxVyG79fYdjgYwIcBx80rCJo7OJOaRI/Q/AFDL98ev8m6HD7UCBU2VlgGnpUqTy
         /JZh5OEXxh6/gWXJNuOJ3/kCe2EFWizahDC64kL1F8Sew7whK8FeWLU+6Hwqur19a52e
         g5ag==
X-Gm-Message-State: AOAM531Xas71+cct8sruoqDy0+dd2K1xHrw2tQeDqait5aFfyNoI/35C
        YahSousBNlAFuhp//Ruu32Hkyg==
X-Google-Smtp-Source: ABdhPJww5qpSJhbG0KBpS0QFSYaR7SsAgrYvay7pX+NyMK6HhSpQzKWYYhnNkbb+GmJ5Vny05u1uGQ==
X-Received: by 2002:a1c:b608:: with SMTP id g8mr4428615wmf.55.1594907048522;
        Thu, 16 Jul 2020 06:44:08 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id y77sm9612274wmd.36.2020.07.16.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:44:07 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:44:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH 1/4] mfd: mt6360: Refactor and fix code style
Message-ID: <20200716134406.GQ3165313@dell>
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
 <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com>
 <20200713065110.GB3500@dell>
 <CAE+NS36uRRqHetQE5QVJ94WX4g7CdQzvD-0VOnLfKAbqdHs3Sg@mail.gmail.com>
 <20200713104816.GD3500@dell>
 <CAE+NS36EEVb0JLDuZ_0tyocu7PeQSpyNGOWm-jWLW2kZFD=jYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36EEVb0JLDuZ_0tyocu7PeQSpyNGOWm-jWLW2kZFD=jYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月13日 週一 下午6:48寫道：
> >
> > On Mon, 13 Jul 2020, Gene Chen wrote:
> >
> > > Lee Jones <lee.jones@linaro.org> 於 2020年7月13日 週一 下午2:51寫道：
> > > >
> > > > On Fri, 10 Jul 2020, Matthias Brugger wrote:
> > > >
> > > > >
> > > > >
> > > > > On 07/07/2020 12:30, Gene Chen wrote:
> > > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > > >
> > > > > > Rearrange include file.
> > > > > > Remove brackets around raw numbers.
> > > > > > Indicate sub-dev compatible name by using "-"
> > > > > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > > > > > Rename mt6360_pmu_data by mt6360_data.
> > > > > > Rename mt6360_pmu by mt6360.
> > > > >
> > > > > That seems like a lot of cosmetics. Why is this needed?
> > > > > If you think that's needed it should be split up in different commits, each
> > > > > explaining in the commit message why you do that.
> > > >
> > > > Agreed.  This set is still not broken up enough.
> > > >
> > > > Please place each logical change into its own patch for review.
> > > >
> > >
> > > 1. Rearrange include file.
> > > After check serveral file about coding style, include file seems sort
> > > by architecture, not by alphabet
> > > 2. Remove brackets around raw numbers.
> > > Due to redundant brackets, another reviewer recommended to delete them.
> > > 3. Indicate sub-dev compatible name by using "-"
> > > Suggestion by Lees when review mfd binding document.
> > > 4. Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > > Simplify the similar resources object.
> > > 5. Rename mt6360_pmu_data by mt6360_data.
> > > Not only include pmu part, but also entire MT6360 IC.
> > > 6. Rename mt6360_pmu by mt6360.
> > > Same reason as above.
> > >
> > > We try to make code more simpler and easier to understand
> > > We can also discard changes if patch 1,2,4,5,6 doesn't make any difference.
> >
> > I'm not sure what you're trying to say.
> >
> > Please place each on of these changes into their own patch.
> >
> 
> I list all topic and reason why we want to modify.
> Before split into patches, can we discuss which topic reviewer can accept?
> or I need fix first?

Fix first please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
