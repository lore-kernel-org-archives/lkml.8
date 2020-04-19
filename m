Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADADCC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1FF21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmEUSvyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgDSPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDSPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:52:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A6C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:52:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so5794451lfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puq4LGaJLu91tsP0EOV/aht8/LoEw9dhNvgkrrgI0M0=;
        b=kmEUSvyMZy3pWlmfBj6ph9+yTJxIicCoTZ2oHWv22uPHShhrD6dXB3nFdSVSQ9UKIH
         X01wDHoO0o3SD9U8nkBwKk6WZIDmluNtrFFPXTkmLLyEe0f+4uK8ugdiQSG9t2xSurz6
         EXZw5KnLHhgHjIVub6meTCWW44m+827f4GjD4iHMj07dOmVdf7BkblrI5b8Eshm0qOr7
         hZYZ3RK3rdu0rTi3+E/4xotGRwYv6RmXJCNx3AXwKU04DNuHgUoQHVowT99KEA1om/xC
         993dUnXPWRO5bdVcMJNqG+DFM6AjpM51c6yfVVcV5Ef7oe1ujo0nIyFMz/T3Uwz9Q1Hi
         0L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puq4LGaJLu91tsP0EOV/aht8/LoEw9dhNvgkrrgI0M0=;
        b=f0xE7nXQHHBP220TzATULLFM/a8sqWodSxH9f497ZPXuaIFXk7oFzO9uTK9hZoOu3l
         CF1Ll/2XEp92SpKeXl9dYCeLxVPpXxogptTdVdmHgyTA6EerqtjwWqPScOLyw4V70aAD
         tlH6CfEcm8YAKo97EgYWP/PyaZeC0MSQG8koVkg6LN/D/GsABHnW+ECkHnWll+ohPws8
         Pr+5eNVLOg30ZHdER6PjbEI/3Zgnc7kkPpaS0qlT82GgQn3A0/n6P/V+Qw0MSlyvfE75
         9d6C6VZsVmh8sO8dw2bimxB3a3QleM46m9cEdsQ1sEC+BL0Wt1vhqKBMufgr5qU4cUS2
         FVqg==
X-Gm-Message-State: AGi0Pua/AL5ZfqNEw5lacmZgh4xBx895kuXB1LxhT1A5J7JXUGif18iE
        ck8C1pXDODzOOwrTr5cdqHaxYq+kyWVIq2ly8UkbuYSA54/mIEki
X-Google-Smtp-Source: APiQypIxAPipFGPF2SN+XT1jDXJXTJdHsgQn2AhHXb63BfvDD9HsotRIaefG6KlobjMHGAGZARFRi1m53SGunpj7bv4=
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr7642643lfk.192.1587311525570;
 Sun, 19 Apr 2020 08:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200419150530.20508-1-etienne.carriere@linaro.org> <20200419150530.20508-2-etienne.carriere@linaro.org>
In-Reply-To: <20200419150530.20508-2-etienne.carriere@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Sun, 19 Apr 2020 17:51:54 +0200
Message-ID: <CAN5uoS_h1T4hw7zpmqzLjTBN8_16JRgXnWGzVmaZ7ohhV6DfdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] firmware: helper functions for SMCCC v1.0
 invocation conduit
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, Mark Rutland <mark.rutland@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 at 17:05, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> +#define arm_smccc_1_0_invoke(...) ({                                   \
> +               enum arm_smccc_conduit conduit = arm_smccc_1_0_get_conduit(); \
> +               switch (conduit) {                                      \
> +               case SMCCC_CONDUIT_HVC:                                 \
> +                       arm_smccc_hvc(__VA_ARGS__);                     \
> +                       break;                                          \
> +               case SMCCC_CONDUIT_SMC:                                 \
> +                       arm_smccc_smc(__VA_ARGS__);                     \
> +                       break;                                          \
> +               default:                                                \
> +                       __fail_smccc_1_0(__VA_ARGS__);                  \
> +                       conduit = SMCCC_CONDUIT_NONE;                   \
> +               }                                                       \
> +               conduit;                                                \
> +       })

Checkpatch complains here (traces below) but I think this is a false positive
due to the line breaks in the macro definition.

WARNING: Possible switch case/default not preceded by break or
fallthrough comment
#231: FILE: include/linux/arm-smccc.h:415:
+ case SMCCC_CONDUIT_SMC: \

WARNING: Possible switch case/default not preceded by break or
fallthrough comment
#234: FILE: include/linux/arm-smccc.h:418:
+ default: \

Regards,
Etienne
