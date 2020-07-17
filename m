Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F9CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BF820672
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diAUC9Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGQDkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgGQDkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:40:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:40:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so12846962wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FelX/7HXNPFyIXT6Lk3mvASXeBDyFVIi7PrhBnwdaxI=;
        b=diAUC9NlfhlkZCkPKkRyXhNaf1HWNRI/SCsR6GdDAx1WWIAr7Nhw5d6cqrXubwEAnL
         Jy4G4NXA1oNEySq0mUOU+OpXlFaiiHJavWca0jLJ4U8tv2ZioRH5dC4tNDgAjyK7NrpY
         Gxrgoj5HZcabqwIemTaKj6Ln1r2AU9/fh+/M0YaUDyE7AEaqpPyLvEHsNbKEr+KHzFUK
         Mr56WK5pd3aWA3r7i53g5Sa4rCrW+9NP7sR8H8o3Kz4WCxWHKm1lvJttx5pxB/UqXVnP
         7qlHpGTMnozZA+S6kYytYvqnXljnCZJOGrMU9rrKJK5uy6OCKHW6JkCeWpTD5WwBiYqZ
         MNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FelX/7HXNPFyIXT6Lk3mvASXeBDyFVIi7PrhBnwdaxI=;
        b=qN/Sop0YVNU44aANeupcjrZbvDFIDicdMDUi5cq4x0/yN9+rbvrF/2B7HccgTw1vTM
         WUxUu9F5HZqcAU34OYxRvWScc0h2xj/ORvl1e5ERch3W8F3khp1/kiZjb9aUau7rOMXA
         TbhmWj8rbFO3AHwfeTt6PERbSF3vp6wDtZv9LQK5MMO0triemhUXlbq0+qvZYSULW3r6
         q4lVhXzrvftTZ/CtpWSIzt8kng0rSBXT7gOhdkjg7Xqz2PpiUTz4LJfe5fSdg//A/SCP
         IY7NPwhdfiN3z5oorUWCmjJLppnLwr+nUVr2bUCx81NPUrZOKgeuxWFRe5Yd18A0moAi
         NP1w==
X-Gm-Message-State: AOAM530jKB4blMWbhtgC7JTvtwhOY7N8sa6wr6DzmPCOvWdCb4yeb/i6
        BZVrU5r5srMSVxKpMPnsEm1B/Nwx838=
X-Google-Smtp-Source: ABdhPJxjh3kf/BdM1R/+JlQs1gQaZCEE/m5JJJYBq9Vr2Ucc4AO5VtrOmvX+pFMOfkzGXCfPySIWUg==
X-Received: by 2002:a1c:b007:: with SMTP id z7mr6935448wme.37.1594957244492;
        Thu, 16 Jul 2020 20:40:44 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id a15sm13392507wrh.54.2020.07.16.20.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 20:40:43 -0700 (PDT)
Subject: Re: [PATCH] clocksource: nomadik-mtu: Handle 32kHz clock
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20200628220153.67011-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <08caf279-24f1-8995-3a79-bfe81116a498@linaro.org>
Date:   Fri, 17 Jul 2020 05:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200628220153.67011-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2020 00:01, Linus Walleij wrote:
> It happens on the U8420-sysclk Ux500 PRCMU firmware
> variant that the MTU clock is just 32768 Hz, and in this
> mode the minimum ticks is 5 rather than two.
> 
> I think this is simply so that there is enough time
> for the register write to propagate through the
> interconnect to the registers.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
