Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D1820738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyte3u/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGEtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGEtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:49:02 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EA0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:49:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a1so45235095ejg.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/8/+PPIkVJHXbPNoKMfF2APRs4xG6XCaEICbOpAq8uY=;
        b=jyte3u/WiKXVb/qWVaBWSj4lPsybrEEyN4xNFLQ3WcXdERWhBirIsjymTugifjqhOy
         NOmiOK44Vas/v5hm6fMi65oOqw7TvAKfuqNIS8NWW0gpVdxZ9eLhuVW8TbnGOANUj/wf
         xW8VJiw+d/8hzaVb0K2oRcBNck5b/XYyHapgVYe3IW2jEiY2VXzJDcTheyh1FgQeC5dO
         qpy2lK5jZvkI19cTWBsKsbnGiDIajkH9A1nI6DM7sS0VjZLXx8s4v4rjRWm4GdeYf8mT
         WybesKJkpzukdVNSomFY3H7bmkCqmHk12ITD6Ho74/oxg53z7Z1ZQaa3KA5mWjr3ednH
         6Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/8/+PPIkVJHXbPNoKMfF2APRs4xG6XCaEICbOpAq8uY=;
        b=jKBwiTEIzgue3WZy9h5l1ye2c5jl+xMBbsokZLzaxqUIwPph1pkg2lYBAAC6TUkWWe
         CQ5buv1A8Bvzqh1SMbGtyxmLSvxuPgFBkVFujFO8Kn9D00DGUjFrSvDtDXbwJj6yM1wh
         oz9A7uAa2QYe0s4uQe/8ZC+B8YKS+DG4WjmatdLun9HDICtfTF5+xVMUprGD6IgHaHPY
         4VJCA5NzZOno0E4f31K72mm+tCiCAtSSs7Q4TChoeiFFeHZeWAVbK2DWDmb2sPrngGS1
         XJsEzy+coB5f5OgtTCLStlt3N8rSH5sBf0F5aePLOa5xvW0eW7j5NgWcEj326e0YRena
         uGGw==
X-Gm-Message-State: AOAM531NMpM8QStSAWmQpzlXAa0QmgXzkij7cl/KXutNf0V/Iq5JLNs4
        HZP0ykhtUVT5a1EBS3vjfPg=
X-Google-Smtp-Source: ABdhPJwQu2BtKRVlCtasv4IraymixSP0MLPp6+XHDgYxwyGqCMV9T6ProPGDsrib3g8jFHbDktHT0g==
X-Received: by 2002:a17:906:a1cc:: with SMTP id bx12mr44306356ejb.461.1594097340197;
        Mon, 06 Jul 2020 21:49:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id b4sm24079853edx.96.2020.07.06.21.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 21:48:59 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] bcm2835-dt-next-2020-07-06
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200706171140.13514-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <40dd8652-8fe0-4db2-d8f8-782516d96884@gmail.com>
Date:   Mon, 6 Jul 2020 21:48:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706171140.13514-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2020 10:11 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-07-06
> 
> for you to fetch changes up to 25c6f3960764b266a609281341f889a06d045039:
> 
>   ARM: dts: bcm2711: Add HDMI DVP (2020-07-06 18:52:01 +0200)
> 
> ----------------------------------------------------------------
> Maxime Ripard introduces two new clock providers into RPi4's device-tree:
> 
> - The first one based on the enhancements made to clk-raspberrypi, which
>   is now registered trough DT and provides control over the whole range
>   of firmware based clocks.
> 
> - The second one based on the new clk-bcm2711-dvp driver, which gates
>   the clocks and reset signals that feed into RPi4's HDMI0/1 blocks.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Nicolas.
-- 
Florian
