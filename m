Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC830C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 00:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F89C22464
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 00:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq+8kIqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBHA2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 19:28:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36170 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBHA2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 19:28:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so924305wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=soWAD8UNijAJb7SHutHwxxBAWeNh89k1vOpxcKcfupY=;
        b=Rq+8kIqJ3e0cTG7areebQpeL5NmWDETx87Z+Q1RTs2pwBS4e/iV+ReWWbbHTpVeu21
         WMZ2Wa/qaTVJjkCRtipWIGitiWe2oOoMBC/KOTmy+Q/SyHJifvj+Ha6QylV0/rdL+blZ
         0eSV4GNC0CRK0KSmfg5R7a4YqXnHBbAl3uTP4DJhsmp0o0NH/SJ5GaBav64HSV4+jvzs
         BOXXS/o+/sDYGH27Jd4xZzTz5Sni46L0o/CDmLhRU1PsfPA2iGOvrowtImgQxuACpsav
         sMIzLkn9ba+aBiF5ZnRKDVb1+3Wvc7mVYU1P/Rr6ncewadY1QNMyGKHvnivi5mr5B4MB
         BnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=soWAD8UNijAJb7SHutHwxxBAWeNh89k1vOpxcKcfupY=;
        b=bgNewsPF4dk8dr9QbjGSbW+J33xNKHdkjSVAeu4u+m7oz2FEWoGdEaL2gn3uxRZkeW
         K8+M+PtIvSYIA/UxMHvAI6kUUItEX9b144gIB7sReSK8x0I7/eFQrUzgwMVS3EtOiz6x
         GPVncNl6lFQF/OkDqLglynSDQVUBa8xbQBVoAO4aswuIOl6W5vWQ4PFWJcucGgvtcN58
         bvyBHSqLc2mHv7/4dD0s6hA5PCgfClxTlrVqRLrikfZhDM+85DEyxmcfAilNHYJFZ+ib
         o/nyDAN4qrR04+hl7r9Kc69VpNEoasF1vmZ/4x6M+rl7azl/VVm4sOTFGE3uMEmx73wk
         WRJQ==
X-Gm-Message-State: APjAAAUkuYUkk0WxcEwgX7aFQWXfI6q5/EqVDT9tpB802nWSgCl1ELUD
        5omcOVuN3eHlsaPNjRrpU58BwtHRJcQ=
X-Google-Smtp-Source: APXvYqwpCvKOJ+uTpFQDfPG7Et4tMAqIsOquaCQjzGt7yEWxxkI5+rj4ldwoYGEx1NnuOzKik7RqTQ==
X-Received: by 2002:adf:ab14:: with SMTP id q20mr1592820wrc.274.1581121710957;
        Fri, 07 Feb 2020 16:28:30 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h17sm5668150wrs.18.2020.02.07.16.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 16:28:29 -0800 (PST)
Subject: Re: [PATCH v5 11/18] usb: dwc3: Add support for a role-switch
 notifier
To:     Jack Pham <jackp@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
 <20200207201654.641525-12-bryan.odonoghue@linaro.org>
 <20200208001520.GB18464@jackp-linux.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <9e653a9a-2fc4-645c-ac33-d9826a7ecbd9@linaro.org>
Date:   Sat, 8 Feb 2020 00:28:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200208001520.GB18464@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2020 00:15, Jack Pham wrote:
> Hi Bryan,
> 
> On Fri, Feb 07, 2020 at 08:16:47PM +0000, Bryan O'Donoghue wrote:
>> Role-switching is a 1:1 mapping between a producer and a consumer. For DWC3
>> we have some vendor specific wrappers, notably the qcom wrapper that want
>> to toggle some PHY related bits on a USB role switch.
>>
>> This patch adds a role-switch notifier to the dwc3 drd code. When the USB
>> role-switch set() routine runs, the notifier will fire passing the notified
>> mode to the consumer, thus allowing vendor specific fix-ups to toggle from
>> the role-switching events.
> 
> Neat! This could work. But let's see if Felipe likes this approach.
> 
> If you need, here's a
> 
> Reviewed-by: Jack Pham <jackp@codeaurora.org>

Appreciated
