Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6ED2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwGlA9aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgFIJ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgFIJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:26:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D317C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 02:26:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so20458968wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OYOer7lO0HMljBOHZ7VovGKXhgNnImZ/DWlp+lLXDhQ=;
        b=lwGlA9aFiWXoQo1DkoldN6nVQ6xfAmPPpEBNreQ/NY8mCy1e5jYCYL4LzarPPBhOPj
         psuNkcGRcO69SKRqTAcHPKoBP9vvtaeMvXgBuYaL5TcCATeNIuFJZ0iUOguVCImoPCdK
         SBGq19n2APiuvZPfc+IVAggLo1ys2yio/nm5ml6EnIqYvlHBj9TZsz3bVSoXVwsH4ZEN
         aoCmQl4YzjUoDr8hMwazPRvBOgPbUUDa3+GPOdEI85rbMxuXuHoizvwN4dInjJHY//xM
         PVrN6ZiLu2DQ5p4B5S1SQvL4nuO/gskTnkuE5KVpW0yOWQBuNejazQzZ4uReaCAv7tVC
         zXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OYOer7lO0HMljBOHZ7VovGKXhgNnImZ/DWlp+lLXDhQ=;
        b=q3brq7VbbUNkZoufis+zWH4H9vC/eV+Cnrs030tcmVOw1H4YtY+c7c+qd08Tnezy2/
         96TDAMYXQKvJ/Duruiu+AobmcmWn/454KyXB8W+q9y9eeG57RC1ni29if3DSyRwLvYPR
         dmb7IEajKuSFt6bA6hLZhsof/ARx/NUcBe3rYfrz4AfitYCghoJdYHHiS2ez0mIEezCA
         smVg5PCnkV9AKzCzNcOA/K+3xABrc3URz2h0UK1J//JpdVROV/750dpfH7ly7OyPrksG
         g7yPE1OBu29G1EWijscFMheQFUKDyNwoIriLf5KXh1GvhTtePzJjUiJGcs3tHPnp/k9/
         Ny1w==
X-Gm-Message-State: AOAM53393StBN3CoSDQLH4CXQokShHtQJVcxoIatFPJmR3t9AvAg+BWY
        4ldmRUK+ihFH6f+JLgZZXZXrow==
X-Google-Smtp-Source: ABdhPJxWMvDjtTmVzjIvQ5bnpDEp9HTCwOBamTqcDavKulml7UlPJ+hGq9M6TEK4ho5i4CsMZThnYw==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr3170101wrt.381.1591694788647;
        Tue, 09 Jun 2020 02:26:28 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b8sm2862295wrs.36.2020.06.09.02.26.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 02:26:28 -0700 (PDT)
Subject: Re: [PATCH 0/5] soundwire: qcom: add mmio support
To:     Jonathan Marek <jonathan@marek.ca>, alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7fc23e7d-b6ef-b97d-0252-8b6fafae64ac@linaro.org>
Date:   Tue, 9 Jun 2020 10:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200608204347.19685-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jonathan for the patches,

On 08/06/2020 21:43, Jonathan Marek wrote:
> This adds initial support for soundwire device on sm8250.
> 

One thing off my list!!

> Tested with the "wsa" sdw device, which is simpler than the others.

WSA881x?

did you test both enumeration and streaming?

Are you planing to add any new WSA or WCD codec support for this SoC?

thanks,
srini

> 
> Jonathan Marek (5):
>    soundwire: qcom: fix abh/ahb typo
>    soundwire: qcom: add support for mmio soundwire devices
>    soundwire: qcom: add v1.5.1 compatible
>    soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
>    soundwire: qcom: enable CPU interrupts for mmio devices
> 
>   drivers/soundwire/Kconfig |  1 -
>   drivers/soundwire/qcom.c  | 42 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 38 insertions(+), 5 deletions(-)
> 
