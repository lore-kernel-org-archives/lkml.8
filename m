Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A31C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD292078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="EVQbCxtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGJIsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:48:13 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:12031 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=dZIYPxZxLpGMbJlkzqUViPaom6ifHuTHK7GZJUTb2Ks=;
        b=EVQbCxtQ7STak8e2KTYAq3X2xsCQ5xHY0P4E/W27lZfgz4prYLoIdXYf7Mvt5d6XYSgw
        3EAuyksY/eabwBVBZkd9DJUWeAnaT3KdS/8O8FhhZiz70rjW0PK82koJvsX+qKg33T8UUn
        yAttkIdgH2oXXDYois2FlUXGmBVDjlDU0=
Received: by filterdrecv-p3iad2-5b55dcd864-t97fw with SMTP id filterdrecv-p3iad2-5b55dcd864-t97fw-17-5F082B4B-75
        2020-07-10 08:48:12.089716361 +0000 UTC m=+1179533.724010213
Received: from [192.168.1.14] (unknown)
        by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
        id bYEuYwbrSeqFXS8MzryL8w
        Fri, 10 Jul 2020 08:48:11.745 +0000 (UTC)
Subject: Re: [RFC 07/12] media: uapi: h264: Add DPB entry field reference
 flags
References: <HE1PR06MB40117D0EE96E6FA638A04B78ACBF0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20190901124531.23645-1-jonas@kwiboo.se>
 <HE1PR06MB4011559BF2447047C66285D2ACBF0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <233509924f72d69824920d9312373eced68674c0.camel@collabora.com>
 <20200710101333.05077f18@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <4e91d580-98a8-0ba8-dbb9-6af3a2634d8e@kwiboo.se>
Date:   Fri, 10 Jul 2020 08:48:12 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710101333.05077f18@collabora.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7MAGOr9=2FnLrpqE1m?=
 =?us-ascii?Q?rzAO3Z06idNmPW7CAhZqvv7RkgGX7um87FmWwtY?=
 =?us-ascii?Q?PI=2F5+wtZhCnC4bbAtUE7lNtuc2ma8ysEDVxHmtC?=
 =?us-ascii?Q?+377wDkh47Prci=2FOFuh=2F1fm4g3jpL1Zup+DnSMc?=
 =?us-ascii?Q?tuznyFaXi4A1fSdEskNedsVIPu3rTBSTeEcAiFu?=
 =?us-ascii?Q?V5kyoBj2bmdz0GRRWQO8g=3D=3D?=
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Language: sv
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-10 10:13, Boris Brezillon wrote:
> On Fri, 10 Jul 2020 01:21:07 -0300
> Ezequiel Garcia <ezequiel@collabora.com> wrote:
> 
>> Hello Jonas,
>>
>> In the context of the uAPI cleanup,
>> I'm revisiting this patch.
>>
>> On Sun, 2019-09-01 at 12:45 +0000, Jonas Karlman wrote:
>>> Add DPB entry flags to help indicate when a reference frame is a field picture
>>> and how the DPB entry is referenced, top or bottom field or full frame.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>  Documentation/media/uapi/v4l/ext-ctrls-codec.rst | 12 ++++++++++++
>>>  include/media/h264-ctrls.h                       |  4 ++++
>>>  2 files changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
>>> index bc5dd8e76567..eb6c32668ad7 100644
>>> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
>>> @@ -2022,6 +2022,18 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>>>      * - ``V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM``
>>>        - 0x00000004
>>>        - The DPB entry is a long term reference frame
>>> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_FIELD_PICTURE``
>>> +      - 0x00000008
>>> +      - The DPB entry is a field picture
>>> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_REF_TOP``
>>> +      - 0x00000010
>>> +      - The DPB entry is a top field reference
>>> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_REF_BOTTOM``
>>> +      - 0x00000020
>>> +      - The DPB entry is a bottom field reference
>>> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_REF_FRAME``
>>> +      - 0x00000030
>>> +      - The DPB entry is a reference frame
>>>  
>>>  ``V4L2_CID_MPEG_VIDEO_H264_DECODE_MODE (enum)``
>>>      Specifies the decoding mode to use. Currently exposes slice-based and
>>> diff --git a/include/media/h264-ctrls.h b/include/media/h264-ctrls.h
>>> index e877bf1d537c..76020ebd1e6c 100644
>>> --- a/include/media/h264-ctrls.h
>>> +++ b/include/media/h264-ctrls.h
>>> @@ -185,6 +185,10 @@ struct v4l2_ctrl_h264_slice_params {
>>>  #define V4L2_H264_DPB_ENTRY_FLAG_VALID		0x01
>>>  #define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE		0x02
>>>  #define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM	0x04
>>> +#define V4L2_H264_DPB_ENTRY_FLAG_FIELD_PICTURE	0x08
>>> +#define V4L2_H264_DPB_ENTRY_FLAG_REF_TOP	0x10
>>> +#define V4L2_H264_DPB_ENTRY_FLAG_REF_BOTTOM	0x20
>>> +#define V4L2_H264_DPB_ENTRY_FLAG_REF_FRAME	0x30
>>>    
>>
>> I've been going thru the H264 spec and I'm unsure,
>> are all these flags semantically needed?
>>
>> For instance, if one of REF_BOTTOM or REF_TOP (or both)
>> are set, doesn't that indicate it's a field picture?

These flags would only indicate how the frame / field pair / field is
referenced and not if the DPB entry was decoded as a frame or field pair.

Both hantro and rkvdec needs to know how the referenced frame / field pair
was decoded (not how it is referenced), my best guess is that MV is stored
differently for a frame (linear) and field pair (buffer split in two).

I think we should be able to track how the buffer was decoded similar to
how VP9 keep track of buffer width/height.

When I played with interlaced decoding of rkvdec a few weeks ago I
reverted flags to something similar as my initial rfc patch, see [1].
I guess it should be possible to keep current flags and track field_pic
in driver, some macro to simplify check for top/bottom ref could be
useful if flags is kept as-is.

I am hoping to find some time next week to revisit hantro interlaced
and refine rkvdec interlaced support.

[1] https://github.com/Kwiboo/linux-rockchip/compare/da52ca6f8d2284aebea2d0b99d254b64922faa2d...c9f04cd9bc65eda0da713f4ce1c77eeb1960bd70

Regards,
Jonas

>>
>> Or conversely, if neither REF_BOTTOM or REF_TOP are set,
>> then it's a frame picture?
> 
> I think that's what I was trying to do here [1]
> 
> [1]https://patchwork.kernel.org/patch/11392095/
> 
