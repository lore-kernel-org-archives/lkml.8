Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C44C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04FF2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVhKpmx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHKP7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgHKP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:59:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4539C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:59:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so14083520ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xAz+V9xSviK+KE3bK3AlSLGhTEyhwFK2obNPSfmyWq0=;
        b=KVhKpmx5MRW2CeSl/ljKDguzeY9+f337pfRsUGSSa50Lxln280/QkKvINTrLrt5x0d
         VfBSKnAGOnx3a1sQDRXZZ/YWPEiCbkzitMdU6YxA+hONzfLChd+TBR/+qJ5MgdAfC+5N
         F1tqAA+xis3OUHRijbLQaHmMvCHPHJ+MDvjescQ1am9LF6Z3msM70Du1yiaQoRLC3p7t
         LVZKofe7teFcjVPUDnDYPaV4VbMHFVnBesbjb9K9LHFP8agHazvOVIHowYiVQC5c8hAj
         MjIaKMPqDwAOghfYVeSfIeTMxAP73FNnEfbZjmhou/lNjU2LQ/5I2na3mxogK7YWF7In
         fXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xAz+V9xSviK+KE3bK3AlSLGhTEyhwFK2obNPSfmyWq0=;
        b=Clx09ALkumkZ1w5te0Iecqp3OrZgN2MjtbJ62Eax9/AE/od059Ji4zQiCFLXfucTlE
         kSOKz0IUPKE7pv0ow/lDdWTZRACb6JOXaoKMWTGYy/dDYSsMyhatz6l5eSKX6kvnu9zs
         27T84isx5nfwtlCJ+K3E6+y55Qyk5xgcwIksw1GxvqX43FbEtUz7sm2flUKBrfswlolg
         g2YshHp68ScLtSb8kvE5us0NPSxmQyQA4lyk2rEGuob/5fb+QlyiB6u2pNn6IrxMg1UI
         9I4WrQKM3MFtWJa9YyoP+rbCYonp2QlY8vempHPF3RHIgYQtyMXEvKRTJObJNHNAh4zO
         QoXw==
X-Gm-Message-State: AOAM532p0dVbU9Y779p47BY+Aav5YFZRO2Oqj2wSxCbAYOBxsPYGaftG
        /bU8cIrS3VHhL3I+OLOdevw=
X-Google-Smtp-Source: ABdhPJxbUxEYU/HAs7PQLEi1C+wZedvi7p7SDlxWxTwc1sH8tPGt9ZKph1DdhMIlKdaoV+7Eq7ZnNg==
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr3325225ljk.216.1597161593055;
        Tue, 11 Aug 2020 08:59:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id f24sm11261481ljc.99.2020.08.11.08.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:59:52 -0700 (PDT)
Subject: Re: [PATCH 1/7] regulator: push allocation in
 regulator_init_coupling() outside of lock
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
 <b305adf8bcde9417cdd5c9d84ef5ed99541f0e2c.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0d61983a-ed11-e5c1-f2c8-954e5ae330f4@gmail.com>
Date:   Tue, 11 Aug 2020 18:59:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b305adf8bcde9417cdd5c9d84ef5ed99541f0e2c.1597107682.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.08.2020 04:07, Michał Mirosław пишет:
> Allocating memory with regulator_list_mutex held makes lockdep unhappy
> when memory pressure makes the system do fs_reclaim on eg. eMMC using
> a regulator. Push the lock inside regulator_init_coupling() after the
> allocation.
...

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

