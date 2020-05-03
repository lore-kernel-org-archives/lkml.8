Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F37C47257
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C78620721
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgECUV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 16:21:26 -0400
Received: from nbd.name ([46.4.11.11]:38750 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgECUV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 16:21:26 -0400
Received: from [2a04:4540:1401:e100:2d8:61ff:feed:60f5]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jVL74-0002lf-Nn; Sun, 03 May 2020 22:21:22 +0200
Subject: Re: [PATCH v7 1/3] phy: add driver for Qualcomm IPQ40xx USB PHY
To:     Robert Marko <robert.marko@sartura.hr>, agross@kernel.org,
        bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, vkoul@kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>
References: <20200503201823.531757-1-robert.marko@sartura.hr>
From:   John Crispin <john@phrozen.org>
Message-ID: <7ae2aa15-d84f-8991-9ae0-e58ca471f6c8@phrozen.org>
Date:   Sun, 3 May 2020 22:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503201823.531757-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.20 22:18, Robert Marko wrote:
> Add a driver to setup the USB PHY-s on Qualcom m IPQ40xx series SoCs.
> The driver sets up HS and SS phys.
> 
> Signed-off-by: John Crispin<john@phrozen.org>
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Cc: Luka Perkov<luka.perkov@sartura.hr>

Thanks for pushing these patches upstream !
