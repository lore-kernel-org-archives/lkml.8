Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB89C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15882070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8LhJhjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgBRJbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:31:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52390 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:31:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so2015264wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1GbHA/keOvnRptSZJ6pvFppLAhKvfcqxR9KXptl2KxI=;
        b=T8LhJhjIQAbzufPjIBK8TQGYr8JhDvS3dUQls+djP7N+YkzZjaVIcKB2hN3ehPvIJW
         pbPOhaK2v+SPkH9Ljwr5RqSNNh2QV7DqTnB09WGoy+SiJ83lTX3TmMBeeM5UQpbaFl/6
         NQq7RtvKg4MjIdyyHbeRhEl/eeTNLmPkDHaO/1pAJTWBsUOU7dehQPg8BhIgYW99IyPx
         BLAu4J21I05uaxMeTb1aSHcsm5fK6b8vtMRgUg0/y6uwW/c973K1GqmjLbO10S3E18uQ
         FZP54ovNcrFCvy41i/0jDveqygwuchBQmcybtAUm9SXBymGgPRXchmWCSCaB0lkzPO4q
         KFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GbHA/keOvnRptSZJ6pvFppLAhKvfcqxR9KXptl2KxI=;
        b=rv6VF+sFx0M4eX5l/tuKKV0wWNHA62UL5ID6lPqbCinqKfrJc+7I06cIihxLBmdd/G
         HMIPSjj/05IeP3lDSY2+XURK4iQmxjlB0BlIRLfbArFwMhzUZvEmU5k8xL9PtiTNXPqc
         bLrlKPOHRFc/yLXfXpjWNiFh/8JIC33EZ5s0AVBKp9GgF7XA7TNKLOqtIlBPl6jua58w
         +0fPkuOUetNfmHc7c5VzZXjy5qRnbwb+HT+ySffBdvSbUD3xUOHXizM4WauBeTWu+ozx
         eKDqyYBjjbnXwaadj1JMzMM4eq9IH2Y193aF+7OD1vdIz6XorLGc9B4BtO6uuM1L7G46
         ESVA==
X-Gm-Message-State: APjAAAUUYP6ZSSFDnaw3P4r0CMzI9w+qkpqGzyF7oc8RDmkq2Xf92UF5
        ZU3ga8eO1gYKuqhkey+b3sp0Xg==
X-Google-Smtp-Source: APXvYqzYSKx+Li0fYXpczjgKmT5lAxvxuI3FiTv9YUX9ISzPv2vzu0g+4RlIjaVPxsKMfNzQe7t6SQ==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr2058482wmi.58.1582018266002;
        Tue, 18 Feb 2020 01:31:06 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d22sm2637983wmd.39.2020.02.18.01.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:31:05 -0800 (PST)
Subject: Re: [PATCH 2/6] nvmem: fix memory leak in error path
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200217195435.9309-1-brgl@bgdev.pl>
 <20200217195435.9309-3-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <207251aa-4f0d-18d4-d14f-ed6bc6fe0fed@linaro.org>
Date:   Tue, 18 Feb 2020 09:31:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200217195435.9309-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/2020 19:54, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We need to remove the ida mapping when returning from nvmem_register()
> with an error.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Applied thanks,
--srini
