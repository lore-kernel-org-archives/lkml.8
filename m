Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677B920754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXjlKsP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgCQPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:22:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42595 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgCQPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:22:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id b21so16636248edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FN6nZxGnOaw3deJgrYU1nB+eySU41aqfgMOvG0B3T1g=;
        b=CXjlKsP5/eG3tZJGw8EPbB69nbC3nO4ZZQfYtvvX5o2sdeR2vVbOAPJd8ufv4NCETI
         02I170hMx6kVh1sjzn69urnNbgExvQeSlkitbDxdyl/uvNwpdojqNN32J5e8ycULPU4L
         s1HVoS9+wzcMbmrKjBXEtZ2cHoqkq7dRot6Mf/ehXoxd28r12XO9VcMG2gMJCDc5tw1h
         gBLJlU/Ptq2it9/Xlo5utCg0XqxXmvkPr+n+vcJg1ARiA9tCg2Mex3p5UBXkQb8pCrgt
         BLAzadrLVthZNCuciVdMd848fwy0bpmh3KryGSNikiM31ny7IGOyUM1ebjPETz6xnQ9d
         IK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FN6nZxGnOaw3deJgrYU1nB+eySU41aqfgMOvG0B3T1g=;
        b=Tkq/Sx0sQixNvFx1yP/YEdon7iYxG3FFJhG5bWl7VdENQ/UN/cOwA8zYhBvkCYCwRS
         l8W4nF2bZ/3g2VAZp7hFJt9hIlX6xx7MOgwiWgcgWiPuyL0h6LUW/i0OXe1XmFakdIiu
         xzWtTfpZRd2IEWNIOmJejdO3wuC77J6dmLzFrduv7p0ScFnBwX1bSGKGraznoxySj726
         A5eNhn+TqRYQqifRtQ+Im3ZVDp/vgRmz58WGuaQJ0IOHMV++tR75uRwolJKsQfeYcqm0
         peC9bhkiGyh7n3rVixFnBoAYCkZQamQVTkOKVJrAZ61HrlQ1fP/6OPL01ZGiSHxU/1RX
         qSSA==
X-Gm-Message-State: ANhLgQ3McobpwWAmvWtwNycIaz11bTTqvZcvg9FN8/rLtpGdJfJKJert
        bDWB/a8zNkL3Mc5WMXiA4FNJXA==
X-Google-Smtp-Source: ADFU+vsI46bucXrS6vRC98i/tyZ5FW2KRCRZlYWtRXZUfYzkhSt7l9XxjzONQxNkkNmWOvcZUFuTfA==
X-Received: by 2002:a05:6402:180e:: with SMTP id g14mr6060137edy.66.1584458524977;
        Tue, 17 Mar 2020 08:22:04 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id bc23sm227198edb.31.2020.03.17.08.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:22:04 -0700 (PDT)
Subject: Re: [PATCH 7/7] usb: dwc3: qcom: Enable gpio-usb-conn based
 role-switching
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jackp@codeaurora.org,
        robh@kernel.org, Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
 <20200311191501.8165-8-bryan.odonoghue@linaro.org>
 <20200317063101.GA2778164@ripper>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <ec573486-155d-c6f9-7645-496e85721a69@linaro.org>
Date:   Tue, 17 Mar 2020 15:22:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317063101.GA2778164@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2020 06:31, Bjorn Andersson wrote:
> I don't yet have a sane suggestion on how to redesign the dependency
> between the two drivers in order to avoid this, but it's at least not
> possible to access the child's state data from dwc3_qcom_probe().

yep, this should be modeled as the dwc3 registering with the parent 
role-switch, like gpio-usb-conn does with dwc3.

I have an idea for a patch, I'll v2 this.
