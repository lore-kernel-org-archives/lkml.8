Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E907C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F43E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMvwM94I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBGKum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:50:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40216 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgBGKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:50:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so2084539wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3siQdVwUR2AQJspUWLBveOF5d5gEtnXKp3bye6ABQ0=;
        b=NMvwM94IBWfiDjGgUZiNve+xmIFm23S+iTOyrmyZM9GuK6WJKYkzqVTZJ7+iQZ2X7D
         OGtNV09th4X3ZMgbmqTATg10cOtTsMEWpetXpUYb7Un0PDB2tNTuqDQnScsZa7s0r1B3
         QQTfMIJmn/RizMM77L/r2T/NYEzO9Je5nsOy/gHqmYoNQ0lzYKJKD1iIeDlvZ4IQIm2t
         wP76v1J7+wMS9t9Y1SWnJdb/cABuV21q+UBcwjCWKzoNwTDsGLoJwKQPV6wbK+w7CYKK
         FLW7l9Cuu8NWv613/cmq0CdBqzxphpbfMUICsxEnY9aOiYhCNA6MSewcADdE8FlnfxXz
         nrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3siQdVwUR2AQJspUWLBveOF5d5gEtnXKp3bye6ABQ0=;
        b=Ol1U/1puTER8XC4jFrESEvndsifAjJsi/qK4sFVK4b56KES7x8aEpLfnj5WfgIF0hq
         hQvqNOp33BsGS91HRHJKoAbIDzw5PqPfI5s81o33bkcyFSX+HLKtBUtzAAGtVAFMAn9+
         ohLYdgR/8PPXTdIOo0L4WwBy1VVcbWluy/9ekhIY/4N8XqZ5M4HbNQpJyJERMz0EqEUZ
         lNUHKQta73BVihkPrA9YUaKFvl9ZhMWjU+ReshItmuMhfJduWqNVRGMQOqrCvLZOtlVd
         +zNqajI/3CckZXA3ZIai/sc6P3MwzmiF3epxjaIq2nRI1RunRLlMzrC8fvrtDkiyykjl
         wimw==
X-Gm-Message-State: APjAAAXWKBPQ4visL4yt3o8hQK+QGG10M196fMpopGjvDDn2Fp3MZgxJ
        V1XObqdpGfEMDi33qWzcwSXQuK1JM10=
X-Google-Smtp-Source: APXvYqz2kV1/VNj2vtLrqOvcxHp2oruPVYMQmZgXomeA4NxtqVu+akd5vZjo2btRinJtOKthW1IARg==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr4305931wrn.152.1581072640457;
        Fri, 07 Feb 2020 02:50:40 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id y185sm3050539wmg.2.2020.02.07.02.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 02:50:39 -0800 (PST)
Subject: Re: [PATCH v4 09/18] usb: dwc3: qcom: Override VBUS when using
 gpio_usb_connector
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
 <20200207015907.242991-10-bryan.odonoghue@linaro.org>
 <20200207080729.GA30341@jackp-linux.qualcomm.com>
 <2bd67925-14cf-5851-14a2-c51a065fac6c@linaro.org>
Message-ID: <453bfea7-4085-1a24-84ad-30c7671665e7@linaro.org>
Date:   Fri, 7 Feb 2020 10:50:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2bd67925-14cf-5851-14a2-c51a065fac6c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 10:36, Bryan O'Donoghue wrote:
> On 07/02/2020 08:07, Jack Pham wrote:
>> Could the usb_role_switch class somehow be enhanced to support chaining
>> multiple "consumers" to support this case? Such that when the gpio-b
>> driver calls set_role() it could get handled both by drd.c and
>> dwc3-qcom.c?
> 
> It is probably necessary eventually, but, per my reading of the 
> documents and working with the hardware, I couldn't justify the 
> additional work.
> 
> However if you think this patchset needs the toggle, I can look into 
> getting the indicator to toggle here too.
> 
> We'd need to add some sort of linked list of notifiers to the role 
> switching logic and toggle them in order.
> 
> Similar to what is done in extcon now for the various notifer hooks.

Maybe I'm wrong...

Looking a bit closer at the role-switch code it might be possible to 
register multiple devices _as-is_ so long as you have a pointer to the 
relevant parent...

---
bod

