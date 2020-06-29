Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE09C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2283206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N58gW58i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgF2TIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgF2THn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A934C00E3FC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:19:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so14418236wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BWB95FXlnWSWC7pmv6iNCOZmz4YpgGsIhyG2MjJbpo4=;
        b=N58gW58idePYUeGL1drtPtk1W+iqzF24SWCw2HBLAV0vp3qEuHkZW2dI/4ssxsgyre
         XhAlPO1jp2eEvhOD9QYPTKxs9mPdUcxOMQq/W5Ooy2mc3XBGsAC41oGpQq8+T6CnCxbA
         vkGQ3CRVkU6lJSFGwBdggPw0a1ag6LWmNwh/umdnv/G0LSbWWTCohGmlBcNHDS01jF1I
         Msp3cIpwCA27zcn/0Z9nPbZQsy5wiSzmGJSGK7hBDgl/iNP1on9n3h5LT3USl4Y6YZcO
         fzmt+JXbP+CgWRe+LEpEbT26gEEaBXVexzbh4EWcF3YLe7pOd9S52sP3K3bS4CjME0et
         PoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWB95FXlnWSWC7pmv6iNCOZmz4YpgGsIhyG2MjJbpo4=;
        b=q/WinCHJ1bkqaoK69Sb9qZVDq6So6jO1NnKQk+3qC3txNi6q12/6zNhxiZw3mf0lXW
         k+E2SuRnqdOuXU1KdzCY6kFBU5fk9yHz0S4c3ZLUTXA6+N1UsVk9Ylof6oAjLScxtNYn
         nHaWmntX/Lr6yVONVkG22LO4EsQAt5HAhp5KM4xdlTwIeyLukuQRBYWZt3Jh6l6VABD+
         UPBFZK1nSxW1RawXLkMbBl8c0YAqlT10HzKLk+9Z0hmS/iPrFRh1AVIpGVZqO6I7q7H4
         +IGp8qNNKGiaqiCrsdIoqTkj5nQeNMScvwmRkq/9KX22brKYF/kB26z/t/wAP1cODKea
         Ee8w==
X-Gm-Message-State: AOAM530KJM5ahB65KP7m/QmMXp1cmXRyptk1esfyZAWdzRM1rGTWrESf
        ycPvOOYv/ubdMfprVnt2ov6JidDm
X-Google-Smtp-Source: ABdhPJxsJ/a8uRcZMmS5qF2+741IxPP19IPww3Tkszrt9a6qnKY1QTB+KhKgqwkCkqeaasFsid3Mnw==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr17358596wmb.144.1593433170908;
        Mon, 29 Jun 2020 05:19:30 -0700 (PDT)
Received: from [192.168.178.22] (dslb-178-011-230-168.178.011.pools.vodafone-ip.de. [178.11.230.168])
        by smtp.gmail.com with ESMTPSA id p8sm12250146wrq.29.2020.06.29.05.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 05:19:30 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: include: ieee80211.h: fixed multiple
 blank line coding style issues.
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200629080927.ivzvczusduxtrc2g@pesu-pes-edu>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <e3b9a1f7-b0ad-1815-df0f-733203d09602@gmail.com>
Date:   Mon, 29 Jun 2020 14:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629080927.ivzvczusduxtrc2g@pesu-pes-edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-06-29 10:09, B K Karthik wrote:
> removed multiple blank lines to improve code readability.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>   drivers/staging/rtl8188eu/include/ieee80211.h | 9 ---------
>   1 file changed, 9 deletions(-)

Hi, those lines are already removed in

commit 5bfb7eadc5874a3a08dd173d66a16a1ed0548444 ("staging: rtl8188eu: remove blank lines in header files")

regards,
Michael
