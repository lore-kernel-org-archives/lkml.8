Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD5CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F920771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ElYOyoi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgGUPoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:44:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24316 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbgGUPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:44:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595346261; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=rdC4JoLgL+0mT3i14s7ghddjUga20hFANQNIf9sHBoA=; b=ElYOyoi4cmnLW0R41wIYVLUXCFSJGJhgq/Mmkvr7sPdnrDl279HOAzL9sCh2HYYg/0m8yReO
 9XqRxnYJhvXk40+Y+pSrvPh507Gs4GFiFf4/XnPzxmOg8xqqN0MtYhgMb1LTNEhg0GqT2RvH
 mXDZNDuttc8z+2N/O7y6bFJn8IQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f170d540cb8533c3baedcd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 15:44:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 536B5C433AD; Tue, 21 Jul 2020 15:44:20 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 819FDC433C6;
        Tue, 21 Jul 2020 15:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 819FDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 21 Jul 2020 09:44:15 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Konrad Dybcio <konradybcio@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
 <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:04:11PM +0200, Konrad Dybcio wrote:
> So.. is this a no-no?
> 
> I of course would like to omit this entirely, but SMMUs on sdm630 and
> friends are REALLY picky.. What seems to happen is that when the
> driver tries to do things the "standard" way, hypervisor decides to
> hang the platform or force a reboot. Not very usable.
> 
> 
> This thing is needed for the platform to even boot properly and one
> more [1] is required to make mdss work with video mode panels (the
> fact that CMD-mode panels work is kinda hilarious to me).
> 
> To be honest, there are even more qcom quirks (of which at least
> qcom,dynamic and qcom-use-3-lvl-tables are used on 630).. [2]
> 
> Looking forward to your answers and possibly better solutions.

Nobody is disputing that the qcom SMMUs don't have their share of quirks but it
seems that the community has mostly settled on the agreement that there are
better ways to solve this than a handful of device tree properties. The current
focus has been on moving more of the SMMU specific bits into the arm-smmu-qcom
implementation [1] and I think that is the right way to go.

As for the other quirks we can probably discuss those on a case by case basis.
I doubt you will find much enthusiasm for qcom,use-3-lvl-tables and I've been
working on replacing qcom,dynamic with something much better [2].

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046304.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046756.html

Jordan

> [1] https://github.com/konradybcio/linux/commit/83ac38af259968f92b6a8b7eab90096c78469f87
> [2] https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.7.1.r1/drivers/iommu/arm-smmu.c#L404-L415
> 
> Regards
> Konrad

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
