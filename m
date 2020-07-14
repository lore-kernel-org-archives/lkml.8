Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BADEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC0222224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgGNLzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:55:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46045 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGNLzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:55:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id s16so11240104lfp.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSrABorvrDzSA3D02QxdjN1XVE24+Jlv3WcRHgwThLc=;
        b=Ok4uBkgPJP6S2pn/6Ausmhs5Ernhyc2AkxNAB3lfhSRb4RPo4pphiRYwdFW2AVDt3z
         XJO92ar0RzZdX652hF+2oRLqxcQM6iSJtenT2n6VSnAQFCQSaSlpO6RWYkw7rg7Coods
         8YmZHxjgqQSppRaJp31J7je+YjnEThkZdHi9p034GWVU31BqDe4oSsh9+a7PYxIiXXMs
         jI7y/DEKOsuALE655g/v/zwZK87rwDZDhsKKQ51P1o8SgzW9eWUdoTI73UKyIzUTDoI3
         FbrR+GNdMrUgfK2/PWzFRYgczEbLlAcWlmas3VnLMQY5qSApiQp+imnvipmRHvIGFemx
         YuoQ==
X-Gm-Message-State: AOAM531eZkWykSD51ygsctoCA3LmZItv7bdvDnN2ibKH3XZ+nJeBzpXw
        Ih47DAM0inJFdHcD4XVnFu39og4cDQc=
X-Google-Smtp-Source: ABdhPJzom7xBiRFyek2ByJURbVVv9yQ7kjX108x9GkaZ2LsxgfECYiMRXiW7HIFSGUXzCoYP7IxUng==
X-Received: by 2002:ac2:5593:: with SMTP id v19mr1999623lfg.43.1594727709309;
        Tue, 14 Jul 2020 04:55:09 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id i2sm4603595ljn.109.2020.07.14.04.55.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 04:55:08 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q7so22225572ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:55:08 -0700 (PDT)
X-Received: by 2002:a2e:958f:: with SMTP id w15mr2098178ljh.190.1594727708768;
 Tue, 14 Jul 2020 04:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594708863.git.frank@allwinnertech.com> <bd2b5ba093adba25dc1321cbdfb1532af7bd6047.1594708864.git.frank@allwinnertech.com>
In-Reply-To: <bd2b5ba093adba25dc1321cbdfb1532af7bd6047.1594708864.git.frank@allwinnertech.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 14 Jul 2020 19:54:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v64e+jEnf98fQowusPKVaVAz=QL5k1K6aoAGsOT7_sx73A@mail.gmail.com>
Message-ID: <CAGb2v64e+jEnf98fQowusPKVaVAz=QL5k1K6aoAGsOT7_sx73A@mail.gmail.com>
Subject: Re: [PATCH v4 10/16] mfd: axp20x: Allow the AXP803 to be probed by I2C
To:     Frank Lee <frank@allwinnertech.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        =?UTF-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 5:45 PM Frank Lee <frank@allwinnertech.com> wrote:
>
> From: Yangtao Li <frank@allwinnertech.com>
>
> The AXP803 can be used both using the RSB proprietary bus, or a more
> traditional I2C bus.
>
> Let's add that possibility.
>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
