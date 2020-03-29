Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F8C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97032206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeNg+3B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgC2Pod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:44:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38912 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Pod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 11:44:33 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so571842iod.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KFosAzMRDm8TtflKg813txqj2n8fX1O6AnHcVFnbwBI=;
        b=qeNg+3B5MHjxyrbyQjv3Z9wiDCYxbzuP5920iIao91tXMOTSuSwTcAOrv3mC3p5bMd
         vPhHy6c6qJmqW4PQs1AHpHz5FbrQ39gUgqzeADFNepkEqJD44/xNdLLG1aDmxcuUuqAk
         JA5gqBEv4tv/R2i4qbVni/uzIC9MzBrDcnRSToeRaIfm2bWDyjyl9ixTeQBsaFWRGBqu
         8bLKXRCtV/UcGJtF0sPKzQpYuLRxHr4yG98LKIc21YMAIzwCQr7k2fojxWGTyoiXcCkJ
         2newlMdSpLlVaLGxl2GxtPUvtLvP38G5PwxzaIYSzSMVJ1h5GUfMq78BABXoRqotV4oJ
         mzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KFosAzMRDm8TtflKg813txqj2n8fX1O6AnHcVFnbwBI=;
        b=HUAPbi3xwOR6GA5cEyHWIvOqGwn0xAoWbYxIjJxoQMdvYsj68CBaY3nnITFfrQ8Z54
         Bb+88v4y0gy9uRVu0vKl+KnVjY6lXHFunaEUDevKYcqO0XDl0Cdg6YGhF+lhRCxVCWpx
         rA8ERkKEBczI3Ch3bM5rTi3tyMrb1dhsYbzq3Gd0Qh9wKbgvkHZZLhVuZttIfbTKkj2B
         S/sL9Fkta7/tk3G+/BNPSZziSxj08rqZm6q0yuG/MGBIqXmxMTNf6FPF07Rj8K/mImIF
         lI0Ex/xUxZuqsPp5LYBJ/m10Ii9nJEXZG0GjvQ5FcBsy1uywKzCs9dmX6zEV0JA5Veth
         vWOg==
X-Gm-Message-State: ANhLgQ3Bbptu/QxWfIbyvEYUZIw7BKy68sHqv6VClCPDdoagcjZcpH21
        IKjQ+st0AFx5DXrRmLbqhZM=
X-Google-Smtp-Source: ADFU+vsvvEBrjzRsGfjaR2hHh4d5qK1ubxzfGeNiZz5Nh1cRdFawZ/sFRc6rtrXpC57OtY2RGwNpXA==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr6964763ioq.173.1585496672477;
        Sun, 29 Mar 2020 08:44:32 -0700 (PDT)
Received: from ?IPv6:2601:282:803:7700:38fd:5c03:95e:23ac? ([2601:282:803:7700:38fd:5c03:95e:23ac])
        by smtp.googlemail.com with ESMTPSA id n6sm3324921iod.9.2020.03.29.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 08:44:31 -0700 (PDT)
Subject: Re: [PATCH] getdelays: Fix netlink attribute length
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Shailabh Nagar <nagar@watson.ibm.com>
References: <20200327173111.63922-1-dsahern@kernel.org>
 <20200328130341.a23be12b3a0f4cf0288a0d84@linux-foundation.org>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <d8795cc9-f4f3-c0de-75b8-ebbacb9485fc@gmail.com>
Date:   Sun, 29 Mar 2020 09:44:31 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328130341.a23be12b3a0f4cf0288a0d84@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/20 2:03 PM, Andrew Morton wrote:
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: Shailabh Nagar <nagar@watson.ibm.com>
> 
> Is this worth a cc:stable?
> 
> 

sure.
