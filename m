Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E029C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A7A20786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGEG7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:59:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEG7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:59:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so15661686pfu.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FBUwca4AjsOP4cmQRMgYD7Pme/xFbxnQa+v76+kyLGNNYhpGcMeSjGnMeupVWosVBq
         c+PAYkNJgDI94uR155PsgUuq7gvbJ/LhWzKghqCwxBvS3XQgg+9/rP4f/mVGhYv/AoPZ
         hsZUBJn/ifdbFuMmX03PX0aII2vcj+VBucstX0NesFyLisz3Khk9OBvV1te2TJZ6fKDf
         NGYE4OKVb76G9sva2PPj4IQ6qkJQ8gzKCcIilHhsbkSeVArny7SbFUDt3wxJDTALSik5
         8vgzSvAheWg1or2hfaN+mVomJ/CxpZnZMGNHXEf60jlqgQJtRRJtRLkGvHOoYyglC4om
         M7WQ==
X-Gm-Message-State: AOAM530HhHiVrXB6/HpDLF8uJOuZf4i25beBgMTkxUEkZwXJaipSQ/uo
        VqkBWe9a303e3CwTmfBTrUfNQJ4l
X-Google-Smtp-Source: ABdhPJxerZHDIQpxkJPD4FNIhC3VUSKnjSLgmPdtqKF28AyDdyJ0p81t54OkjGPoWQoQo3UbR5srGA==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr28506198pgm.348.1593932392462;
        Sat, 04 Jul 2020 23:59:52 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com. [68.186.33.250])
        by smtp.gmail.com with ESMTPSA id b21sm6421045pfb.45.2020.07.04.23.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 23:59:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvme-pci: Use the consistent return type of
 nvme_pci_iod_alloc_size()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <f6a3c779f68ae170076ea37a721c9c06a9dc70f3.1593743937.git.baolin.wang@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c97e7fec-8602-ef3d-b841-f6e90baf7251@grimberg.me>
Date:   Sat, 4 Jul 2020 23:59:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f6a3c779f68ae170076ea37a721c9c06a9dc70f3.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
