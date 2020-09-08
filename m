Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51238C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0509D2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bun7s7XH";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ASXpXfyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgIHTHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:07:25 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:45196
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731676AbgIHTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599592015;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=lWsMChywupzdHzp7I9YzcKd0Y+ARnhQXfU8/OA9aDl4=;
        b=bun7s7XHXTFbXJ0s25yJSwDDBqtqeEAQEO7ORPqELvQrtNKTRSHqgzyvIo9T/90M
        dYyB1gonJMSVirDBgo4QFVSu7VffhZAKMJVwEk4TDGFEx97fuZEZXKQc7KNown28JxG
        31m3b45MQHWtpC6JQeVOldzJAilRpxqjA+L8jGME=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599592015;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=lWsMChywupzdHzp7I9YzcKd0Y+ARnhQXfU8/OA9aDl4=;
        b=ASXpXfyYPuEX7KzVTeQlzNrPjG1Z499KXtA7pWdQH0vChrBex7uZcLZKV8vPa3Mf
        Bt0UTYHvT2iqXwEGN+QjK/nJjb3tNaL9AdBbztUJQml6uF/fWtn82PU2UAdhkfIWwD/
        q8MnvDFS39H0cTohS2+zGd0G/LxemiZDFm95XM2I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 8 Sep 2020 19:06:55 +0000
From:   abhinavk@codeaurora.org
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Drew Davenport <ddavenport@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Hongbo Yao <yaohongbo@huawei.com>, Bernard <bernard@vivo.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/msm/dpu: move vblank events to complete_commit()
In-Reply-To: <20200907170450.370122-1-robdclark@gmail.com>
References: <20200907170450.370122-1-robdclark@gmail.com>
Message-ID: <010101746f1d268a-8a3ad278-cd47-4688-af9d-531567f0307c-000000@us-west-2.amazonses.com>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.08-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-07 10:04, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> We could get a vblank event racing with the current atomic commit,
> resulting in sending the pageflip event to userspace early, causing
> tearing.  On the other hand, complete_commit() ensures that the
> pending flush is complete.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

I checked our downstream code as well and yes we are not signaling
page flips inside the vblank_cb and are doing it after 
wait_for_commit_done
This aligns with that.
Hence,
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index c2729f71e2fa..89c0245b5de5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -297,7 +297,6 @@ void dpu_crtc_vblank_callback(struct drm_crtc 
> *crtc)
>  		dpu_crtc->vblank_cb_time = ktime_get();
>  	else
>  		dpu_crtc->vblank_cb_count++;
> -	_dpu_crtc_complete_flip(crtc);
>  	drm_crtc_handle_vblank(crtc);
>  	trace_dpu_crtc_vblank_cb(DRMID(crtc));
>  }
> @@ -402,6 +401,7 @@ static void dpu_crtc_frame_event_cb(void *data, u32 
> event)
>  void dpu_crtc_complete_commit(struct drm_crtc *crtc)
>  {
>  	trace_dpu_crtc_complete_commit(DRMID(crtc));
> +	_dpu_crtc_complete_flip(crtc);
>  }
> 
>  static void _dpu_crtc_setup_lm_bounds(struct drm_crtc *crtc,
