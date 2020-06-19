Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFAA206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWxCcNKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgFSJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFSJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:29:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC8C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:29:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so8957401wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnmzgcKo/cBaDVUinsVzz5iYDrFt1Jg4MPKsxfJtIl4=;
        b=mWxCcNKuTZASSNd7jalvWR9GzEUGsZDpmy2q7VfMBiMO2j/l6Q/HNDM5GKyqA6AqW+
         AUi+ol35+rU6R0Wso2uAfHe0kwM05pdnJ9m9p7ErKNfWz83dnkMKHamX7GtzAlx+SxQP
         zf71Tao0ULZWEExaa/Ld8TFaiTdQjrgiKQ86wmJmvNe/5kV3XHXGzPn2e68YpaPfrmyS
         He8RFDM+urT4huq23TMwwkT8bOQ0AfNCpvZv+d3iQ6HCEN4+R4JUoBE14dyyPAg7EtY0
         V+ff+EVIcbL7x3sdIg/00yxtNxMTQZ6ovQCypY0kACLorkteLS0uNbeOsT/4eQeUHNu8
         joaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnmzgcKo/cBaDVUinsVzz5iYDrFt1Jg4MPKsxfJtIl4=;
        b=Xg3oQ4f79CJYTc+/4W0QVZP4FEhX+qftlJ7ZNuWmKqOa3L4FrEfH/KEGw1Sy3T1pn7
         TrPYSurICe1J+JOBwMnlnL9q6cfyXUwFaVIfqBBj1NKzSo6s0uc0qoLy/8q8mvt4QvH8
         xZlgSXIn9fVX/ve4CvIH6b+2NB7k8RrBEK3cPC7i3ybhtbkR5MZym9VS1u+F6kWNL3eZ
         5OJOoFfavCFBXwUccSx3t1If2oyI33GdaPcb67fT7UWWIAGTDeZL+auyYChl5ZLdZV3X
         IL5ueChFeP1b8u435Zg3KSNBZKzhRlW+m0qlj+o+FoUvmVApzCofilAdqNp9CU7iRQ0Z
         QXtw==
X-Gm-Message-State: AOAM533YpfxR7DdbbIiRg5qs4+uxWCKzwrM5SbUh22X0fu8F4VfCpFsm
        vmcTjmQGu/xY39EdSGaPwGAZvcCfToI=
X-Google-Smtp-Source: ABdhPJybrcTtdKuMtr08fQG2M3BYBsLRtDo0jbW3M7e8VIim590FRQjLi35LSQpkk5XSbfkXY340uA==
X-Received: by 2002:adf:ed01:: with SMTP id a1mr3287107wro.271.1592558977492;
        Fri, 19 Jun 2020 02:29:37 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o15sm6240352wmm.31.2020.06.19.02.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:29:36 -0700 (PDT)
Subject: Re: [PATCH 1/3] ALSA: compress: document the compress audio state
 machine
To:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-2-vkoul@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e4b24fc3-4e5d-bff7-e3ff-83ecea1e713f@linaro.org>
Date:   Fri, 19 Jun 2020 10:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200619045449.3966868-2-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/2020 05:54, Vinod Koul wrote:
> So we had some discussions of the stream states, so I thought it is a
> good idea to document the state transitions, so add it documentation
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Thanks Vinod for doing this,
Makes things much clear on the state-machine side!

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   .../sound/designs/compress-offload.rst        | 52 +++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> index ad4bfbdacc83..7292717c43bf 100644
> --- a/Documentation/sound/designs/compress-offload.rst
> +++ b/Documentation/sound/designs/compress-offload.rst
> @@ -151,6 +151,58 @@ Modifications include:
>   - Addition of encoding options when required (derived from OpenMAX IL)
>   - Addition of rateControlSupported (missing in OpenMAX AL)
>   
> +State Machine
> +=============
> +
> +The compressed audio stream state machine is described below ::
> +
> +                                        +----------+
> +                                        |          |
> +                                        |   OPEN   |
> +                                        |          |
> +                                        +----------+
> +                                             |
> +                                             |
> +                                             | compr_set_params()
> +                                             |
> +                                             V
> +                                        +----------+
> +                compr_drain_notify()    |          |
> +              +------------------------>|   SETUP  |
> +              |                         |          |
> +              |                         +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_write()
> +              |                              |
> +              |                              V
> +              |                         +----------+
> +              |                         |          |
> +              |                         |  PREPARE |
> +              |                         |          |
> +              |                         +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_start()
> +              |                              |
> +              |                              V
> +        +----------+                    +----------+     compr_pause()      +----------+
> +        |          |                    |          |----------------------->|          |
> +        |  DRAIN   |<-------------------|  RUNNING |                        |  PAUSE   |
> +        |          |                    |          |<-----------------------|          |
> +        +----------+                    +----------+     compr_resume()     +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_free()
> +              |                              |
> +              |                              V
> +              |                         +----------+
> +              |     compr_free()        |          |
> +              +------------------------>|          |
> +                                        |   STOP   |
> +                                        |          |
> +                                        +----------+
> +
>   
>   Gapless Playback
>   ================
> 
