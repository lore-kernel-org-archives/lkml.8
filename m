Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE312072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n95v2Wx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgFHJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:40:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:39011 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729214AbgFHJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:40:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591609226; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=H5MuWLiGAPcb/as9k1D9LJqte98VlPM02vFdUe95LKc=; b=n95v2Wx3nrwE8KQIMZVcY2RwGSzDVlmSrcrUc7REWDf0CElxTfzXzBxijiWo/yPABZh0NH9z
 rRQbdbC1hwP5WtTlW/l/Bfk2Qgtd7MbczjLtTlNTi+ATS329LpRiYXJEDnySbuuIPogb5CVh
 Iq/NDgwZMDOn+XE7gDoa7DLDABo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ede0774754b69016466190a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 09:40:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9057AC43387; Mon,  8 Jun 2020 09:40:04 +0000 (UTC)
Received: from [192.168.0.105] (unknown [183.83.153.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFB87C433CA;
        Mon,  8 Jun 2020 09:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFB87C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V2 3/3] mailbox: qcom: Add ipq6018 apcs compatible
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1591441171-20341-1-git-send-email-sivaprak@codeaurora.org>
 <1591441171-20341-4-git-send-email-sivaprak@codeaurora.org>
 <CABb+yY2HhHSbP7UX_r1bGgpxzQKfC9aS8r9nxX5AOt8ENG5ACQ@mail.gmail.com>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <0ee184f4-bc8d-09f5-d756-c87498e64777@codeaurora.org>
Date:   Mon, 8 Jun 2020 15:09:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABb+yY2HhHSbP7UX_r1bGgpxzQKfC9aS8r9nxX5AOt8ENG5ACQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On 6/8/2020 2:15 AM, Jassi Brar wrote:
> On Sat, Jun 6, 2020 at 5:59 AM Sivaprakash Murugesan
> <sivaprak@codeaurora.org> wrote:
>> The Qualcomm ipq6018 has apcs block, add compatible for the same.
>> Also, the apcs provides a clock controller functionality similar
>> to msm8916 but the clock driver is different.
>>
>> Create a child platform device based on the apcs compatible for the
>> clock controller functionality.
>>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> ---
>> [V2]
>>   * created a new structur for driver data.
>>   * re-arranged compatible strings in sorted order
>>
> Please break this into two patches, first reorganise and then add new
> ipq6018 of_match.
have sent an updated patch series addressing the comments, thanks for 
your time.
>
> thanks.
