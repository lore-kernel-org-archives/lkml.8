Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC6DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E27F2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="wC0p0y6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgAVJr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:47:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42530 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgAVJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:47:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so6032780ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZA8MvhgTjR1Db93Kl8ZE7I1AjnzSwS3ydOzQHANga8=;
        b=wC0p0y6lCM/wUPS/IfTODzcD7cUkMCgxGcO/Ls1M4lnxeAF25AhC2C4Vq95flX9Cqq
         xswljYa8WRGoOcWSXm2W6pX2i6tbrYZl/tb8PK/KF9zkamDnl/8pfd8ewgUZPz+/5fUN
         96AHMmL0Xyt0c2MJApHZI/9syXmJZFx4J7GGEUVjJGKldYUqhWiheRD41HKTG6nv1vZ5
         Un8WBaJ9FkkGTQC6qxUyq7cuVinhs2Dm1yIk1WWhjGE+FZDGLeYEP5xap+gN/v6mU1v2
         ErTBn5SK/sVESEgcAgTGOTxhVZ6ZhyvAtPn6ooVjh7EqlhaL+k0gItHCbJzd4la/PwJk
         2nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZA8MvhgTjR1Db93Kl8ZE7I1AjnzSwS3ydOzQHANga8=;
        b=qtQpWqLTqUTrrumSkJb4qb1vpbV1V4Z0I6hAr/13y8tMPutdjBv3dF+OSZGK8rwzQz
         iFCl6bP5BQPRzMY7tw68tLFdPPpFB5D7LO8SvtiSIPW8lLI685eXKzrL5jGcmTHl32M2
         UbVScJ9rq4M7JFmMcNgd5jxoJrJt8H5d3rcBexrWYELNED2v1JNeBBumee1NOkEKJ4oR
         LMJweugyYjVE3VM/BhlaEqa2gIeL05riYh6HmlBBdZ03I33v/ffh7XVNtOfNq6LfHgg3
         fx+gvN2IZy4DE2NdUoMW8I7T0t3eEHwwhqdqO3bELCQ0F9MPht78ShXnlV1uaI0eUnJE
         lR/A==
X-Gm-Message-State: APjAAAXwM362D3rhqUcxJ66tpULJvOuP9UGwQlM8MxDmRzUv8sYkkKrj
        9YP8wEPD70DbcuvVa+vzpZGOwA==
X-Google-Smtp-Source: APXvYqyLk8hqyXbvO8Cs28biGHLs880vO3AoEuMqCtu7rpPoP/AP/GFODe0/mn2xfn4dxkEXiyQ0Mw==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr19259412ljd.227.1579686475289;
        Wed, 22 Jan 2020 01:47:55 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:468a:1e6d:e8e4:fead:7539:293d? ([2a00:1fa0:468a:1e6d:e8e4:fead:7539:293d])
        by smtp.gmail.com with ESMTPSA id r9sm23922473lfc.72.2020.01.22.01.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 01:47:54 -0800 (PST)
Subject: Re: [PATCH net 1/9] r8152: fix runtime resume for linking change
To:     Hayes Wang <hayeswang@realtek.com>, netdev@vger.kernel.org
Cc:     nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org,
        grundler@chromium.org
References: <1394712342-15778-338-Taiwan-albertk@realtek.com>
 <1394712342-15778-339-Taiwan-albertk@realtek.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <62c3af7b-0e94-c069-0d35-4b5f41031a4e@cogentembedded.com>
Date:   Wed, 22 Jan 2020 12:47:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1394712342-15778-339-Taiwan-albertk@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.01.2020 15:40, Hayes Wang wrote:

> Fix the runtime resume doesn't work normally for linking change.

    s/doesn't work/not working/?

> 1. Reset the settings and status of runtime suspend.
> 2. Sync the linking status.
> 3. Poll the linking change.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
[...]

MBR, Sergei
