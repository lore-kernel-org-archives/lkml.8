Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E91C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB3DuWnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgH1MHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgH1MHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:07:14 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59227C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:07:14 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a13so430689vso.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d6PvVFdNEXqrisTqlB/SwjexIHyVp9z/FWKW+XWK+dg=;
        b=DB3DuWnGy9DxF5THrJXbcjwYGeSgP7Wsf/P0IlXzlgUoujukUJjO+afTBup3gUB29Y
         w+1IG36r/UACEKFpaIXkluY1E2xEjokiZxy7JgfahNhoxtL2VLIcXA8K/tn3hk+OHMqu
         6eNmWqS0GdOqU0cLI98e3XAHPUt0/z6OIpP9fSXymhCYajyT4zhkoitHevFJzw59xtBn
         tC8JLIgO72yxJZLsW71CsGkF36B1P6BeM8sSK1ELJ6B6CSMmXHJWWAWaoPQolvCTljln
         GV+rR2te4RAD/m2VPRGBcu5RmMBUydGIBjN00LIaf0u4atqHQFqRgOcjxQ/XogTRgdO4
         CrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d6PvVFdNEXqrisTqlB/SwjexIHyVp9z/FWKW+XWK+dg=;
        b=Kdjs5DG0UEkFOLenSHbMpWYgnPCvq0FYllf8quNd4ZAtVq2TcJo2xiVVpuzDTpy1up
         sDKYWoIW1qYnr1c4eCAoeV2JQGBETJm1KqAnZHzO5DMdRRUV88wfl73iQbKY3kHpE4QV
         Z+GCKdGhnmgKgRaIlZr9PKLQ6xRGM3/OtajBKa8rVB2nNsNDvCl1oydAkFH++a5mgirQ
         vMrSJNHOQpX46+3V//D5T8SuKqdeYfAkJykGinepJY3atURT8ly2QfqvSvmQa3XReNg6
         etBcOP1TY/99VSbaw6xET3Be/AFAhjNhjuMgY5YLhPqZiik1vYhUGzhp4EldYiAcOhOl
         dPYg==
X-Gm-Message-State: AOAM5314o5ezQYA3WLFcsxNVERQDfEvogMkO3u1LRa4HH94jtLvBr+pt
        r2JK5t+N5L3sQowPDhqH7h86Cb6dYVjT
X-Google-Smtp-Source: ABdhPJxn0WX99+39mM8B4VO7nY4s/6kZZ+XAIiXnJVKTG+D+TYkIOjQOet6BU1RegdaPnBtctyr8tA==
X-Received: by 2002:a62:dd8a:: with SMTP id w132mr1029481pff.220.1598616061949;
        Fri, 28 Aug 2020 05:01:01 -0700 (PDT)
Received: from mani ([2409:4072:6d87:4cd4:5db4:99cb:1fe6:fc86])
        by smtp.gmail.com with ESMTPSA id k5sm1215520pjq.5.2020.08.28.05.00.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Aug 2020 05:01:01 -0700 (PDT)
Date:   Fri, 28 Aug 2020 17:30:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, amittomer25@gmail.com
Subject: Re: [PATCH v7 04/10] clk: actions: Add MMC clock-register reset bits
Message-ID: <20200828120054.GD9143@mani>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-5-git-send-email-amittomer25@gmail.com>
 <20200828115431.GA9143@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828115431.GA9143@mani>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0828, Manivannan Sadhasivam wrote:
> On 0719, Amit Singh Tomar wrote:
> > This commit adds reset bits needed for MMC clock registers present
> > on Actions S700 SoC.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> 
> Stephen, can you please apply this patch? I'll queue the dts bits for v5.10.
> 

Just realized that you'd need to have the bindings patch also. I've asked Amit
to resend with you in CC for that patch.

Thanks,
Mani

> Andreas: Let me know if you want to do the PR! These patches are waiting to be
> queued for a while...
> 
> Thanks,
> Mani
> 
> > ---
> > Changes since v6:
> > 	* No change.
> > Changes since v5:
> >         * Added Mani's Reviewed-by: tag.
> > Changes from v4:
> >         * Reordered it from 03/10 to 04/10.
> > Changes from v3:
> >         * NO change.
> > Changes from v2:
> >         * No change.
> > Changes from v1:
> >         * No change.
> > Changes from RFC:
> >         * No change.
> > ---
> >  drivers/clk/actions/owl-s700.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
> > index a2f34d13fb54..cd60eca7727d 100644
> > --- a/drivers/clk/actions/owl-s700.c
> > +++ b/drivers/clk/actions/owl-s700.c
> > @@ -577,6 +577,9 @@ static const struct owl_reset_map s700_resets[] = {
> >  	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
> >  	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
> >  	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
> > +	[RESET_SD0]     = { CMU_DEVRST0, BIT(22) },
> > +	[RESET_SD1]     = { CMU_DEVRST0, BIT(23) },
> > +	[RESET_SD2]     = { CMU_DEVRST0, BIT(24) },
> >  	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
> >  	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
> >  	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
> > -- 
> > 2.7.4
> > 
