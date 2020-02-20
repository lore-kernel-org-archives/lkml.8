Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC66C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A2320679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBTVMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:12:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32896 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:12:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so29099364oig.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FNySM7+ZGK3F8XQLomvkf+fLeLguxdr89jI776J+teI=;
        b=DyVZ8ARfB6bN51+9owy1N6r9Ie5fM6C3FY1qY5uLT35RBwyJH7331NGrldW46eDoRi
         wopNM1olp8rJkROHcXNfyB7OU3O5dcSF9eTQdUmGd0uNiT0zKsUbhoTUS12SI2E8YFN+
         9TANkKYqdtDSr9kaxlz6xazziPOaDJtjQzWHdmedaonjTVvr9rJRPVbUdVMBfM4Lej1N
         PHeZF1jks2+7jWYsWPdMmTu0pKJSpNG3VLrTwzVAqDOXDH28tF7KAGjYqXQ+EbVSnUrE
         c7E9UkLM7rjARDbAqwOdSjyT95IxW/Cu9+AOLbkacf6BVNg156qigRwMByx+n1apVJbF
         32+A==
X-Gm-Message-State: APjAAAUtg425fP8lBDp0vxg3nzrSnleP6rJ6280lUfTgRzZ1NryNZb9r
        ZWqLmOQLJtn2qAKbE6TLQBg=
X-Google-Smtp-Source: APXvYqw6Ba+6qn/njDshlmqjLyu/9nimEIfELWkjMON1pMiuDCyNPWKrWvjFtu/7ak2bgZ+MmpYU0A==
X-Received: by 2002:aca:50cd:: with SMTP id e196mr3528791oib.178.1582233164694;
        Thu, 20 Feb 2020 13:12:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id u66sm163103oie.17.2020.02.20.13.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 13:12:44 -0800 (PST)
Subject: Re: [PATCH] nvme-multipath: Fix memory leak with ana_log_buf
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200220202953.26139-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f77a1d7e-89b8-780b-2710-3baed48519c9@grimberg.me>
Date:   Thu, 20 Feb 2020 13:12:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220202953.26139-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Keith, can you CC stable when applying?
