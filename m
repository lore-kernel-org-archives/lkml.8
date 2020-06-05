Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F06D207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="S3kWp7/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgFERnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFERnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:43:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E84C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 10:43:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n141so10562639qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rZzlH3lgJQJ1GMva4U3PZGzXYmKRlX309wcrnr5n+uY=;
        b=S3kWp7/LuNSWrfUi5frZnfE9rEvEaHJeB8X7ZzkN0AUH7ZRcyj1NK0Xxc3N9O8Nn19
         51smv5NiVOuB/qrQg8Wrcj3NPeKGiY3mh2zGZNwKRWbQmxIph4oOBW1H7ACKRQQHWnDd
         fT5JcOe2wkSRH4uXJ/SrTOwC+7+rkshaFAsWQ13d0A6hNEk/JO5VUcAgYEY46gxMy1PA
         fVer0A34vt37OVh6U4TBBwvqiUyt5KU9rEDMOOj9lKInKC2MH4X6kZIFGIYfgZlAkBTp
         sHadbRfDtGf4tfanol1uU48dxQtGIf9VhZX83rcnfHYQQ82+WbcipGKl6CVmy2LFfR2R
         u9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rZzlH3lgJQJ1GMva4U3PZGzXYmKRlX309wcrnr5n+uY=;
        b=VlkYkzZEd+MVH5DF1zFjI0KSw3FbGaXOmWK5mMGpG9OMxGHhsvUnfGd2rdEau3E4Q9
         /M9nA2p1hbovRCrwmnGf7Gn5wx95pqyRHDZ1UGwLG1qvz/66RND2gZMpHYt9rUKAWwfH
         iO+YpuPscwbUutO5xPQeDJaKszZLWT2dMW5d7i/vFAEY1oox7LTR1Y0W5dM0hjCDCWWp
         1kmKat4in3S9ZY5rIq4bZ1chqPFrJWR82VYSfX4D8XyUDEr+NzaULs2sFdlMqhHKiF41
         V12Au3e2dml+RVzJr2SDUxLnA821s4slUNeszm4M/nXpLwonJPvVekhVYiKszNvToxvG
         KAzw==
X-Gm-Message-State: AOAM530h0RZ3mQ4l8bdjInOQChREy3h2icwouGpi1Yaaqidss7DbE2rg
        pWCQIWeW3hgpsqqHCgSg8MyEbg==
X-Google-Smtp-Source: ABdhPJx5VdfTacBdommIKg1RhtvX4MaRuPEPiDdNpolMZqjrE6XJwiukyJJzDa1sR2c1lYGpiAO93g==
X-Received: by 2002:a37:b847:: with SMTP id i68mr10785437qkf.431.1591378994692;
        Fri, 05 Jun 2020 10:43:14 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id a1sm332298qkn.87.2020.06.05.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:43:14 -0700 (PDT)
Message-ID: <edbae7a96fb6cc2d017d947fbeedc86a7540302a.camel@ndufresne.ca>
Subject: Re: [RFC] METADATA design using V4l2 Request API
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     dikshita@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, majja@codeaurora.org, jdas@codeaurora.org,
        linux-media-owner@vger.kernel.org
Date:   Fri, 05 Jun 2020 13:43:12 -0400
In-Reply-To: <5356c146a340d951b8d492373f349199@codeaurora.org>
References: <1588918890-673-1-git-send-email-dikshita@codeaurora.org>
         <d1179bc1-662b-615f-0f9b-67693fe8c906@xs4all.nl>
         <fb96e2c09346e7831a0af99c0fe9f94c@codeaurora.org>
         <7be1070ee7aad1f48fc6de63523da8e1bc952dc8.camel@ndufresne.ca>
         <ad61378b-e279-d161-adaa-17349adf183e@xs4all.nl>
         <5356c146a340d951b8d492373f349199@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 05 juin 2020 à 12:32 +0530, dikshita@codeaurora.org a écrit :
> Hi Hans, Nicolas,
> 
> On 2020-05-29 13:01, Hans Verkuil wrote:
> > On 29/05/2020 04:18, Nicolas Dufresne wrote:
> > > Le jeudi 28 mai 2020 à 16:18 +0530, dikshita@codeaurora.org a écrit :
> > > > > not allowed. So I need to know more about this.
> > > > > Regards,
> > > > >        Hans
> > > > 
> > > > we need this for use cases like HDR10+ where metadata info is part of
> > > > the bitstream.
> > > > 
> > > > To handle such frame specific data, support for request api on 
> > > > capture
> > > > plane would be needed.
> > > 
> > > I have a bit of a mixed impression here. Considering how large the 
> > > ioctl
> > > interface overhead is, relying on HW parser to extract this medata 
> > > woud be the
> > > last thing I would consider.
> > > 
> > > Instead, I'm quite convince we can achieve greater and likely 
> > > zero-copy
> > > perfromance by locating this header in userspace. So everytime I see 
> > > this kind
> > > of API, were the HW is *needed* to parse a trivial bit of bistream, I 
> > > ended
> > > thinking that we simply craft this API to expose this because the HW 
> > > can do it,
> > > but no further logical thinking or higher level design seems to have 
> > > been
> > > applied.
> > > 
> > > I'm sorry for this open critic, but are we designing this because the 
> > > HW
> > > designer exposed that feature? This is so low complexity to extract in
> > > userspace, with the bonus that we are not forced into expanding the
> > > representation to another form immediatly, as maybe the display will 
> > > be able to
> > > handle that form directly (where converting to a C structure and then 
> > > back to
> > > some binary format to satisfy DRM property seems very sub-optimal).
> > > 
> > > Nicolas
> > > 
> > 
> > Nicolas raises good questions: it would help if you can give more
> > detailed information
> > about the hardware. We had similar discussions with Xilinx about
> > HDR10+ (see this
> > thread: https://www.spinics.net/lists/linux-media/msg163297.html).
> > 
> > There is no clear answer at the moment on how to handle dynamic HDR 
> > metadata.
> > It will help if we have some more information how different SoCs handle 
> > this
> > in hardware.
> > 
> > Regards,
> > 
> > 	Hans
> 
> As per Widevine Level 1 requirement, it needs “Hardware Protected Video 
> Path”.
> Hence, in case of secure bitstream decoding, we need decoder metadata 
> delivered from HW.
> CPU cannot parse secure bitstream and extract them.
> Apart from this, there are other metadata like "histogram" which is not 
> part of the bitstream
> and generated by hardware

(I'm ignoring the bit about camera data + histogram, this was about
CODEC, and it also does not make much sense to me)

We extract this data from the bitstream, before the decoder. The
bitstream is not subject to secure buffer, because it's encrypted. Be
aware that the implementation does not encrypt all NALs, PPS/SPS SEIs,
are in clear, and NAL headers are most of the time in clear.

Going with full bitstream encryption would have required rewriting a
lot more HW, since you would not be able to handle the
depayload/demuxing in userspace or you'd need all this multimedia stuff
to be placed on in your secure firmware. Multimedia software these
days, ffmpeg, gstreamer, chromium internal stack etc. needs a lot of
information from the bitstream that would be very hard to pass
properly.

regards,
Nicolas

