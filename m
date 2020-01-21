Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677BC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF00624654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579595101;
	bh=zY45NEgiqUBkPrHoNMe1qF5eSC8mEb3WAY9umCc1y6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wdhs7KdHg9qay+x9K6goDQpKhwtrRr/nQoxjsY9PjmRdDFI0sj1AXXfG0+7fK2j5W
	 pRC9y2shSIQtdapemqZsn+0uXjBQlutmUjcpZTqa4FTon4aFJSa/wcgQVcO6PWDadx
	 pBH7eXBPF/iBeur3FW311AEYXbtkWrVoaiq5NyRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAUIZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUIZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:25:00 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66DB2253D;
        Tue, 21 Jan 2020 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579595099;
        bh=zY45NEgiqUBkPrHoNMe1qF5eSC8mEb3WAY9umCc1y6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxnR/tY1kzR2qIRQw72aVrJ3GJw+9YAQifeVXQPKNE3ObpVIpooSaQ+9Ejj9wCzbS
         7QfvmNcJ6BolG6r+B6T5hFoVpL2XnaoyVXiAJcFOA3Xaa1zwp3NlifStNBHHmQEBhS
         K9dYAvuPIQYYioWxd476TXmICFHMF3chlukuaIIo=
Date:   Tue, 21 Jan 2020 13:54:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     dan.j.williams@intel.com, peng.ma@nxp.com, wen.he_1@nxp.com,
        jiaheng.fan@nxp.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
Message-ID: <20200121082453.GD2841@vkoul-mobl>
References: <20200120125843.34398-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120125843.34398-1-chenzhou10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-20, 20:58, Chen Zhou wrote:
> There is duplicated argument to && in function fsl_qdma_free_chan_resources,
> which looks like a typo, pointer fsl_queue->desc_pool also needs NULL check,
> fix it.
> Detected with coccinelle.

Applied, thanks

-- 
~Vinod
