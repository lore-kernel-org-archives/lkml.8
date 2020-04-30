Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A4C47255
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D63A2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p54tUHYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgD3O0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgD3O0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:26:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF5AC035494;
        Thu, 30 Apr 2020 07:26:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w14so1393554lfk.3;
        Thu, 30 Apr 2020 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+UFp6Ib7z3ZjpMo/76B36boHiAngfIxECFau2eYJlo=;
        b=p54tUHYwXZlbsqlaNAUxYv63ugmI/LEoMUYEoTA1sY4gBfVO+tG0BTwd7x6YOHUTs2
         nTzGwRX5TjpcYY1TZPUSa+cxkCTWxNUZdYevcrLkaN/Ekc6jvOZ+CUcCdnleR3q3p27T
         whk1vdtV1qxzo1HavdEseqMfOi/i9nAFX2WAGLQJlGDnrlC+3TwU52pAnN3Z8D/MADor
         nDjRL84nr76I5+x6fjqIyune7b6MsFqFx2h+F/4u7Hec+LyfKk53q67id0h8fsCxcLyW
         tbXhiFuOD9bw+wkhtRyca9EMuMU3PuIAQ8uy339L+/tlCfYVjByjTVtoQUrR/Y8tFNz3
         flVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+UFp6Ib7z3ZjpMo/76B36boHiAngfIxECFau2eYJlo=;
        b=iJIxfVSd/M6ckpqtq2KYoC0UyY9bM7jPudkJsv94Z+BbzGWLhOiy6S33mrHb95jTbP
         GsEilJRwulQTAc253so955Y16Upt9/eUTK9wSXv+KaNC4wfWclOywlbHgWzw9BBJEE8f
         dODhnu62A8KjVe1Lr8HoGTAP923LtLhfEcB6yo2kwj7xrMsqIlyD3Io4xzd7cFiG/4JX
         QmxIFzg/BQzFwYabgu9H11nOVcdwkt+X3X9u27riW5Eg7fzrVz8sDHUOt2hF9Lx7kMiM
         eRJTNOfhmI7pgi3pKBHHO7gJg6ee51G19UerLGxLAmebqcSs901GvHp9+d6ROVO07hrE
         popw==
X-Gm-Message-State: AGi0PuYIrFoPjbw+ifno776pIbRCh3xAiEuLFJ73X4WiIY4Ak86eNS8P
        IqRlyvzZliwvxJlF+trEa0Xuff3S
X-Google-Smtp-Source: APiQypJV95MF9Q83bkw8gnjdPRcQLL8CpazAt4tHwIesvF0QFuGC0cuw4n5pHLGWNELeui7Ee7mb7g==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr2399366lfm.91.1588256770843;
        Thu, 30 Apr 2020 07:26:10 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id a24sm4473769ljk.10.2020.04.30.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:26:10 -0700 (PDT)
Subject: Re: [RFC PATCH v11 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588197606-32124-1-git-send-email-skomatineni@nvidia.com>
 <1588197606-32124-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8369a113-d85d-a50c-f9e7-fe5df8270aed@gmail.com>
Date:   Thu, 30 Apr 2020 17:26:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588197606-32124-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.04.2020 01:00, Sowjanya Komatineni пишет:
> +		chan = kzalloc(sizeof(*chan), GFP_KERNEL);
> +		if (!chan) {
> +			ret = -ENOMEM;
> +			return ret;

return -ENOMEM;

> +		}
