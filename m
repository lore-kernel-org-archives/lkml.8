Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E02204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yss1B0Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHGSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:19:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B038C061756;
        Fri,  7 Aug 2020 11:19:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g8so2503349wmk.3;
        Fri, 07 Aug 2020 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8hPWlVFgiyQk9Of5X8xf3fgFy4+y+jNTowUJ5Z3elPg=;
        b=Yss1B0PxrifQKUYToKjMYuo8OQyR5O80ydGP63oKyZklTmNPMRYUqrFTRzvxZOcUwl
         Yjv5EJ8rySKIx9Bzrt949RsXASJXqR1hgMzbmqm9Y/LvsidHsqe3Nwl9oSd7rqht5iE4
         EmQZT0en+eW8AjlY3zC4vnFwtJ7tDRaS8doi9LZ21JXnsGTP1JsCR2fD9RnTNm+BBRsw
         vSh79Zi3TXt/94tX4rjaV8eMpZMMY1AVb9mHVqbFjEQziT/96Hc48BSig3XGKE0QIHGd
         6QGCJUCCbZWP/M8bXnFUfJFJW0s6Cc56lcXdmX40aaAoF5e7vL2cMAQqCZwhhPzBPPdI
         WOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8hPWlVFgiyQk9Of5X8xf3fgFy4+y+jNTowUJ5Z3elPg=;
        b=U62r4I0aT04VSAbNLe1rwLVcovyhyTnCaA9cmrRsKk17jqQjoLskebbtDbXwWMJwMg
         UFQlY2S0Mes02N/nQtqnwbcEV+wO8H9QM8/FTV/DlHMw/kwLbY99Ud5HxJWtNtJScW3X
         crSJ/s/UvNBNusn52SUMFMVWaSnCGp74f9jJ4H2hB4grseVsNVv5zaHk8SriWUVlqfkQ
         MU/1CNmevb0x4AHPI8CpcNrBYTfuuAIZ70htU+2WBEiMO5z/wvnSxmkFm9M9uKgrDb+4
         zJeBz+I6GzBsI8OcswffmCGEkGbhY4jw6qBxQlmHUybwNZXM4C+fCxkvVb1tkbSwMYra
         4ANQ==
X-Gm-Message-State: AOAM531viYwqbpgX/AQ/xlJ0U4ZWe6nHchIkKxZ3ojmnbM/uBbRBB6iL
        saXvf3VTESxTnAQ0TGjtT2C0V19K
X-Google-Smtp-Source: ABdhPJwjxH7eglD2VfO3ebydghJ3c8EtTGGj1V8I7HrLHqscHglP6YHVFSzqPne33qP6/A7cKiwwFw==
X-Received: by 2002:a1c:b188:: with SMTP id a130mr13135170wmf.125.1596824380300;
        Fri, 07 Aug 2020 11:19:40 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f15sm11759840wrt.80.2020.08.07.11.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 11:19:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] MIPS: BCM63xx: remove duplicated new lines
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        tsbogend@alpha.franken.de, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200807100411.2904279-1-noltari@gmail.com>
 <20200807100411.2904279-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b41f438e-5c33-a7df-2bd3-d0e003009ac6@gmail.com>
Date:   Fri, 7 Aug 2020 11:19:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807100411.2904279-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2020 3:04 AM, Álvaro Fernández Rojas wrote:
> There are 3 duplicated new lines, let's remove them.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
