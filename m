Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0854AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7229207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m9HbE6lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgHSNHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgHSMzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:55:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3DCC061344
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:55:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so11350454pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eJyS7BjK7wDUsKL2rCrjdhtuG6HRkdolBIn6enpoXLE=;
        b=m9HbE6lZJ4RKqfEHA2yd1nXSFEowGn6oCKQcUNU65nF8hQGmOPewZkZ6KGsSzL0RQq
         KSU3SQrky/XIK8WvGZ6WzlDk+845U83Fd1JJuPUHFU4TZDMneUimIwkT8GLzSxCyiqnb
         0W2Qlbj2bo4KZXRLlLh41NttK+CYgPuCUHseECCcKLqN8NDiCnJ2UbiGd+vOcdvI0Mco
         HexL34mg6xmXk4QRqTQ+KTwicqoumgGoMqDgamXuF+GwfIFT2puE5TO0j4INgkVfN6IB
         RW/9SffGVPFme31bR8J9syJDiIWfeNX2brIrOCPNDQbdMnJsUbOQliFq4sUvQMBY7wmj
         viSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eJyS7BjK7wDUsKL2rCrjdhtuG6HRkdolBIn6enpoXLE=;
        b=YQZ75wvBxt/FvmwqqSWa1I3kcKlVLT7ct5u+2p/r3zIVwRgLV923cFFtSAQ8WM5Xcc
         wzpO59HJOc0tcoEGpNpcklOlvrZE/dEjVb0gg33Lz6tq5qOjJ+QG95xrVM2nzt06P86o
         P5PcXHXlv1B3o4RIRNv55C6uia+kvKm97wUlwDPKd3OceOeKH4fwSHwjppIPxv3ATMUn
         JqheJfkyiZDnwCwxQVFGg/Spsaa6jnJPkCZjqvgRaYacqRMqA7ckhL24B/2hjE9bugNb
         jfgW5mk0aVMv1b9AlYJzFvfb4lCPqybFzfr/wyX+hfMvo+DA0iAeq8qY8DNm4X4xSaCc
         61GA==
X-Gm-Message-State: AOAM533RYfheBNWP2KVsjINNhyj+5OVdl3heI11IKf/YfK0tkFOBFHXE
        utEUfuUA0rYAeN+gDsaJT55ZFf/OBlthBbot
X-Google-Smtp-Source: ABdhPJxvgfFos8NuS842i0OTcagtkYQEtKig33RmRzfeH4z0jn2Ve5ZHEgBBpsdZBttqkSJRo+2UHw==
X-Received: by 2002:a63:c509:: with SMTP id f9mr16644768pgd.144.1597841732876;
        Wed, 19 Aug 2020 05:55:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n12sm29776266pfj.99.2020.08.19.05.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:55:32 -0700 (PDT)
Subject: Re: [PATCH v2] MAINTAINERS: Add missing header files to BLOCK LAYER
 section
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819123243.18983-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd76fcd0-83b2-cc16-952b-8fb4c960bf28@kernel.dk>
Date:   Wed, 19 Aug 2020 06:55:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819123243.18983-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 5:32 AM, Geert Uytterhoeven wrote:
> The various <linux/blk*.h> header files are part of the Block Layer.
> Add them to the corresponding section in the MAINTAINERS file, so
> scripts/get_maintainer.pl will pick them up.

Applied, thanks.

-- 
Jens Axboe

