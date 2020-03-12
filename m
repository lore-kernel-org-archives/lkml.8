Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB0BC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86EE20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Cm60S2dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCLOfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:35:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40764 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgCLOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:35:33 -0400
Received: by mail-io1-f65.google.com with SMTP id d8so5878137ion.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Q4FiQLXhjwStZmOYzHQGfmnzPhLI0zvMi+wXTYLHpTk=;
        b=Cm60S2dWe8JeJkat+EMyGodxi2i2wiUkKIZy7EHVeo9mTS15Tpb57ERxbwzulv7UDu
         Ft2N6+TI5UPC344muYxQk4MCjyfeRLvhY7oSpL0I6dgCiHG5zRM8bVVBUXbRzr6a7XpL
         uXzPEzJLYoiwFQETYmhPHWPWdAJbrwsKlc50PlIjqWHbQObsC8M4HZaIisDGUkgvWqHi
         0eQKYdl7KiTGNbUXzcvSDzm8lCwDxFsDzgaSbKVxxvbmY05thnX9YAHQ7iuHq+kb7z5e
         uRDW67gmW9J18Y8PsE6Gc942nGaRbX7XiS6x5T3er7G3cQ3DbWGQ0el3pOSC0JEUNKAJ
         KGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q4FiQLXhjwStZmOYzHQGfmnzPhLI0zvMi+wXTYLHpTk=;
        b=NUdvGXH0y7xnQHSCTR3hq5E5ph9guPDv1N7iSPOK2NcLP3LMhXsNc+oxWhlVM+kvfT
         GBr1vYymfIPyGQ5L2/nO8dyz2FxOSHW/OYMjaXJibbzR0dodxh7dZD2gmQHv6gu5AVNQ
         cQRIv5w+LgngsWCPyARbOIgGjpKsLhum8LJx3YMhRMT/IEWyWs3rMywixC0wlqXk/IEk
         2ByHd4f6a6HXRzcMiUW7ZR6oX3inSbIOghbgjI4A8rq1eigUORX2uJDobAO/5QsNLSjS
         duzuSZE45nL602W6e6t66kvgNU8Udk7l7ef0mczRsFXu7BChvhJig9KFvRP281l56Al6
         9yFw==
X-Gm-Message-State: ANhLgQ3lZHS1kyUH/Ld2RHzLjWh1NLOJzieBTNan5avqj2gxedizWIZv
        1Q88gETNAuTcO2/cvOYErzZv0HRJgw/vfQ==
X-Google-Smtp-Source: ADFU+vslzlUjaqbM05REXlsAewd1RXt/CcCOlTCgp8fwLTiBQ3Vzrnpkj9AMeaqpMuXQBxwXlhuJkQ==
X-Received: by 2002:a6b:7407:: with SMTP id s7mr7988540iog.11.1584023730700;
        Thu, 12 Mar 2020 07:35:30 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x7sm8719674ill.19.2020.03.12.07.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:35:30 -0700 (PDT)
Subject: Re: [PATCH 1/1] io-wq: remove duplicated cancel code
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <883f200570ee22c8081469bd571bec5fb27da4c5.1583531319.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <277bb693-d5ad-b021-7ea9-d935f878215f@kernel.dk>
Date:   Thu, 12 Mar 2020 08:35:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <883f200570ee22c8081469bd571bec5fb27da4c5.1583531319.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 3:15 PM, Pavel Begunkov wrote:
> Deduplicate cancellation parts, as many of them looks the same, as do
> e.g.
> - io_wqe_cancel_cb_work() and io_wqe_cancel_work()
> - io_wq_worker_cancel() and io_work_cancel()

Looks good to me, and passes my initial testing. Applied!

-- 
Jens Axboe

