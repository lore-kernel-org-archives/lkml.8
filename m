Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F26CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A67F20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJT2i7oN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgHXMb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgHXMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:31:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:31:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s20so3116750wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oyXzsgWOgUSKqh7OmCxpMIN54jigix4a16FwR8oV1Jc=;
        b=PJT2i7oNvHTb8GIY3pbdq0CKqaYt9NAekVdTmH3v3/3onYeUE/NnOkyeVQk7zQxOTw
         OCirfXd3t3tTgOXCy3wmga+o2LzoqRGR+mlUiLXAbmWvKVAJCRYBMW1fcUGR3IZBG+H0
         Eo3XgVXOujSZ7x0hRe6VNl5CBNOzlLQRDT9YqMcOcQ5g7rwiy28NyTkrUfa+dqpfGNJL
         xpcZjRQ5iPGm5fI1eR8WGCtxBdPBSEJyepuDiM5n6wK1jUDsIkNnPSPKPPJ/CCotBeNr
         tooMxB1l1uSoZzBcPexlK5hlHt48rIGToAfGYQqHfWN/IqU20mb1N+L3vXfFoKG6G27+
         qsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oyXzsgWOgUSKqh7OmCxpMIN54jigix4a16FwR8oV1Jc=;
        b=HtbdXoLKPCjcgHZyQbd0ROIoqCya8V9yC5OdfnaCu7eN6BtT7nkS1AZ4JH+1DVz2PE
         saDGmfAniWXl5qmPo9pPFQe4IWN1edsCdb8AxMWDpGUFEgISe8ojmRvMOAtSaVBkfOMv
         /khGJku4f8YHwIA/1cn3EBiYzL1V3BcBr/hSn3WspEGqNRie9aVG8dHjKKZAj3HG3jGW
         8GgyTUPhbxarvOZDTXj7GuFbEjXH6EU8DpOaWUXNlpvm0SlYqu9Kc07r3Z0evBwJSm02
         GwSJLIHJcU5+FYNdgwpLK019opYi30TZ3tZ27PZLrPcC8PCpcJI4ksVc7hvaOwUdxUS5
         tivw==
X-Gm-Message-State: AOAM530j9Ys93irxVhccN+/58sUW349q8fT1TAL0BaH8zLCoiJ5qgJoR
        vq/d02g6sLvxYULb0TrTOAU=
X-Google-Smtp-Source: ABdhPJzCG8ZeDcWVct1PS4h/Vf1ItylB7hBVwzVNHzXGcW19wknoM4zUvaEth3ZoSDxUERetRqAPGA==
X-Received: by 2002:a7b:cf07:: with SMTP id l7mr1519763wmg.93.1598272279039;
        Mon, 24 Aug 2020 05:31:19 -0700 (PDT)
Received: from [192.168.0.16] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id x8sm20292007wrq.42.2020.08.24.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 05:31:18 -0700 (PDT)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion
 15 inches
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     adrien.crivelli@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com
References: <7210c752-0a1f-3985-91f0-b70facf0293c@gmail.com>
Message-ID: <30693624-744d-6971-1dc8-8ffe4df6082c@gmail.com>
Date:   Mon, 24 Aug 2020 13:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7210c752-0a1f-3985-91f0-b70facf0293c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My mistake -- I didn't read your changelog properly. Sorry!

On 24/08/2020 13:30, Alex Dewar wrote:
> There's a mistake in this. The ID numbers are the wrong way round.
>
> Alex

