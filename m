Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62032C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCF9206D6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XT+FJNIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDRPbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDRPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 11:31:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=NlkGCBm90qszLp6wCxrdMOdGhToTzCQN6txyhVeyQXE=; b=XT+FJNIpCsv2rGy84Uz5hFlGLA
        62TxnJ2ODUoC7GbFIEoIbG7KW5ao5A8I2irhdtLhgclh4y1Jc60jD4wzjXGLGxuAfQITdAVHo2jeV
        lOcrR62zfJ38w1rSDlY5hkFdFEkqkriWruQJKLz8ap5F2QFezMhspySnNsyRSw/Kqi7xg7EXr/Rsj
        MLuOru4Rq5/BHCVdIcyOUvFcsKKwu6P9kSjw4/FgrkCLT/3GUWY7tiLCxH0chJNeTAvS9HbIrDdnB
        n9D9TowEcPV5Er1H9KbcWUs8QDFZAfhvHUPjlW7sceEp6x9/r4aTL3yXJEbkjbq0StVCucwBPUAH/
        vnfl4TXA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPpRI-0000dg-EX; Sat, 18 Apr 2020 15:31:28 +0000
Subject: Re: [PATCH 1/5] habanalabs: Add INFO IOCTL opcode for time sync
 information
To:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org,
        oshpigelman@habana.ai, ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
References: <20200418082440.21277-1-oded.gabbay@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3fcee921-3eba-b7e7-8adf-d95db9aeeed2@infradead.org>
Date:   Sat, 18 Apr 2020 08:31:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418082440.21277-1-oded.gabbay@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/20 1:24 AM, Oded Gabbay wrote:
> From: Tomer Tayar <ttayar@habana.ai>
> 
> Add a new opcode to the INFO IOCTL that retrieves the device time
> alongside the host time, to allow a user application that want to measure
> device time together with host time (such as a profiler) to synchronize
> these times.
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/goya/goya.c           | 10 +++-
>  drivers/misc/habanalabs/goya/goyaP.h          |  1 +
>  drivers/misc/habanalabs/habanalabs.h          |  2 +
>  drivers/misc/habanalabs/habanalabs_ioctl.c    | 19 +++++++
>  .../include/goya/asic_reg/goya_regs.h         |  1 +
>  .../goya/asic_reg/psoc_timestamp_regs.h       | 56 +++++++++++++++++++
>  include/uapi/misc/habanalabs.h                |  8 +++
>  7 files changed, 96 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h

Hi,
Not a comment about this patch per se, but ioctls (main number, 'H' in this case)
should be documented in Documentation/userspace-api/ioctl/ioctl-number.rst.

thanks.
-- 
~Randy

