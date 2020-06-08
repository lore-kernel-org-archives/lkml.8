Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFFAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9942B2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgFHQ5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:57:00 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45223 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgFHQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:56:58 -0400
Received: by mail-pf1-f171.google.com with SMTP id a127so8777691pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=o1Xlm9NlIyrLiWE4JkbVGE/5ZqtKY6YJWp7wrW7aRa1ptbcjDWk0eMXBejYEouBL2I
         HNNHwAx2JsZ2+yV/RPiFgbF1HvxRYE8arXxTTDA7ORzaxthNXmuN3B/HyalrOOII+9vx
         Qv6giPjMCusULIS4RP8+JGk0I87wizGXtFC+B1f/WjCy/oyyQbynmiU37X6xRvzryXc+
         lriRlLFdIa3KN2yJk2YRJxqu8tVp0LXBk+9m721PFXxygfxoEUI27MlozY5nBZ3DaLtH
         RGDBtRqou+YnQHHNBQuWzmW241YOk3yge0Tz9jPZL++ZllTXF44Vl8cQJWsPfJuign1J
         sEMg==
X-Gm-Message-State: AOAM530mvpGGbgWVYsNXQWIVCD3cjOq60uRNjyVTjmsOXobZLps1n4NQ
        AbzRFIpP+o874ROAM8wHqCk=
X-Google-Smtp-Source: ABdhPJx6gAn0h6aqJ7jzMSVfvojObTsA3nOi6NlanvrHc2aqJe1+1r1N8ymfjUmfJJGj4CxfXHXdMw==
X-Received: by 2002:a62:1512:: with SMTP id 18mr22947195pfv.34.1591635418333;
        Mon, 08 Jun 2020 09:56:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16? ([2601:647:4802:9070:5183:321c:38f8:ee16])
        by smtp.gmail.com with ESMTPSA id 77sm7781360pfu.139.2020.06.08.09.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:56:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-pci: remove empty line following
 nvme_should_reset()
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
 <20200608162002.17017-3-dongli.zhang@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <991d5bf7-f3a1-6b6b-08aa-fff9ddd7a79b@grimberg.me>
Date:   Mon, 8 Jun 2020 09:56:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608162002.17017-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
