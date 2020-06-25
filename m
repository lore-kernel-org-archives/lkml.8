Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63C3206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUhPTx8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbgFYHNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFYHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:13:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33243C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:13:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so4481442wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PGrFn0XRF8uRjgWBcvu5PNhHZSeJg99S++WxkFtMkJg=;
        b=CUhPTx8zB8HG/jcwwRDUYIHNNuZEJLNauEiMY3C8REU8XySPEUL2z+OjVtjtmvZp1V
         gv64csC0HP0xav0rLymHXUpb4c76VdX/oASWUyNAS7ATXvVYxBVX0eNKC2wrr31y+n6I
         Dhk9lYjjVjun2tV6q+X/T1vDfzdYcOxeJTsOCppWVILpxk/206vBT7P4EmmnZfbSdNht
         p/73hFHkszMDi4+PyWy/KzxjAreb1/zrkSgBzJkW7cfBwEwSTONHt2rIPxVC8BEZDBNS
         ASE2YzV4UB5l7ejYhwAUYLv5PjwGu1pq2B/RKISqBFpxF8s7Ug8ubH2jab497xOpxYao
         CmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PGrFn0XRF8uRjgWBcvu5PNhHZSeJg99S++WxkFtMkJg=;
        b=Rij6006p9q6lJ4wQ/+3oEyj+QOy5Ll1Q6VN7mBaWAoyvsibv96s0dcWN/aF7xmWeMu
         LGv8WQ8+O5xatjlJ/0EMRIQGIOl7yC0QLBu/n2jGfBqMsw938EK7wL3oKs7l3QT/+P3N
         X5YGh8i5wJuh0miuSAy6cv5/k/A11WRa38xVd16udSaEPpXw+mGiwX+5NAA0Hj+NB7he
         3vKvGLLoUneRehO0Ppdl/zCsfb1Drf7RSz8xpvLXeAdR0aO845TaUADv/OCPh5+7McMW
         J4B2L740ZET3HMX9cHlpLFR6lWoDrgrezORDZv5XhbHcY2yAlsuriihCgszA3v2m3emt
         RI5w==
X-Gm-Message-State: AOAM532V+11lQm1kmPK5XiTXXt32tcLh/xMhNb7lygFIfIpvXsl7ZQZR
        TvzINSg8cLq7307Uso+G4I2wfQ==
X-Google-Smtp-Source: ABdhPJw8CK6oDvUI2B5bmK60SBWVP+jU29EXOd9oqJLvueX5GkJxnGw69NGYQHimfWSQI2tVlu/hDA==
X-Received: by 2002:a1c:5583:: with SMTP id j125mr1867316wmb.189.1593069195923;
        Thu, 25 Jun 2020 00:13:15 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c18sm5124907wmk.18.2020.06.25.00.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 00:13:15 -0700 (PDT)
Date:   Thu, 25 Jun 2020 08:13:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 01/10] mfd: wm8350-core: Supply description
 wm8350_reg_{un}lock args
Message-ID: <20200625071313.GM954398@dell>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
 <20200625064619.2775707-2-lee.jones@linaro.org>
 <20200625065608.GB2789306@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625065608.GB2789306@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Greg KH wrote:

> On Thu, Jun 25, 2020 at 07:46:10AM +0100, Lee Jones wrote:
> > Kerneldoc syntax is used, but not complete.  Descriptions required.
> > 
> > Prevents warnings like:
> > 
> >  drivers/mfd/wm8350-core.c:136: warning: Function parameter or member 'wm8350' not described in 'wm8350_reg_lock'
> >  drivers/mfd/wm8350-core.c:165: warning: Function parameter or member 'wm8350' not described in 'wm8350_reg_unlock'
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: patches@opensource.cirrus.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/wm8350-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/mfd/wm8350-core.c b/drivers/mfd/wm8350-core.c
> > index 42b16503e6cd1..fbc77b218215c 100644
> > --- a/drivers/mfd/wm8350-core.c
> > +++ b/drivers/mfd/wm8350-core.c
> > @@ -131,6 +131,8 @@ EXPORT_SYMBOL_GPL(wm8350_block_write);
> >   * The WM8350 has a hardware lock which can be used to prevent writes to
> >   * some registers (generally those which can cause particularly serious
> >   * problems if misused).  This function enables that lock.
> > + *
> > + * @wm8350: pointer to local driver data structure
> >   */
> >  int wm8350_reg_lock(struct wm8350 *wm8350)
> >  {
> > @@ -160,6 +162,8 @@ EXPORT_SYMBOL_GPL(wm8350_reg_lock);
> >   * problems if misused).  This function disables that lock so updates
> >   * can be performed.  For maximum safety this should be done only when
> >   * required.
> > + *
> > + * @wm8350: pointer to local driver data structure
> >   */
> >  int wm8350_reg_unlock(struct wm8350 *wm8350)
> >  {
> 
> Why are all of these documentation fixes for stable?

Because they fix compiler warnings.

Not correct?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
