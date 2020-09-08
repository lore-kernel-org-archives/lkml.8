Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E2CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A4720936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FSjMfGsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgIHUKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgIHPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:15:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B33C0617A3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:12:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so10761661pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4cTTNM2LfB0ZKQtokAlGtAKTl5Gj9gXx4yYPrBUZ2LI=;
        b=FSjMfGshmgfnWWC3U1YIBx7DE7b7W/6phz3fnwef0gKYOPsk8l7rM9PaF1LdGQy6XF
         WmriscNv+tWq3wLFbD3vC0aszsLJds7gWEYwfq3AfjZz1C6EWnzGFboWt+UsVWUFseaj
         1sBDmcRmbvonzTJacW/pB9DmX3xU4DO3FX3ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4cTTNM2LfB0ZKQtokAlGtAKTl5Gj9gXx4yYPrBUZ2LI=;
        b=awRu7HOTRI43P6MEgzLjacmEczlqAakhEF4FEx8+2ZTueNEdypCwTHj4hCS5P/R0th
         u4neHX7mXyK/0N7DzZvrR7ipGsKyvtEbQbNluvELB4S2ZCsJJPuqXZSp0cSf7ZWiZbLg
         83Q6nRpsFa1QhzBxvMYT2Q3JGs1RXRh5lYfoYEpcAbMdzhTWh1QNTNfvI9kXkpDAs5iS
         hob5PP3XrOSDbMLCLIK6Munm5VloOt5miJJiYbfv4vrmYZOAXua+un8UC1E7tNg34bhY
         ey8zYIjiQge9zjbd0XD0K43U7Q8vzQTwLMOEJ23C2BPY1b3guCCPHOIh9RqaEmfyLzqe
         eysw==
X-Gm-Message-State: AOAM5339rfNqtYp+WvuVtzjtsZSXJaouy/yeiicsZ5tBhU6VCiVAR/JJ
        jZkwOJCk6JzLNYDWlllk/a9SWG+/R3jTU4pcYSRHVWIgxLIrpQLkSpkAMrvCTA43tD/IfqXo39d
        opcDRrLAxnGJ7jzT4iqG8NHEEVD6xRoIEdRaQucmtg+091vGeDELC7lDB52DenAKgMJF/sNJk95
        NjOF6YPN/6GFiBCA==
X-Google-Smtp-Source: ABdhPJzaP8k6OK/iQH1v2SvEVSnGPEtqyLPkJUIOp6ScETEYqxTNqDc4Tope5wDw9XDBQ7aoitAf2Q==
X-Received: by 2002:a17:902:d702:: with SMTP id w2mr24215594ply.53.1599567139350;
        Tue, 08 Sep 2020 05:12:19 -0700 (PDT)
Received: from [10.230.32.194] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id z9sm12049463pfk.118.2020.09.08.05.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 05:12:18 -0700 (PDT)
Subject: Re: [PATCH] brcmsmac: fix memory leak in wlc_phy_attach_lcnphy
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list@cypress.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
 <20200908001324.8215-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
 <c13ee142-d69d-6d21-6373-acb56507c9ec@broadcom.com>
 <CAEYrHjmG-R4RHn=59AGK8E0jKDXE5sbxQj49VpBvDMvBuBGiig@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2a11074f-e155-0af1-aa37-108c8cd120e7@broadcom.com>
Date:   Tue, 8 Sep 2020 14:12:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEYrHjmG-R4RHn=59AGK8E0jKDXE5sbxQj49VpBvDMvBuBGiig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2020 2:02 PM, Keita Suzuki wrote:
> Thank you for your comment. I am relatively new to the Linux
> kernel community, so I am more than happy to receive comments.
> Please let me know if I'm violating any other rules.

Sure ;-)

Here a useful link that Kalle (wireless drivers maintainer) is always 
sharing in his email signature:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Regards,
Arend
