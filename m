Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96AC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849A215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GOqnAI/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCJULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:11:51 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46062 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:11:51 -0400
Received: by mail-il1-f196.google.com with SMTP id p1so9216255ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XCqf40GUhK/TZ0i/ss/XymrIME6RYC2/9jBGUr6tadQ=;
        b=GOqnAI/TKiv7VDWSuouVJiN3pz8paQm95zjfldi79U6wK9ec8bwf4xR4P1qPu4JIMc
         78OByHxZQi/jjjg5QHMxvA3GsdCzeEPiaABuF5agJawfOVAoZ75RFd3czGTiqQr9icvG
         SfxX8Qjr7xDOl1C9UIXvcptcvDxZrpwDMbbwbXJcsno8q1eeUJQBIzBAZCsiiPcL3zjT
         VCkAhjwbpYfylNlY++pQqZgc9ClwQ/cgR5cYBo9QiqtNTrpqQj8ta7uhovNxGwV/GBwE
         ub+/LrnXLK4TFPfPu1JcSVKcrqQ9tGmrCas3YkxxquYmNIRC1iVG4v4THRgi+URcoDK7
         gakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XCqf40GUhK/TZ0i/ss/XymrIME6RYC2/9jBGUr6tadQ=;
        b=Iw7wZJxVRKX4/i2mqlSSLMs+H+TgvR3WL41Rr8a3M0rKvGEfuSBxgUnXDsNbbCr1/h
         o4dZIbf/VB7d8VO2EpgTu0PuWt4ifX6hcZq4CCo4KJmx8/uBTpdFC6If5hQgVQDZ220m
         +GcD4kxc5QzBiaNK6nu6e4GX0JSpijrZdNG6OhBqs/mXFAEf89TEPTC7K3V3y/NVeGCX
         7sKaaRBkTfnz3ehnaNf/DuG41z8JKJnhlw9C8HdUX3fIbRW6O5xQmHwJ8DwE0a645rrN
         Dv5xlUZNQTD415Fi0Lb5GZ2o1b5GVLS0MGpwcbQ7KXcVgx6BCoPUl5ahRtqFf52E9IzU
         IZtg==
X-Gm-Message-State: ANhLgQ0OPvhw44Fcmmk42bWSzGaTuNNp2hSJL9TJ54V5tNxu+yMb0+cK
        7rJhbsQc61yYtI22sSVcPST63YHnGIPyfg==
X-Google-Smtp-Source: ADFU+vv8bm/Ll9GDrFmKUaFxorGsol1kTk+OiVKDb35jovd/4Q9fWSF6bR62R/8r9sLXtLSdp8Wsqg==
X-Received: by 2002:a92:111:: with SMTP id 17mr20596998ilb.158.1583871110589;
        Tue, 10 Mar 2020 13:11:50 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t24sm3887552ill.63.2020.03.10.13.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:11:47 -0700 (PDT)
Subject: Re: [PATCH] loop: Only freeze block queue when needed.
To:     Martijn Coenen <maco@android.com>, hch@lst.de
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20200310130654.92205-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd6af0cd-24b9-4c46-01fd-aa78f7714350@kernel.dk>
Date:   Tue, 10 Mar 2020 14:11:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310130654.92205-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 7:06 AM, Martijn Coenen wrote:
> __loop_update_dio() can be called as a part of loop_set_fd(), when the
> block queue is not yet up and running; avoid freezing the block queue in
> that case, since that is an expensive operation.

Applied, thanks.

-- 
Jens Axboe

