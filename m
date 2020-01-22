Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E25DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F1924656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Py6sZFPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:20:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42978 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:20:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so65283ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vIx4lscja28Uh7U0W4QY+DTsixl+e93XKF+xyAQNdMk=;
        b=Py6sZFPW2rMeWUelSibRbBmW0O9lCok0imy0xJPQxD6E5wUAmwUvG7228z23p6JjM2
         UjNDlKBFDWAHAWBNLSzZJGpyPzmo+t1ZWX7pWot2/Keh7r9YC4/BusdkIjsRhOhzUb1u
         ZMdT5WzgP9usGVMRUrOU0FEmzrDSNQd/jZ+JlLzeLF0gCML6gsJlFNpbQ7rBtJUcF3+x
         HigiKuS8ujAFanPzShz6dbqHtKy01a4TsAoL+PPC3PMc5uGmDJH0eR+fWEYGNfesUTyV
         K2ztLTZ1DnW4Srpx5HUes9jnw3SIWWPncUiMF6JJkwSBf1OsOBFxnNpx6FLQjF6sem9j
         RUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vIx4lscja28Uh7U0W4QY+DTsixl+e93XKF+xyAQNdMk=;
        b=jzcgFmrFQfeBviLCfLFbWmR4wwWaGOGivl2ljKGV6lxixpIE+3eOrgXHUcExTrfkKs
         av6cxYokmNgsA09k9+ndoNJACiai7rM6AkHrAMNg62VqRnsN/twiMddt3TNvTKP9GK9N
         yzq2tUIGQZcriDEFYSclvrsH+XQcXHW7S63vc892R8AamkUCmHuG87LGdNJnhVIRQO3Z
         G7sfwg/J5cJhKuP0diKn9ka2OhwQxPXQqOv0AhvSAaDSf/hEINq2HDAWugEqfu84RflG
         TAQav6pbhV+Wzc8B5YdCsyyKYy2R6EZw79HMBDcmscpi0hf3jOjhES3z1nWZEnb7NtAQ
         0lZQ==
X-Gm-Message-State: APjAAAXers4EUz+9pjqYXBxaBj93N2grzcHCNxclFd+xts+ewEPEMYvw
        +vCmy7IO+tUfzh97GHfEZe8oblfIWvKmxxWexDBg1Q==
X-Google-Smtp-Source: APXvYqxNDXbU8ueVFwAk29RRDB6v2Wy5WnK2yvmYNk28ZFeNKo4WqmbHLF/xp/FllzS+5GSJAZZR2B/JpGKIWq2MKuk=
X-Received: by 2002:a2e:880a:: with SMTP id x10mr20107250ljh.211.1579717212687;
 Wed, 22 Jan 2020 10:20:12 -0800 (PST)
MIME-Version: 1.0
References: <CAN5uoS_YyPXiqZnNfM32cxeAsK+xuPX9QRK94-DJ6oMQFrZPXQ@mail.gmail.com>
In-Reply-To: <CAN5uoS_YyPXiqZnNfM32cxeAsK+xuPX9QRK94-DJ6oMQFrZPXQ@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 22 Jan 2020 19:20:01 +0100
Message-ID: <CAN5uoS-9yUfAT4=a9ys4d_2wxh9nW_RgXd_-3T-zF2r-k-PtOw@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>, f.fainelli@gmail.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        etienne carriere <etienne.carriere@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peng and all,


> From: Peng Fan <peng.fan@nxp.com>
>
> This mailbox driver implements a mailbox which signals transmitted data
> via an ARM smc (secure monitor call) instruction. The mailbox receiver
> is implemented in firmware and can synchronously return data when it
> returns execution to the non-secure world again.
> An asynchronous receive path is not implemented.
> This allows the usage of a mailbox to trigger firmware actions on SoCs
> which either don't have a separate management processor or on which such
> a core is not available. A user of this mailbox could be the SCP
> interface.
>
> Modified from Andre Przywara's v2 patch
> https://lore.kernel.org/patchwork/patch/812999/
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I've successfully tested your change on my board. It is a stm32mp1
with TZ secure hardening and I run an OP-TEE firmware (possibly a TF-A
sp_min) with a SCMI server for clock and reset. Upstream in progress.
The platform uses 2 instances of your SMC based mailbox device driver
(2 mailboxes). Works nice with your change.

You can add my T-b tag: Tested-by: Etienne Carriere
<etienne.carriere@linaro.org>

FYI, I'll (hopefully soon) post a change proposal in U-Boot ML for an
equvalent 'SMC based mailbox' driver and SCMI agent protocol/device
drivers for clock and reset controllers.
I'm also working on getting this SCMI server upstream in TF-A and
OP-TEE. Your SMC based mailbox driver is a valuable notification
scheme for our SCMI services support in Arm TZ secure world.

Regards,
Etienne
