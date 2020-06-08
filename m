Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A4BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FCF2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgFHQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:56:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38297 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgFHQ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:56:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id u5so9021161pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rTHrus3i4YQ4mhGZ0ttj8n5T/WxhfxgK+isF/FbLcdX5APIPOI7FJyHdvSEwdfMFjU
         p9jAcnNcqGLZnjBP15Oxim4pr9zmcuywx9/ku5rfZAU23R37O9dtMGchYVHd28rN/lqn
         5Ttbp3pq0hR/j0spAKUg4EogtNBAfCu1ynuh3sLLt1hNa8oJSt5WkqAxIugpe1yi77ue
         flAjwIJST8yhWVYQNrcT1HVXy2lekAER5d/p50lmykCdB/uis4AJm5VKmXDJMZgc7Nbt
         efJeSrJg3g3YwKxOI2POYgZEVqSx1VtAgnRf//x/e85hJvbd2Zmv0ztXRDMI5j9zeH1i
         VlHg==
X-Gm-Message-State: AOAM532SgPGSPePL3NfkMkfaa+bhVo9FGIegHuXxn+Z0qTz/hI2+3jOC
        Y8LZIjX2x1wc1W1+dWJ5d1s=
X-Google-Smtp-Source: ABdhPJxkaMnGp5/oDgkdCmAw7VoDdkdA6yItkr/GRn1VNxTA5ppA2XiR8Yaqv54AJuE9hAxW6CwYyw==
X-Received: by 2002:a62:848f:: with SMTP id k137mr12333025pfd.99.1591635409659;
        Mon, 08 Jun 2020 09:56:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16? ([2601:647:4802:9070:5183:321c:38f8:ee16])
        by smtp.gmail.com with ESMTPSA id h17sm7550090pfo.168.2020.06.08.09.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:56:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in
 nvme_loop_ctrl
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
 <20200608162002.17017-2-dongli.zhang@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <512568ce-0bcc-7940-c2a0-a6416788cd7c@grimberg.me>
Date:   Mon, 8 Jun 2020 09:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608162002.17017-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
