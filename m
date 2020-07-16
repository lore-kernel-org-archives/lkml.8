Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE85D20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="voMIzOHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGPLpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:45:05 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:36061 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbgGPLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:45:04 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id w2Juj4VQ8NPeYw2JxjUuuJ; Thu, 16 Jul 2020 13:45:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1594899902; bh=ocX3h7C2mB2k9EdNbERODh1fBs1RKjA6eiTyuzzqIik=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=voMIzOHiVYG1pC81I0Vfgmvm9KUbfLJYe4tJwJjVQc3tZzgZrKGtXXGRRdbMjP0we
         aig+Mk1NxDbA7xM4nF5M02U2RH390B6YPBFcXRWHh/Tqtbq2pFjBUxpmW9Hf7rfYec
         6hap9PYCNMM1/+QOZu125A9H8nmmUQCgPVlk8oahHKM+qD58d4ItcymjYpXZ6B+eIE
         YHTDrHM8R/8Nw/3bwDfOKn3TLc4/jVw88Le4Khc0ZbmWeY/2vEIltupLBy2I+ZL8c9
         MR1RLzjeB5e4bPeCgJ4hYvXh2VpS2M6efLC7+AlEFv0gZ4EtgjL9LZ9ydrJFrLSgOP
         W+VmLE8HDVSzQ==
Subject: Re: [PATCH 02/10] media: uapi: h264: Further clarify scaling lists
 order
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20200715202233.185680-1-ezequiel@collabora.com>
 <20200715202233.185680-3-ezequiel@collabora.com>
 <bfb5d0df-779f-78d2-fc48-3c6056f5fdd3@xs4all.nl>
 <6e61d98bd8d7a6d41daf0edd449bd27558c0ac16.camel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <39819dcc-a336-3d13-38ab-93a27460e103@xs4all.nl>
Date:   Thu, 16 Jul 2020 13:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6e61d98bd8d7a6d41daf0edd449bd27558c0ac16.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDL66E0Skoqx60YILWBzPAdko3NSlEE7T29wnMuX9V1cM9PipwoGDNpSOYBlqupmz6lvkFlstT+7UvoWhw/w6RFi5ZZ//0wdLHEZ2WNAYqj2bzipWbAv
 zC6UUIMoljrRMij72/v7+SPEHFm8DXP6RkZiFn9Z06EdNdIOjBxvUH9uaMkQkk4zWsOZKS7ALPRyiAuTmnni0MjXCV8fvxbvyGEiCvEpizwafUavKq4Z+GoI
 2AQb4OCTSEAboqHWVUx3JZaWRh1VPTME7JyfTenaeCcKp9SvleT8qCxefRgnEKSGXjlnlnB6li2Ue0XxnkhKNKjyqLGnZ+GKVKGK9cVV8flWudwVoltTghKq
 bJLdlRv7HWKyoatI66Cbrx9dtA4XqfplJeqNr8ZQ9+YZq6lGSXYTXUr57v+Lg32pKCFR4/J2+ePly3as3A58iAbjfageTgC9krO1zD5quD4CQSlOd7DtUtVa
 S1hESLdOM3/wnGkE3euULsC5sG62CCi+1TIWXg7+WV/n9aAezqNTvhLmHVPK9SBgB4xc8iX8tjjTlgwP2h3NJvTNbGu7a9pd6J+xqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 13:43, Ezequiel Garcia wrote:
> On Thu, 2020-07-16 at 09:23 +0200, Hans Verkuil wrote:
>> On 15/07/2020 22:22, Ezequiel Garcia wrote:
>>> Commit 0b0393d59eb4a ("media: uapi: h264: clarify
>>> expected scaling_list_4x4/8x8 order") improved the
>>> documentation on H264 scaling lists order.
>>>
>>> This commit improves the documentation by clarifying
>>> that the lists themselves are expected in matrix order.
>>
>> "matrix order" is not a well defined term. Especially since different
>> programming languages lay out matrices differently (e.g. fortran uses
>> column-major order). Perhaps something like this is more unambiguous:
>>
> 
> Agreed, "matrix order" is perhaps not a proper choice of words.
> 
>> "The values on each scaling list are in row-major order."
>>
>> BTW, why not be explicit and use:
>>
>> __u8 scaling_list_4x4[6][4][4];
>> __u8 scaling_list_8x8[6][8][8];
>>
>> That makes it explicit and the order is just that of what the C language
>> uses.
>>
> 
> I am not sure if that'll go in clearer direction.
> 
> I'm thinking we just need to clarify the coefficients
> are in raster scan order, as opposed to a zig-zag scan
> order, which is a part of the decoding process.
> 
> How about we simply say "raster scan order" and keep the patch as is?

That works for me.

Regards,

	Hans

> 
> Thanks,
> Ezequiel
> 
> 
>> Regards,
>>
>> 	Hans
>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>> ---
>>>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index c2e17c02f77e..16bfc98ab2f6 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -1725,12 +1725,14 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>>>        - ``scaling_list_4x4[6][16]``
>>>        - Scaling matrix after applying the inverse scanning process.
>>>          Expected list order is Intra Y, Intra Cb, Intra Cr, Inter Y,
>>> -        Inter Cb, Inter Cr.
>>> +        Inter Cb, Inter Cr. The values on each scaling list are
>>> +        expected in matrix order.
>>>      * - __u8
>>>        - ``scaling_list_8x8[6][64]``
>>>        - Scaling matrix after applying the inverse scanning process.
>>>          Expected list order is Intra Y, Inter Y, Intra Cb, Inter Cb,
>>> -        Intra Cr, Inter Cr.
>>> +        Intra Cr, Inter Cr. The values on each scaling list are
>>> +        expected in matrix order.
>>>  
>>>  ``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS (struct)``
>>>      Specifies the slice parameters (as extracted from the bitstream)
>>>
> 
> 

