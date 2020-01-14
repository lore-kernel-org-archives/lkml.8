Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C357C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0124656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nMUjESMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgANWzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:55:15 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45949 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANWzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:55:14 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so15711961ioi.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 14:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Sf9mie0Pz934kmh4EmyF4Fmp91t8y8zzkblqm9jbhoM=;
        b=nMUjESMW4hf0JSEUW7WoDc/wRMRIYxfCCqEAV6LYnnOW2/D78908KeuZHoRr5gL7xJ
         68a8fmTrh1hvunWKfpG5JS407uh2Ea8s8juPCXbxuMVYeLzc3tLWjJSxaDPttOfNuafM
         ac1wgJAm4g6dP3agcZb2RL8vuQLqcBPrbm3zKvTeH2nH0Dj8/1IsFoYE7+ukAbEl4y3x
         ihXxvstnhpmHr4hbgSryr2MtQSDI/aGQJyLhcJoFt8YyDErSCpXdlzDdMG6v5h4OzfOu
         Sa/r+tYMRvKxkUh3Gxc57g7YnAp/3cJtdtBPI97/0pLipUJ2o/LUGw6ww4DSUrQVSmgY
         Au4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Sf9mie0Pz934kmh4EmyF4Fmp91t8y8zzkblqm9jbhoM=;
        b=EvXK1YpGf2jW41dmpiVIlQjgt8KZr0s3F5yXDzwt+aUmZyuryr1oLx+siO9rj/wgJ0
         CTCxLA42Ja6YU14aWRrPc5d2v09FIXjfyy+8QlGitqz8cZZLf/gHn0gnTY6fOHmKaUf5
         0jrPXN81pWkxGvotiyYGzLSbuGArCg3I2g+D5AcReINWtF73Ry6wZcqx2eMfk5R84sk5
         oedVnbF70PZsLZOddvo+WzT6oSH8mQ3UTqRChnXtO3dB7tpRaT2znOhKq6k3im/nDUEf
         7yKl7M8x7YbKZcEZ26x2SfPQ2yOpDEBLOZ0zORASMXxj6DtNCbtCvTJfC0mBZ29UcDou
         zJJg==
X-Gm-Message-State: APjAAAXRDqoSC3/Ef9jzWDnaTzW4Cdq2tRxfSjEDT/i9ujeDl4GL0srL
        Qj5610DZV+UeAYqnM5C46w1v3g==
X-Google-Smtp-Source: APXvYqz8djSH1ntG8s3wT163J3moUwwfYppKnhWa0LzYyjUzA4PFzcv9GCKm1p3MIafWF+BoL3+Kag==
X-Received: by 2002:a5d:8c8d:: with SMTP id g13mr17945399ion.65.1579042513968;
        Tue, 14 Jan 2020 14:55:13 -0800 (PST)
Received: from localhost (75-161-100-226.albq.qwest.net. [75.161.100.226])
        by smtp.gmail.com with ESMTPSA id u20sm2535276iom.27.2020.01.14.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 14:55:13 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:55:12 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <greentime.hu@sifive.com>
cc:     Gt <green.hu@gmail.com>, greentime@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v3] riscv: make sure the cores stay looping in
 .Lsecondary_park
In-Reply-To: <CAHCEehKchrwd7TTmSrhtEPeCmkrYrx7TX_c6ogpCpSkCKnBQoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.2001141449500.21279@viisi.sifive.com>
References: <20200109031516.29639-1-greentime.hu@sifive.com> <alpine.DEB.2.21.9999.2001091126480.135239@viisi.sifive.com> <alpine.DEB.2.21.9999.2001121011100.160130@viisi.sifive.com> <CAHCEehKchrwd7TTmSrhtEPeCmkrYrx7TX_c6ogpCpSkCKnBQoQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

On Tue, 14 Jan 2020, Greentime Hu wrote:

> I think it is because the sections are too far for bqeu to jump and
> the config I used just small enough for it to jump so I didn't see
> this bug. Sorry about that.

No problem.

> I tried this fix to boot in Unleashed board.
> 
>  #ifdef CONFIG_SMP
>         li t0, CONFIG_NR_CPUS
> -       bgeu a0, t0, .Lsecondary_park
> +       blt a0, t0, .Lgood_cores
> +       tail .Lsecondary_park
> +.Lgood_cores:
>  #endif

Looks reasonable to me.  Care to update and repost the patch?


- Paul
