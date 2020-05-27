Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80682C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60329207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BprYPSq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgE0HjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbgE0HjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:39:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246CC061A0F;
        Wed, 27 May 2020 00:39:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 131so3092746pfv.13;
        Wed, 27 May 2020 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdoj3JJ/5JLP5p3ePdNfRX52Ttc8j3sVsRMMvrMaTIk=;
        b=BprYPSq9xmBhWjDRNElxaRFVWEShMqprHmjjyIJrc8N16XlAsGIYyRv1JNKiSJByYu
         gr8cQIRLs4rPFhAHqM+2yM0XG8L5aBrpralWp8waDBcl2/VPKkjIfH2MmfrJQeKaUsDL
         RaSaVdNrS6S4X/0LjJ4X7FgFLF+xAl5+kuPgADYYa5hJmX78g0WSKnHFtTZd9UFAl1Ob
         26zqAe/5MWJZx+do4gXxWW57nucincSqxItcfQHPcRqS9GiWgbcr4D8g1dbkaoj7QEpf
         2aOmbIxI5545n1M+2iPPP+HwcIpHvU3IpcMFK1mEHq4NlXLj62cmvZRua8ZdBTxaw2vE
         BDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdoj3JJ/5JLP5p3ePdNfRX52Ttc8j3sVsRMMvrMaTIk=;
        b=q1bcxNlbxpI+6odyyyM4Vdf+yTW9XSeyZqHnK8szQpZQOIZG7uBD+K+ZXhJRLBMQmw
         r0e6Niva67tmGpwrvsr9gU4mM3OVBO418jwMQ7z5sB79dKKOZQqIeglCjsxYYG+hHCmw
         PjY2PI5W5H5qIeKwOG3hHfGngY7/knaK0E3RQhasl0rSxBDiYcmWrL+xVinsllogPvvK
         NeiJVwx08K7z3GjxGNX3X0QjBcko2EJB2CIxu29n4t4yRaWa3iuLJNMbvshacT8mwrbh
         eKS1WFOdYk3PR16Njh6297Jz3ip5TMLWoxwCyZ5DEE/DFqx/YHKjPl8emXzBVMgR0cTy
         YuRQ==
X-Gm-Message-State: AOAM533yvFlCS3JSN/d6fS3jB1mbUcltWEKMBlvZWim5p5Czjub2FPHr
        SHcUlP0SlaHyoGNLXANPUHw9fCwPDVc=
X-Google-Smtp-Source: ABdhPJwSOdP6lQD3E0LVW8K1PBoseWJJB+8I8vF1L4waxiipBMMFPGYt2JnXNkOo/mfbVqMNMS/Xsw==
X-Received: by 2002:a65:49c8:: with SMTP id t8mr2827098pgs.335.1590565153244;
        Wed, 27 May 2020 00:39:13 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:286d:5436:cc18:dcda? ([2404:7a87:83e0:f800:286d:5436:cc18:dcda])
        by smtp.gmail.com with ESMTPSA id o18sm1478897pjp.4.2020.05.27.00.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 00:39:12 -0700 (PDT)
Subject: Re: [PATCH 4/4] exfat: standardize checksum calculation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200525115052.19243-1-kohada.t2@gmail.com>
 <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
 <20200525115052.19243-4-kohada.t2@gmail.com>
 <00d301d6332f$d4a52300$7def6900$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com>
Date:   Wed, 27 May 2020 16:39:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <00d301d6332f$d4a52300$7def6900$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment.

> I can not apply this patch to exfat dev tree. Could you please check it ?
> patching file fs/exfat/dir.c
> Hunk #1 succeeded at 491 (offset -5 lines).
> Hunk #2 succeeded at 500 (offset -5 lines).
> Hunk #3 succeeded at 508 (offset -5 lines).
> Hunk #4 FAILED at 600.
> Hunk #5 succeeded at 1000 (offset -47 lines).
> 1 out of 5 hunks FAILED -- saving rejects to file fs/exfat/dir.c.rej
> patching file fs/exfat/exfat_fs.h
> Hunk #1 succeeded at 137 (offset -2 lines).
> Hunk #2 succeeded at 512 (offset -3 lines).
> patching file fs/exfat/misc.c
> patching file fs/exfat/nls.c

II tried applying patch to dev-tree (4c4dbb6ad8e8).
-The .patch file I sent
-mbox file downloaded from archive
But I can't reproduce the error. (Both succeed)
How do you reproduce the error?

BR
