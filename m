Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0256FC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D225020724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584009686;
	bh=OV9ZiHrPuC+tMP2co9RjC2LJmT+2Cle0WN5ef7t/bs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RkIexeBMd1u8kaZi8AuzNOiHZy3/Ugc+KrsPHzbeCLxIO7hkLhGxYxPBvyQN9+ah/
	 5C/UCI1lslC3ybQrA/IM1tIxtvGnbbR71zkjwHEkPEN0v3H52OMbSJtfvFP+XJZMBI
	 qD/g0/59QOcGeSGSA4B+MjhO8M4ZafqM/Pdz6wPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCLKlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCLKlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:41:25 -0400
Received: from localhost (unknown [122.167.115.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37DC6206BE;
        Thu, 12 Mar 2020 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584009685;
        bh=OV9ZiHrPuC+tMP2co9RjC2LJmT+2Cle0WN5ef7t/bs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+o9Yp89aj42+rMhtTb/NJQMwnFcv7UMm7a48wtgdXxUaFTZAQuGgsPiXxJWeiWw7
         kQDA5SRdy5TNWAWQwhvPw6QSejgdJexIZhB/rZr8QMNne+l1HATCPo7D17mKqrmrRF
         nlgzfaLYKIZHGri6ZgyxyZHNe8g9H0R4CAY1v8M8=
Date:   Thu, 12 Mar 2020 16:11:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix default FE dais and routings.
Message-ID: <20200312104117.GY4885@vkoul-mobl>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 18:04, Srinivas Kandagatla wrote:
> QDSP6 Frontend dais can be configured to work in rx or tx or both rx/tx mode,
> however the default routing do not honour this DT configuration making sound
> card fail to probe. FE dais are also not fully honouring device tree configuration.
> Fix both of them.
> 
> Originally  issue was reported by Vinod Koul

Thanks Srini for the these :) I have tested on DB845c. And they work
just fine after adding the DTS bits.

Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
