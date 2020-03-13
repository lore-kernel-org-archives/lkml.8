Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7693206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCMQwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:52:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:52:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 61E9529825B
Subject: Re: [PATCH 0/3] media: staging: rkisp1: allow simultaneous streaming
 from multiple capture devices
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, linux-rockchip@lists.infradead.org,
        hans.verkuil@cisco.com, kernel@collabora.com
References: <20200313014626.3103091-1-helen.koike@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <9673b170-69cf-b951-bc29-76cf05e57fea@collabora.com>
Date:   Fri, 13 Mar 2020 13:51:53 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200313014626.3103091-1-helen.koike@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/20 10:46 PM, Helen Koike wrote:
> Hi,
> 
> This series adds support for simultaneous streaming from both capture
> devices (rkisp1_selfpath and rkisp1_mainpath).
> 
> Patch 1/3 fixes return error handling from pm functions, which was
> preventing the second stream to start.
> 
> Patch 2/3 don't allow .s_stream entity callback to be called if a stream is
> already enabled. Which fixes the issue when stopping one stream would
> also stop the other.
> 
> Patch 3/3 serializes start/stop streaming calls, since they both read
> and modify the streaming status of all the entities in the piipeline.
> 
> This series was tested with:
> 
> SEN_DEV=/dev/v4l-subdev3
> ISP_DEV=/dev/v4l-subdev0
> RSZ_SP_DEV=/dev/v4l-subdev2
> RSZ_MP_DEV=/dev/v4l-subdev1
> CAP_SP_DEV=/dev/video1
> CAP_MP_DEV=/dev/video0
> 
> WIDTH=1920
> HEIGHT=1080
> RAW_CODE=SRGGB10_1X10
> YUV_CODE=YUYV8_2X8
> 
> v4l2-ctl --set-subdev-fmt pad=0,width=$WIDTH,height=$HEIGHT,code=$RAW_CODE -d $SEN_DEV
> 
> v4l2-ctl --set-subdev-fmt pad=0,width=$WIDTH,height=$HEIGHT,code=$RAW_CODE -d $ISP_DEV
> v4l2-ctl --set-subdev-selection pad=0,target=crop,top=0,left=0,width=$WIDTH,height=$HEIGHT -d $ISP_DEV
> 
> v4l2-ctl --set-subdev-selection pad=2,target=crop,top=0,left=0,width=$WIDTH,height=$HEIGHT -d $ISP_DEV
> v4l2-ctl --set-subdev-fmt pad=2,width=$WIDTH,height=$HEIGHT,code=$YUV_CODE -d $ISP_DEV
> 
> v4l2-ctl --set-subdev-fmt pad=0,width=$WIDTH,height=$HEIGHT,code=$YUV_CODE -d $RSZ_SP_DEV
> v4l2-ctl --set-subdev-fmt pad=1,width=$WIDTH,height=$HEIGHT,code=$YUV_CODE -d $RSZ_SP_DEV
> 
> v4l2-ctl --set-subdev-selection pad=0,target=crop,top=0,left=0,width=$WIDTH,height=$HEIGHT -d $RSZ_SP_DEV
> 
> v4l2-ctl --set-subdev-fmt pad=0,width=$WIDTH,height=$HEIGHT,code=$YUV_CODE -d $RSZ_MP_DEV
> v4l2-ctl --set-subdev-fmt pad=1,width=$WIDTH,height=$HEIGHT,code=$YUV_CODE -d $RSZ_MP_DEV
> 
> v4l2-ctl --set-subdev-selection pad=0,target=crop,top=0,left=0,width=$WIDTH,height=$HEIGHT -d $RSZ_MP_DEV
> 
> v4l2-ctl -v width=$WIDTH,height=$HEIGHT,pixelformat=NV12 -d $CAP_SP_DEV
> v4l2-ctl -v width=$WIDTH,height=$HEIGHT,pixelformat=NV12 -d $CAP_MP_DEV
> 
> sleep 1
> 
> v4l2-ctl --stream-mmap --stream-count=100 -d $CAP_SP_DEV --stream-to=/tmp/test_sp.raw &
> v4l2-ctl --stream-mmap --stream-count=100 -d $CAP_MP_DEV --stream-to=/tmp/test_mp.raw &
> 
> wait
> echo "Completed"
> 
> 
> 
> Helen Koike (3):
>   media: staging: rkisp1: cap: fix return values from pm functions
>   media: staging: rkisp1: do not call s_stream if the entity is still in
>     use
>   media: staging: rkisp1: cap: serialize start/stop stream
> 
>  drivers/staging/media/rkisp1/rkisp1-capture.c | 25 ++++++++++++++++---
>  drivers/staging/media/rkisp1/rkisp1-common.h  |  2 ++
>  drivers/staging/media/rkisp1/rkisp1-dev.c     |  2 ++
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 

Please, ignore this version, I rebased with the wrong branch. I'll send v2.

Thanks
Helen
