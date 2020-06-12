Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE55C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306602081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591966794;
	bh=MKQQpvr7EQJhmEioJJE4VZbRGd6MocMRhIpMoJJ7U60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSLmtm/ZSYJiZiVhxJck0/VxjdLrTk3x5oVOfIt/qOzQQdarT+o1sV1O2LAx106Dn
	 BbfrZ/g3L2aXCuSSFkhh+mxjMkRDg6JyCpHh+uWw7A4l5YQzjamtkS+0JzprIfGwa5
	 l6RlMdMGbyXL579jbeO4bF9Zi/Fs5/VMjEhT+2sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFLM7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLM7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:59:52 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEBB20792;
        Fri, 12 Jun 2020 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591966792;
        bh=MKQQpvr7EQJhmEioJJE4VZbRGd6MocMRhIpMoJJ7U60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1erF+Gnz10eFlYO5+Gpah2ueDrWqubNymiRTSfA6na+vakPD8ZmpEbDufK7C04M7H
         sDVGiR0doXlAxrBzXjGQ42xREvMlrDywEIOJwsIJ9gUamRRKYfe2mozRngC+P4GAcG
         vFknS9PLCrY7qm6VNDwDU9OY7rsoqlJdsi9812Ak=
Date:   Fri, 12 Jun 2020 18:29:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: qcom: common: set correct directions for
 dailinks
Message-ID: <20200612125948.GH1393454@vkoul-mobl>
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
 <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-20, 13:37, Srinivas Kandagatla wrote:
> Currently both FE and BE dai-links are configured bi-directional,
> However the DSP BE dais are only single directional,
> so set the directions as supported by the BE dais.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
