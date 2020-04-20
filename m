Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B4F214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587366505;
	bh=UWEF8anj4RInPM8cOzySci9CGjDHuS3EH9QM7a51Be8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eIdLMtM8RFKQvMHnsOyT37Whlova16aKfsIfa4gywsPwR/V9n+kG/sQB3zUyG62n3
	 ILKcHJSM67b7Ub68H7dc0eKur8HjN5n2RVdvncqzlqIDjKMeHcOTupt2x5xSyfVfxH
	 NrKVNnaUieRqjjCMc30mPnGFa+mjeJmRCEZG1/SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDTHIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgDTHIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:08:23 -0400
Received: from localhost (unknown [171.61.106.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B9021473;
        Mon, 20 Apr 2020 07:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587366503;
        bh=UWEF8anj4RInPM8cOzySci9CGjDHuS3EH9QM7a51Be8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+NqI280vQ0VCqH7CFazIGBoespfaQ5HGIU7y9J2GNVY4lMAUOyBbvpPX3sSXWXgy
         uEPdiyzLVxLSdJwO3fphUYn1lb3EWyd1q11gtKxizOmm0jXTOZjpgZJUBHLrYpwqA8
         ZZ7+VyedZzVd8OfTl+41EHEJVHcbrsQlXlIMDMkE=
Date:   Mon, 20 Apr 2020 12:38:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420070816.GU72691@vkoul-mobl>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20, 16:01, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now ALSA SoC needs to use asoc_rtd_to_codec(),
> otherwise, it will be compile error.

Applied, thanks

-- 
~Vinod
