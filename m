Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1247C20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSDSnc+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408218AbgDOI6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408198AbgDOI55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:57:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FCC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:57:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h26so6737846wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5Am7t3fQtXB7+UGkMARmYYRwQ6nurFzvBqolqTPwJoU=;
        b=dSDSnc+F/fN0cdKLJf/+kR9r8g0CPgBhHy5/dGeDnEKUPjDVeBmitlUtvpovYN8AeT
         17gXZ7c2H9RjKlNBlg4eM1P2BvZ4qjDRq1e4ro41DFBaHH8e32Laf/tooFpPdmTj0b8C
         9g6W3e5ErY0yJ03tl8nckyB2t38jOGNf4sMtgyAq+860/6U+gW7FMZ0Iw7LEOICvCkrY
         nYc7jl1msAM8lOxB6HcsppghnVjStqQ8YAxSEvCq/ioO0xFN+tOSrGIFnCWtkEWZ6DxP
         YU4AnpjvleboFVCypRNZf/4+STEVaFAvXDTBXyetTQQTClK8JytP8xfmxHb/gbAnc5Qu
         hp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Am7t3fQtXB7+UGkMARmYYRwQ6nurFzvBqolqTPwJoU=;
        b=rEckDU2SOXRn1e0kxP4rwI2jepAcG+1ySHRuk3g+oSKJwzrWow/dFMud3QzgM9mlp8
         gf0c7C4JxdYfkHdL5eb+L8nfGOOhA40Z4vHIEffW6lgtgNG7+RTQzZ1+nTU6yzDwN1bz
         MZaJ4ggPXymc418Y6hnwFPlnox4zs1N6MdBwYtsjws+Wla2zURH8mL46uoHkSS3MTvp+
         srHt27G6Z1vhKpnnEzWAWSkUsQ+OUvc88P4x+lQySY8RMYSAdhvKXfa1Pn73PEfKWqi2
         kBXsFwAywcqo7Ze0D9ICS1MKbEXIjb/mCw8kUPRu2zIRCACeMgV3AHrSqBWCrPGcUSVB
         ebfg==
X-Gm-Message-State: AGi0Puby7S4TSNRleQsnTXWy/g3HmObuLNytf6Py2kn+r8w0ZaxQV8SZ
        iVBk+p9CEHKiZJDrNJv8JKs4ZSRXN8g=
X-Google-Smtp-Source: APiQypL1/voYE4ae3tvbe+pTrP5MKfMNWZDplh7HA3hUnSh7oqZK7SVyH8Fnmg2b3wzZhpnjhLW4UQ==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr13579334wrn.56.1586941075360;
        Wed, 15 Apr 2020 01:57:55 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id 17sm18812097wmo.2.2020.04.15.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:57:54 -0700 (PDT)
Subject: Re: [PATCH] clocksource: atmel-st: remove useless 'status'
To:     Jason Yan <yanaijie@huawei.com>, tglx@linutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200414120238.35704-1-yanaijie@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <634a96af-7078-9e77-45ef-610f9beedd4c@linaro.org>
Date:   Wed, 15 Apr 2020 10:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414120238.35704-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 14:02, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/clocksource/timer-atmel-st.c:142:6-12: Unneeded variable:
> "status". Return "0" on line 166
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
