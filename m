Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3CC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B312187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579114771;
	bh=sI7qjuFwHkU+C/ugTPZ02yC7mmhnfBVUf/WexK9dq9E=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=ydvstniiZPhLmhJibJuKvNdgfjQ4DL6T1pUK0DygBqsKQTiOBaoD8T8Ra5vCfkYiB
	 PHF2Y4rk5kzLQ8AiyiVq5zQY6KYpyQvuFXeYlkeHsV2F30R5tvBkWcJ723ivarikh/
	 1Sb/vGZr98G8srGzLBZC6Aou1QPEJR7D9JQGMq+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAOS7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:59:30 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39844 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAOS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:59:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id e11so339466pjt.4;
        Wed, 15 Jan 2020 10:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=6gSo4RAPlYJmWVLazwjXSnCzKLp8vlmWill3n2LyNiY=;
        b=CqQxHJcRMAe99p+rrj734cCdyjG17g36cIw01iS09XoA3p4kCpor+bzEMxOQp9BH0G
         fLsoP4z/uVL0zDLonN5tnGVHMqlohJGjLoQ48gw2P3k7y8Q9UmjpILHRUAL5fXPNoeEo
         x1ZhOVxNvC5+OPN5ZDRu+iNbHuKWC8bhIQ82FlppH0l8QKr/ST3iZlWl9AnYD6MTuYQ4
         qfKuzVfXodJ+fTaOEsL6/jshWgMXXFaFrBxMvdnXuRgvxaZTXkqlJYiRF+RlwhJWB/h5
         hcgSpAl0KDVwi2p8wu/UqWxkxSDqZMbFU+tzmxHwKCgY/hEiZXCcQxZsyug7U7g65n1O
         M1ug==
X-Gm-Message-State: APjAAAXzyt13uRIxR0Q5ZIA3OavIUGQ+M7b+6i67muFgb2Xkk0SvC64z
        6j7eD8rwy3IabkDvSYeEcYQ=
X-Google-Smtp-Source: APXvYqyZnMD8FGLhGq+S+3gD+ymfeRgcx+0vuUYpc28gAwsoI79XSISNo0pC8UxBf37Tlmk2Zi00VQ==
X-Received: by 2002:a17:90a:e990:: with SMTP id v16mr1545811pjy.67.1579114766333;
        Wed, 15 Jan 2020 10:59:26 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id z130sm21618156pgz.6.2020.01.15.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:59:25 -0800 (PST)
Message-ID: <5e1f610d.1c69fb81.f807e.398f@mx.google.com>
Date:   Wed, 15 Jan 2020 10:59:25 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
CC:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: Document loongson vendor-prefix
References:  <20200112081416.722218-2-jiaxun.yang@flygoat.com>
In-Reply-To:  <20200112081416.722218-2-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> Loongson is a MIPS-compatible processor vendor.

Applied to mips-next.

> commit 1590b1eb9370
> https://git.kernel.org/mips/c/1590b1eb9370
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
