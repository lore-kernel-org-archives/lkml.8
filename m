Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79862088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="aEQg8J6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGCTR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:17:58 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:63367 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGCTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=JMzrrLQ9se++ZwGRw0s0zK1g6u9cLVDW96O7G1u/LAc=;
        b=aEQg8J6q+Bw3+XJ+Jl/Y/soe0aGdmEtHXUY68xq6uk4V1IfIVBc2dMjPZjWHPqLP6AGT
        mfTA3mMKFRJL/yuM3KivhyLhh7i0f//NHNJU4pi65U+mZ5bvT12I/ewzC/Yj48SmqxVG51
        rVhRDTSMNWnbUULOXd533trsTtj23a0u4=
Received: by filterdrecv-p3iad2-5b55dcd864-m99xc with SMTP id filterdrecv-p3iad2-5b55dcd864-m99xc-18-5EFF8464-34
        2020-07-03 19:17:56.826658092 +0000 UTC m=+612511.431606343
Received: from [10.13.72.108] (unknown)
        by ismtpd0008p1lon1.sendgrid.net (SG) with ESMTP
        id HoXTftLrS9-boT5QYJGq1A
        Fri, 03 Jul 2020 19:17:56.477 +0000 (UTC)
Subject: Re: [PATCH 8/9] media: rkvdec: Add validate_fmt ops for pixelformat
 validation
References: <20200701215616.30874-1-jonas@kwiboo.se>
 <20200701215616.30874-9-jonas@kwiboo.se>
 <67a130a8fd8874c5dc639c924de959f88357b480.camel@collabora.com>
 <f817d682-ec76-1879-4324-39cf7993493e@kwiboo.se>
 <7abec9992460dcd84a2c951fce55bc8e46f2a0ed.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <0353b993-907d-2dfe-993f-94b82aa27e00@kwiboo.se>
Date:   Fri, 03 Jul 2020 19:17:56 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7abec9992460dcd84a2c951fce55bc8e46f2a0ed.camel@collabora.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h40s=2Fv=2F1ukgnTt=2Fzk?=
 =?us-ascii?Q?0CuiLNFfOI2CGiWfwT=2FJx5rhXV48ki1b5PqGv4p?=
 =?us-ascii?Q?CeCjFHq6Y7p3xhgjWlCn+xQMS=2FdNxQo9inrRmEu?=
 =?us-ascii?Q?wgAGSLnUDyIYYEUS+HJMzqJfvV0BfkEcF7cuHz1?=
 =?us-ascii?Q?RfM+zA=2FTLn7FfQsLhZL30TxRszhapa10iGkE4JU?=
 =?us-ascii?Q?uAVjIeHtwrG2urnT=2FVJgg=3D=3D?=
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

