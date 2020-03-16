Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4295C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938B3205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="AgrLIe5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgCPJjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:39:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46244 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbgCPJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:39:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id d23so17764307ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JLytmDCmn51mn44rY6noInxUpy3ZOK9+CPA5ppocb9k=;
        b=AgrLIe5sp8wxfMXOXw2adaEdRxyCCK8y2u0Hhg9ld0v+sZezrd+3DQbWNTjMhx4c70
         67+am6Xz8+PIvZjoKxDgOJvBkSIkbEjfHMHVgMJ6FeRzbBjkJK6lCw+1BUw2ywHXDnO2
         fYU23293O/uKCMZcCwHpeSn0AWr4LRBBwS3/LVp+NrMtKxbg0SrO7zG7OBwByvfwzlJJ
         1Y+MgDvExFuuM69KPbLHLZ7MNN3j7UJ+KJcj7ob/6xgFunxijQgHqWPI+MNeH6D1vc7i
         5iKLHjRiWGnlav90A4cyD5oxChCqjnAjc1DBh0nNxnZCA5ovDVoOclBntuhUu17Jja25
         xDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLytmDCmn51mn44rY6noInxUpy3ZOK9+CPA5ppocb9k=;
        b=o3L07uFsG3m8Vq8FTlWleyhwqPOt6T6OlzWHUSfoJgyPeU7+m4CjajuiXEc8iydlr5
         qlIxplb8di0FicR+x8x2WWUzJa9DN4hqPgLg6zTYDlcGqD2ZTOKxcx2VYchoCrqUMwhj
         CarmPA7AZo9Hr/HwFbp9bNVfo324LD+ejmP5gSF33+hOjuKA0p6/cMvCZoN9zYb2IPz7
         cx/kWrXVsZ2pSIyCrEAGKQTw4c+tC4y8eQvfQAKrxLUXiUGlZlgWjbeLNLMSTw1m/W8T
         NCGJ0CornoG6fc2EO6yxme+Zwduyz1FCo2RCsTwlibvFHk+wqvUASL96Lv7UEk7Desjz
         Omyw==
X-Gm-Message-State: ANhLgQ0qSSFq7Npi6ckWssx/3yEPISU24kVrKl2WWo0/DfX0SQVzZ9rf
        ZbdDmM6QR7g3P/4Uw4jrXMKSN3xicc/jlg==
X-Google-Smtp-Source: ADFU+vuuTCqpP/tMAnOSfw02o9lCU2mmkwvTIw6R5yQ7sbu/Sgp//Q3DGEIoMniG/NIUmGJaTxw+ww==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr12844818ljj.249.1584351588489;
        Mon, 16 Mar 2020 02:39:48 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:487c:8c8d:3425:ccbd:b743:a5f8? ([2a00:1fa0:487c:8c8d:3425:ccbd:b743:a5f8])
        by smtp.gmail.com with ESMTPSA id a13sm1371057lff.81.2020.03.16.02.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 02:39:47 -0700 (PDT)
Subject: Re: [PATCH net 3/3] ethtool: reject unrecognized request flags
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
References: <cover.1584292182.git.mkubecek@suse.cz>
 <40d6e189e3661dc996f7646c848bfb067ac324cb.1584292182.git.mkubecek@suse.cz>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <09ec9c9b-10d3-510b-df0d-bf9f06bf99da@cogentembedded.com>
Date:   Mon, 16 Mar 2020 12:39:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <40d6e189e3661dc996f7646c848bfb067ac324cb.1584292182.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15.03.2020 20:17, Michal Kubecek wrote:

> As pointed out by Jakub Kicinski, we ethtool netlink code should respond

    s/we/the/?

> with an error if request head has flags set which are not recognized by
> kernel, either as a mistake or because it expects functionality introduced
> in later kernel versions.
> 
> To avoid unnecessary roundtrips, use extack cookie to  provide the
> information about supported request flags.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
[...]

MBR, Sergei
