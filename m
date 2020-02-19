Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D76C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D29D2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flBkeap4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBSLAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:00:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39333 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:00:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so105935wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7H/YCOn3cZ80p3ZvLfOobGUP/Cj28W0PDaZeNMELPIA=;
        b=flBkeap4OICGKzUAhwUnG6FiQB1q04IFsUXbjyFENB6EOm/Xqe55BJaBUvuTORHncc
         VswpQuiR/4l08ix5jb3w4/Uc6QoG2O8dGaIxzVt9wP0x4G2FSLCPEG/W3o8OLIrFBx/P
         IeqCZROJl3ptNO+i5+n5ziOvzba7tfCtGjz2cSyKsJ8dleFnYwzueCCsrCyPVTTstVH9
         sjTB6latKBzHDv69IKj7VJeH78iqDtGrVIuGaml5dsEsuV4zNP8fFGHmdzUYTdgVgb8W
         0ohMfKENUy7UNze1SiVkhESR2guCb527zd0ZJXxUVVx9MMqgev2XtDc3g0rB8O9igPlT
         GzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7H/YCOn3cZ80p3ZvLfOobGUP/Cj28W0PDaZeNMELPIA=;
        b=WrGPKYOmEFkFkLTO+V+nIFq/3revqMuy8C5uL3PwQCC4/1dSgbByBYcVyiHGyp5yTG
         f6cn89kC87NCaiAEmmqSKke79GGKAZ9wXSs8F5L13jSMwXwI6IxTNUivzZKTS8mgU1VI
         iE2AGBp3SS32vZI85PX3lFKS5EPRQ28sw15B68poil6AylDuH0txxfHJIYuJGzLbfqs7
         tOesYUWI+PM+HyM2fUIzPf+Q3oLHHLuz1WgVy3YhRwGvrO5lwEuZ+pwZdd/sNYcGA8lb
         sHIgWfYqXcobt3bSY0znnwDa3t/BR247FHiHn3Hn4stEh+y5R9rvPhj5c++AR5BymL86
         CCyA==
X-Gm-Message-State: APjAAAUxShHOI95h43rPUmkx1j6w7DjyKaw113xBUSoGqUC+xZxsTxI+
        ny37l7T7qbLIstNm3Bjzo49AdXI19Zg=
X-Google-Smtp-Source: APXvYqzf/HQlKxt/BTpiD44E/5sNAO7qxk3LcGuhwkPntczUGlNzz4XgXLBh2d4dsCaVgvNHY0KA4g==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr9243214wmj.43.1582110018880;
        Wed, 19 Feb 2020 03:00:18 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t1sm2603782wma.43.2020.02.19.03.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 03:00:18 -0800 (PST)
Subject: Re: [PATCH v3 0/7] nvmem/gpio: fix resource management
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200219092218.18143-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4a36c93a-704a-832b-0f66-dd17fe304da6@linaro.org>
Date:   Wed, 19 Feb 2020 11:00:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200219092218.18143-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2020 09:22, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 

Can you please rebase your patches on top of

https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/log/?h=for-next


--srini
