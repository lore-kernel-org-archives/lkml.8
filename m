Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E99C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B32071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="hCd69Z0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDZQwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:52:21 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.219]:13017 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgDZQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:52:20 -0400
X-Greylist: delayed 1487 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2020 12:52:20 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 2256ACA1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:27:32 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id Sk7wjo3p8Sl8qSk7wjDrod; Sun, 26 Apr 2020 11:27:32 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nOj2osYNQXr8K1shlwowWOqo3kkVH+1V33i1mSrzbOo=; b=hCd69Z0a5Rcuo1M10ME1Q2NPgW
        UF4Wfuj7T5NVxEK02KOESbe0ypBal3zFywClY6U8ETSSPA4oQ5BIC2ekU08ym/i06bW0ElDx206O4
        j6zpUiE13vw7p0IhEjrBXKkHdkTkQGDM2azno7fzsiC0qxEkn6tbkZ4vo9wDkCneWBdJSLN4nDu7L
        3LO+xkH3PZvRDuVQqyaA9R2t1aHlFr17/1lBa0UGjj4cOgr52e+GMJazf9FvgK2rp9jd9L4zWJK5J
        EjD7qvS1GerElJCgRF9I7v9ZcVgLjY5kI4Rb3mPMkW7PDSw2vpXLB33nwHxtE9t89exZffR0wLzyR
        ACzZpapQ==;
Received: from [191.31.197.205] (port=46284 helo=[192.168.15.9])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jSk7v-001MdU-Ou; Sun, 26 Apr 2020 13:27:31 -0300
Subject: Re: [PATCH v3 3/3] ARM: dts: Add Caninos Loucos Labrador
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-4-matheus@castello.eng.br>
 <20200405065137.GC8912@Mani-XPS-13-9360>
 <df32c750-a097-9210-6e13-db7db49836b5@castello.eng.br>
 <2dca5a4e-933c-0a43-e86f-21b55d75a586@suse.de>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <f9e48fba-0da8-7ba9-d44a-7909067a1df1@castello.eng.br>
Date:   Sun, 26 Apr 2020 13:27:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2dca5a4e-933c-0a43-e86f-21b55d75a586@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.197.205
X-Source-L: No
X-Exim-ID: 1jSk7v-001MdU-Ou
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.9]) [191.31.197.205]:46284
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 10
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

thanks for the review.

Em 4/26/20 8:58 AM, Andreas Färber escreveu:
> Hi Matheus,
> 
> Am 23.04.20 um 17:20 schrieb Matheus Castello:
>> Em 4/5/20 3:51 AM, Manivannan Sadhasivam escreveu:
>>> On Fri, Mar 20, 2020 at 12:51:04AM -0300, Matheus Castello wrote:
>>>> Add Device Trees for Caninos Loucos Labrador CoM and base board.
>>>> Based on the work of Andreas Färber on Lemaker Guitar device tree.
>>>>
>>>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>
>>> Will queue the series for v5.8 once Andreas is happy with it.
>>
>> do you have any more concerns about these patches? Let me know.
> 
> I've reviewed the preceding two patches. This one here looks okay,
> 
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> 
> but see 2/3 - model here does contain M and your .dtsi is named -v2 - 
> what's the difference to v1? If it's big enough to warrant a separate 
> .dtsi, you should consider whether a versioned compatible string may be 
> needed, too (likely in addition to, not instead of a generic one). No v1 
> info on the website.
> 

The difference between v1 and v2 is the model and vendor of the DRAM and 
storage eMMC. But that had no impact on the software.

Checking examples on "/Documentation/devicetree/bindings/arm/" I saw 
that some add enum descriptions for both the base board and system on 
module, keeping in const only the vendor prefix of the SoC. And in the 
device tree both have the model property description. I liked this 
example, I think I will follow it in v4.

About "-bb-" in the file name and description: on PCB is written 
"Labrador Base-M v1.0a", so with that I think it is better to leave only 
base on the name.

I will send the v4, thank you very much for the review.

BR,
Matheus Castello

> Thanks,
> Andreas
> 
