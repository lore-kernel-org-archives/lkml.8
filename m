Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBCC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DCC20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0ol5jS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgGWOeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgGWOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:34:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CAC0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:34:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so5182060wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kcqSFG3PZo/UmJ0bcT4TKemDKca3FfDpYWmqtwN5O6Y=;
        b=O0ol5jS6RjSrVoy1krIq2puUU3bM6YnORPdOjg6oRctJaAo0qeFkeEa0DAB0+6lNZt
         D/pv8cWPuoVGiMepm5YWOYf6vJ3IJ0Rx7uCD3I6Xx7ZZcO5dba/FU4i+AtVesgCFXHtU
         XouaNHnN7QkmWfaA1cqpHrJgzcBf3wE12lGni4sIdrz+b04Ooup6OXvgjBHhEzy5cRvD
         VUbncuhPdoeFml3KmjuFHH0XRWLVBqWRhV8NYbDAy22NGwjvlrlRSeK/m2ANwc+iy8Et
         ws9ngZxWZUMU/q2/XBOCg7J+COsgjJvmyxc1P8xBMyYJnAYj2ejUe1O4DO+sxNNxyUXg
         i8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kcqSFG3PZo/UmJ0bcT4TKemDKca3FfDpYWmqtwN5O6Y=;
        b=LktVBvgmDWdb72wMCLNtvq2icL9Zhy7kk4yrDybPMYbAPk6/hIDEWX7crEyY53ijU1
         WTDiwKNijNksEWPfbqJj+BcbB21hFxTSysbTr81i8y+hujBoIbNYsz4Q4G3dYwD9t2fk
         RR9lIH+zc920RAXY6xItspgzJd5BAcKCoeed4YEJlN5g9lCAtCS7VzclQP/r9DBkSbpb
         EKE6Us5Q82hzAPI5sGyH6z8fwJkzxw6THxdrh4KZEV9G3z1ajhseP6wmShFyXjcqeMYs
         ZDsmiTgIUDULl7JoH8u/E3NF3PczaAgMIv/3YrBRYQOtGqrBE8EsdFl0LBCDgRuW7DKz
         uHoA==
X-Gm-Message-State: AOAM5327wwPq7YQmRbEjzE/bh039lrg53dQfwklnQ4tTYkMDxQa1NA5w
        Jzu2CFvqIwR7tFjbceJr5kcJ3Q==
X-Google-Smtp-Source: ABdhPJwghOiyUKMQjbCRRwM97akzde6uqm+99J0U4w+8JSZg9XFrx+PSopfmQeT7hmLALhoXOfiahA==
X-Received: by 2002:a1c:5ac3:: with SMTP id o186mr4353780wmb.39.1595514848856;
        Thu, 23 Jul 2020 07:34:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:dca7:8d30:33fa:daac? ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.googlemail.com with ESMTPSA id b8sm3980634wrv.4.2020.07.23.07.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 07:34:08 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] clocksource/drivers: Add CLINT timer driver
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Emil Renner Berhing <kernel@esmil.dk>
References: <20200723142409.47057-1-anup.patel@wdc.com>
 <20200723142409.47057-3-anup.patel@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d6cf82bd-70ad-19e9-36ef-35c9db92fa56@linaro.org>
Date:   Thu, 23 Jul 2020 16:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723142409.47057-3-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2020 16:24, Anup Patel wrote:
> We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
> RISC-V NoMMU kernel).
> 
> The CLINT MMIO device provides three things:
> 1. 64bit free running counter register
> 2. 64bit per-CPU time compare registers
> 3. 32bit per-CPU inter-processor interrupt registers
> 
> Unlike other timer devices, CLINT provides IPI registers along with
> timer registers. To use CLINT IPI registers, the CLINT timer driver
> provides IPI related callbacks to arch/riscv.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
