Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22843C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED5B207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QxVgzK2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGJN7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgGJN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:59:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E33C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:59:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so6067797iom.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mlQguU1U2hvwSJk30LAK9bB9kVEoSAR2Lu6iWKVRBx0=;
        b=QxVgzK2SsL8sgX36yDnhSAlanH8a9ipHEgYMzsFZMu4XWL4dS5GHNGFqeK2a4IPiQc
         AaiToF9P7IpNAzxLUVPA7K0UyT+EGR5s+SIphaYOW1dv65zea/4hvzCiVxnd5tE54m7p
         ht8MxEacP4qOK1+e59bVNasYU5WQWytNq1nUnB/4yL2oq3lsIiIEvCMVASV7R9gSySNq
         qk0LaBiFQAKh+TDD7oOgQpop0Vg13cWVlK5PGBT1/OtRL32YSCq3fVbEB2M1rCW0Mx+L
         m4DVJgvr6AsZzrjLM9MZBtc12QRaRgo9eh8SstcWB1pUT2Aoyp+9+UHIzOWXArpsr7Uj
         QOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mlQguU1U2hvwSJk30LAK9bB9kVEoSAR2Lu6iWKVRBx0=;
        b=eI9V39LwUZrS9FnGp9rlHvSSNntqIQiB8V0XwxdDpQXsruvKtjzcI8ijRZnIK01wk+
         KrPiebhUPfpdFH1ODGR5K0CSI6qPMOhaQAyIz8Of0Z2sRF+rtsrCjnoHwJZL48TkEk+T
         RY0takhO4KE7cCEy1c7R451AixHUOyol2pncA6yOd/Il7THhOnb2N+sl+PeKh0w6+CAn
         JldSp1pmmrAUaJqu/ibvJQSnRshXdy8dHHVLBKnBXYv5pLz9/ND1hUaI+1kSrSguF4A8
         MCo2yl0SpInq2C0FtR9XkS43HBQoE+bXtbAjmH3ylGVgDVdQQWM2o3+TBHiceXns1F3v
         sc9g==
X-Gm-Message-State: AOAM530EG5TrZ+YX8lx8G0Qyi+PMW/YoT1iw2N+FDHdROaUFnKws6yFA
        E6SqxvQnIu6xLQU3quvkVenMkISnuNnbSQ==
X-Google-Smtp-Source: ABdhPJw4W2QlT96qjonJgHmFLwy6GyJG/IHPn+aFBToTY/NhL8XjMBDyq5Q6DerUJbHeCxRVjyhFQg==
X-Received: by 2002:a02:370b:: with SMTP id r11mr75398071jar.119.1594389589474;
        Fri, 10 Jul 2020 06:59:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t5sm4038923iov.53.2020.07.10.06.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 06:59:49 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Remove unnecessary local variable
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <37baa5f3d47675b782652c85acf303662368e99f.1593846844.git.baolin.wang7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9858c648-6070-05ff-c6e1-38317eb65045@kernel.dk>
Date:   Fri, 10 Jul 2020 07:59:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <37baa5f3d47675b782652c85acf303662368e99f.1593846844.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 1:26 AM, Baolin Wang wrote:
> Remove unnecessary local variable 'ret' in blk_mq_dispatch_hctx_list().

Applied, thanks.

-- 
Jens Axboe

