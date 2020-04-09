Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512FC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94720769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgZGStOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDIROA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:14:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38257 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDIRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:13:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so221022lfc.5;
        Thu, 09 Apr 2020 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j5y9erjap5VmHy0BQLWCh9oVMJ7PdliECGnV0deEBC0=;
        b=TgZGStOXa5YzcE/XeS59qlX6qIX4dKczf+omjTRlYVc7kUr+CaxrRkwrJqreMAAO3Q
         P0X2hEjUYmMKnQMlHldzMz64AcvhudBeAnFqfyuzNLDVkwuZiFUVl6GiRn/mOm4dmPlg
         Vcxl0iRHBtyOcX34+UNkZGfSwroNn7P440DSyaeDDOWbdAjbNfJcc9ObMi8fJS8NbODD
         Q9xg7pYCHLLwxDQRSA0DwaQTLoWcRIYM3licsf7mnjoC7S07X3koZpY8pV6K50XjZK+Q
         /RDHJOAU1VGceZJl0hY5o/BVxBAUWl00hD6Bc1fEGBP+sShBLFjTUCzk4M+AtyMn0uhE
         4PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j5y9erjap5VmHy0BQLWCh9oVMJ7PdliECGnV0deEBC0=;
        b=Qg+QhXYPaBBd/l7qOPIBNBOChoT8BMyu4ODmmoux1p5AMmAJJYHgcR9Z/vQe8VcWYR
         6FBXFROUEEdAJWO0k0Js6mBxB6gvcFPAKQPC9ZsFJqQc+77qeYH8YYhE4p3k3x7oNQrc
         znEzmMtYj5HiqlP+D+9DYV2p3taf7eUrBA+MeX5zcPaDhX2RT3luVRNdTMzzm6AGkRxb
         QXEWz+OKjc1PGG90cNOtli3sjhsYQ6Fz84wwvQR9YIwWoVR3piltxu2j37YYDrU//bNC
         YCacDPoDrOmW/V1vPZbKNQjF/gBe5ztm8BmNLW2tKunyWwlLAmK2mRody6nEKeBjmwac
         BHHw==
X-Gm-Message-State: AGi0Pubb7HIEy/3tUxRLGGcEILbSFKAVr5mH3t1H4HaWCPpKWALYWWIe
        o9d8kx+gHoIcSwijgwNxPjxcy2bm
X-Google-Smtp-Source: APiQypLZXt4t1Gkrg5L1En5p1CGXycKYgR724EWJAl4RMO/nyeZQwzbZ97CZnMFl6YDIVLqtyOEw8Q==
X-Received: by 2002:a19:f611:: with SMTP id x17mr182866lfe.51.1586452435969;
        Thu, 09 Apr 2020 10:13:55 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v9sm15934908ljj.31.2020.04.09.10.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:13:55 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Support headset on Tegra boards that use WM8903
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200330204011.18465-1-digetx@gmail.com>
 <5c9c995a-a571-e543-e680-30739cb1561c@gmail.com>
 <848cc6c5-e8e4-2796-3ee1-3e12a3e92c54@wwwdotorg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a7159a8e-4987-0c08-ce3a-fa82d926218e@gmail.com>
Date:   Thu, 9 Apr 2020 20:13:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <848cc6c5-e8e4-2796-3ee1-3e12a3e92c54@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.04.2020 19:54, Stephen Warren пишет:
...
>> Jon / Stephen, are you okay with this patchset? Could you please ack it?
>> Thanks in advance.
> 
> It looks plausible based on commit descriptions, but I don't remember
> the details of those APIs well enough to actually review the code change.
> 

The code change doesn't affect any of the old users, so it should be
safe anyways.

I understand that you don't feel comfortable to give an ACK if you're
unsure, but I assume that Jon is in the same position, and thus, I'm not
sure how to move forward.

Mark, could you please help with reviewing this series?
