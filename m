Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D004C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036C2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579176446;
	bh=NmJH2VsZS8uBAylZN1sbCVAnyGcjHMx6DMzTE4g3v6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xxILWHhATXc3ytgRZCm1vhkJlDMwW7snjwvzf+GoroHXT24OwAQAmhFBGYnbbir2f
	 yeyRLBgQI3j2Tgk1vi74C8wXOe+29FffpEiNWK9YK7m/qPUKNZmBJWuql3/2n4NZa6
	 qeuRZ8FzytDSwKqoocT2rZTv0dWe55nAE/YU3NBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPMHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAPMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:07:25 -0500
Received: from localhost (unknown [223.226.122.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B082073A;
        Thu, 16 Jan 2020 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579176444;
        bh=NmJH2VsZS8uBAylZN1sbCVAnyGcjHMx6DMzTE4g3v6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsTtnsoDB+3OeE14UNHJK/+eHhzJ+/RkzqfmGgV5HsnhzPd2W3Tqs8bWaPmZsGrng
         aUxiJ83WSe/i8N+mU35eZzbNp+2wtj7kL+JLU6rMEA63xjNhQcP2Dne8p706NxxumT
         8X8rO4X7BZR9r4TVryqHRJ6aGtLkhFzajw+gQ3uE=
Date:   Thu, 16 Jan 2020 17:37:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soundwire: fix example
Message-ID: <20200116120720.GQ2818@vkoul-mobl>
References: <20200114094806.15846-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114094806.15846-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 09:48, Srinivas Kandagatla wrote:
> As wsa881x schema mentions #sound-dai-cells as required property,
> so update soundwire-controller.yaml example so that dt_bindings_check
> does not fail as below:
> 
> Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
> speaker@0,1: '#sound-dai-cells' is a required property
> Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
> speaker@0,2: '#sound-dai-cells' is a required property

Applied, thanks

-- 
~Vinod
