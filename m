Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E90C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE4A2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="C+HDCZge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQOfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:35:13 -0500
Received: from mx01-fr.bfs.de ([193.174.231.67]:9092 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgAQOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:35:13 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 09:35:11 EST
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 94FDE2036D;
        Fri, 17 Jan 2020 15:26:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1579271204; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vklTv1W7/ocwmfCw1yXAs37PNEse48aUNTXTC6C3H0c=;
        b=C+HDCZgeGXwzghdLLVb2Z0kGY2gmufm+jURg6DQu2im7bC26WaFaEGGZHoHUTepbTyVNE3
        LyPcEiGpaelRbhLIZxMf2/0n8H5ErY6WVaFrhdQNBhHOUqWJoPfU8+ev2pa2q+WGha2Dhr
        Ydcuq/q7qL4JBz6PFxmasSmfMsD1Ho//QAmoocevBaA5r/j/nTJcybSFRFFRGGOFfLkfg2
        5TPNV4ogtJVZMnOmeGpdz6H9aDulCYBnpqa5GGpZSXChfJwis1KO7DA/zNxAcsiW+VVv4C
        DgnFGrOBYi9G6qmPOwXcIrmZ9ZEGyUaTHx5tUCILIMs9N9nshMW6WSsNdoPFsQ==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 204E5BEEBD;
        Fri, 17 Jan 2020 15:26:43 +0100 (CET)
Message-ID: <5E21C422.6040708@bfs.de>
Date:   Fri, 17 Jan 2020 15:26:42 +0100
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Nikola Cornij <Nikola.Cornij@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/display: fix for-loop with incorrectly
 sized loop counter
References: <20200117133305.113280-1-colin.king@canonical.com>
In-Reply-To: <20200117133305.113280-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17.01.2020 14:33, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A for-loop is iterating from 0 up to 1000 however the loop variable count
> is a u8 and hence not large enough.  Fix this by making count an int.
> Also remove the redundant initialization of count since this is never used
> and add { } on the loop statement make the loop block clearer.
> 
> Addresses-Coverity: ("Operands don't affect result")
> Fixes: ed581a0ace44 ("drm/amd/display: wait for update when setting dpg test pattern")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 6ab298c65247..cbed738a4246 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -3680,7 +3680,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
>  			struct pipe_ctx *odm_pipe;
>  			enum controller_dp_color_space controller_color_space;
>  			int opp_cnt = 1;
> -			uint8_t count = 0;
> +			int count;
>  
>  			switch (test_pattern_color_space) {
>  			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
> @@ -3725,11 +3725,12 @@ static void set_crtc_test_pattern(struct dc_link *link,
>  				width,
>  				height);
>  			/* wait for dpg to blank pixel data with test pattern */
> -			for (count = 0; count < 1000; count++)
> +			for (count = 0; count < 1000; count++) {
>  				if (opp->funcs->dpg_is_blanked(opp))
>  					break;
>  				else
>  					udelay(100);
> +			}
>  		}
>  	}
>  	break;

Nitpick:
the else is useless you can remove it.

re,
 wh

