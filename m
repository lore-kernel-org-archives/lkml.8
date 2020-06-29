Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D97DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A85A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462116;
	bh=LiKVXY23oylE1D5iKy3i2vr44WMPTs52Izwdsf3Fmp8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0QKQiYHn8GU6f0T9nrXvoDShugNJg9VKzqv48dQCQxRPXgQnDwfXO+XocIboG/A6B
	 3eqLPY1hTwuqow25JfJ+4m43fHNIhN6t9R9ow/e+ZjFXIcL3cf6MGc2VHGT2APi4zo
	 hfzE1OYaMLRBdRi0xKE0BtWRqwGrjwt51+DSABWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgF2UVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733091AbgF2UVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:21:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4204C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:21:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y2so18617992ioy.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xe0Kngev5V0/2bx10GzAMBFnMV/HG+Kp7x1mqRPLtn8=;
        b=Qe0B4hN6JKmXDAhczq2oH+LohHCdr7IKU3Oc+5OvaVsLeMY/Gfq8E693dAwZeXvtYB
         9UxlCIgHPxx8vAzPeOflNYyNQnfyo3uUyg2WSWgfB+HBYIdbc6DtlTd1wL737VZ5e3BK
         IrlSrC/99WWot+aPQgwRMpRDEuf+8IY0FSfYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xe0Kngev5V0/2bx10GzAMBFnMV/HG+Kp7x1mqRPLtn8=;
        b=FPMZyjNA0JcX27Hy3DmDftOQ2cn7m5Wyv/Zr+U1SI7pyME3uM/gbEXHmOpqeh65Tbs
         7thjPpeyOQWTd8dWW9CJnog+r0c5oC8ylbF4hDbWAF32B6cw9QHXEkeYuJhx2BTq2NJa
         9RIjTtsCHMe3LlcxNDySPdyD8kzq76AtI+AFQJqaLDKSQkuVqIPHcXaU4Q5fFoAh6wzN
         DiwQiQBEsvLIe19RRv8P0R//8bvR92anTPvC2kj7n3lMybhzXo5Uug6hUKo7UeSLSse5
         ZGy9wYT56LHXAKXx6SoiHSq1TqcBYqWUpPRS+zqxVJS5+VEL7J7AUP+tEl9kgkTwnGuN
         r6SA==
X-Gm-Message-State: AOAM533fluZqXRFB0l7EBe+IgqDtitVMkNVUqYQtZz2lyc9sB5tdcL7B
        WIpPsE+bKAVzFgKJVkN9I5Nc2Q==
X-Google-Smtp-Source: ABdhPJx8iE1nRfHXfDv7Z/LjcCPE31AEKBsPiln2NpPL29NMT2q2L7llun+8++o8/dahYOJ1YsK5Mg==
X-Received: by 2002:a02:1a06:: with SMTP id 6mr20182590jai.8.1593462109366;
        Mon, 29 Jun 2020 13:21:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c9sm471009ilm.57.2020.06.29.13.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 13:21:48 -0700 (PDT)
Subject: Re: [PATCH 0/3] selftests: tpm: fixes
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     pengfei.xu@intel.com, Joey Pabalinas <joeypabalinas@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ddf50129-5fe0-ab84-1bae-90a06ba017a3@linuxfoundation.org>
Date:   Mon, 29 Jun 2020 14:21:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 3:20 PM, Jarkko Sakkinen wrote:
> A few fixes for tools/testing/selftests/tpm.
> 
> Jarkko Sakkinen (3):
>    Revert "tpm: selftest: cleanup after unseal with wrong auth/policy
>      test"
>    selftests: tpm: Use 'test -e' instead of 'test -f'
>    selftests: tpm: Use /bin/sh instead of /bin/bash
> 
>   tools/testing/selftests/tpm2/test_smoke.sh | 9 ++-------
>   tools/testing/selftests/tpm2/test_space.sh | 4 ++--
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 

Applied to linux-kselftest fixes for Linux 5.8-rc4

thanks,
-- Shuah
