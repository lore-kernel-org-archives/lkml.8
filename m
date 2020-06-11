Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFDD2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vbvIIWVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKEaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:30:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17111 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgFKEaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:30:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591849819; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QJjET0k8yu9zFcdIKSvsKbosEtQIO+kgRnz9burdEE4=; b=vbvIIWVHsYzTeD4Y98pfeIL3yBbRebxHlFmC1V/rjDTpd0Cax3JtA6QzrW9SUpgO4O83aJEI
 7wiWx0hsAbOokAeOCP18V+Sv2KJCHmLPdhmcBQrUefm+RZhmfVxoY9zjmiviChDxTSkNstky
 37mne4lWFxyvkgKzaDYGDxpRlFA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5ee1b34e86de6ccd441f96b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 04:30:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1797C43395; Thu, 11 Jun 2020 04:30:05 +0000 (UTC)
Received: from [192.168.0.105] (unknown [183.83.153.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C95DC433CA;
        Thu, 11 Jun 2020 04:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C95DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V2 1/2] mtd: rawnand: qcom: remove write to unavailable
 register
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, peter.ujfalusi@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
 <1591701056-3944-2-git-send-email-sivaprak@codeaurora.org>
 <20200609160217.0b111883@xps13>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <5a82ed80-0ca3-ecb6-2c30-7ac279d437fa@codeaurora.org>
Date:   Thu, 11 Jun 2020 10:00:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609160217.0b111883@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 6/9/2020 7:32 PM, Miquel Raynal wrote:
> Hi Sivaprakash,
>
> Sivaprakash Murugesan <sivaprak@codeaurora.org> wrote on Tue,  9 Jun
> 2020 16:40:55 +0530:
>
>> SFLASHC_BURST_CFG register is not available on all ipq nand platforms,
>> it is available only on ipq8064 devices and the nand controller works
>> without configuring these registers in this platform, so register write
>> to this can be removed.
> Maybe it works because the bootloader is setting the register itself.
> What if you use a different bootloader, or the same bootloader without
> NAND support?
>
> I don't think this is a proper fix, you should instead have a different
> compatible if the IP is not the same and depending on this compatible
> do the write, or not.

I understand your point, will fix this in next patch.

Thanks,

Siva

> Thanks,
> Miquèl
