Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439DC20789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="EE8JgXr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgHRWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:25:13 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:61734 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHRWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=5sA1HBIbrK4jPVJcP+jI4izFpNEEHPxFg/NXWJXMC4g=;
        b=EE8JgXr61Z3ufTYRqqa2+xQCNvdAVubtYA8pVgrJgxTVxG8EEIxd6MeQYaCdLjFar0MJ
        9gwlxNGcp1eSa7aIxrdxWTEnHwH3NahaWyPZQ8Y0s2/2serz4I49TgmOId5GaTi2M5FsY1
        izV4PoCNyveAD2h9wFc3WuJ7YGL+qoff8=
Received: by filterdrecv-p3iad2-5c98798b7-8vpdr with SMTP id filterdrecv-p3iad2-5c98798b7-8vpdr-18-5F3C5546-43
        2020-08-18 22:25:10.778364702 +0000 UTC m=+453341.494334549
Received: from [192.168.1.14] (unknown)
        by ismtpd0008p1lon1.sendgrid.net (SG) with ESMTP
        id -eqZ85VSTrOUcbmstS8KlQ
        Tue, 18 Aug 2020 22:25:10.310 +0000 (UTC)
Subject: Re: [PATCH v3 16/19] media: rkvdec: Drop unneeded per_request
 driver-specific control flag
References: <20200814133634.95665-1-ezequiel@collabora.com>
 <20200814133634.95665-17-ezequiel@collabora.com>
 <7ce53e65-1a05-bef7-afe7-9a5113d5bd4f@kwiboo.se>
 <57e324f9e3e7e56aa634bcfa0aeebf08c118776d.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <b97351fc-1238-e3ee-e7ec-6e74b19725fb@kwiboo.se>
Date:   Tue, 18 Aug 2020 22:25:10 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <57e324f9e3e7e56aa634bcfa0aeebf08c118776d.camel@collabora.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5iAJJICWQucZEPgD?=
 =?us-ascii?Q?lkqTvuNTWM3C5i3gOLtfyiv5E68eDvDkpYtAXPL?=
 =?us-ascii?Q?t2qGRvwlMz4AEvoER=2FVvPngnMtPDj8DO7qAlze5?=
 =?us-ascii?Q?Z5Id1jg+K391ZyuHfKZu0TL4fpwNmixPVU7Atec?=
 =?us-ascii?Q?KB1yPzltKwC4t1XVo6jes0qQBZ3QUFnSOwb6+m3?=
 =?us-ascii?Q?KRshQuTGvlh7YobEf4jMA=3D=3D?=
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset=us-ascii
Content-Language: sv
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-18 23:38, Ezequiel Garcia wrote:
> On Tue, 2020-08-18 at 20:17 +0000, Jonas Karlman wrote:
>> Hi Ezequiel,
>>
>> On 2020-08-14 15:36, Ezequiel Garcia wrote:
>>> Currently, the drivers makes no distinction between per_request
>>> and mandatory, as both are used in the same request validate check.
>>>
>>> The driver only cares to know if a given control is
>>> required to be part of a request, so only one flag is needed.
>>
>> This patch cause decoding issues with ffmpeg.
>>
>> The removal of per_request makes DECODE_MODE and START_CODE ctrls
>> mandatory to be included in the request.
>>
> 
> Ugh, I just failed boolean logic 101.
> 
> Yeah, we those controls shouldn't be mandatory.

Yep, removing mandatory flag makes rkvdec decoding work again :-)

> 
> I'll send a fix for that. Other than this, can I add your tested-by to the series?

Yes, with above fix this series is

Tested-by: Jonas Karlman <jonas@kwiboo.se>

using ffmpeg [1] on rk3288 (hantro) and rk3399 (rkvdec).


I have also done limited testing of field decoding on H.264 conformance
video samples and rkvdec manage to generate matching checksums.
On hantro the output is slightly different for fld and picaff samples
and match for frm and mbaff samples.

Because field decoding works correctly with rkvdec I am confident that
uapi contains everything needed to support field decoding.


[1] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-hwaccel-4.3.1

Best regards,
Jonas

> 
> Thanks,
> Ezequiel
> 
>> Best regards,
>> Jonas
>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>> ---
>>>  drivers/staging/media/rkvdec/rkvdec.c | 6 +-----
>>>  drivers/staging/media/rkvdec/rkvdec.h | 1 -
>>>  2 files changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>>> index 7c5129593921..cd720d726d7f 100644
>>> --- a/drivers/staging/media/rkvdec/rkvdec.c
>>> +++ b/drivers/staging/media/rkvdec/rkvdec.c
>>> @@ -55,23 +55,19 @@ static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
>>>  
>>>  static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
>>>  	{
>>> -		.per_request = true,
>>>  		.mandatory = true,
>>>  		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS,
>>>  	},
>>>  	{
>>> -		.per_request = true,
>>>  		.mandatory = true,
>>>  		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_SPS,
>>>  		.cfg.ops = &rkvdec_ctrl_ops,
>>>  	},
>>>  	{
>>> -		.per_request = true,
>>>  		.mandatory = true,
>>>  		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_PPS,
>>>  	},
>>>  	{
>>> -		.per_request = true,
>>>  		.mandatory = true,
>>>  		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX,
>>>  	},
>>> @@ -615,7 +611,7 @@ static int rkvdec_request_validate(struct media_request *req)
>>>  		u32 id = ctrls->ctrls[i].cfg.id;
>>>  		struct v4l2_ctrl *ctrl;
>>>  
>>> -		if (!ctrls->ctrls[i].per_request || !ctrls->ctrls[i].mandatory)
>>> +		if (!ctrls->ctrls[i].mandatory)
>>>  			continue;
>>>  
>>>  		ctrl = v4l2_ctrl_request_hdl_ctrl_find(hdl, id);
>>> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
>>> index 2fc9f46b6910..77a137cca88e 100644
>>> --- a/drivers/staging/media/rkvdec/rkvdec.h
>>> +++ b/drivers/staging/media/rkvdec/rkvdec.h
>>> @@ -25,7 +25,6 @@
>>>  struct rkvdec_ctx;
>>>  
>>>  struct rkvdec_ctrl_desc {
>>> -	u32 per_request : 1;
>>>  	u32 mandatory : 1;
>>>  	struct v4l2_ctrl_config cfg;
>>>  };
>>>
> 
> 
