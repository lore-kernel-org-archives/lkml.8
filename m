Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5496FC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152F82075D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="DTR+woOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIBEv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:51:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgIBEvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:51:25 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4BhBNW4Sxsz9sV8; Wed,  2 Sep 2020 14:51:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1599022283; bh=WOfp9otDnweaCa9QqM2OIoG8iDSDoTlcwj+EuEhBVJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTR+woOO6qeYDsljobUQVGIbaihDCn3rXPf03LnF7I6kLqQhgbaMpLTeQ07etO+c5
         xwZ67OX3DnhiFTAEQwIUQdLGKkFbf9xj4HGPbZl6RdlOrL7gpXntDESOju2lESBUdC
         aGv0ZsYaPG3y1E3dKV47QPQe79W26HvGEhs977pmdWQOfcRXS1yyg0yIQ/qFjATM7d
         TkXtzQyKya6L3YWtB1VOLoOFaGD8KOED50c1V1ps4UETTC8BooW5uZYnI3wHZrlJ8M
         QO5+R5GfyNTFzk7NRVkMM94NZdgZoSHl6M0lf8GZ4tJMBtRK4qCPXEI7WtewThoGTz
         NdJMOilWIYc2A==
Date:   Wed, 2 Sep 2020 14:51:18 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200902045118.GD272502@thinks.paulus.ozlabs.org>
References: <20200716090712.14375-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090712.14375-1-miaoqinglang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:07:12PM +0800, Qinglang Miao wrote:
> From: Chen Huang <chenhuang5@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>

For the arch/powerpc/kvm part:

Acked-by: Paul Mackerras <paulus@ozlabs.org>

I expect Michael Ellerman will take the patch through his tree.

Paul.
