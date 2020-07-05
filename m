Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61565C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF0520870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGEHAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:00:25 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:38747 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:00:17 -0400
Received: by mail-pl1-f173.google.com with SMTP id d10so14127192pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 00:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Jnl/jxgQtyDu4ayMCAFJxI9tLz0Z2oawTbmfrPH5b4vS1OUN1o7mahew+h7oGseUPh
         mmy4asqtOsHDu04Eueunw3mTM3/EjTVxmgkx/U+0fyyrsiyLsDUkWDS1xKKHVZpPCC4i
         cNmDO9Yfqn5TRGF0aZQWpsyk+ew8zDZ8qsRFttConUz3QbKaTguoahwiOJCdRxPUDmhZ
         bJLNLu4+2RC4tCVcsJ5jEdg7l0zI3lnoZ1V5mu8+jI+x0D9N/NXEM3MB6Gz/GLiCIPer
         rgHwbB0vJHSU56Ef4RBy3k9h61zTLaXqelLwOWZ8UmRO6030uCQbkkAqweFymPBsPAG4
         W+Ug==
X-Gm-Message-State: AOAM53085eiqM1W8zL509OIL2wIJmmQ+92y8zTEE3az12kwNpOh0ivSv
        kMQumfh+VgFSopkQTFaH+I8oeL/r
X-Google-Smtp-Source: ABdhPJw/x44WohlEVYRxaffxVXKB7Jo+/UwG26L+YFUWlVIBNMuhpgZ+YKJo7G+yhFx7I3IGWu4nVg==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10mr38278459plb.236.1593932405488;
        Sun, 05 Jul 2020 00:00:05 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com. [68.186.33.250])
        by smtp.gmail.com with ESMTPSA id k26sm9119800pgi.16.2020.07.05.00.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 00:00:04 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <096528d7-78d4-ef90-9a42-0b5ee574740d@grimberg.me>
Date:   Sun, 5 Jul 2020 00:00:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
