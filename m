Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EEC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3020857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587393060;
	bh=1MM2YWhi3e2vrsxEwFMk4HeCduw6RjfxTXdbMfd5/ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FsgdpdNbAw2izl14pCzi9Qw89ksPyOZfnJxjG2apLKNoYJI8aOAzAXzmzA7SuLMNj
	 qL2VPgWGV2wOBvBxMCDGFtAkdx+B/QNiCU/PLTCws97OikuGJK1v9py6uWfnmw0kV3
	 xeQadKrvJLbUHG6OJcFgtmumwGkMnemSWZpxq3tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgDTOa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgDTOa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:30:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630E320B1F;
        Mon, 20 Apr 2020 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587393057;
        bh=1MM2YWhi3e2vrsxEwFMk4HeCduw6RjfxTXdbMfd5/ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTh3SsZYt3dXwIf7fFg8vwSyGeIguoE1VxBW0XkQPhS2I+MYgjRNEwFga2HEcPiXC
         Nby/pIucs017PdWVF6b8BB/ayosJVPfsmyNeWQnjdEvYSQAFVca3S+4S3ojLXhw3sK
         4voasffhwOkHLE2CssNPWqoqyDQc9Z3HMyP+pOAw=
Date:   Mon, 20 Apr 2020 16:30:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Allison Randal <allison@lohutok.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] drm/msm/adreno: add A640/A650 to gpulist
Message-ID: <20200420143055.GC4125486@kroah.com>
References: <20200420140313.7263-1-jonathan@marek.ca>
 <20200420140313.7263-2-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420140313.7263-2-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:03:05AM -0400, Jonathan Marek wrote:
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 10 +++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)

I know I don't accept patches without any changelog text, maybe other
subsystem maintainers are more lax...
