Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA2C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2524921702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2MkfsCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGUNbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgGUNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:31:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:31:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so2852579wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uyBU0n93mYL4MPnVZSrUf3hQRNa7z/RTZ/TKuAjq3Q8=;
        b=R2MkfsCQuYWzdV3pwRrLaT8N1kzRpNcsFvr6wnqUiJrQk9jaPTpAwG9/BxmKH0fg4e
         csnBNsmMOvVrz/CJ+WpUAIOUa92I9kRfRCKd33NJX/RQ5DALtKWGB9IV/8y5YuU/FEGm
         ABQSVM09Kd1gfUDLlBqWcP6KdrcFWArxsSp6AkHFMYr/bnYPxQntffyf8B9orCvGnSZD
         kpIz2FAvQ6MLmX+RfADxPxmtyzNZ4rFR5tmSwBCK0I9/l1n0ZDpLwFbwZ9tSpvPX0XTL
         LQHQMEMxDFZ0U2xD6mGRCERCgYTrwUvl8rhc9PPSgVVavx2jLMlCN/QIytxMBrCHlFab
         81Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uyBU0n93mYL4MPnVZSrUf3hQRNa7z/RTZ/TKuAjq3Q8=;
        b=sJz/MA52rfL2T8vfqHp6FehAe7ycQQuRTVpg7kUAJjWaCAD0ZeUjMJ4xLixE7lflrJ
         fKFNrxIdsH4al7pPu5NZTyXxVEIvbF4wiZFDecOzMRsnBF50MOw0D7I1vK+n6L+Z69G9
         GhLYnGueYuAhMyj6MyLkjVOnZ8oogQpyeAaSUrFDrCIrSEzkioD3uOYehpdTRMBHB478
         qCZAvipxzKNBDRJVZLrMcBFwEvnG9yjHB80n2Gl7HiJUuXu57eW+ArDjmlZZ/DMK4y8/
         d0Sabvp2mOiz/y/PDP8nbt4qQQ1znnWP3AdvPg9NkqATORnf/F/ED2PEZ9antl7UJu8q
         d8WA==
X-Gm-Message-State: AOAM532gT430u4inLWXeuPQYdlywTdfKbdjQx5V4aTI/9iV0OaUjnvdz
        wprIO5+CJBigF8TlnFPIWsI=
X-Google-Smtp-Source: ABdhPJzuacQT/Evp2PHZb0CQXYblt0HAY+Bj+IAqC14Rd4DQUDuO+4iTsHjhrA3NqW8RBRIhAaQjlw==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr3983422wmi.41.1595338296463;
        Tue, 21 Jul 2020 06:31:36 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id j8sm21924758wrd.85.2020.07.21.06.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 06:31:35 -0700 (PDT)
Subject: Re: Speaker pops with max98357a on rk3399-gru-kevin since v5.7
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <f2ca985f-7dbd-847a-1875-dd0e1044ef02@gmail.com>
 <CA+Px+wU1S1EqtW-yZH9z9aCF3ggSriBqy73SRYy8q61x0GkdQQ@mail.gmail.com>
 <846feea6-e2b6-3a0e-b05f-d70e898f9ea5@gmail.com>
 <CA+Px+wUhAHAx-qmAEWy_8Jy40NDTAHH-TNYtPtMfwocMHQ=AbA@mail.gmail.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <ba020dd4-167c-f67e-5cf7-5e4e60a71919@gmail.com>
Date:   Tue, 21 Jul 2020 16:31:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wUhAHAx-qmAEWy_8Jy40NDTAHH-TNYtPtMfwocMHQ=AbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2020 14:46, Tzung-Bi Shih wrote:
> Hi, I got a rk3399-gru-kevin and can reproduce the issue.
> 
> Could you take a try on the proposed patch here
> https://patchwork.kernel.org/patch/11675533/ to see if it fixes?

It does eliminate the pops, thanks.

(I've replied to the patch, I am sending this for completeness as the Cc
list isn't exactly the same.)
