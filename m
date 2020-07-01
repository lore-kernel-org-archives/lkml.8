Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72895C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DC92073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMhSMyxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgGAJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgGAJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:51:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F5C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:51:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so23130120wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fj366YBf1wK9fUUm8pn/f0wRLN+C66RzqNPCkZkGdjo=;
        b=nMhSMyxLW+hfjvf+9wE+aYTChw1AUe5uCsbBDN47Bph9DBmfp6xkym7AH9V0eMZ4Gp
         vTdyyWsn9qX6oQ1skTbDz5CPBWg/5H7sQi3HCq11Kwx/lCGNIdlLKYPsRmENTLRoAe/4
         tXrbJIhwRf+kHyy8txD/NXLpk+c50J5U4+SZZqTnCNJixNn7TUbG6k62Byp2fF/CL6QI
         Ir11nyjrRBmR317O9zoZLtWf30Hk6/QxqD7pjySLVy18VlqE0yNtaMOEBzIzJMmKwSxi
         i/haR5+S/kC3RbqNtrUhcdEjIamEqfvgoUsqpHzXLUSBRJeP8HjkQRaA9hbDj57/8VDN
         5Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fj366YBf1wK9fUUm8pn/f0wRLN+C66RzqNPCkZkGdjo=;
        b=hEsBZcz9LKk5BasyqbmuceK0TP4AXKbP7vxTjrnKJkFBb0MxDzj8w44FQFIL3S3wrK
         ixoDYHnIkmHv7iw0q2T4SP+I3EfxSAANecfbQn7ZnNrJC7cKzOS63ob9GAxOqFKBZbC2
         iBP8rx0g59uk4LuLnuCoKNdiDnEPpmoiP6p1mMcah2Hv/KEsexjzNk7OZmP2JtDHYkEf
         Do0cdtyHi3FhmwrWjK7egjuZSi9WEBRl1vNf6EcERo5ztUuTOzP7q348gdvu0rDD+XsR
         CXMQy1pIoj2eFys8C8S3PSdKcrhAKAcOUT4VTu3QQb73Grr8VZt1BtRTe/ng87EEQKsO
         QZDg==
X-Gm-Message-State: AOAM530+46rHV85dRgrYFx4x8MXOcfc30WUninxWCq1r6pvoqnoNsD1M
        Pjbld1Xcecb6sCtVSBxHcVron85DrxM=
X-Google-Smtp-Source: ABdhPJwKd+H9pffZ/9biDVwYMaSTSADwLWkbHkqt28Zyy1I0nO7Lgwt+43pu3oDpKM98rzn5c1d31A==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr25971083wrp.412.1593597058461;
        Wed, 01 Jul 2020 02:50:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id b18sm6883975wmb.18.2020.07.01.02.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 02:50:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz
 and governor list
To:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
 <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
 <143d954f-2ecf-c4d3-cb7d-f2ea75da8276@linaro.org>
 <766cbdeb2a0f9d9df4f68a71b4b0defd1e95e0be.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <18b3139c-725a-017a-4bb1-367c306440b0@linaro.org>
Date:   Wed, 1 Jul 2020 11:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <766cbdeb2a0f9d9df4f68a71b4b0defd1e95e0be.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 09:57, Zhang Rui wrote:

[ ... ]

>> Do you want to move them out?
> 
> Then no. I don't have any objection of removing thermal_helper.c, so
> you can just leave these functions in thermal_core.c

Shall I consider that as an ack for this patch ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
