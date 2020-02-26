Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E6C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497F24670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBZXfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:35:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37619 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgBZXfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:35:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so1198303otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YO08zB1uWcmxcUdr3YqMpD7DDsmFvFrk63ooSNf2884FOuoNl+fM1Q53KI6WOfQZ8S
         YvUTRSzks+68LkohXPtV4wZdaEK9jUK7VrjshbQWaGtN4efpeoW4oDP6qKDcOpODFV85
         rtGUgRx8V/2F+BFXjN6axRQlGOP5t/tuDXPhwDT68CjBsELXc8e8SHWUMf7rqiQukbJL
         A4Mlwjh9UzpqpG3NJ8xFFGIk7KZB6EdSg4+4Rc522MTNZWQBi+fM/hsP/nYI4mBijaVC
         80u2vBFRPmw24GKpI4Uwhk3Mf15OE49CKA38D7pbLqJrEcAKmuTlxQa2soxigHguQftf
         XtnQ==
X-Gm-Message-State: APjAAAVEgQAb0oMYaqPcXC1rj+CIOUpZ7CKoq0sSlRPHBdQpDuyWEf6x
        FLI52nzWtpm5JeFFvTnU9EIKk39P
X-Google-Smtp-Source: APXvYqw8ljv9JE3y7LZUdCo5NfX8TYCwhyuntYEgnrnwOAQXz0HIV3btvzcTz/ajttN++cyoXdT6vw==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr1075882otk.23.1582760119876;
        Wed, 26 Feb 2020 15:35:19 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 15sm1331058ois.20.2020.02.26.15.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:35:19 -0800 (PST)
Subject: Re: [PATCH v11 9/9] nvmet-configfs: Introduce passthru configfs
 interface
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-10-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <81000b3d-016f-9370-081f-d9c4cc4019ef@grimberg.me>
Date:   Wed, 26 Feb 2020 15:35:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