On 2020-07-03 16:58, Ezequiel Garcia wrote:
> On Fri, 2020-07-03 at 06:55 +0000, Jonas Karlman wrote:
>> On 2020-07-03 05:14, Ezequiel Garcia wrote:
>>> Hi Jonas,
>>>
>>> Thanks for working on this.
>>>
>>> On Wed, 2020-07-01 at 21:56 +0000, Jonas Karlman wrote:
>>>> Add an optional validate_fmt operation that is used to validate the
>>>> pixelformat of CAPTURE buffers.
>>>>
>>>> This is used in next patch to ensure correct pixelformat is used for 10-bit
>>>> and 4:2:2 content.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>  drivers/staging/media/rkvdec/rkvdec.c | 8 ++++++++
>>>>  drivers/staging/media/rkvdec/rkvdec.h | 1 +
>>>>  2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>>>> index b1de55aa6535..465444c58f13 100644
>>>> --- a/drivers/staging/media/rkvdec/rkvdec.c
>>>> +++ b/drivers/staging/media/rkvdec/rkvdec.c
>>>> @@ -239,6 +239,14 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
>>>>  	if (WARN_ON(!coded_desc))
>>>>  		return -EINVAL;
>>>>  
>>>> +	if (coded_desc->ops->validate_fmt) {
>>>> +		int ret;
>>>> +
>>>> +		ret = coded_desc->ops->validate_fmt(ctx, pix_mp->pixelformat);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> + 
>>>
>>> I don't think this approach will be enough. Unless I'm mistaken,
>>> it's perfectly legal as per the stateless spec to first
>>> call S_FMT on the OUTPUT queue (which is propagated to the CAPTURE side),
>>> and then set the SPS and other controls.
>>
>> I agree that this will not be enough to cover all use cases stated in the spec.
>>
>>> The application is not required to do a TRY_FMT after S_EXT_CTRLS.
>>
>> If I remember correctly we were required to implement a TRY_FMT loop in
>> ffmpeg due to cedrus defaulting to SUNXI_TILED_NV12 instead of linear NV12
>> on platforms where display controller did not support the tiled modifier.
>>
>> So having TRY_FMT as part of the init sequence has been my only test-case.
>>
>>> What I believe is needed is for the S_EXT_CTRLS to modify
>>> and restrict the CAPTURE format accordingly, so the application
>>> gets the correct format on G_FMT (and restrict future TRY_FMT).
>>
>> This sounds like a proper solution, I do belive we may have a chicken or
>> the egg problem depending on if application call S_EXT_CTRLS or S_FMT first.
>>
> 
> IIUC, the order is specified in the stateless spec [1].
> 
> 1) S_FMT on OUTPUT (to set the coded pixelformat). CAPTURE format
> format is propagated here and a default format is set.
> 
> 2) S_EXT_CTRLS, parameters are set. We don't do anything here,
> but here we'd validate the SPS and restrict the CAPTURE pixelformat
> (and perhaps reset the default CAPTURE pixelformat).
> 
> 3) G_FMT on CAPTURE.
> 
> 4) (optional) ENUM_FMT / S_FMT on CAPTURE, to negotiate
> something different from default.

There is also the following scenario that we may need to support:

1) S_FMT on OUTPUT, default CAPTURE format is set.

2) skip S_EXT_CTRLS, mandatory controls is only validated in req_validate.

3) G_FMT on CAPTURE, returns default CAPTURE format.

4) S_FMT on CAPTURE, CAPTURE format is changed from default to selected format.

5) STREAMON

From this point on I would expect S_EXT_CTRLS with a V4L2_CTRL_WHICH_REQUEST_VAL
flag to reject any SPS not matching the selected CAPTURE format. Effectively
allowing S_FMT to lock down a format instead of an initial S_EXT_CTRLS during init.

This means that we have to both allow and reject a SPS depending on the state.

Regards,
Jonas

> 
> Regards,
> Ezequiel 
> 
> [1] Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> 
>> I guess we may need to lock down on a format at whatever comes first,
>> S_FMT on CAPTURE or S_EXT_CTRLS with SPS ctrl.
>>
>> I have an idea on how this could be addressed, will explore and see
>> if I can come up with something new.
>>
>> Regards,
>> Jonas
>>
>>> Also, V4L2 spec asks drivers not to fail on S_FMT
>>> format mismatch, but instead to adjust and return a legal format
>>> back to the application [1].
>>>
>>> Let me know what you think and thanks again.
>>>
>>> Ezequiel
>>>
>>> [1] Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst
>>>
>>>>  	for (i = 0; i < coded_desc->num_decoded_fmts; i++) {
>>>>  		if (coded_desc->decoded_fmts[i] == pix_mp->pixelformat)
>>>>  			break;
>>>> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
>>>> index 2fc9f46b6910..be4fc3645cde 100644
>>>> --- a/drivers/staging/media/rkvdec/rkvdec.h
>>>> +++ b/drivers/staging/media/rkvdec/rkvdec.h
>>>> @@ -64,6 +64,7 @@ vb2_to_rkvdec_decoded_buf(struct vb2_buffer *buf)
>>>>  struct rkvdec_coded_fmt_ops {
>>>>  	int (*adjust_fmt)(struct rkvdec_ctx *ctx,
>>>>  			  struct v4l2_format *f);
>>>> +	int (*validate_fmt)(struct rkvdec_ctx *ctx, u32 pixelformat);
>>>>  	int (*start)(struct rkvdec_ctx *ctx);
>>>>  	void (*stop)(struct rkvdec_ctx *ctx);
>>>>  	int (*run)(struct rkvdec_ctx *ctx);
> 
> 
