Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36661C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8A206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAYDuPa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgBQKmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:42:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34258 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:42:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so17127320wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xK9gSeKjuTrA7UchFgBVdfbmk8btUEWvMGPvHLQD5JM=;
        b=QAYDuPa2ckyNKNs+uc/7kOYnDiCDyG5wPtjvhR59Myh+YznC8GYiN2AG06cTLVRObo
         ROlADqWcNe98jyG2/zOJx0GmEUb7kEPIEArlZgxJWwNRv6pJs1YlzY3L+ke9BHkM2j7B
         aeGz8B3EMSISeSPkbZNLZUTPgNCoEY5OjtpOX9CuwfzGD6qJdvOaxPi5UPWqYvGqaNar
         O4UT3VEF0GINCmmv6ibsepv9zdV9oM0/spTfYAhPLEwt03h0sQN//Tqp5MDrjEBICiV2
         dsGRIvt/baD8UMoaXtSA+m1K4rbKEYJv3mL7g6+jkeeZXV876uqoD2GDYmEfhrkqwPqN
         Vvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xK9gSeKjuTrA7UchFgBVdfbmk8btUEWvMGPvHLQD5JM=;
        b=ovRRBBBc8OcHs+TuSFYPRkk8QQTu5N5JErmgbo+lj5b/oHLWpcA/JKYRaYNzjaRwJz
         gDbaT+PZEf2IlONdB8QVI5R+NHviRunJ8Kozk0G0Q4n1h0TLT/M/7tdviqArmfrSC6oS
         V/VXeX3TYj7YcRTXV4FmGTPvEcydeSHvi/eV7SAIRiMxW+i2nt3H6S77ch++qWInE5KR
         8HRN9PxN0/h3xMsFMMvGWO6rTi/m2xDjpbYspQXkpoM3JVQguuYuByjaPBFmWNCiZgH4
         HIzrgpnTZNHY6m3tk0oaKlLfLc4ifYpylNGTOVnYk5RDgSrr4i3aZFlM6ryb3hlDoUVF
         uiIQ==
X-Gm-Message-State: APjAAAWmXVnutWKoIygmb0EcQDvRMB/xXZO7vKCPbmyATmooCpAOZkks
        9gunHb0sa1mpDp4b8bylGtzX5RLAtJI=
X-Google-Smtp-Source: APXvYqwWfS50fnch4zgS7Kfh2jKt9qZFo/AadUs19hGjKsVCFf3nDddgafWbzS4NxIxJ7cdTWz6aCw==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr21086636wrm.75.1581936123145;
        Mon, 17 Feb 2020 02:42:03 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m3sm332833wrs.53.2020.02.17.02.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 02:42:02 -0800 (PST)
Subject: Re: [PATCH] nvmem: imx: ocotp: add i.MX8MP support
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1579231433-14201-1-git-send-email-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <05b29ecf-3873-067c-c480-ed32c388333b@linaro.org>
Date:   Mon, 17 Feb 2020 10:42:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1579231433-14201-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2020 03:28, Peng Fan wrote:
> From: Peng Fan<peng.fan@nxp.com>
> 
> i.MX8MP has 96 banks with each bank 4 words. And it has different
> ctrl register layout, so add new macros for that.
> 
> Signed-off-by: Peng Fan<peng.fan@nxp.com>
> ---
> 
> dt-bindings doc has been posted by Anson Huang
> 
>   drivers/nvmem/imx-ocotp.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Applied Thanks,

--srini
