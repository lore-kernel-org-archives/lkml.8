Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9702C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A0620716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fklxr+GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMHIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHMHIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:08:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54021C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:08:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a79so2334161pfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oXHNkcnjdKbtST/Cm72EMU54y/enkmsrbD67DAs+07Q=;
        b=Fklxr+GNMBRv9AdOmZve+uLJ4LVS10Wd3Efz0ihbZTLMTOPOgReJJykQoZcjwpyjjS
         d4rRk8uWKwlA8L0irHe9fQ+OspRENYO6F/zcD9N/Mlxe4qKRj4EGAhNVUA8nl1b9969x
         tjZWGCjF6mJmHcYf5Y5y3Jb2zwct9S+zg1BSwNwGmOjkHim50IkRMlgAhdmJqNqCjlqO
         VME/tlWH6CN8XMVXFHBLEBlJGUVmRPf5nIVitK+qSrEW+YLa2AdGrWldO53L2xn6d3a6
         hx9/RDRBygqotoV08G4c9S8WQs00HkQy9YbiChcAzlnvXkACAF33vSzFNnJCojz62lJU
         ZqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXHNkcnjdKbtST/Cm72EMU54y/enkmsrbD67DAs+07Q=;
        b=GlEG4HNBHQ62ePJvmL+0oSNCDMkHv6qaL5vxdKpggjb5Rez3JsPlfFhvGXPnvht4sH
         V7GQpBoPfn+izuu41qVGC/8xtDFDmYsU0r28RVOCZhbR/QJCsBQjc6/3Pd7ud/Bp4k4p
         fPTdQFbFLjifPqV5YxQOq3CSAz4RUAe+cF1HzxzHAaXxVnRKwUjX1hlWX4ElktlChINB
         UYh9xTTnhmod8DzfFj4IGRqjUDoLLnc2Npnzfcx0rBRr6iA/3OEjOy5L7ss/7gRttK21
         UF8XvQsrtTiOG9YpWdpuxgYg7G+ImVaV2smcRslJy6xrybE6ph+L43X+dVISGZlWMmLP
         Hq9Q==
X-Gm-Message-State: AOAM530BZuBuzP76zZ+CeikCtl4miahaMUl/DqmOnmcBYABivG8XZcPu
        5QHpqWz1Sgc2/yVQnrhvyaw6GQ==
X-Google-Smtp-Source: ABdhPJy5mTa6bjpMvZNEqyus64np+Q1hqEXWGxyB6FdFHAaKwxpJXm138hVyyVcESnvJqC/jue2U6g==
X-Received: by 2002:a62:2e45:: with SMTP id u66mr3107106pfu.121.1597302496590;
        Thu, 13 Aug 2020 00:08:16 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t10sm4260202pgp.15.2020.08.13.00.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:08:15 -0700 (PDT)
Date:   Thu, 13 Aug 2020 00:04:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     amit.pundir@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, john.stultz@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sumit.semwal@linaro.org
Subject: Re: your mail
Message-ID: <20200813070448.GA499758@builder.lan>
References: <CAMi1Hd3Dv_T7kgThLTk2QLtfS7LBvhJ5R=6C3seUYK0GvNV6eA@mail.gmail.com>
 <20200806223134.42748-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806223134.42748-1-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Aug 15:31 PDT 2020, Konrad Dybcio wrote:

> Subject: Re: [PATCH v4] arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)
> 
> >// This removed_region is needed to boot the device
> >               // TODO: Find out the user of this reserved memory
> >               removed_region: memory@88f00000 {
> 
> This region seems to belong to the Trust Zone. When Linux tries to access it, TZ bites and shuts the device down.
> 

This is in line with what the documentation indicates and then it would
be better to just bump &tz_mem to a size of 0x4900000.

Regards,
Bjorn
