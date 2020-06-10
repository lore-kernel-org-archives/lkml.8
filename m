Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1371DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3527206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIo+ES8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFJBLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:11:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E460C05BD1E;
        Tue,  9 Jun 2020 18:11:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so212985pgv.8;
        Tue, 09 Jun 2020 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JUXFIpAZNhLOKFb21Ru5xbanffFal9dLZ6uEHtJQTz4=;
        b=BIo+ES8jhdKEvHJb4WeWrTnqAuloMz7BJ7pkt7ZsUstmVJESP+UhHAsntts/SGJ/4C
         fAnqr64AWBvkL7hs4e+bD15uOIzgzp9p8KbZeB1RB7EGOb+9JoitlkhE+1UvcvIi1Bqe
         zpRMMS66kb6xP5o0nif7/aItjg8d4tmYX5raxO3GJ5i+cOetj8Y19Yaqb2MHEar6MyQY
         3R2F60FTYYjEBsmz2IGjyMROyhF8mDSOoII5w6TW4lXTrB9KgBRDUfQVEfUq++UjfafY
         RY0e2s8WeQhESPsacn6QW0pizTeYUdr9ArZcaOxbNBh5QLx5hs5FPc4Wz1ufE0OtGr86
         8y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JUXFIpAZNhLOKFb21Ru5xbanffFal9dLZ6uEHtJQTz4=;
        b=e0ev2Dm+e1+6qXgsswIJQqW8v6eiB1MsvUOLdivjlW1A0NdpJSBPIbBX3QLrtaO2wa
         nhyn2BfIu7BFD+FMw5S//YXBi8e4zxgDmpgcrADK7VCHbpTfguHEf7vTvK89lQbx2FOB
         KKEvPRyQP15MqIzIIl7q/O9yhXVGsaIMKqH9Ci2gTrfDXLXUBz30rfn9j6xxARk/S7oU
         oLt+pAwpPj05GHB1Zy5LS4+z+d6U/jcpKM2kL8kK1U/lTymbHUSQ0x3MO6r94pL5OQQv
         7Fb+/I4+w8Q8rkvS9Er4hsY+Dj7bVXnavzu6tyxLHHq4BOreUXYLbqeCi16AJfAqHpY6
         qWqw==
X-Gm-Message-State: AOAM532MEQ8vXAHXYxUDPN8cuNcrCRiHCGd0M8f3x5esq2lqXk6BRXc4
        4HIB32qmZrf4X8rOPVIknwA=
X-Google-Smtp-Source: ABdhPJx66/JbYr7Qvtbsf0ncqiiEOw8ap+m0Rzt1aEKjKN9mwOa53uaoI275IGjAZq7Rs+Z/exeBdg==
X-Received: by 2002:aa7:952d:: with SMTP id c13mr480416pfp.125.1591751502698;
        Tue, 09 Jun 2020 18:11:42 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 136sm11013973pfa.152.2020.06.09.18.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 18:11:42 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] dt-bindings: reset: add BCM6345 reset controller
 bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, jonas.gorski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200609134232.4084718-1-noltari@gmail.com>
 <20200609160244.4139366-1-noltari@gmail.com>
 <20200609160244.4139366-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e1266c58-958a-57bd-e4a3-b63867960614@gmail.com>
Date:   Tue, 9 Jun 2020 18:11:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609160244.4139366-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2020 9:02 AM, Álvaro Fernández Rojas wrote:
> Add support for resetting blocks through the Linux reset controller
> subsystem for BCM63xx SoCs.

The commit message should be paraphrasing part of your binding content,
not necessarily describing why this is useful.

This looks good to me though:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
