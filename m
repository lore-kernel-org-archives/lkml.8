Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22769C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6BA206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595937764;
	bh=zq0QFR15LKAQyhej+djI+MUkQdCC1czmdACzur8Ut2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NgPyqmJMOrK4//SGtZqsvVRZDtgjaYxLHt6JL55h3TKN8Bd7pagIR6X7F5FVl2iaw
	 XsnWJRgOgCvbVoI6MZ0NL1cd7se3Il6qO4pnNXX8+e4jDtFqy2QkF+ZiUEY2fz001e
	 liX4rrQ7m7F3yi4r88Jb4wl7nGykDrh5Evna8Lr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgG1MCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgG1MCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:02:42 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240C9206D7;
        Tue, 28 Jul 2020 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595937762;
        bh=zq0QFR15LKAQyhej+djI+MUkQdCC1czmdACzur8Ut2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/DajtogiCq73EE+MTHxDDTib0zZnQ58tzBIMySb0wXnNa+yXuapmd4ptlifCbhVH
         FamrV9E/fh+I145MiYKVqhxs3v2RbVQcG5K28n2H0TXc8995IBdu1GrrxNvy/sFZ/K
         7u48MEWQIUzwQKrgAaY2Wy8SASnOKPENjxkpsVYA=
Date:   Tue, 28 Jul 2020 17:32:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v3 00/10] ASoC: qdsp6: add gapless compressed audio
 support
Message-ID: <20200728120237.GZ12965@vkoul-mobl>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-20, 10:37, Srinivas Kandagatla wrote:
> This patchset adds gapless compressed audio support on q6asm.
> Gapless on q6asm is implemented using 2 streams in a single q6asm session.
> 
> First few patches such as stream id per each command, gapless flags
> and silence meta data are for preparedness for adding gapless support.
> Last patch implements copy callback to allow finer control over buffer offsets,
> specially in partial drain cases.
> 
> This patchset is tested on RB3 aka DB845c platform.
> 
> This patchset as it is will support gapless however QDSP can also
> support switching decoders on a single stream. Patches to support such feature
> are send in different patchset which involves adding generic interfaces.

The lgtm so:
Reviewed-by: Vinod Koul <vkoul@kernel.org>

tested on Dragon Board RB3:

Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
