Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC218C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F620774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYHVDqiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCRNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:41:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40626 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCRNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:41:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id z12so3387761wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GNDxVoBT2iKzZolV+xo2w6dbpJfkDsJ6BSfw16sOYh4=;
        b=fYHVDqiYbiglR3W237Zvt5ckqSN9N6Q6zO4fBKJ9Fd7+rF1WPB/fvlcOwexOEPh7Fb
         m0cxV7CYrClIBgW/dCitam3IYK/kK9RXdfEzOSXEqfjgs0O3BwFXdDpPrJGiAPRPJUWr
         kGsmPvk49eXKbX4lBXn7qHxUr5DOmWXmDPe9YEt3G4ZY9b37i7TnZ9z/ShYhMXngrFz7
         Y0tSUj7gqmuaJK1nbuealQsIkALKe5D0kbEBtLg1hk8j39cTh1elqKJCcMFzj6y88zRM
         0mBd8Rof+ii3evFfgsoRutA0ya0X2v6VuGCEnweI4SdZqEX9tSmDmRb5Nstu/KUWJtBj
         xfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GNDxVoBT2iKzZolV+xo2w6dbpJfkDsJ6BSfw16sOYh4=;
        b=cHb6N5+pz1p7Uuq9uLTGPUKkkf5KvDAb7W+Q11hFszpHvN97w4++JEqjbxn1dmAxoJ
         O/zQ6LHpHFPsHJ7F3SetrTAiXUBWdyha6IbJ6jgqouwNR+nhaRIiXs+L/wlCOZJP2hR8
         vMM7F3Szi3YhiOlA0Rrn84aHla2u7EV2l4ZPzaevmOYqwL/xYrMorIKNI/48Nnu429Lv
         pur9Fw6DBapr+UhhJeT5vrho+2ubf1PYGczXI8WUP6jaW9GIrwL540A6VYij6g1nKe7k
         Zk1VtbX4iu6wNBrGj2Xwc9HzXGJI4gza8nWRonaKcnFCswUDiZhCUmLf1ReeGxMzqfin
         1VVw==
X-Gm-Message-State: ANhLgQ2/OwmfOAui4rMWjFxDseUoMqmhIyhD4YhEq2RYqRxo8U2CLZ3p
        Kh3FoAIOEkHyw+MICr5N9AkDPw==
X-Google-Smtp-Source: ADFU+vv3kSjyk96xe6Y/4OCtIVE9ioLklBRUOBX5s/Swg6e48yVxbLcyRaFKAOeohGdQWbV4rZCyng==
X-Received: by 2002:a1c:dc55:: with SMTP id t82mr5272895wmg.6.1584538906267;
        Wed, 18 Mar 2020 06:41:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n4sm9224120wrs.64.2020.03.18.06.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:41:44 -0700 (PDT)
Subject: Re: [PATCH] nvmem: mxs-ocotp: Use devm_add_action_or_reset() for
 cleanup
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1584169871-418-1-git-send-email-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <81390f07-a968-7e90-64e5-78fa7db868f6@linaro.org>
Date:   Wed, 18 Mar 2020 13:41:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1584169871-418-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/2020 07:11, Anson Huang wrote:
> Use devm_add_action_or_reset() for cleanup to call clk_unprepare(),
> which can simplify the error handling in .probe, and .remove callback
> can be dropped.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/nvmem/mxs-ocotp.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
> 

Applied thanks,

srini
