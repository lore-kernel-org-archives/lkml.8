Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4CCC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B3F2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbRweIMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgEELk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728737AbgEELkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:40:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82DBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:40:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so2341163wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zw8AGAHFXGrv2iacmWJVrfWvZyG12y22YZaRvl3DEfA=;
        b=PbRweIMky5ZkEGXsQqcS5VVBKvjdLKoF8NN6LUtUo0feNkVWNzQuUOP5PfSeNqV7gT
         kbvVbm8O+vdW5duJm/STuZRMkIMNbwmfX2jKC+yDQzEuoQJ4BUC2IG98/RQmxlTJeo2r
         fPHppnLpZ6vuzLtSAqWylv3JHkvCuRMmQfevQDwjFf0AZTVy+9HXcYDhNTx2ujb8G6r5
         H6Im1v94r3puCJFVDfWkYbQHn1SwK9bZzaTWZgun5/zYcI1qw/fPeQmHFuOlRAI7VMQ2
         sD0JBD/IaldKNgfmuS1Qzbo5inQpZakELaG9LsLWYPKN9Eaa6uA4QTbwIEF1HSmA5wUG
         tQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zw8AGAHFXGrv2iacmWJVrfWvZyG12y22YZaRvl3DEfA=;
        b=gEKrl1wiwhJt5bU/K7BunPC4xarlYcELheUFw9PF5Ex4aWy56Qz5VsDxZZaC+TG4hc
         QCEgMQkgqMxzxpaEe41951BPfGWy5miQ5AgshCHr7LEHL6jno8bqyCFgPgogn0aK6P4K
         UUsGZohfcGwyPfBP0J7HifA6Z6fja1eP/l5BlpoSWpCp8CihESIgT3CdxHfryH4T/Vdg
         nqXAj1UsOR621kaoBXnW80cNBZZRojThllDycyrqyfFotfrzRzk8n1BwOePYjv5WjCdV
         WYawiN7/zVBhrR6jFAkWYXqtxxXah+xe7gRCn9q6VH74BC7kUANUkvE8P+gI+nHAbUft
         9PpA==
X-Gm-Message-State: AGi0PubsWMckDEUwXPrmvFwnr0yPWPFoldVoNUqz66Dy6zjmAMXdF7EL
        KHh/v+Jhfm4raix7GYbM9Qi0zZbLrbatTw==
X-Google-Smtp-Source: APiQypI0HqhUGc3uoEMdVOIh5K+2MJBbCn7ght4cbnf28YDmBZyywJZ1Sw8z06C+sb1meRqW7pVeXg==
X-Received: by 2002:a5d:4092:: with SMTP id o18mr3239554wrp.227.1588678853373;
        Tue, 05 May 2020 04:40:53 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-166.ip.btc-net.bg. [212.5.158.166])
        by smtp.googlemail.com with ESMTPSA id e2sm2729863wrv.89.2020.05.05.04.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 04:40:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add support for venus on msm8939
To:     Konrad Dybcio <konradybcio@gmail.com>, skrzynka@konradybcio.pl
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200501203505.144362-1-konradybcio@gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <1bd1e0ea-0be3-340c-9c2a-0e7a03017cc4@linaro.org>
Date:   Tue, 5 May 2020 14:40:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501203505.144362-1-konradybcio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for the patches!

Could you describe hear what is the status of the new added SoC. Is
Venus driver tested on this new platform or that will happen at some
later point in time.

Also, in both patches the description is missing, please add something.

On 5/1/20 11:35 PM, Konrad Dybcio wrote:
> Konrad Dybcio (2):
>   media: venus: Add support for MSM8939
>   dt-bindings: media: Document MSM8939 Venus
> 
>  .../bindings/media/qcom,msm8939-venus.yaml    | 119 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/core.c      |  33 +++++
>  2 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8939-venus.yaml
> 

-- 
regards,
Stan
