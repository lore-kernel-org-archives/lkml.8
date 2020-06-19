Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2204C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE12208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CeO1vgEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgFSEd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:33:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38152 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgFSEd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:33:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592541206; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=xL8WRZW5X1FjpBOjpJn9kEbJZJS8WhjJ0iTqxhL7V7A=; b=CeO1vgEfEr1ZS1SoCcqgRMhKbbFZ1HKrvRFFlSc9FSd/qKGwwKft/vTbNdhyMZEv8f7PpJ6W
 Uayzwz8m8+xKKqzrYsi8Suv59y1ZQlFIu4YWhMAMWN43GgkiUD4qkkCjTWidm7MZGxNKhXza
 bfM+QybuXXaLBSDWxjXho/9oFZ4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5eec4006e144dd5115a8f500 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Jun 2020 04:33:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10506C433C8; Fri, 19 Jun 2020 04:33:10 +0000 (UTC)
Received: from [192.168.0.101] (unknown [49.207.137.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7538CC433CA;
        Fri, 19 Jun 2020 04:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7538CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200616211214.7cc1f1a6@canb.auug.org.au>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <9fdfd0fc-5bc9-1e7d-3955-a95535b32995@codeaurora.org>
Date:   Fri, 19 Jun 2020 10:03:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616211214.7cc1f1a6@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I just sent version2 of this patch with correct fixes tag. please pick 
it up.

Thanks,

Siva

On 6/16/2020 4:42 PM, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>    912f25eca000 ("pinctrl: qcom: ipq6018 Add missing pins in qpic pin group")
>
> Fixes tag
>
>    Fixes: ef1ea54 (pinctrl: qcom: Add ipq6018 pinctrl driver)
>
> has these problem(s):
>
>    - SHA1 should be at least 12 digits long
>      Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>      or later) just making sure it is not set (or set to "auto").
>
