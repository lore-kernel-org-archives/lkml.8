Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F31C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728FC20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596807576;
	bh=djVAZ8bgNnDd5s20tDbtmbbCi6mAMF/eFolBBmMjS/4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=l3Y0aOr342rMEX6FGVoHqNcUeczfOw22fLdlaAc6U/EmjsqUGYVjuNRMWZkm6C5vy
	 GlyPmq2gx2TJZuNzYGBh7ashcmUOgMg3GRrCpKOigI6IJuaye2StB37UB+j1WKM5MG
	 5JXNto9da29pO9VElvzu5Ksi3S34mfmSUD98lS/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHGNje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHGNjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:39:19 -0400
Received: from [10.20.23.223] (unknown [12.97.180.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C614520866;
        Fri,  7 Aug 2020 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596807559;
        bh=djVAZ8bgNnDd5s20tDbtmbbCi6mAMF/eFolBBmMjS/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M2t8KqC8r0URtDNpW9FSWMTYh/AqHEhN8JK9uqdfkyd61X7sFgA6WeVL9bX34Bf77
         l80ZFYD73auUDGxQSXdi5NS03vbp3/IVW2FGapuluwwl45VS2XFJGRnUE9PdzTZKL6
         2HjUIkDnNrxmao+96kag6Vd8PXuTAVDCR25wvCmM=
Subject: Re: [PATCH net] net: qcom/emac: Fix missing clk_disable_unprepare()
 in error path of emac_probe
To:     "wanghai (M)" <wanghai38@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20200806140647.43099-1-wanghai38@huawei.com>
 <87f41175-689e-f198-aaf6-9b9f04449ed8@kernel.org>
 <df1bad2e-2a6a-ff70-9b91-f18df20aaec8@huawei.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <9ec9b9ab-48d9-9d38-8f58-27e2556c141a@kernel.org>
Date:   Fri, 7 Aug 2020 08:38:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <df1bad2e-2a6a-ff70-9b91-f18df20aaec8@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 8:54 PM, wanghai (M) wrote:
> Thanks for your suggestion. May I fix it like this?
> 
Yes, this is what I had in mind.  Thanks.

Acked-by: Timur Tabi <timur@kernel.org>
