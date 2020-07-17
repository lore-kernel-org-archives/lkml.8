Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB512C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3E820737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594973151;
	bh=R5Xrabo1ypns4x/y+wVu5E5vQZfAi4H2W1OYTh3sGLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3V9kPuaKpWD7frGEZI+aJSi5Fn2fUhlJx4KM5Kufj+2TsnPONu9LqpHPXUVxzyGM
	 DjO7czpYG7RgaOPXgXvXHblkDXysLXN+y5MZDrvC4nPXXgKvDsk1Z+sd40Cw5acXwa
	 6gwLmw/sgc7Jh6xgiIjh18fKJ+jvlCrpf1TjMQ9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGQIFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgGQIFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:05:48 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9CC20737;
        Fri, 17 Jul 2020 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594973148;
        bh=R5Xrabo1ypns4x/y+wVu5E5vQZfAi4H2W1OYTh3sGLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZ7fOzXnBfNPFl8ZRLhe36tRRmNSWBJELk+d4hqCro0BwRxK1gnPS15JAQr+DhkBK
         rYoNYteTPWKaTORWIzldCOKBRp9WyPRI9IRq5Tjma/4/Nud224WUB1/Pjvkytbk43a
         8pRmg0mvhvA0Kb5o8KSYJtGApZcpFz1XEMKW03QY=
Date:   Fri, 17 Jul 2020 13:35:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh+dt@kernel.org, krzk@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v13 1/2] dt-bindings: phy: Document Samsung UFS PHY
 bindings
Message-ID: <20200717080544.GK82923@vkoul-mobl>
References: <CGME20200716194405epcas5p2da2808b30d8f958290bc5d424aa6a0c7@epcas5p2.samsung.com>
 <20200716192217.35740-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716192217.35740-1-alim.akhtar@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-20, 00:52, Alim Akhtar wrote:
> This patch documents Samsung UFS PHY device tree bindings

Applied both, thanks

-- 
~Vinod
