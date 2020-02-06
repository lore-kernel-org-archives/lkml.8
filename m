Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D5C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB420661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JR6HUENY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgBFCui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:50:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39515 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgBFCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 21:50:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id j15so1957117pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Qegq55lPgC0BXvUu/wXUbnt5DmIBr/mqJPSuK0MffVE=;
        b=JR6HUENYiKJlHLAt10j6UEXGf3D/qSOezkF4iUhK0bzQ9dbse5/E3WSh8ir9qlqpH5
         jf4Fp/+LIvHw1my1Bvn/J9G5j1LJNvxWv4Jke5XorIRuaL1STjelYKuXD0yhKYhM5oBw
         tHwkq0A/2rKVfz50tVXipbh+lZ7Ri8oOl9Gg4orJ7kQoLc8Q1PFB3f8OpZAuA0mCShMT
         UE9cWtY4R0Fhfu/ZX2vkChVRCAIBpQoIBFmVWnp+QpW1ayTn9Cuh/rGcMKf9U8d1JGbB
         uB5+ZCLlmO2IQmLiJgmXQ9s+Y0Yuri2EVVvLxAkjul6eu9kMo6OxsCuIFBVDj7w3x1Uf
         cprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qegq55lPgC0BXvUu/wXUbnt5DmIBr/mqJPSuK0MffVE=;
        b=eKDSWn2C+6L9K0Kc7waRgF4KlK6gHUf8RU/0TIXt817Cb+NBQYLtksPPD7bGjeex1+
         //nKASo9pwVNIIv7Nfp28L3uvTd2noL9tdAgOov3JmNxoBfnTBHYh4DJYLhwYqyxEZjU
         oRL52jBPYHN/YtWFJJHToXIoInNyPmVgNxdCuNGQ3fzoHOrSDcPV1uR8NnCy3XACzvLa
         lT1fQQEHyGRqUgw0GzBSz1KhZpLUJMqh1OvXEOgSP6Ywx+deoMxROPsZCPacA+hodk/O
         XePNBfxcgEXd95gfyMk9NOIwLMuoMzgwNq5IK5bjto7XSUmieX8uoGbck3/Y0QTP57aI
         Pxpw==
X-Gm-Message-State: APjAAAV9+Mtj9y0dF+WFxK+mlfuLPJRh9llmPDFUkf/oh2ryDn1ZZ9Oj
        utNYNzqv61pTmD2dAkYy3/mrfBfFKj0=
X-Google-Smtp-Source: APXvYqzQURvopbf2xHH7Ke3u3nMN5PBZxuBr5Xtzix0A+O1jwajcJtRtzMV8Uay8e5JjI0gkfxmlog==
X-Received: by 2002:a63:6a02:: with SMTP id f2mr1183633pgc.219.1580957436182;
        Wed, 05 Feb 2020 18:50:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v8sm851074pff.151.2020.02.05.18.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 18:50:35 -0800 (PST)
Subject: Re: [PATCH 0/3] io_uring: clean wq path
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1580928112.git.asml.silence@gmail.com>
 <1fdfd8bf-c0cd-04c0-e22e-bc0945ef1734@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c0639c6-78ad-6240-0c18-d3ef8936e2f4@kernel.dk>
Date:   Wed, 5 Feb 2020 19:50:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1fdfd8bf-c0cd-04c0-e22e-bc0945ef1734@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 3:29 PM, Pavel Begunkov wrote:
> On 05/02/2020 22:07, Pavel Begunkov wrote:
>> This is the first series of shaving some overhead for wq-offloading.
>> The 1st removes extra allocations, and the 3rd req->refs abusing.
> 
> Rechecked a couple of assumptions, this patchset is messed up.
> Drop it for now.

OK, will do, haven't had time to look at it yet anyway.

Are you going to do the ->has_user removal? We should just do that
separately first.

-- 
Jens Axboe

