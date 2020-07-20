Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF901C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0896208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595217787;
	bh=NJmzmO+e2SXB3AlXa47J4NMhA0n2fipNMDlfEtAPcLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qhOqxeKE2DH0UFRsLLH8cMaU2kSfWaMzxviPcuWPOJM3P7j0O3/AonJzfeGht/gs3
	 snqC8Q6LPvE+CQLDoXyA8OXbQWdh0eIF9FjKZjENPz6lyITdRcZP4KYJq8XJr5y8zX
	 M3zTTGAcP3Ale5x7pbV4KSKARbbMibecABZtFKM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgGTEDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgGTEDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:03:06 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D362080D;
        Mon, 20 Jul 2020 04:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595217786;
        bh=NJmzmO+e2SXB3AlXa47J4NMhA0n2fipNMDlfEtAPcLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJiV1YhZ5U8Uf2VprqR6kEQcTYOGk8tJBMk3y95O+M8rA1VuDLTNgjgDkJZ1HHaf0
         PNbTjtUSbqf7Ygldm9RIRQCzU+x8lL3hQ/PSS9bp7UwHWwrIFezfgvgZ/V9JT+qzXu
         NRt9CaTtOS0K5fakedvIx4z1J5/2yDnnolPAyQF0=
Date:   Mon, 20 Jul 2020 09:33:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v5 3/4] drm/bridge: Introduce LT9611 DSI to HDMI bridge
Message-ID: <20200720040300.GB12965@vkoul-mobl>
References: <20200708103559.132300-1-vkoul@kernel.org>
 <20200708103559.132300-4-vkoul@kernel.org>
 <20200719171806.GA55541@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719171806.GA55541@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 19-07-20, 19:18, Sam Ravnborg wrote:
> Hi Vinod.
> 
> Three trivial points below.
> The rest looks good.
> 
> With these fixed you can add:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks, I will send an update with nits fixed

-- 
~Vinod
