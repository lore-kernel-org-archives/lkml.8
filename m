Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A824F20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="PokwTfkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgGETLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgGETLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:11:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA10C08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 12:11:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so40222027ejj.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xt3dOuMU6eTwoXcY8IjEkhHFc+2w+XryW8TVkin2ZTU=;
        b=PokwTfkLrg/bmM8c13myLwZt3KcUH8zV5xC962EE89+3RJyCJybDmdF5P0hHyoiEBx
         SbDQTSK5sdWOGsabemoZqA3fkToEAqMR84VdCLxu97SpYIh+R1PmlFGfdHMbWHv14lKM
         VmH5/fBkrq8jmYeqHNu3qL2rAxPXJZXo2EyMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xt3dOuMU6eTwoXcY8IjEkhHFc+2w+XryW8TVkin2ZTU=;
        b=NIaeA4YPq4oE7mqKtTW7LbsnxZrj8Zle6yt9GVaLAyl5U4Xw1zcVQlq7RsaqK3Pz8p
         fUac35DLCDHi5JPzB4Dn15QZX7kSZoiqb77CMpXXVbukwcYjf/pabOnJmXqY1ADu8ZGl
         KSHLtjYpO5Kf2e1Hy78UREeKGssY7VligOx1m8skstuTgnoYHFLjVYvf2scOlUkxO5SB
         ESpL3AngQRbWBx64iW7+lkgU60nnP2mz2mXIkMjnS22Add/AtzaCn6r1gs5ITB4Bqmg0
         3WszRW98kakq9LJbY9ql7aHmAl/TeaAjCxewTI60pxxQS31zV/h4pc1fX0DzvNVr3yGH
         6SgA==
X-Gm-Message-State: AOAM533GitY/K/2BeZqryja160W7HAzLjTv1fYd5bmE0srjz54pUYre4
        ebCbJSgasIAUaf3NOClD2pJFZz0JslvnLQ==
X-Google-Smtp-Source: ABdhPJxiTpppeAh2jceWrIULklFnFR7tpoaFOd+aNldck56zwzDpUkkVseaUjAhTOi+cGJtsrBs/oQ==
X-Received: by 2002:a17:906:26d6:: with SMTP id u22mr5832091ejc.271.1593976300766;
        Sun, 05 Jul 2020 12:11:40 -0700 (PDT)
Received: from [192.168.0.112] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.googlemail.com with ESMTPSA id b98sm21583091edf.24.2020.07.05.12.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 12:11:40 -0700 (PDT)
Subject: Re: [PATCH net] bridge: mcast: Fix MLD2 Report IPv6 payload length
 check
To:     =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc:     netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        Martin Weinelt <martin@linuxlounge.net>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
 <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
 <20200705190851.GC2648@otheros>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4728ef5e-0036-7de6-8b6f-f29885d76473@cumulusnetworks.com>
Date:   Sun, 5 Jul 2020 22:11:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200705190851.GC2648@otheros>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/20 10:08 PM, Linus Lüssing wrote:
> On Sun, Jul 05, 2020 at 09:33:13PM +0300, Nikolay Aleksandrov wrote:
>> On 05/07/2020 21:22, Linus Lüssing wrote:
>>> Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
>>> igmp3/mld2 report handling") introduced a small bug which would potentially
>>> lead to accepting an MLD2 Report with a broken IPv6 header payload length
>>> field.
>>>
>>> The check needs to take into account the 2 bytes for the "Number of
>>> Sources" field in the "Multicast Address Record" before reading it.
>>> And not the size of a pointer to this field.
>>>
>>> Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
>>> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
>>> ---
>>>   net/bridge/br_multicast.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> I'd rather be more concerned with it rejecting a valid report due to wrong size. The ptr
>> size would always be bigger. :)
>>
>> Thanks!
>> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Aiy, you're right, it's the other way round. I'll update the
> commit message and send a v2 in a minute, with your Acked-by
> included.
> 

By the way, I can't verify at the moment, but I think we can drop that whole
hunk altogether since skb_header_pointer() is used and it will simply return
an error if there isn't enough data for nsrcs.

