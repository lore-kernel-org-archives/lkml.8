Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC14C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5EA2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="NKQVLMLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgDULq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgDULq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:46:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA484C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:46:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so8163348ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+H9os75cIo4KHTrHVk8LMtdC9lnVa9Alpi6f3QpAfg=;
        b=NKQVLMLCfLf1tnVQ/SkrUSgZmpkmJLntDQgHa3XQmJNgd38Ila3CM7WovB8nRFqKyv
         9VYxQ63+odAnzCgrDHHCMhe0RYb+g0lT+YZ/CooSujIRfc+tvSyrZ/ooJSmCeXP5rovS
         /NSKdA1bsJurtOR8JqI4ZCQiswLMdaIjKrN8VGn+J3dZLU9ULqnOdLaViZ2jwcHqmNxa
         Woty4SKmvoALvdi7MVJTYT3ksx++UggI0wGzHc8YM6tRYoU1KQpJIbRh202XJFn04bFX
         spJVzeKThRJnA7UdAuYdJMB7sQdPJrlUXy5VJuWF4/lyCCaO3HGVV6+P5CVVTEFjVUiE
         Z3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+H9os75cIo4KHTrHVk8LMtdC9lnVa9Alpi6f3QpAfg=;
        b=JxpA85pthxipZ8JS/X/TJmC3WN7nGOoX7t58C16oJKq9luG/6AmQE0P3Z7qn5mCuoT
         oHjau5VvKH6xQ5LMv7LsFEx2psGpUEvpO1GfXjuJMdDlv5hq0V5gmZVmxhXJiN168B09
         VCYVr94Xv3dUwUjyvQGgqBxwg9RWTVeSyOTOXOuH2u+GhI5reflxF6C2zhgpET2t2ZTO
         ikWX0PvPaA9pBJIuV3U0hLfse9jcsyLW8sb5sCeFYfBrc18dEukJVlW67mo8UGmbB7cw
         BcK8CduxU3jSd5/m2NM8y/uvkrIc8gPGC4zAd3o1KATHMxM1OYFJXvOCK9LqMDWir1F7
         Ah7g==
X-Gm-Message-State: AGi0Pub0cImR7heTn3Ztke1GdoUnIuWkihJd9yj9+6goKFBpqpE2PRca
        QtogrxFtP5HKJZx0wiToFleo+O+SyoDLx+fWONbotg==
X-Google-Smtp-Source: APiQypLgsnJow2mpiivOAayYhtuUEJT1TmUYjjrfGeaQB2ofILE7UEw7yn2rngCib3Z1WguRRmyvG7q1r8qOwWU+hRc=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr7288847ljj.273.1587469615222;
 Tue, 21 Apr 2020 04:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-3-maco@android.com>
 <888a008e-bfa0-6323-413b-5c4bf2485726@acm.org>
In-Reply-To: <888a008e-bfa0-6323-413b-5c4bf2485726@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 21 Apr 2020 13:46:44 +0200
Message-ID: <CAB0TPYEPMx4+507ENX5ErTFprJvV3_B6u9TWUSNd9BDhCVT70A@mail.gmail.com>
Subject: Re: [PATCH 2/4] loop: Factor out configuring loop from status.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> An additional question: since this function sets the status of 'lo'
> based on the information in 'info', would "loop_set_status" or
> "loop_set_status_from_info" be a better name for this function?

Yeah, I like the latter. I will rename, and add a comment that
explains the purpose more clearly.

Thanks,
Martijn

>
> Thanks,
>
> Bart.
