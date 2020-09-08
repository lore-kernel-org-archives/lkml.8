Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1455C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B19C2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VB4HA7ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbgIHT2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbgIHQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4CBC004592
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:03:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so2270356pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YnSMm4ogisR5W8OzFSgC2w8o0qTW3G5f4K1/tGLIEYA=;
        b=VB4HA7ZYUddQ/czN0QR6hFOtLPOVBlc7yLlibZ8LGNe7lrh/c+qET5DMkAXLxTmt7c
         2My3M29VqYQtJyC2HUJaeqWuSn+14HZLUiuedh3TdzD9kopJC9AfijVLH4nCSa4SzDr7
         CyzRiOKsGvrjC/qzkt0HKNyrW6VRexUTgx+p1tuEC0nso2zv0fhCkNFmuqGKI6ZYrPG1
         R4PSFPcQyjzmbmpJNvZBSXlLgo6rkjfVad941h7r8FI3PqAb3aU7MvPrNtHPe/fULAlV
         AzbextZqwrYLgzq9E47RsEi0rt0YEJvllqQkaID87k25MLGjR0sydF6xl/dg04qRjQ8n
         zaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YnSMm4ogisR5W8OzFSgC2w8o0qTW3G5f4K1/tGLIEYA=;
        b=U9Ws8OI9RYuQ1TfCOIMOUoEIyVCTo98jJ9vXd06eKqfi6zsF+cbwxWdEYb0X3ITEsU
         CqqnDEB9M+em2EJsld11MASSVzj3Zb+SaSNEkDUAbhrKxm8Z2fvAzxKY+tNq6S4FI0af
         f6wHp9rYI7E/EdtA1CtVXpzKDy8i/FrJ5EhKu3bpdFIi/3KsHLSJoEn+2m+beuf5zTlq
         nT22Cs1ZNlmE9YKvxzS9D07KynP4M++0tPDBpI2AmIM/mToIk92prHq9JUyycWfIYbq0
         /7wGXGFTrieyIj015EsuqT74sFkqBsZcnKqAayeGN4N9IUiB68TYl/WX6QnRVUJW8jfZ
         PV/A==
X-Gm-Message-State: AOAM5333Yr6PZYx/992qzoGyXiJOHhIRpAIzaE/IRDllOFQ31X5YqZQV
        NvxGmKwm8GVFZ2A6J/V3OtKW
X-Google-Smtp-Source: ABdhPJwaSMvsTZUDr7jKf0C5tA5mVnmNXNN7uyn6m0m5LM0pEXGmuIkqRDs+yGpf3+HmM9uGWPhsig==
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr4319741pjb.184.1599577419882;
        Tue, 08 Sep 2020 08:03:39 -0700 (PDT)
Received: from mani-NUC7i5DNKE ([2409:4072:6213:6149:94b7:eeb3:82a5:2b53])
        by smtp.gmail.com with ESMTPSA id a18sm4160368pgw.50.2020.09.08.08.03.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 08:03:39 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:33:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200908150321.GA2352@mani-NUC7i5DNKE>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
 <20200908103444.5e526uawa45om6lt@vireshk-i7>
 <20200908111141.GB23095@mani>
 <20200908111813.bbgfxo5v7qt6ujpc@vireshk-i7>
 <CAHLCerMndYeEBOxtj8mV7OdOP9pufx+C7n1F9m+CFAneuh8DnA@mail.gmail.com>
 <CAHLCerPm6MXr662CaA3zZm4fQ3dJ_StJt3Ehutc3xnc0L9wj3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerPm6MXr662CaA3zZm4fQ3dJ_StJt3Ehutc3xnc0L9wj3Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0908, Amit Kucheria wrote:
> On Tue, Sep 8, 2020 at 5:18 PM Amit Kucheria <amitk@kernel.org> wrote:
> >
> > On Tue, Sep 8, 2020 at 4:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 08-09-20, 16:41, Manivannan Sadhasivam wrote:
> > > > On 0908, Viresh Kumar wrote:
> > > > > On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> > > > > > Use regmap for accessing cpufreq registers in hardware.
> > > > >
> > > > > Why ? Please mention why a change is required in the log.
> > > > >
> > > >
> > > > Only because it is recommended to use regmap for abstracting the hw access.
> > >
> > > Yes it can be very useful in abstracting the hw access in case of
> > > busses like SPI/I2C, others, but in this case there is only one way of
> > > doing it with the exact same registers. I am not sure it is worth it
> > > here. FWIW, I have never played with regmaps personally, and so every
> > > chance I can be wrong here.
> >
> > One could handle the reg offsets through a struct initialisation, but
> > then you end up with lots of #defines for bitmasks and bits for each
> > version of the IP. And the core code becomes a bit convoluted IMO,
> > trying to handle the differences.
> >
> > regmap hides the differences of the bit positions and register offsets
> > between several IP versions.
> >
> > > > Moreover it handles the proper locking for us in the core (spinlock vs mutex).
> > >
> > > What locking do you need here ?
> >
> > Right, locking isn't the main reason here.
> 
> Having said this, perhaps this patch can be held back for now, since
> we're not yet using some of the features of regmap to abstract away
> bit fields and such.
> 

Okay. Dropping this patch for now (in v2)!

Thanks,
Mani

> We don't strictly need it for just different register offsets.
> 
> Regards,
> Amit
