Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD25C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0620863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="TXAJosmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgCCQrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:47:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41335 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCCQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:47:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so1726520pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=iw9YBEqn6SiuMz3RoRL2TK68UdSA9OieFntlL99NIlQ=;
        b=TXAJosmCBNpJ2ZM4d8/elkA5aRTbUCyJAmk2yL+61fVFIKWPQNjo9CeKeMy8i8Z9h9
         OgpGQlXqj4yPs5pLr9GlMcZGf5lwHTHKtYqOk7mCc7hSqwBRym0s60yMov0blx1pD9t0
         QpVlQbHKt1uA85VzK7w2Z8MmMFINPf5smhcAePWCyN1i0nPtogg+atDtfCvEo2mvM08M
         BvBK6axwbkWcdf215lcIlz0UKn5QSrmGvxvNx4+sMQFnNjr8LVdjiCo7e3HY6kzodF8t
         2P5kMzzVgr9SNIuO8kGIh79/A2DFx8HmUYpLH/KdKcDiosFrF7BRzir2KCfAqnpcyhku
         Z6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=iw9YBEqn6SiuMz3RoRL2TK68UdSA9OieFntlL99NIlQ=;
        b=JCE+ExRadIJdEi5s2A9rV/tyxKPlTTmoDlQofMSNlyWvyflK0gUI6ej504y3hzfC+x
         Q6sBvvOhTn5mLWEMTT4QCEeAodMnewNIRcyCXBRj0OArALnD3/GUMAB+rRA1cjE+ZLKA
         NStKOxrS4cs8ebOthC64C1+7kk3QftRVKFi86uJwTFUxEUmUpAqfOoz5+7CgLU5mfkMQ
         95LuzgqGOec0L1MgrEWGhX/+UyvVVXRklWVm8X27neDpeN/J3IIi7//wbUf2Z8k3ZLC9
         oNAnsbZ1Rh8iBnETIspC93kRT08cdGErppIt6a5r5D9qZJbUi9NgdloqvdKwgtdTbm1p
         z3bQ==
X-Gm-Message-State: ANhLgQ2MaapOiPWFrNNQCCxMx7I/KKmCTNCSg6i9llH04GT9WSAtr4pv
        PiPtxgzbo++7o0Incs//99yAXhuZPls=
X-Google-Smtp-Source: ADFU+vvzktlA9BA3EIrpaH5JRzfIdDt8GsZXatXec0z684I+/dOUbNfEp7oBgocNTwDj6kHGdxVgAA==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr4898806pgo.124.1583254035982;
        Tue, 03 Mar 2020 08:47:15 -0800 (PST)
Received: from [192.168.0.9] ([103.16.71.221])
        by smtp.gmail.com with ESMTPSA id a9sm24724365pfo.35.2020.03.03.08.47.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:47:15 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Meggan Berg <megganb@dynamicaims.com>
Message-ID: <71d83520-ae9e-e39d-2c77-b1c271c27da4@dynamicaims.com>
Date:   Tue, 3 Mar 2020 10:54:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Enthusiasts List" from USA?

We also have data for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Meggan Berg
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".

