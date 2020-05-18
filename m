Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5505120671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ng7kf9oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgERNQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:16:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36624 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgERNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:16:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589807817; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uINdg6B01buhlCAC3xos5oZKi+SLgZfqfWsmUT0tazg=; b=Ng7kf9oZte0eA/CUaqkdzJF8uMtnv8gEw81on7UAI4UdrTeQ98ZGzlm2NKJhUTJG29fIlK+V
 4OTI8mRiCY3nNNe6wy4P6OGqXBw5gEklsWgfT/tkP9UEmhdrXIPCkmjn3JU/AaVIE89ylxm1
 Ou06mqYIW79IXa5dQATjwO3B6B0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ec28ac15d62762fd417f24b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 May 2020 13:16:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C430FC43637; Mon, 18 May 2020 13:16:48 +0000 (UTC)
Received: from [192.168.0.11] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 420FBC433F2;
        Mon, 18 May 2020 13:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 420FBC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V6 0/3] Convert QUP bindings to YAML and add ICC, pin swap
 doc
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org, mka@chromium.org
References: <1588863647-17240-1-git-send-email-akashast@codeaurora.org>
 <158942181222.215346.11981864062704009851@swboyd.mtv.corp.google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <3b28ae06-3e4c-56dc-53d4-46515dfcbf7a@codeaurora.org>
Date:   Mon, 18 May 2020 18:46:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <158942181222.215346.11981864062704009851@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 5/14/2020 7:33 AM, Stephen Boyd wrote:
> Quoting Akash Asthana (2020-05-07 08:00:44)
>> Changes in V6:
>>   - As per Rob's suggestion moved pin swap documentation from QUP to
>>     serial.yaml file[PATCH V6 3/3].
>>
>> Changes in V4:
>>   - Add interconnect binding patch.
>>   - Add UART pin swap binding patch.
>>
>> Akash Asthana (3):
>>    dt-bindings: geni-se: Convert QUP geni-se bindings to YAML
>>    dt-bindings: geni-se: Add interconnect binding for GENI QUP
>>    dt-bindings: serial: Add binding for UART pin swap
>>
> Who do you intend to pick up these patches? Rob or Greg? I suppose if
> it's all in bindings then maybe Rob can pick them up.

I intended Rob to pick these patches but Greg is maintainer of 
serial.yaml file so I send patches to him as well, I thought I would be 
needing ack from him.

But from your reply it's clear that I should be sending to Rob only.

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

