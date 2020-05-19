Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F18C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B928120809
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589869422;
	bh=pEUnHXzWtTkGG8+gt64e+gkH1Bjuec5902GkItqSqCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S1R0aLy0bV1izFh7c/OQLa/syCE+D/GKCwIVAX/IUoMma+0Fm+v4bjmiXRPbZo+9w
	 ONzOnEPe6SgqVclHogE10uL6UNVchA5VcgvY7WYIjtcl6bk31Bqzwa+tIaW43cgHZS
	 aJd881KAAFBFh8dYZK4h9CMwKQjwGz/js5cOKGMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgESGXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgESGXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:23:41 -0400
Received: from localhost (unknown [122.182.207.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A19A20708;
        Tue, 19 May 2020 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589869421;
        bh=pEUnHXzWtTkGG8+gt64e+gkH1Bjuec5902GkItqSqCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvXEIn9UG+/Gepsedn3uzlahRb4eWFpk1pxVsSqNCYWmPlK+aPGT5KHzT87JsjyIX
         ahhrXAwJJ+y5dXYG2cKaja2k4ECGmIDQQ4u+PiUAp2pMkOOoJgZDR609PMfz/qryeN
         Fi4RuEXhVHOFFPJX7g7H/3cIy5kTS2wfidgpYilQ=
Date:   Tue, 19 May 2020 11:53:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v7 0/4] Add QMP V3 USB3 PHY support for SC7180
Message-ID: <20200519062335.GJ374218@vkoul-mobl.Dlink>
References: <1589510358-3865-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589510358-3865-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-20, 08:09, Sandeep Maheswaram wrote:
> Add QMP V3 USB3 PHY entries for SC7180 in phy driver and
> device tree bindings.

Applied all, thanks

-- 
~Vinod
