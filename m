Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C24C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6EB2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLijFIvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgG0N0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0N0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:26:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65282C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:26:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so14772485wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WDER7sEQ07iO9lbiMHpBS3vuy/YPfuGN5lk9udY8M+c=;
        b=PLijFIvK5siMBHs84spluphEbrfBvkT8AoNGdW6z49N7D8llCGkf+ODfqLwoAxEPWn
         Rkt+DZsm83Lu7FjZ5HCrTtVKEWU8Mc45SB2UiZ6gFgRpYTE0kbenzuqerHkmiDpJBZ0X
         gcHLbAuoKIjltQxIZ078DnnyBajd2yZLT8S/YI/52SItruWQizdSacEKRd/ZIzNU5vR9
         kSqWOv4ZK393IL1ynQxON6gvH8JEcRrtJRzRqvUt++0zqG/TgpYOIGSsnCN6tVuHdyWD
         Ni54MvNJCYkQCZYcUycYmbHB5VSJXCX4LJgbEYHZNbzvWZBBJ8RpLYBnERagiVcxpVGO
         RSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WDER7sEQ07iO9lbiMHpBS3vuy/YPfuGN5lk9udY8M+c=;
        b=n0Mf2B6tRtMJfEewcrhqXONn+p3NfjhG136xBryUsfQbcGY+6pp463N/6pwPPI3kxI
         SAsL64hyKa8jRdfDebrlR8dfUki0pmZn6mck9jzRHRu+PcoZTyrN2Y1cNeW5ZN3g1ocL
         8eDawZJkQUkynst+S8Jr9qDNXCU9SsrbcEHN/6oUHElkyODFcWmjeX8SOuT9AqDfEIWn
         lpJn7BBOpkIeiPnDvsEHyrnq7YE3Dj2ZK/nys5HtuB3hOHmyQgy/7ptv7Qbc9wg206XC
         csqVAkTiU0Z5kiA54GD93EAAu0I6bktWLjw8RR99WeYXyGfFyx8jG57oanjT7x/8h2M3
         rQ5w==
X-Gm-Message-State: AOAM530Ytb6aFipdL1PT93aEPiZl7M/gtlBi/REdCchi7l4hd+8iRwZz
        tqOftNs5y4s5KcyybQachd+o4g==
X-Google-Smtp-Source: ABdhPJyQCtUW4ULIDDUcv6VdC7NMl22J+2YfSNXl3A560WDb4ux2wz/zrsc2jCRmpIaVKvLaRaSuZA==
X-Received: by 2002:a1c:6007:: with SMTP id u7mr21231085wmb.32.1595856401128;
        Mon, 27 Jul 2020 06:26:41 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id 31sm12881758wrj.94.2020.07.27.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:26:40 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:26:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xu Wang <vulab@iscas.ac.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_soc_pmic_mrfld: simplify the return expression of
 intel_scu_ipc_dev_iowrite8()
Message-ID: <20200727132636.GR1850026@dell>
References: <20200727030407.8820-1-vulab@iscas.ac.cn>
 <20200727120908.GR3703480@smile.fi.intel.com>
 <20200727125335.GQ1850026@dell>
 <CAHp75Vfi4pC0rQHVmi6nuQ12tL7shtKPbbSuFgBhD-jDs_Z=+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfi4pC0rQHVmi6nuQ12tL7shtKPbbSuFgBhD-jDs_Z=+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020, Andy Shevchenko wrote:

> On Mon, Jul 27, 2020 at 3:57 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 27 Jul 2020, Andy Shevchenko wrote:
> > > On Mon, Jul 27, 2020 at 03:04:07AM +0000, Xu Wang wrote:
> 
> ...
> 
> > > It's a bit more helpful in the original form in case to add some debugging.
> >
> > If you wish to add debugging, you'll have to add the extra line of
> > code yourself. :)
> 
> True, that's why I'm not objecting the change.
> 
> > > It also keep it symmetrical with read() counterpart.
> >
> > Can this be fixed-up too?
> 
> How? Can you elaborate?

I hadn't even looked at the code before my reply.  I just assumed it
was in a similar situation.

Now I have looked at it, could the pointer to the return value be
cast?

If not, just leave it.  Symmetry isn't a good measure of good, clean
code.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
