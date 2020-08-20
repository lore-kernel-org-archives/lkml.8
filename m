Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBAEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1CD2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927694;
	bh=pFq7iB7XnrP7Joiut7KtoVnKCKN42jGESFbYRJbWaKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kVh1XpdwaBOdm5iMKvSSbHa0zaWmX9rRXEuNL9ok+nzQeRCPuX0pym259D0i9p10+
	 8dKPKBie8Z/GGdnA6W5Wgh0svILgclzO+tSWye+eR5ZO2h6Szz8hHgWdvgQYrKBJsK
	 ELAoxKyVX7R3qZiCW8zuJUisFoayLtJjVk4SsR2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgHTMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbgHTMrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:47:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17AE2078B;
        Thu, 20 Aug 2020 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597927668;
        bh=pFq7iB7XnrP7Joiut7KtoVnKCKN42jGESFbYRJbWaKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0AEFL5Uga/yx7bmcfdjXBBqx6fyLXuznCa39VkuFXi1j1NQBDJLq3mvbmldMpd+Rw
         spaaiQ1Al2myjvxc41nBH1pzTuSK3jVfdOrfpqDVDOZArlgX5e3q96KqElaoO9sbvO
         +p0d3GTbl1r1YfKx4bmiF5XQ0tHqMYYk537DJVUU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8jyt-004ZAx-4r; Thu, 20 Aug 2020 13:47:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 13:47:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>, alix.wu@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yj.chiang@mediatek.com
Subject: Re: [PATCH v2 1/2] irqchip: irq-mst: Add MStar interrupt controller
 support
In-Reply-To: <CAFr9PXnzdHs2F3pyF-493xuhn9wFU1G9eLXRtiW-rYNB5bLX7w@mail.gmail.com>
References: <20200819034231.20726-1-mark-pk.tsai@mediatek.com>
 <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
 <CAFr9PXnzdHs2F3pyF-493xuhn9wFU1G9eLXRtiW-rYNB5bLX7w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <ec3dd6b7664d647b2dc27926539eadda@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel@0x0f.com, mark-pk.tsai@mediatek.com, alix.wu@mediatek.com, devicetree@vger.kernel.org, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-20 13:36, Daniel Palmer wrote:
> Hi Mark-PK, Marc
> 
> I'm not sure this will be the final version but I'm going to try to
> integrate this with my current MStar/SigmaStar tree over the weekend
> and then I guess I can give this a tested-by?

That'd be good.

> Assuming this version or the next is acceptable can I just follow up
> with a small patch to add the instances I need in my dtsi or should I
> wait until it's merged before doing that?

No need to wait, although the platform-specific details should go
via the arm-soc tree.

I'm not going to review the new version before next week anyway
(I'm making a point in reviewing any given series at most once
a week).

         M.
-- 
Jazz is not dead. It just smells funny...
