Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5475C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0D2214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WFSsG2/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbgALSM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 13:12:26 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45547 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 13:12:25 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so5955276iln.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=e3CTVqfwVB8ZiU/Nlsteqsk0IzbNSugwDXW2au/cyRw=;
        b=WFSsG2/yf3wle5KTOl/qmjFIRIKTF5AF+9fGE9V+3GLXs8NGX7DQK4xKIVd7dLtMFF
         9HahEOH1PIQ433mvns+NP4lp5Cl05pA55L4575fITfrFfeV+Wm7ATvqdiwXBf8r62MTK
         wkMDKIgnMd4HpRqGrGJPuHo2oFJJ7ao0M5VN+t7t8pOV8GE4pU7W1JEt55JnXO3uGyrS
         YnUNzarWKyVsY636bzkmd9/cOKf2HJPhBg7sQbEeQF/OrhReJFVX1wnOcqpXpSsPtgaa
         bUDDUxxxh/t1/7fQKvstNqtJbTw4P8fLT4RiRlIuv3H+gfCzFl7j4A9Cun/u8DlYYaMw
         +WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=e3CTVqfwVB8ZiU/Nlsteqsk0IzbNSugwDXW2au/cyRw=;
        b=RtiwrQXdKs4k8YEKgEgIvZb4d4PpDgBp4awv9piVsPGOurA/YV7bZEFMkrp2lu9y6Z
         FRUwClviee8MNn7HGGo0UKgxMTYV4D62GndQ61Gx7Gld8wv3rxKDhLTCPUZ1hgjHATXl
         bjH2xjlwm/INgECHRM3T1of9Sl86xZA2RE4+aQwDqoRfjLrLsTUFlPdEMKVPzd5sLgtd
         OMwWLLuQl3Cii2lmr1O1fwFCIqDJMBqhRa2TpbsXnvJ6yvzFVT45gDY+dWqvY0xeBlDJ
         hmDOQD8dOerqz7DlXQXSHuZtiLItCnbIkz8UBXodYJa/tqq8Mz2SOZ/sx7q/8p4z3A66
         0Ucw==
X-Gm-Message-State: APjAAAXr222BLgPZlMMcjUuYhuw9PSn0xPuHB5eArZ9euWO/cuosQeQZ
        2B6EVQ5hMyOLQ3/ixIy/gHsUzQ==
X-Google-Smtp-Source: APXvYqx9xtCFFybB8/4h3gLqXwDMu4zv4xw5vqc48ZNym/BcQuFJaDGJ7EuiIDNzweQ8PjnWqsJjOQ==
X-Received: by 2002:a05:6e02:d05:: with SMTP id g5mr11426851ilj.272.1578852744782;
        Sun, 12 Jan 2020 10:12:24 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id a3sm2146879iot.87.2020.01.12.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 10:12:24 -0800 (PST)
Date:   Sun, 12 Jan 2020 10:12:21 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <greentime.hu@sifive.com>
cc:     green.hu@gmail.com, greentime@kernel.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        schwab@suse.de, anup@brainfault.org
Subject: Re: [PATCH v3] riscv: make sure the cores stay looping in
 .Lsecondary_park
In-Reply-To: <alpine.DEB.2.21.9999.2001091126480.135239@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001121011100.160130@viisi.sifive.com>
References: <20200109031516.29639-1-greentime.hu@sifive.com> <alpine.DEB.2.21.9999.2001091126480.135239@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

On Thu, 9 Jan 2020, Paul Walmsley wrote:

> On Thu, 9 Jan 2020, Greentime Hu wrote:
> 
> > The code in secondary_park is currently placed in the .init section.  The
> > kernel reclaims and clears this code when it finishes booting.  That
> > causes the cores parked in it to go to somewhere unpredictable, so we
> > move this function out of init to make sure the cores stay looping there.
> > 
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> 
> Thanks, the following is what's been queued for v5.5-rc.

During final testing, when building the kernel with an initramfs, I hit 
the following linker error:

  LD      .tmp_vmlinux1
arch/riscv/kernel/head.o: in function `.L0 ':(.init.text+0x5c): relocation truncated to fit: R_RISCV_JAL against `.Lsecondary_park'
make[1]: *** [Makefile:1079: vmlinux] Error 1
make: *** [Makefile:326: __build_one_by_one] Error 2

Could you take a look at this?


thanks,

- Paul
