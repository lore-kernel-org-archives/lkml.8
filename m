Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6F206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5E0aMFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgFBTQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgFBTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:16:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF1C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:16:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so12512921ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UywQyHtI8fXpM4VAmwZWYaYfXJnDPZ4DdqMwxQ4d9J4=;
        b=X5E0aMFrxTSQkPUj2EQgOzd/uLAf5y5ROaR2TC1U4xQeuRP4zZyFaefbtpALQl3g2T
         o5c5sK1LRGuKV5nMtFan+xBNBC3btdKUlZmOydCPjurotN4pCpVSg0XhDz4Ch3tEZpai
         oY+VeThPltHttDfod+i4ugG3wBHJf99F7dM50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UywQyHtI8fXpM4VAmwZWYaYfXJnDPZ4DdqMwxQ4d9J4=;
        b=b/KAk7f+McmB8b0xSwcgMGDmg534kiqxCxjmieFXOdUhwjAM4ob0XvlR+RjMRKGL3z
         Z111yQ93m5CoJYfB1/zlshLuWqZaNJ9prp/1dXZ7g5gxvQ0mviOVILLkx70XG0w5Q6kQ
         4oMCjFG8dYP9lUrXqcsgw8zOzoMTS/4e95z6Nf+JtATjLlIvLUPspCf2gpvelWSvRnVp
         SJXbgIddxUKylvq90+T2Rd6V5Cu0QBzGe1GoT63zhXx5nskuDt/o70PPaVa9Dx/5Ut65
         4HrbOXrnBEhgUKBXeEQEE0XMVj9TxiEg6IWcU0T7I3Ru95Q/E9xyobBFdPKXCH3vD2Br
         3rFg==
X-Gm-Message-State: AOAM531Lg6t9nPWNV/QM7jh6cFpu1El82MTF7+zJ/FnsUW/6X5drxOjR
        iJUexbPCCSiJKDmOxp0Mb5h89BtZ6qA=
X-Google-Smtp-Source: ABdhPJy+nBI6kbg5uD/8CA0AytCHdt7buVf9qlmZCxGX90q/lU9hUq+RSQ9/L1gmgeG/aQvRwhS+fw==
X-Received: by 2002:a2e:8144:: with SMTP id t4mr272670ljg.412.1591125383026;
        Tue, 02 Jun 2020 12:16:23 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id k1sm833752lja.27.2020.06.02.12.16.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:16:21 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id w15so6838614lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:16:21 -0700 (PDT)
X-Received: by 2002:a19:fc15:: with SMTP id a21mr424706lfi.121.1591125380888;
 Tue, 02 Jun 2020 12:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200602052533.15048-1-john.stultz@linaro.org>
In-Reply-To: <20200602052533.15048-1-john.stultz@linaro.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 2 Jun 2020 12:16:09 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
Message-ID: <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit()
 to avoid hard crash on reboot
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Govind Singh <govinds@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sibi

On Mon, Jun 1, 2020 at 10:25 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Ever since 5.7-rc1, if we call
> ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
> reboot, resulting in the device getting stuck in the usb crash
> debug mode and not coming back up wihthout a hard power off.
>
> This hack avoids the issue by returning early in
> ath10k_qmi_event_server_exit().
>
> A better solution is very much desired!

Any chance you can bisect what caused this? There are a lot of
non-ath10k pieces involved in this stuff.

Brian
