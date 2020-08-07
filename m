Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C586A206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whSCyRwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHGAno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHGAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:43:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF3C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 17:43:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so65156pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RgPXZVMrIckGX5DmfsQv8yNcqJQDdPlKU/7tj+0RAOU=;
        b=whSCyRwNhpsO+yWDNZ4Cv5qNyZzpLOvp7DiNIK2pc3y7XGe+OgdIGNTYBxcj8Zsxh7
         zYK0DR66GIMJwtwOdD0UOwxI+I5yf6lNoZKf3J+MlgeO82rATZ4XoQZuFSQZYbA+Y1el
         SO329IS71+vYIjIWEGLmlMbwErG6gv2/N5bXbsRi6xPMSzueQ04XdqNNg2be3HuBptsM
         +lJdAMvJDOB5JSozRVKaB3mz6n5A8d428+EF0qwNz/iOBaDczoIhMPLfszGtK7+UWBPK
         Z67kBsTMFlydITNfQZc49FejvfOdYfrpHYf+O4jF1aB9AFLpGA0O2BcoeO4qSphffdVH
         WRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RgPXZVMrIckGX5DmfsQv8yNcqJQDdPlKU/7tj+0RAOU=;
        b=fZUz3P8X2jb+7x5ZO1eF7hOrDhGzomS8bKcQbFyvuu/zWoTlCZbKGxLTJuo0VsGMwB
         uvdLrCm+vrY4Ris/wMVx6GkPfiWm6F3furVi3T4SMhEFLZDy7j2oZpyVs2AXarWdhFkB
         xb36aoPBO3yC3Wu49LIeKnXeNG81PTlhhuY74vCTFzv7Idk7XCDbxEU1qFo2cz+9mHfY
         pklfww8VG6A4HTwYqegmP+ozQxXy2L4hMhGJBmKMiUzhPG5ATneFOBnZQw8v4Kd8rt5A
         yLmol/7MVDXzN1hjJABXSUCzBW0sbAuC/as/UEmBBdaLGRrvwnPFUfjN9ACg1k7gZJVj
         vJ/Q==
X-Gm-Message-State: AOAM533kCnBc5LKEJWvOMsmdIzKxYfUDtYtkxLveqNHvKU7A25snO8sU
        dcubw+yJF9ZuMUxFVgOHFwh2IQ==
X-Google-Smtp-Source: ABdhPJzzSsdKj+hMfY/ueb2cz2zxYSb8Y/2u33WYsliSAC12b4M2MWm1xSe3yMluHLVX3jxKgljGCQ==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr10174683plo.184.1596761019053;
        Thu, 06 Aug 2020 17:43:39 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b15sm9673497pft.116.2020.08.06.17.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 17:43:38 -0700 (PDT)
Date:   Thu, 6 Aug 2020 17:40:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
Message-ID: <20200807004001.GF20825@builder.lan>
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com>
 <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <f314b687-11a9-5a5e-e79e-c46dd2f16c6f@kali.org>
 <78ad0914-6173-f753-9eba-b7cbfbb51fd6@kali.org>
 <CALAqxLXPN9kThwF32YoWyApaWnfjthANXj3uk65Wc3ddaJQFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXPN9kThwF32YoWyApaWnfjthANXj3uk65Wc3ddaJQFFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Aug 14:57 PDT 2020, John Stultz wrote:

> On Wed, Aug 5, 2020 at 2:47 PM Steev Klimaszewski <steev@kali.org> wrote:
> >
> >
> > On 8/5/20 4:16 PM, Steev Klimaszewski wrote:
> > > On 8/5/20 3:19 PM, Saravana Kannan wrote:
> > >> On Wed, Aug 5, 2020 at 12:44 AM John Stultz <john.stultz@linaro.org> wrote:
> > >>> <sigh>
> > >>> So this is where I bashfully admit I didn't get a chance to try this
> > >>> patch series out, as I had success with a much older version of
> > >>> Saravana's macro magic.
> > >>>
> > >>> But unfortunately, now that this has landed in mainline, I'm seeing
> > >>> boot regressions on db845c. :( This is in the non-modular case,
> > >>> building the driver in.
> > >> Does that mean the modular version is working? Or you haven't tried
> > >> that yet? I'll wait for your reply before I try to fix it. I don't
> > >> have the hardware, but it should be easy to guess this issue looking
> > >> at the code delta.
> > > For what it's worth, I saw this too on the Lenovo C630 (started on -next
> > > around 20200727, but I didn't track it down as, well, there's less way
> > > to get debug output on the C630.
> > >
> > > In my testing, module or built-in doesn't matter, but reverting does
> > > allow me to boot again.
> > >
> > Actually - I spoke too soon - QCOM_PDC built-in with the commit reverted
> > boots, however, module (on the c630 at least) doesn't boot whether it's
> > a module or built-in.
> 
> You may need to set deferred_probe_timeout=30 to give things a bit
> more grace time to load.

With the risk of me reading more into this than what you're saying,
please don't upstream anything that depend this parameter to be
increased.

Compiling any of these drivers as module should not require the user to
pass additional kernel command line parameters in order to get their
device to boot.

Regards,
Bjorn

> (I've mostly recently used qcom-pdc as a module with the android tree,
> so the fw_devlink bits help there, but I need to re-check the state of
> that upstream.)
> 
> I'll dbl check this and dig more on the issue with the patch in
> question once I can get back in my office later today.
> 
> thanks
> -john
