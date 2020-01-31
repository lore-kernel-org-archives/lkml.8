Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FFC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1146206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="eh+m0Uxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgAaKkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:40:14 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgAaKkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:40:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 488DJ44WsFz9sSL;
        Fri, 31 Jan 2020 21:40:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1580467205;
        bh=t+s8IXmWy8smiLWcBN6/ROFxyXt50DgN0gQz63dthJs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eh+m0UxtIKLSkLBM2+h1bfL7Sqbjt8HBh90YjNP4Rmh6apty+6QHqyakuoH5MivVz
         1AVKSBRjL4LLJxYAl/MbKqfCvv7dlmlQ6zFRm90onc7za6+2tOMXKp6klsaVfIq9vc
         l4maU/5MoO05LVVvrZgtcp3TeOxB4UDWJWqbHDIIv6HbF4+Wr+3V1c8b9qylp07DNm
         ojI0PSCZuUcvtUyjvaKSz0thr/fU3zRP6IN1Zs+XS8a6UCXgSpJ6JHGcfwPv0HOaT0
         nT25LXzSCa8/P8EYPWAJnD3Lm8cx6b9d+AnPDb3FU0X/e6RCQKy5rD167sAdsreVgM
         6aAYUdIeub9fQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc
In-Reply-To: <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
References: <20200126115247.13402-1-mpe@ellerman.id.au> <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
Date:   Fri, 31 Jan 2020 21:40:03 +1100
Message-ID: <87mua3gb98.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:
> On Sun, 26 Jan 2020 at 12:53, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> There's an OF helper called of_dma_is_coherent(), which checks if a
>> device has a "dma-coherent" property to see if the device is coherent
>> for DMA.
>>
>> But on some platforms devices are coherent by default, and on some
>> platforms it's not possible to update existing device trees to add the
>> "dma-coherent" property.
>>
>> So add a Kconfig symbol to allow arch code to tell
>> of_dma_is_coherent() that devices are coherent by default, regardless
>> of the presence of the property.
>>
>> Select that symbol on powerpc when NOT_COHERENT_CACHE is not set, ie.
>> when the system has a coherent cache.
>>
>> Fixes: 92ea637edea3 ("of: introduce of_dma_is_coherent() helper")
>> Cc: stable@vger.kernel.org # v3.16+
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks Michael for helping out fixing and this! The patch looks good to me.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for the review.

cheers
