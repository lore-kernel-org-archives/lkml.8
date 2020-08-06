Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B60C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A40206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735133;
	bh=5ZUQhH4PMrtC+SaoTpZasAo44xzwb5YxXmuircmK4VU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ptj6eKkrwwX5JBRaHQ+AzccJGfrIG4eOh1BuBGC44yqO0omW4JW/4HZd5eLz2eQj1
	 JcOAEE3gDeiXxHcV8PXzN2ZSTQDoBIixkL+Fas089nA6s/faD246/UrdFSSopD+JmW
	 GY3h5Kw7NzYocCD/p4DZ1eFhTN8tn7JMXRBIWl0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgHFRcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbgHFRbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:23 -0400
Received: from [10.20.23.223] (unknown [12.97.180.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD6A23121;
        Thu,  6 Aug 2020 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596723838;
        bh=5ZUQhH4PMrtC+SaoTpZasAo44xzwb5YxXmuircmK4VU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TNwOaSnYwAU9V4Lauj/qaS4RZbDaGYaZwK1pIRL+oDVoYUO3SCDnT7OwxQIfL7QzH
         IQ+JjjYCIZCQ2niOrELQ3+zGHVTGs7ZwYtDbldjkzlwG+Ic2ZAwe/iXAGBtlBhwEsZ
         MFx4HWl5OUywJfiPshX2MrPAXZ/NHiIm+9q8Tctg=
Subject: Re: [PATCH net] net: qcom/emac: Fix missing clk_disable_unprepare()
 in error path of emac_probe
To:     Wang Hai <wanghai38@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20200806140647.43099-1-wanghai38@huawei.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <87f41175-689e-f198-aaf6-9b9f04449ed8@kernel.org>
Date:   Thu, 6 Aug 2020 09:23:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806140647.43099-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 9:06 AM, Wang Hai wrote:
> In emac_clks_phase1_init() of emac_probe(), there may be a situation
> in which some clk_prepare_enable() succeed and others fail.
> If emac_clks_phase1_init() fails, goto err_undo_clocks to clean up
> the clk that was successfully clk_prepare_enable().

Good catch, however, I think the proper fix is to fix this in 
emac_clks_phase1_init(), so that if some clocks fail, the other clocks 
are cleaned up and then an error is returned.
