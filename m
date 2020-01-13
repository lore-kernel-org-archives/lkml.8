Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB605C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC8F207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSa0JUdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAMMGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:06:09 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40261 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:06:09 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so9488566iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CZK7dKMZNH+opiefMkjMH6OKZgUdNCuAi9u4ncS4wdg=;
        b=kSa0JUdd3YnKxBRGqACx+Ne5dK/rMCJJkhZf559JIGUykLgOXhxeAww20f30yj00Bn
         aaCPzWBAaATN96iT3JLBrb8Q8+wA4cuzEY752aDWIytReQhqduCxfgLL3VAs1+690vzV
         v3jTZZBJerV+wMtuWDit2M8Oiy2RXQwgZTMdAE+TzwGdKynmfmeZaEURJK4y/RCfZfhy
         TFM+OwRecfareeXROEWfq1q0F7cs/L7lGW6/p1bTcdObTHB6Fvn0FjrHzr0euJwZ/arJ
         +rl5bOvHrMYriqBi4kmvdcn7nmJVmL0smYFQlMZ3P6z714BgO5wPlVS48N3mzgok5/Mi
         HuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CZK7dKMZNH+opiefMkjMH6OKZgUdNCuAi9u4ncS4wdg=;
        b=CZTSA2EEEwujjqd6PAVACKFfA8b9k8c4RqQIRF32scoF7hMKBaVCc4XXbf+riYLqbs
         KGbTQqd7GYxBB9JaSTKTar/6Q7zxDbZ4ZF5UKPwBvxBNqQur0Ekvle/jrW/1d2UdoV7q
         W44ZbUk8OSoc4r8CIrAPvn7ufJjkg1/shbDwPzO2/YN5aLprRtVaodg8tLC3zfYe+OmZ
         pYsYIORkNjXXrZj49BknNmrUKKjAe29rZhpfDUbdwAfuOQbO+I9HXgfnUOnb3RTBTMui
         J2VuxNPSkJFzGnlMXxn1EsPpvxQwchkSlbsw6yVGjqYUha0Q/Z3+pqtGYcsfRG1LG3zN
         xsgw==
X-Gm-Message-State: APjAAAXfM5YfXLsiLusH0CVDw722fwpJ3K7+7T0MdAgm5ZMojdW46+Ff
        Sw7Qm633ZkqnDxHvM/nLbAr3HFEUHQvslChLptd6MA==
X-Google-Smtp-Source: APXvYqyv0BV7Oc5zyIS8CA5WnrzdTPGhbYbpOIMjm/w4RLq5BoeVmpILQ0dErwSOcrPrx8FusRqpyrwOSancPdZoveA=
X-Received: by 2002:a6b:700e:: with SMTP id l14mr12995432ioc.170.1578917168494;
 Mon, 13 Jan 2020 04:06:08 -0800 (PST)
MIME-Version: 1.0
References: <CAFZWReakYoDcSgEXw-d-SPAzum=fw=uLo7sh8OMqZV6FjP1ymA@mail.gmail.com>
In-Reply-To: <CAFZWReakYoDcSgEXw-d-SPAzum=fw=uLo7sh8OMqZV6FjP1ymA@mail.gmail.com>
From:   Uday R <opensource.linuz@gmail.com>
Date:   Mon, 13 Jan 2020 17:35:56 +0530
Message-ID: <CAFZWReYF83JPvnqqVPgw88UBwQwJkeDk0wMTAeOdWDe-xoYtzA@mail.gmail.com>
Subject: Re: Issue with Kexec memory allocation
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any help ?

Thanks,
RK

On Mon, Jan 6, 2020 at 12:43 PM Uday R <opensource.linuz@gmail.com> wrote:
>
> Hello folks,
>
> I am using kexec to load into the new kernel from the existing kernel.
> My vmlinuz image size is 6.6MB, initrd size is 18MB, and the root file
> system size is 715MB.  I use kexec command to load the new kernel into
> memory. I observed that before calling kexec if the available memory
> is less than 1.33GB then kexec lands into an out of memory issue
> effectively kexec being killed by OOM-KILLER.  I dont get into out of
> memory issue if i have memory >=1.33GB.
>
> My question is why kexec tries to over allocate memory when the
> available memory is less than 1.33GB and gets the available memory to
> ZERO.
> In case if the available memory is >= 1.33GB before calling kexec,
> After kexec load, i see the memory consumed by kexec load is
> approximately equal to size of "linux+initrd+root file system".
>
> Is there a bug in the 'Kexec' code and had been fixed ?
>
> Note: i am using the kernel from a vendor, Just wanted to know if
> there is no such issue in mainstream code.
>
> Thanks in Advance,
> Uday
