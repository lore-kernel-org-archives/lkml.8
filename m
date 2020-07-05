Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58E720786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGEG5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:57:51 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:44156 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:57:51 -0400
Received: by mail-pl1-f174.google.com with SMTP id bj10so8897121plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Qmrkrb7MxqxnFUZEYaFETHspTdf7robwvIXobcly4uE6qVp3ntXXMMmbz3l67kJsCa
         t3hrTFZBhr4Nxxxo1iw2o3n4y9d0sMzZJF+CUvRTfZ+X1wZOsOwpGm3OEtwhb+2w46ad
         9A/F2+kcHi/hkaWLTQE2imZj2akQXpk8kx1Hh6Jh1klbrNZs6yXtDMArywMfKFnR9Vvt
         DQ4ytkQr51q9WSGvnPEGaTXUkGOr+dWLIuljMYNdLvfxpNrt+X0evqD7NWn1tX9SS93F
         s71fnflMQpSgBwchyAeofyZikWGPbay+2l+m9U1gsQTIipQnmazYvEOyATgdzDKUM9DY
         0bFw==
X-Gm-Message-State: AOAM530HsyJP+BPLo95X9U1Czax/LQJXh1/RoUwHKDFR2ieiQ+FSQ6ft
        vi0A7a+0iDVvkEvwBb+piHofCA4N
X-Google-Smtp-Source: ABdhPJypWSm9W9bqR3VR6bTyuGv9UTH4hvnCUSOcXNB3QyCHDa8bAzBTf3ID0QEgL7VrehVs0MPhnA==
X-Received: by 2002:a17:90a:fd12:: with SMTP id cv18mr39950621pjb.66.1593932270252;
        Sat, 04 Jul 2020 23:57:50 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com. [68.186.33.250])
        by smtp.gmail.com with ESMTPSA id w9sm16328111pfq.178.2020.07.04.23.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 23:57:49 -0700 (PDT)
Subject: Re: [PATCH 2/5] nvme-pci: Add a blank line after declarations
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ccb5416-1c55-41f2-8808-b102d32cb55e@grimberg.me>
Date:   Sat, 4 Jul 2020 23:57:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
