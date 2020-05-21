Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B785CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A29320759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bY4EphQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgEUSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:46:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C8C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:46:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so9603545ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVnabUAfbStwaN5v1xACPM1JlL4rJeSp9+AcKNA/LtM=;
        b=bY4EphQdUmKBF9bagGDcWpc4ElKXTpWpESCLmDczOyKUABHpqTnssrhhPe2wRH1JsB
         q/kV7X5Rj+njrhsDBXga4cv2fXbfdFQJ7qbOHakSJj34o9PaY9j+8JrTaQznJ6aDFfOX
         yhv4R3flvrn4ECnZKb6PKGyUjWdW2FOvmky3iPy89bC1bC5WLd/Irn5HiaagnJ7EfeJv
         pBYHpqSPnTU/kuTMWC7i8Fvjr94OjPeBIoooO16LW52tWKBQv8Pf1LAh/rL7hwSek2eg
         4ic5CQFCFbJwo110FjgIjheYrtIaeJJpQEClGlpivH9JMD6ULDvfMjUjAaEasJsAm4cC
         BSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oVnabUAfbStwaN5v1xACPM1JlL4rJeSp9+AcKNA/LtM=;
        b=kcFwtHYBnNq6OcAzagjDstHNux1W1qohAPsxUTQyRcUJv+Y9z9jlB8prERF0RpVJLZ
         akCzehdba3KjFjWcVejJPOFm2fgSY3Dx3dYm1bnLKn42XywBR5U3uahrS8NBfMsQUzex
         73lLaAG0hiyW3bxSbBmFEDUCkLAdyOTKuYI/sEKJhHQ4/D4iPIF9cbtkJ3ZjeG9OKb5C
         qvH4PyDcNAc4i4+sYJ89QA96yUrNouPMPXyqxiGgmOojok9P1OV5gK1eQn/rR/SZnTok
         9Z8XQVtIrW16HPXs31gt4m6FXZUVZ+8BDa/nz6d/VsuaNATUJJWsI2JNEKsGTpoGNnk/
         Tu4Q==
X-Gm-Message-State: AOAM530/obPnGZHBhqaiqTEnxCP8tKV6y+7wf8WgnUcHExbEGOj5dPHc
        9VFIPoLivO7ef8pD1MFEmMdcRY45D8Y=
X-Google-Smtp-Source: ABdhPJxiedYiqVYUOWz8DMGdNjvPpWBRJA/RNpg3zLv8CLaypPzbZ2zk8KMykGp4zZIsfyiM68dgCw==
X-Received: by 2002:a2e:160e:: with SMTP id w14mr3343295ljd.66.1590086784105;
        Thu, 21 May 2020 11:46:24 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48ee:17fb:5171:3fe9:1a17:bec3])
        by smtp.gmail.com with ESMTPSA id f14sm1012378ljp.118.2020.05.21.11.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 11:46:23 -0700 (PDT)
Subject: Re: [PATCH] sata_rcar: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200521085825.2098-1-dinghao.liu@zju.edu.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <f37f5944-29e1-643f-638d-71cc0d851734@cogentembedded.com>
Date:   Thu, 21 May 2020 21:46:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200521085825.2098-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05/21/2020 11:58 AM, Dinghao Liu wrote:

> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
