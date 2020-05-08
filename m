Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51675C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F82821974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE1VBkoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEHWvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:51:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECC3C061A0C;
        Fri,  8 May 2020 15:51:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so3745724wrt.9;
        Fri, 08 May 2020 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VpkDJVKHc4loBr0cVw/TtfglstgI7gfYGDWl/w66BUo=;
        b=PE1VBkohD1DlkpHC3uc6rKJlZk6pHjn6N2MABAvUqGwn+f0/jiu65UsggR+dKj1Icd
         mddJ1h2OkMNJ0keht5buwInUJWW0U+Z0U6+EDL9Cx2EdmMZ1a51dBVnrBtCVY6sI2/wh
         ei8WWOjOAWMBvT6fy79UxqnJJIOI+qRHTnMWjOvqW0Tcz6CgUOv+jAckrGAyFdnzCDGq
         rExFUaTBUjsMHai37q8N6zwh6BnwPjvtl6wEI9CuvY2zsXIx6Dx9G0Rt/Yxzxqlbo4U5
         Aevnvd2KJ6xiiYY0+zFbNWc7EMRdNIpkK5tjxBuivAjseU3uRwL/zz77f4XQHcy4dPeY
         CB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VpkDJVKHc4loBr0cVw/TtfglstgI7gfYGDWl/w66BUo=;
        b=WvG4iAvm2fYlGa/PF2afZZSm4M6HDCS0f34xqBsY0YaF0wRLplUpMovhXu2BRoWTJS
         446hd/3m+sW+WXlqj2pLWvRVZ1P2CPOuj+IlXMXacMNq3LSl0CshTvkLMa693HS9TWjH
         abrYWqJjp3SjcIb4B9rz2R+UjRPXVkazWolIuY46aq9+KMB5mpu3B609xQNXG3b/JeFn
         gliXpZu86iItaOJxvCjIlpp1H514K0Umz1FMthSd916N/i3i+FusVw62SiDr68vRMVuN
         skJfulJB40Pat6qL91CAImUQe1X780j9u2vQG9gX9sV5fClcUJK5VYyp6WoBa26qtWZH
         6NBA==
X-Gm-Message-State: AGi0Pua1cx1u5NIH2yETfuiD53LyVdBCCbX8HEws8UELSmQSM9s2vq0r
        0ytGK3EUHuOkzKJtJjlWlOMWmIOW
X-Google-Smtp-Source: APiQypJkF91dMnVQXhwsrjBKxSv2sIkp7E58Chi1nPuHpkwWtH+OyRnsVIYk/dKSJdslnAQX8oSytA==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr5209629wrn.82.1588978299377;
        Fri, 08 May 2020 15:51:39 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v131sm15777404wmb.19.2020.05.08.15.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 15:51:38 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] usb: xhci: xhci-plat: Add support for Broadcom STB
 SoC's
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
 <20200508211929.39020-4-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <de5242bb-77c0-cc0e-bd95-f83106fb2973@gmail.com>
Date:   Fri, 8 May 2020 15:51:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508211929.39020-4-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2020 2:19 PM, Al Cooper wrote:
> Add support for Broadcom STB SoC's to the xhci platform driver
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
