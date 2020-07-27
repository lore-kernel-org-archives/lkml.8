Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30947C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A07206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYCwTD5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgG0Mxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgG0Mxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:53:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:53:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so13714011wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OKBC78fRUsagIQPVuNlcQcC33WynfMSk7xXsZ9n82rA=;
        b=bYCwTD5kGiJc9stvrIrWpJi8eMtSpUPEF24UjTrPUeYxuhFn0Rgk6BtH8i2UHYueEl
         NOD5q1z7ArkNw54bgJXM37dM0RHqB2/Znl38N7/85Wc+Hd6oslBMQiCgM1jb7gcjM3+o
         ZFq9mouI2Cgi/l3icqbcls2SXpvfFarLsa2Pd2pBxQXRO295JioWV9H4VfgRQ2C8R7Ry
         ayB6wOnvEnUVF9nREAR1Lhivz9CsEII2+C/aNnG6BOHH6MVUNDPDHOsIu6pox/MbWSSU
         bJcrWu2VhhMsDLR4O6rNpX3qm3TJwSdsuvXBFZrv7lMyUaeHO55u8/a0RMc8j56slAm/
         X+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OKBC78fRUsagIQPVuNlcQcC33WynfMSk7xXsZ9n82rA=;
        b=U9Bfc1mp6U6XEbjK1nXfMoF9EPJE9gDIXSxw5IyYPXuzQF/XzLNDP2EQYPXMKAc2+k
         Fqorql/Gc+g6joGuZULqWdJFK03VNwnXJuuYheQoKnYjO1RJ3UhPfA/GaGj8y7zWdhpY
         +Ap7sWktMUKzWN26jGqYc0XfrsCjjfVgMKqf9vqQTwTZJ1fDQt+Hcpzlb5ipfoEXKYXp
         SPIOEz5JXieZX1GviCVeM1Mx8/SnmahGHcYQv7SOZuE4sIw2mx6DmASBnqcCdWfrdeBe
         QcOBC5N7jVsgpTBQ9T+oGakjiJ5tteZSq9t8vvzWaUCjgnbwQ0yz3hPoL67LbeaK4WKZ
         8lqA==
X-Gm-Message-State: AOAM530TPP+JRBTrimtk45xaORpFm7yvUZUTctvwHSebvdvRA/kqRoe8
        Trul/kNuObjcP5zVx5WK77RFVw==
X-Google-Smtp-Source: ABdhPJzTYBZjZp631h4EWSAdPJc21hD2BcQhj8E+Hf8SShiAji9/FKFYk4MV1Y+v4RqIjdAmqmAF6g==
X-Received: by 2002:a1c:1d2:: with SMTP id 201mr19142377wmb.132.1595854417540;
        Mon, 27 Jul 2020 05:53:37 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c16sm12689205wrx.73.2020.07.27.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:53:36 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:53:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Xu Wang <vulab@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel_soc_pmic_mrfld: simplify the return expression of
 intel_scu_ipc_dev_iowrite8()
Message-ID: <20200727125335.GQ1850026@dell>
References: <20200727030407.8820-1-vulab@iscas.ac.cn>
 <20200727120908.GR3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727120908.GR3703480@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020, Andy Shevchenko wrote:

> On Mon, Jul 27, 2020 at 03:04:07AM +0000, Xu Wang wrote:
> > Simplify the return expression.
> 
> I understand your intention, but I would rather leave as is.
> It's a bit more helpful in the original form in case to add some debugging.

If you wish to add debugging, you'll have to add the extra line of
code yourself. :)

> It also keep it symmetrical with read() counterpart.

Can this be fixed-up too?

> That said, I'm not objecting the change if Lee finds it good enough.
> 
> > Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> > ---
> >  drivers/mfd/intel_soc_pmic_mrfld.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
