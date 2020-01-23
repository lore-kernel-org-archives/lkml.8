Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D27C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2321D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="gW3y/RVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAWT0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:26:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39084 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgAWT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:26:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so4503341eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqIW6P3nd0U6+Dsb/HPJR6jYzvPosfZF53uQ6BthKN4=;
        b=gW3y/RVj2biVs5qjZRGGCVdyKyYY5PkgEb4/NzAl2uLh5e5wBRP2O/SVVaH2DzteAs
         QGluUfOAUEKlrymgGFQgmLZH3RPKauzPaxKKz6mgDyIWqG8c63VnJgBPMmYcPZQFti+3
         lH/P4AQhTWU3tEZbuNDs/vGZNtzVd/ySMEEjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqIW6P3nd0U6+Dsb/HPJR6jYzvPosfZF53uQ6BthKN4=;
        b=noraJgGiNZEhyHTJJHzjiaaM5B7TzJjH/7FMQA56DWcjqtf67EUPM7JKVfcW41G/BC
         3AJOtTX/cjaQysD9y4HjkCr+qn8Q5fDAjJfCTu5FW1sfs7f2kJ6cddgKbwn/TtE1fK4F
         425UgF1LhxjNeef9Hm+UmNvurD4zRJJ6bapv46tJnFNg3iYGkDukpOwj8Ty28OLdKXqL
         mP/LDSyr6rNMo1yrYqiKK9wMfCs6soUCumNqDBVUiJyWB3GGA4dDRCDVxUJBbcW1nZJg
         1qQfEDFMDZP4DlwJwq2BZq/U6Oop5SdFhlwCVjPRWCl2JgzDPN8u+SVUSl6tQV2rOroO
         84Ng==
X-Gm-Message-State: APjAAAWaMwGLOMzVtnEaFBdS2b9tdeIP+SKvWxHwwuG//RctIMbfw3tt
        5ndTxI7YHid9ERNXnlFqd+5/nP6cVQxMm3jWpyXNR3I1IQ==
X-Google-Smtp-Source: APXvYqy+5EK2XIUhq5ABCc8/NNvWj4YsDl2Uf+JrOq/5DntqE4eTNmBm/zoLhcikAJl04M2I98zGqF09GRSNg/PNHf4=
X-Received: by 2002:a50:bae1:: with SMTP id x88mr8266708ede.10.1579807568083;
 Thu, 23 Jan 2020 11:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com> <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
In-Reply-To: <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
From:   Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Date:   Thu, 23 Jan 2020 11:25:57 -0800
Message-ID: <CAByjrT9=pZGOwDFnJQ60aG-EznV2QK+DQT3a1NEDJr3RU0K_Gw@mail.gmail.com>
Subject: Re: [PATCH] Adding multiple workers to the loop device.
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see that the kernel is already is using the multi queues with the
number of hardware queues is 1. But the problem IMO is that the worker
seems to be processing 1 request at a time, to parallelize requests
and have more concurrency more workers needs to be added. I also tried
increasing the nr_hw_queues without increasing the number of workers,
I did not see any difference in performance and it stayed the same. It
allows to queue more requests but it is processed one at a time. I
have not tried with enabling BLK_MQ_F_BLOCKING though. I see that it
can schedule requests early.

On Thu, Jan 23, 2020 at 10:59 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
> > Current loop device implementation has a single kthread worker and
> > drains one request at a time to completion. If the underneath device is
> > slow then this reduces the concurrency significantly. To help in these
> > cases, adding multiple loop workers increases the concurrency. Also to
> > retain the old behaviour the default number of loop workers is 1 and can
> > be tuned via the ioctl.
>
> Have you considered using blk-mq for this? Right now loop just does
> some basic checks and then queues for a thread. If you bump nr_hw_queues
> up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
> tag flags, then that might be a more viable approach for handling this.
>
> --
> Jens Axboe
>
