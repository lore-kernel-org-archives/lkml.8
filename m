Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62B7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F4F2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y54+52P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGTWkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:40:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:40:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r12so19238471wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tdzStXPHhn/lPCcmGPCaBvtaXY8ZKM9Cp45GAKfxt9s=;
        b=Y54+52P/XnjtilisJNCnGinNUWBD1b9Cvz+O4isdAveWxDMPbnyfUL7l8PH2vQGasT
         vl3INNIKsFFzrET9BFHvb+Ue0N3aZ4z75lX0PzZpTLERLsjAXYUd84XeeCJt+whtg/n+
         AzY6AQ64NTNFlEgiVdsU6QsgFUBdbR2SjY+cAGcED1wahHvRR8vY5/ICQ9L4an3LDNVC
         /k3EpFMu853pFmtQOWpfE/xLcgBsChLYtYfh1k2d+lqevnP98D0iDMW/11k5723XfJlD
         MuEksnUiyX+c/oF2wwGA43PgPCDU027fBzfMN8/XRYzdP+waUPU1Zvxwrg0fvUn05JNG
         1PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdzStXPHhn/lPCcmGPCaBvtaXY8ZKM9Cp45GAKfxt9s=;
        b=XvQEVRHZB28IxpNye2vCp8OzBzYimwp2d23J09f4eNZfOBcEPgQ1cQS+CQSsQ3GA01
         57Q+HhYQdMvFX7CRYMJKFHW4RVw0d6vm21D3qkkIIbzwdJBLUaLcfS3Pw0CCpv5q8GWo
         aVhK28joSgGpdpCWsNxxHeu48CN0GL9vZbq2OEmDrzKIMuaOPssuw3PLD0PXdrsD+T5v
         lE1qBkJITQA8x21lnOg5BLp5gHkVANiWEI0NXKZBE1LtMF0pKJ62AFNNu5tQ9/bxSf58
         ueAPnr1oe4pw2JeTS/9qOmNIBX8BCW5NvwBTBRVqhQnDHoxEFAyFnZZVfv3mMp8eRzZT
         OQlw==
X-Gm-Message-State: AOAM5306G4fh7QdB/kZU83gybUAL+xLDJetFGzcpRnmd1LyIdphIfiRY
        5kLLuXox/alR5zCzi2Q/LvTtYcuA
X-Google-Smtp-Source: ABdhPJxMuvjHZthcawt8WUmiSHPwNllUGkXx5YnfTh7/mggvie8pQKteaMNu69ak3ikuRjX9cBkcVQ==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr22765783wrt.97.1595284819931;
        Mon, 20 Jul 2020 15:40:19 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id i67sm1153944wma.12.2020.07.20.15.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 15:40:19 -0700 (PDT)
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
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <846feea6-e2b6-3a0e-b05f-d70e898f9ea5@gmail.com>
Date:   Tue, 21 Jul 2020 01:40:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wU1S1EqtW-yZH9z9aCF3ggSriBqy73SRYy8q61x0GkdQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2020 05:27, Tzung-Bi Shih wrote:
> I am not convinced the pop comes from 128f825aeab7.

Maybe some pre-existing defect in rk3399_gru_sound got exposed by
128f825aeab7 or the machine driver needs some changes to complement
that commit?

> (I don't have a rk3399-gru-kevin so I got another test machine with MAX98357A.)
> (I was testing with and without an audio server.)

Your observations are also a bit different from mine, which IMO also
suggests the machine driver is the true culprit -- I'd guess the pops
you hear would be from a different problem in your test machine's
machine driver?

(Let me restate my observations to contrast with yours, as I feel my
previous explanation was too wordy:)

> Observations:
> - I can hear the pop either with or without 128f825aeab7 (with and
> without sdmode-delay).

I never hear pops without 128f825aeab7, but always hear pops with it.
(no change when I remove "sdmode-delay" from the device-tree)

> - The pop noise is not always.  Higher probability after stopping
> playback than before starting.

I always hear one pop when starting playback, and two pops (with a few
seconds between them) when stopping playback.
