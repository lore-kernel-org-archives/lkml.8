Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB87820786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGEG5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:57:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40126 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:57:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id e18so16956263pgn.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kI3Snp2u4CWX9wFdA6BXk8yZequxCI3QMAj0Sw2LsWHn9PmM+JwtDYHABvxXHZXfW/
         rUSo2NoUrusG8/1y1ZNGpEq/gVm6V8PdWFJ4nfmCEwuxM+01twTLsLXG7pUgy6kDcnqK
         Trq3Ng/bU4+TPSx01dxH6QRW0aRLyQRdE6ynieluHW6w6fC1ktOSt1bkNZlw00MEKPCS
         WVT2+OAVa7y2XNY7xBhQaE5bO+JsQclsVm9ceFVxTpELBOSn6ATmBASaAiFgYoy+25xV
         TOakVkNR22AYsU9CFopYC43YhYxOsoJ6ZrT054WohtuWXCIVBzEaePqwEMDKe5zh5I4H
         ovOg==
X-Gm-Message-State: AOAM533RlwdeVPDQisBSDrSJKKWwJJLK2fvQJATCUssaslAWJMosPzfK
        BbkLZzuBknGBkcYPcYJRYY0Nsy3s
X-Google-Smtp-Source: ABdhPJySiIKdxUgJ5KvNkSJIlMB6oJcFhp/aQflJgSvhdfl1UVB4puezU51EnI++76D74RV4ZWqE9Q==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr36769320pgp.333.1593932264458;
        Sat, 04 Jul 2020 23:57:44 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com. [68.186.33.250])
        by smtp.gmail.com with ESMTPSA id y12sm15886090pfm.158.2020.07.04.23.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 23:57:43 -0700 (PDT)
Subject: Re: [PATCH 1/5] nvme-pci: Fix some comments issues
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c46f453-f215-0478-2acb-87d73ee477ae@grimberg.me>
Date:   Sat, 4 Jul 2020 23:57:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
