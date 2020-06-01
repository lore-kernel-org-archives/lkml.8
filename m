Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B879C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D1A2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dzBNYx4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFAG4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFAG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:56:15 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98439C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:56:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r67so8157766oih.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0w2t/wWI/QCxHDpPI+UeXRtbBNz0ZaPFoJMjmCS4xg=;
        b=dzBNYx4KCtzHAwRMHhOThlU8e8bl8Vl7O/mEp8KdVvjoVCnyIDpRRRD0O26JjbJFaq
         8WGjYJTIH7/RWF2mGT4ch5wCbDteVB0FA5dgOfEYBbmdN/WK8FCP21cjwTQdR2B5HuOt
         UoDT3HHD8Y/MxaVjvxaZpewq5hja1+xMeHfpY8ggG41CzMzqzJVTva6QxXibeVUXQ2hF
         1ZVZRkos+sN++v9xqPcQ00oKD7rbQjA6f8wajllZoZbHOnrkw47Bk0/2EQj1/4VfA1yc
         ZhIpRoTnP2NUzGt9dws+sPcMg2KBIXhvZAp10ASou5gwuqheK2Xb+G4/wfW7aNKNgRN1
         sD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0w2t/wWI/QCxHDpPI+UeXRtbBNz0ZaPFoJMjmCS4xg=;
        b=a8bCMz+Cyi1/PUme/L9m9R27Tke/qrT5iqW9O2f39UNSmMUrpCpqx0AN4vLbgZQQOs
         85qAwdX/X30wsE6eAqXNNmPiimHr998wKSS3SYIlYjvSvIhkBo0BvWZnY+weq9I2ajid
         snGN+tt6PByWwhHOvCVg0Cu19vpCnDAGDy7+1oPZH9DMZGgfg3uBDigeps89gVfFGv9+
         7NW/QLi9gqwlsuDfcLSqOO8MdBwknSaKn/f7A/BfoarDQIADW8qKRiLjLMQ3XkZwm27x
         YFrs2w2KJfoWs/SkZpbjg1t+lyeDrN6wPIgbHQ9WCcs5puRwGZOLw5EhmIBi/UNpWu5r
         m9+Q==
X-Gm-Message-State: AOAM532i6YfQjUVrQVB2DRM3DMGnqVNydH61nd8sYpzXKj4YfUTXlNme
        E59aDopizXEIcSrRd0eiN+LG1gXQEo6WR2NrVuLZAQ==
X-Google-Smtp-Source: ABdhPJyqNACpXYqQkXsHVCY4LqRtj+EL8+2VHnMYc6kVnONhIWLNdbyrmtKRxDEbtjf0LYCIg5vFhJcOZ9TqHDEet18=
X-Received: by 2002:aca:fccf:: with SMTP id a198mr2563302oii.91.1590994574891;
 Sun, 31 May 2020 23:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <7acb6dcf9975bbf3aff4be3b01320fd1b5ba30c1.1590983619.git.zong.li@sifive.com>
 <87ftbfqo2q.fsf@linux-m68k.org>
In-Reply-To: <87ftbfqo2q.fsf@linux-m68k.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 1 Jun 2020 14:56:05 +0800
Message-ID: <CANXhq0q-bZa2Y7T_JUQ5o97zOXyy735tub2r-SnN2Y=joyVW7w@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix build warning of missing prototypes
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 2:48 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jun 01 2020, Zong Li wrote:
>
> > Add the missing header in file, it was losed in original implementation.
>
> s/losed/lost/
>
> Andreas.

Thanks for correcting, let me modify it in the next version.

> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
