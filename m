Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C172C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B5820752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="DgG2coG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCSBSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:18:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49745 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSBSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:18:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 48jTZH1vPMz9sRY; Thu, 19 Mar 2020 12:18:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1584580727; bh=VBieu84jNex4rf5tZCk5leIvZLK6i0Bff/OLnlxA9T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgG2coG3tgVzln8eQ/SgNhMogSqvTPY3N3uiHpcH/A+KRoVNBJ3N9mRGRpQ7NQwzA
         9pQJa0xQwoYYXXo/15vUEuZk5qC7NioVEwWD4ScSroMECAskVrw8XUoTUFCPcJJzID
         KvbGqhTb/YBK/EbQ3Gn9c2ceCL1yVgnfNz/Y85Cp64+e6vP1S8jc+McdM87pi/LVSD
         nIO6UrSemKVKVcPVGcL5JUUR+2TnzQTvXz4Ezi+DkZjCnHwA02s2SSL4pYAmRRIg7C
         ml2JyfbsM37Kh89bFaqjTv4Ib8tJ2lAOWAkIeQIg3fwv6NujhHfWuQzUBGuUmhaGI3
         KjVJE3N09CZog==
Date:   Thu, 19 Mar 2020 12:18:41 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Joe Perches <joe@perches.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 016/491] KERNEL VIRTUAL MACHINE FOR POWERPC
 (KVM/powerpc): Use fallthrough;
Message-ID: <20200319011840.GA5033@blackberry>
References: <cover.1583896344.git.joe@perches.com>
 <37a5342c67e1b68b9ad06aca8da245b0ff409692.1583896348.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a5342c67e1b68b9ad06aca8da245b0ff409692.1583896348.git.joe@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 09:51:30PM -0700, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>

The subject line should look like "KVM: PPC: Use fallthrough".

Apart from that,

Acked-by: Paul Mackerras <paulus@ozlabs.org>

How are these patches going upstream?  Do you want me to take this via
my tree?

Paul.
