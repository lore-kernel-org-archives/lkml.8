Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A962084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="SZxBPUEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGCLkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:40:06 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:19322 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGCLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=wsZs8l2jsZpG5p2pmDzzBj240/dRHkP1AbxbABY0TAg=;
        b=SZxBPUErkbng44f9FOzJPKJsy3s+NKlFRpxShe3lFQb5/PdAq0SUEDOozciH4i0wE5Vu
        wZLk+5bH3DNfu4cJ4bE9CNbuxHUDrfOGyxVKYekTUxetJL6/cYS9HYkj4tOc/0Ym6PKvRn
        3dyfrlL20lTZayCv2ZVeMiDEjDGILFxuM=
Received: by filterdrecv-p3iad2-5b55dcd864-9xqm9 with SMTP id filterdrecv-p3iad2-5b55dcd864-9xqm9-19-5EFF1913-7D
        2020-07-03 11:40:03.915577276 +0000 UTC m=+585042.874662400
Received: from [10.13.72.108] (unknown)
        by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
        id QFsYjQUNReGTJlkvFINDvw
        Fri, 03 Jul 2020 11:40:03.570 +0000 (UTC)
Subject: Re: [PATCH 7/9] media: rkvdec: h264: Use bytesperline and buffer
 height to calculate stride
References: <20200701215616.30874-1-jonas@kwiboo.se>
 <20200701215616.30874-8-jonas@kwiboo.se>
 <d34520b6799ddf84d9bd6de1cc6352f28c665c9a.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <957479f7-6427-1cc6-700c-b3efe0cb6ff1@kwiboo.se>
Date:   Fri, 03 Jul 2020 11:40:04 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d34520b6799ddf84d9bd6de1cc6352f28c665c9a.camel@collabora.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyX2muiWjmuL9K719?=
 =?us-ascii?Q?h1plRDgy9Akh4eiapuPAt3js9=2F7sjca2qqnDVs0?=
 =?us-ascii?Q?vRzrrSZeUcvcHhLZTaYTIjJwaQ4PFReksGm3h0m?=
 =?us-ascii?Q?rXoSsCiYfxlxvoHUv5jgFduu+azBZQFmcMcHjGi?=
 =?us-ascii?Q?8tOlUKc4C+QtC590k0unTpAS6pYc+krwFnH1eRb?=
 =?us-ascii?Q?mIwXaXjeEiVj1KdS5rhRg=3D=3D?=
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Language: sv
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-03 05:21, Ezequiel Garcia wrote:
> Hi Jonas,
> 
> On Wed, 2020-07-01 at 21:56 +0000, Jonas Karlman wrote:
>> Use bytesperline and buffer height to calculate the strides configured.
>>
>> This does not really change anything other than ensuring the bytesperline
>> that is signaled to userspace matches was is configured in HW.
>>
> 
> Are you seeing any issue due to this?

Not seeing any issue, I just feelt more confident when both the driver and
application use the same value to configure the stride and when used for
drm framebuffer pitch.

> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/staging/media/rkvdec/rkvdec-h264.c | 27 +++++++++++++---------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> index 9c8e49642cd9..1cb6af590138 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> @@ -891,10 +891,11 @@ static void config_registers(struct rkvdec_ctx *ctx,
>>  	dma_addr_t rlc_addr;
>>  	dma_addr_t refer_addr;
>>  	u32 rlc_len;
>> -	u32 hor_virstride = 0;
>> -	u32 ver_virstride = 0;
>> -	u32 y_virstride = 0;
>> -	u32 yuv_virstride = 0;
>> +	u32 hor_virstride;
>> +	u32 ver_virstride;
>> +	u32 y_virstride;
>> +	u32 uv_virstride;
>> +	u32 yuv_virstride;
>>  	u32 offset;
>>  	dma_addr_t dst_addr;
>>  	u32 reg, i;
>> @@ -904,16 +905,20 @@ static void config_registers(struct rkvdec_ctx *ctx,
>>  
>>  	f = &ctx->decoded_fmt;
>>  	dst_fmt = &f->fmt.pix_mp;
>> -	hor_virstride = (sps->bit_depth_luma_minus8 + 8) * dst_fmt->width / 8;
>> -	ver_virstride = round_up(dst_fmt->height, 16);
>> +	hor_virstride = dst_fmt->plane_fmt[0].bytesperline;
>> +	ver_virstride = dst_fmt->height;
>>  	y_virstride = hor_virstride * ver_virstride;
>>  
> 
> So far so good.
> 
>> -	if (sps->chroma_format_idc == 0)
>> -		yuv_virstride = y_virstride;
>> -	else if (sps->chroma_format_idc == 1)
>> -		yuv_virstride += y_virstride + y_virstride / 2;
>> +	if (sps->chroma_format_idc == 1)
>> +		uv_virstride = y_virstride / 2;
>>  	else if (sps->chroma_format_idc == 2)
>> -		yuv_virstride += 2 * y_virstride;
>> +		uv_virstride = y_virstride;
>> +	else if (sps->chroma_format_idc == 3)
>> +		uv_virstride = 2 * y_virstride;
>> +	else
>> +		uv_virstride = 0;
>> +
>> +	yuv_virstride = y_virstride + uv_virstride;
>>  
> 
> Is the chunk above related to the patch, or mostly
> cleaning/improving the code?

You are correct it is mostly cleaning/improving the code,
this should probably be moved to a separate patch or skipped altogether.

Initial 10-bit implementation was made for HEVC so I just backported the code
I ended up with for HEVC back to H.264. Will skip this cleaning/improving in
this series and possible include it as part of a future HEVC series.

Regards,
Jonas

> 
> Thanks,
> Ezequiel
> 
>>  	reg = RKVDEC_Y_HOR_VIRSTRIDE(hor_virstride / 16) |
>>  	      RKVDEC_UV_HOR_VIRSTRIDE(hor_virstride / 16) |
> 
> 
