Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30BC2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E7206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUTO+Qx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgDLIju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:39:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:39:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so7168926wrd.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ydioquZgqLSixo2HGZzKcXImWHvCTw0YsXAUmkffXQ=;
        b=HUTO+Qx+Z0tSbrVKqd1NH9/8CJwkjJOYIxaDu1HlTYhcZncWsEM0aP/Vh3zuEGoqJy
         ExIyUty46K0Yb3UhYRyT9Xoxl75DK64ZIdtZ4oca9G6dLZrbJcTXlYcb76cCaAtfWEbp
         rI9lf60tOgAtDMLE4/K1htsk2SRq/Ii0ZYHXskL0qwmAsJvUM/bpwRj8X6jaUXS03UkJ
         aMbnHVDbgfMJsEyCBeBjh3d2AweuMui+/Bch+xf1I7cLycDEBn0glzpOM+vV3ESkSFRV
         w3i1JjTNBEONGyrSaBy/hXdQJQrJ7RrK6zjXyvhlVbtLGf0RbPEU67cgZ/kfNV/bqX13
         DboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ydioquZgqLSixo2HGZzKcXImWHvCTw0YsXAUmkffXQ=;
        b=VznN0vmnctWmREQAijUNDO2bMu8f5WYBljK7Kjn8VLaG7h4T7k3NPAR3axgAEiCtme
         vBkJ1A/vkSS5KVmXAhaf/K3hoHGprv96AaSfENyCwn+Jz+zY4lSQb15rijC1yP+6eFos
         8iZiQIKAGdPcclwysSGmi3XZbyXsy60UqMlzMvpqXN9AD6SvpSFk4sFUSR6I8bu8Wp6X
         erETRDuIqSMgPEww7bOWOvhcFYANgdSMtlwgg8Xbi9V23Pq4m2Ek3BKeGS14DVeYvj8g
         Hd7HFRDa8oUjOJ6RNprdGK7fOsQQIUyiEf6uS1jz+8+IFkzK8LV4l2s0sEGhrOUEATi1
         /9Sg==
X-Gm-Message-State: AGi0Pua7uYf4/W63ZxTJdahMtnsJNAejv/VlbGUg/LIfUHRVXzvCVe5W
        q5OuGNLKRi8BYAXBdl+dgBQWsJ4I+rA=
X-Google-Smtp-Source: APiQypJoZQU2qKjrNS9LUnKMGyhn3HCZq9g+cbw5ltOT5bSCdNAyA4Llpbaa+RN6tpZqI9bHl8ykXQ==
X-Received: by 2002:a5d:4cc7:: with SMTP id c7mr12730820wrt.375.1586680786499;
        Sun, 12 Apr 2020 01:39:46 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id t67sm10373203wmg.40.2020.04.12.01.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 01:39:45 -0700 (PDT)
Subject: Re: [PATCH V2 1/9] thermal: Move default governor config option to
 the internal header
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     amit.kucheria@verdurent.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
 <271484966db322cb052b59833a4babcfb8488d95.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <86c25a5a-f339-a6f1-fb5a-568c7f158125@linaro.org>
Date:   Sun, 12 Apr 2020 10:39:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <271484966db322cb052b59833a4babcfb8488d95.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2020 10:35, Zhang Rui wrote:
> Hi, Daniel,
> 
> please feel free to add my Acked-by for the whole patch set.

Great, thanks!



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
