Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B087C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E67214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCBRq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:46:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37847 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCBRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:46:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so101472otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FIMG3KbzEPwgAIUG1B3you+qJowv4AZA0wQaQyZmF4WvkCg04UYP/0LFSLWTNTIrCg
         jzN9dSeOUIcHNaBDWCk2MVC16aIYhBYvCjeKtYTl0U06KrYB5y7FxmM/MauUTJ/IrEjh
         XdJC178HFLwWAA+L8PhzB4SZhlitnneUgtI9f/jYTQcf3vSgxgS9LmJQ3O8bWdDXD638
         YcatBO6pQg/HxzYtiaVy4NK6PLKXQ927Wgdc8R6loG+iXjOI0iDegub5K0RHpvEwwHsc
         BSqlgsQwVMJfO5n/E3SKoJaljd7sp3rxlKlRkxaHFhtvSdMeCXBGp3l3zEV6o4F6fujJ
         9FAw==
X-Gm-Message-State: ANhLgQ0i8iezQrPpCCn+GAjooT4w4heocEr4zfv71WSmQoXWbNqS0MfP
        g7uqkrElsa6bOo7NEZqdX/fx52zn
X-Google-Smtp-Source: ADFU+vs+4P7x9C+1xgKFkNL2G9WYke1HRmktrcTie2hYiQ5RLGtZXCTXiDgRVVmL2AJgl99XI//5vQ==
X-Received: by 2002:a9d:a16:: with SMTP id 22mr239324otg.31.1583171215362;
        Mon, 02 Mar 2020 09:46:55 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v10sm6516476oic.32.2020.03.02.09.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 09:46:54 -0800 (PST)
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
To:     Josh Triplett <josh@joshtriplett.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200229025228.GA203607@localhost>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f97877d5-2cb5-426f-3117-0b439b00b88c@grimberg.me>
Date:   Mon, 2 Mar 2020 09:46:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200229025228.GA203607@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
