Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A04C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574A620747
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oeze1jbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGEP37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgGEP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:29:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4AC061794;
        Sun,  5 Jul 2020 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KwonaS4ZUVQA/penKUCvFe9Q0+8Q/JPmxWHqhQkbcK4=; b=Oeze1jbH+oDedKFNqUNMHTa9TP
        mNQaDm4L/M1SLVm7KUNJcEOMS/q+kHNG/sG3n0YG1HyoYvR4BGGwxiUncCc3g8xPFOfdu6IO1Gv5R
        DdMPMIp2JOoIMjlloHDl8qhkCluPYhaicxsKzPzOlMUQO2diVdR40fyrgAp8EJ23mSJb7/hyWeF99
        X3HU1GMWRBJXcdGdCZlVBUx1+XJCLsfOLyeMhNzXqLw3gB4+oRhsPaR+lM7KFTOvWkBkZ+xHuedvQ
        AZW/h64wwlIXNvthXIRhn2CIVpVkV4SuQ1ckhGNMkAxfXi9VK/YPAkNxkGBJ0YYRvpD6zJkBP4ZeJ
        6LdQf/Mg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1js6aR-0002Z6-8B; Sun, 05 Jul 2020 15:29:47 +0000
Subject: Re: [PATCH 4/4] media: docs: Depricate mfc frame skip control
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maheshwar Ajja <majja@codeaurora.org>
References: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
 <20200705121128.5250-5-stanimir.varbanov@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <721a6a24-6fbe-8413-e7fb-cf471a7211df@infradead.org>
Date:   Sun, 5 Jul 2020 08:29:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705121128.5250-5-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/20 5:11 AM, Stanimir Varbanov wrote:
> Depricate mfc private frame skip mode control for new

  Deprecate

Also in $subject.

> clients and use the standard one instead.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index a8b4c0b40747..c0760bfc54d4 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2805,6 +2805,11 @@ MFC 5.1 Control IDs
>  ``V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE``
>      (enum)
>  
> +    .. note::
> +
> +       This control is depricated. Use the standard one

                          deprecated.


> +       ``V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE`` instead.
> +
>  enum v4l2_mpeg_mfc51_video_frame_skip_mode -
>      Indicates in what conditions the encoder should skip frames. If
>      encoding a frame would cause the encoded stream to be larger then a
> 


-- 
~Randy

