Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE073C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52A520729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXmQdCif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgGVJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:52:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE38C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:52:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so1255632wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NnGp80NPQTu2mI4cBw7kWXjSdKbhAuK7vytIEfdLi3A=;
        b=UXmQdCifEmIxRngWqAYgwe3Ayp+g5td9CPnaXP/KMtwZIILHi8wltE9Mllv+KXVK7B
         4aiPUr64nFFsvBz95wEeMSFjs5A7C6jm2l98aUF210EVYC73QoxDu4xQjDyy97nCSOua
         +UnMtEtmY68L7uYzQ7e3XMEqzO8aLJYp5kHNKk/60vkFUAYuDkfoQZgE7t9OpJVojQ0g
         mnshC0eQLuSqSpTZAqEJki37fIhQCOG1p64Uhl6GEmRw8pk6Fkamn+tYe6W4ZOTTo2ae
         2BtpH59cR3VJg0Fm8Q4cmyF0se8mhRmBiQ8I9u3TjqDgyhnikyiIGUku3bsOb8U5NBm3
         KLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NnGp80NPQTu2mI4cBw7kWXjSdKbhAuK7vytIEfdLi3A=;
        b=Hhtfdco9M+CTjpjcKm/lMtT/UKgMsfnTOu8ZsURbtvgqlwGemLF17KUc7xjdzfLYuO
         n3JRKLx+5IhTpIdP2NagWdAxNoq04AvWWV6f9kbwN9n51W/+jQT1lPq9zMJzMOYWlKtN
         eZ3SB8KJxBGoc42YZkMA1YZDLfUyWoEBUNMy0u12s+Hp028MF5llldMP3cSGNDufJo9F
         8epo1Uuw+2m7UTP/a6FmkWnQ70KPo5UStj+WvaXt6ZETF5CcxKO7wxKs3V6Y5ALAGWuo
         BVuTo5SMMlpIEqlrwCretxEcvbvlB5HDX6rpWg4Ql0iWzRRezLhBo8gNKNXiB0d6YUsm
         LFpw==
X-Gm-Message-State: AOAM531jLSUw38vPo919m8KzKG+lLwctRTMoNhVdtW64pjSA+bCj8Jhg
        A1PUOepiZGvn1eCgfriSC9bDCQ==
X-Google-Smtp-Source: ABdhPJyrsqCYVriDUqXD4wDhJUomgmz9tx85g7/PWV5dw4QcWgnev4HMGFmJGCptHJTJYjX8WN1gXA==
X-Received: by 2002:adf:82e1:: with SMTP id 88mr28998520wrc.376.1595411551356;
        Wed, 22 Jul 2020 02:52:31 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id j14sm40752327wrs.75.2020.07.22.02.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:52:30 -0700 (PDT)
Date:   Wed, 22 Jul 2020 10:52:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org, j.neuschaefer@gmx.net,
        m.felsch@pengutronix.de
Subject: Re: [PATCH v2] mfd: rn5t618: Make restart handler atomic safe
Message-ID: <20200722095228.GJ621928@dell>
References: <20200721073402.22925-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721073402.22925-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020, Andreas Kemnade wrote:

> The restart handler is executed during the shutdown phase which is
> atomic/irq-less. The i2c framework supports atomic transfers since
> commit 63b96983a5dd ("i2c: core: introduce callbacks for atomic
> transfers") to address this use case. Using i2c regmap in that
> situation is not allowed:
> 
> [  165.177465] [ BUG: Invalid wait context ]
> [  165.181479] 5.8.0-rc3-00003-g0e9088558027-dirty #11 Not tainted
> [  165.187400] -----------------------------
> [  165.191410] systemd-shutdow/1 is trying to lock:
> [  165.196030] d85b4438 (rn5t618:170:(&rn5t618_regmap_config)->lock){+.+.}-{3:3}, at: regmap_update_bits_base+0x30/0x70
> [  165.206573] other info that might help us debug this:
> [  165.211625] context-{4:4}
> [  165.214248] 2 locks held by systemd-shutdow/1:
> [  165.218691]  #0: c131c47c (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x204
> [  165.227405]  #1: c131efb4 (rcu_read_lock){....}-{1:2}, at: __atomic_notifier_call_chain+0x0/0x118
> [  165.236288] stack backtrace:
> [  165.239174] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.8.0-rc3-00003-g0e9088558027-dirty #11
> [  165.248220] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> [  165.254330] [<c0112110>] (unwind_backtrace) from [<c010bfa0>] (show_stack+0x10/0x14)
> [  165.262084] [<c010bfa0>] (show_stack) from [<c058093c>] (dump_stack+0xe8/0x120)
> [  165.269407] [<c058093c>] (dump_stack) from [<c01835a4>] (__lock_acquire+0x81c/0x2ca0)
> [  165.277246] [<c01835a4>] (__lock_acquire) from [<c0186344>] (lock_acquire+0xe4/0x490)
> [  165.285090] [<c0186344>] (lock_acquire) from [<c0c98638>] (__mutex_lock+0x74/0x954)
> [  165.292756] [<c0c98638>] (__mutex_lock) from [<c0c98f34>] (mutex_lock_nested+0x1c/0x24)
> [  165.300769] [<c0c98f34>] (mutex_lock_nested) from [<c07593ec>] (regmap_update_bits_base+0x30/0x70)
> [  165.309741] [<c07593ec>] (regmap_update_bits_base) from [<c076b838>] (rn5t618_trigger_poweroff_sequence+0x34/0x64)
> [  165.320097] [<c076b838>] (rn5t618_trigger_poweroff_sequence) from [<c076b874>] (rn5t618_restart+0xc/0x2c)
> [  165.329669] [<c076b874>] (rn5t618_restart) from [<c01514f8>] (notifier_call_chain+0x48/0x80)
> [  165.338113] [<c01514f8>] (notifier_call_chain) from [<c01516a8>] (__atomic_notifier_call_chain+0x70/0x118)
> [  165.347770] [<c01516a8>] (__atomic_notifier_call_chain) from [<c0151768>] (atomic_notifier_call_chain+0x18/0x20)
> [  165.357949] [<c0151768>] (atomic_notifier_call_chain) from [<c010a828>] (machine_restart+0x68/0x80)
> [  165.367001] [<c010a828>] (machine_restart) from [<c0153224>] (__do_sys_reboot+0x11c/0x204)
> [  165.375272] [<c0153224>] (__do_sys_reboot) from [<c0100080>] (ret_fast_syscall+0x0/0x28)
> [  165.383364] Exception stack(0xd80a5fa8 to 0xd80a5ff0)
> [  165.388420] 5fa0:                   00406948 00000000 fee1dead 28121969 01234567 73299b00
> [  165.396602] 5fc0: 00406948 00000000 00000000 00000058 be91abc8 00000000 be91ab60 004056f8
> [  165.404781] 5fe0: 00000058 be91aabc b6ed4d45 b6e56746
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - keep comments
> 
>  drivers/mfd/rn5t618.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
