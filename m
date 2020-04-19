Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB1EC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4A320753
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHzw1v+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDSMMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725841AbgDSMMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:12:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F22AC061A0C;
        Sun, 19 Apr 2020 05:11:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t63so6721625wmt.3;
        Sun, 19 Apr 2020 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qDWwN7dRk5pqZLvOlJ3z/P/6xlKYB15KnptTZqFY7ac=;
        b=WHzw1v+6PR34pG/FOKkcHRN2/DDqhMhjR/iJO5meFbj8IrqQe8AdPrjKLYw8HAJHsE
         tnUALuEXuRfa4Y4+pFausKpgN7dakbYI5x9TLjyiBlxqHbnLIfJc7RZKWKbJCt35b7Pi
         NXiAm5gg+h0iMcY6MQcTP6Nyp1Jq5p2wn47CPrY13BElvgWT/0Cl6p47HafBgEMhiBYC
         /w/kNua3p7dHgIsdHGP1YBhZ63pzTcSQSXUce/pkRClm89PM2o+F+mA4CExEKGz2Wmd5
         +H+NlCZ8TG9awAjgbjTgMs9HoHeIOR+WqyDKgsFJKYdvx5kss4aGK8QRz48OoO5kj+wg
         NhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDWwN7dRk5pqZLvOlJ3z/P/6xlKYB15KnptTZqFY7ac=;
        b=nyUpwiET5GrytP/ONb5cI4SUz1Ln/0icDnCtEBQNvMG9tJT+KwnId2i97nG/uNB5ru
         5ds1MnvGJv9A0r44frIa18zgSAkWd2RaQLGz3f+Jq3hgScOD9YVTUdLQVTu8CY64zbGm
         mdnUHqxtNYunpcQ7YEjHlRT4HFyT/e4dG4sY23EAaa03P7lkftrpGojDB9d+fowyvFPT
         EG7l819UlBkjLUwuXZmDPxBTPn7I6gKwBgzko2YiNIxYRJlJfCtKMO2pQ8rJ1LRlP9Bi
         QODd/FdBi8VMUbeUYW9He7Ljw7rohg6Uu+a8vU/4ILJfICz3lvPpWOeT2p5VO1zLuDfC
         khcQ==
X-Gm-Message-State: AGi0Pub0V3rR3bTjMExhBjR3K1wH7wjT5PbGfi9OvijYZLUbGVQT4cha
        HU3USldcf59tXDK72ICEhhU5ta6S
X-Google-Smtp-Source: APiQypKgu/b0k3pBd8Nqh1Je1Us+ItJulva0YmJp72MQ6GXdsWl+kPbc/D1tHvSbT4zMsffzpOZNMg==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr12454056wmy.30.1587298317543;
        Sun, 19 Apr 2020 05:11:57 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm24581283wrc.35.2020.04.19.05.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 05:11:57 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: display: convert rockchip rk3066 hdmi
 bindings to yaml
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200403133630.7377-1-jbx6244@gmail.com>
 <5903181.62QgbpdqVa@phil>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <2cf39dcb-1057-5c52-02bd-cc81607414cd@gmail.com>
Date:   Sun, 19 Apr 2020 14:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5903181.62QgbpdqVa@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 4/19/20 2:08 PM, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Freitag, 3. April 2020, 15:36:30 CEST schrieb Johan Jonker:
>> Current dts files with 'hdmi' nodes for rk3066 are manually verified.
>> In order to automate this process rockchip,rk3066-hdmi.txt
>> has to be converted to yaml.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
>> @@ -0,0 +1,140 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> checkpatch complains about the licensing:
> 
> -:100: WARNING:SPDX_LICENSE_TAG: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
> #100: FILE: Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml:1:
> +# SPDX-License-Identifier: GPL-2.0
> 
> please consider adapting the license accordingly

This is a conversion of a existing document. => GPL-2.0

> 
> Thanks
> Heiko
> 
> 

