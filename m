Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA09DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47E720723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMgDqgWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGCJrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGCJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:47:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE97C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:47:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so31438093wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CkcJhb/CNLx6sxUe4/rACgYtwPj1y+jwOacbPr50x+o=;
        b=LMgDqgWYbV1ZdV2LtPqUvab8ZY0vFAONXEIH4JLdgaLKjTv+JbfmTKXCgEPPkZLyzW
         HigqLuD7MComI4DLhGktyLL0ZVy+DYZ9DZPT7nsnq/wugK2N+EPcAgu5W1Jyaa8sOgwH
         YePRTaGZE0HTQpRqUovayORqwiVS90wk13Mt3oA+FZnKonc0pIE9vB4paaYYPEUcJkV5
         Xpog7VEhMaYXz30xj7wL43As28gv49KjE9AOM18IjzVkMW/OEkrjBR4cAqJYc9B57URd
         iLZVddIUUWayocz+8SkwXERSqfm26ClOov8LghNpeWYBx3CxlguJtye4KLJ8+sv73F6u
         kreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CkcJhb/CNLx6sxUe4/rACgYtwPj1y+jwOacbPr50x+o=;
        b=ARhuG5aPAjHb0loLsHhr0o2HwMYNUcRFuO4vOAVRHg7vmK/Ay93K05WcQFtKPDcCrJ
         OS25Blf3bbpCJ3lrf2mvG4Ek73T++Zm4gIKGkLQMwIS+xbYxRKRmpcI1XYMRKUSnhqIT
         5iITYR9Wj2AnIokLkVPvohOp35MiQ7WHdJWR0D/MeVgCqbQykP4M7gFSZY9damHszmu3
         w9LX85U1Fi8QTX81WfkGG6e7GxpjoRwQaQkNEh6c8lMfIaQ34EFLk+ykbYvWOms1QKEV
         IMivl02CwBvMmK5EzcfEL71ukqNrY2NRSRNnGyV7Jk7TqXEu/DSgxy6wKkTylXNAMYZx
         AsVg==
X-Gm-Message-State: AOAM531jpywt9xi9XiJEmLrJOGQ/J98s0MSlJJP30YnOUZ1kCI6ganRn
        pq4fuTZ9PBU4lD+Du1yhn9aa3g==
X-Google-Smtp-Source: ABdhPJxUfA4HJx4Qj0EEgXwmd8e1DOTHGcqfQjIPYwamRL2l5AP7q+n0kNWsBx+aP3bY74kbgonzAA==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr34495057wmb.47.1593769661935;
        Fri, 03 Jul 2020 02:47:41 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c11sm12711773wmb.45.2020.07.03.02.47.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2020 02:47:41 -0700 (PDT)
Subject: Re: [RFC PATCH] ALSA: compress: add support to change codec profile
 in gapless playback
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        plai@codeaurora.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, vathota@codeaurora.org, bgoswami@codeaurora.org
References: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
 <90ed95e0-8b01-6c87-b86b-dfa463181527@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2444711a-319e-1f9b-1289-7744bb1a2987@linaro.org>
Date:   Fri, 3 Jul 2020 10:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <90ed95e0-8b01-6c87-b86b-dfa463181527@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for the comments,

+Adding Patric Lai into loop,



On 02/07/2020 16:00, Pierre-Louis Bossart wrote:
> 
> 
> On 7/2/20 6:11 AM, Srinivas Kandagatla wrote:
>> For gapless playback its possible that each track can have different
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
>> userspace to set this new parameters required for new codec profile.
> 
> That does not seem fully correct to me. WMA profiles are actually 
> different encoding schemes - specifically the WMA 10 LBR.
> 
> The premise for gapless playback was that the same codec and profile be 
> used between tracks, so that the same internal delay was used. If you 
> look at the output data, it's made of zeroes for N samples, and then you 
> see decoded data. When you change tracks, the first N samples actually 
> come from the previous track.
> 
> If you change coding schemes between tracks, you cannot call this 
> gapless playback. You will both remove the last N samples of the 
> previous track and insert M zeroes (for the new decoder).
> 
> If you wanted to support such a mode, you would need to provide an 
> indication of the delay difference, e.g. by looking at the ID3 tags and 
> let firmware realign. Unfortunately, you don't send this information 
> with the new IOCTL? You would also need firmware tricks for the first 
> decoder to flush out its output and the new decoder to realign.
> 
> I also don't see how one might end-up with different profiles for an 
> album in the first place. The gapless use came mostly from ripping live 
> music recorded on audio CDs in different tracks, and it would have taken 
> a twisted mind to select different encodings between tracks.
> 
> If the 'album' is really a playlist, then the gapless playback as 
> supported by the ASoC compressed layer is nearly useless. What you would 
> really want is cross-fade but that's a different use case and 
> implementation that would be needed.

Patrick seems to have discussed this topic in detail at one of the audio 
conf!

He might want to add more to this discussion.


Thanks,
srini
