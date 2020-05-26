Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D6620721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaHt12wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbgEZSNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389096AbgEZSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:13:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:13:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so8983417plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M5+lH45bn+qZSHAItaOoLPP98v+wT4Co9b5U7SWVW8=;
        b=RaHt12wvpTY6tOtLb0vsYNtTEE8M9Nm7372Hem6BcTR/cAOxWvBgWbepKF+wDO6OOC
         L3qLV61B7B4CQ08v0XAJAVSWUAfbp9wb2Nnd8a3VpYrpmZPuQds2W/QiR/KhovDSfCpR
         1jmQxShRSLc9XMnsKLdfUDzjFXPK6YmrpNPWzbxPLyA1KxyAtlStDGCghvauxIc6x8ZE
         vGsoDOzYTBOwrJKFRy/Sgdes9XFX2bQitPEsE2UcvUce49QHdWVEUZBP5ybPin8Kcq9B
         XE/9GXrpHUjrTR+CJVn+HVEnBH83BL5If0DRL/kgTJ18N9m1V5bG2vYyDpxLdwXgk1rs
         M+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M5+lH45bn+qZSHAItaOoLPP98v+wT4Co9b5U7SWVW8=;
        b=An+I2aIsOeaMv8OMccRlvBS1rfcS9oNJqzT1rWJqoXP3OmXr2Q6z9LFlrKKNjwyLPc
         rAD/GJbRMbEpmHGdlJ5cAd0iPkZCQ2ipvZVHuGlkKg4eg3dAl100zHZVuJ7qiFDq8+p8
         vfq23hJFduHPLVgEUIvsCchTYBPJ2oQH5FiNE2kb2CWQPh8d8XQ82TGH7kfCLwrFdc51
         K7cB9avc40HQMNmqNw6NGr5dy9t4+d1l5IKmnhBDAps/orB1d6hi+/BQDPKHHIdydqYJ
         FP44lUSG5haTwLn755tp3f/kdhoBzkWUwGS4O9igMOttAWPyyF2rYwuLQ8OelzBq9uOX
         H17Q==
X-Gm-Message-State: AOAM530B3taQpyWVQjrxFGgYzTFwhwo94c3kEvCI/w30Ov3ZzUKGM7fz
        OqugpEuB+zeaKwu2eToLWZlYXNAxehGoWSQm0ax2dQ==
X-Google-Smtp-Source: ABdhPJzCI2IaRrre0DNAyviJoRQ9WlP6w5J0/ocpcicOcqrWv8jwyVF3MAlAf3fUOwAkM4Ajekm9oh1GFMghlWI4l/s=
X-Received: by 2002:a17:902:341:: with SMTP id 59mr2088402pld.119.1590516789291;
 Tue, 26 May 2020 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200523035043.3305846-1-natechancellor@gmail.com>
In-Reply-To: <20200523035043.3305846-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 11:12:58 -0700
Message-ID: <CAKwvOdn5R0md+9jVGrzQhR4ZfcSWsCqPE9qK2UxMDOKnWnpaKA@mail.gmail.com>
Subject: Re: [PATCH] phy: intel: Eliminate unnecessary assignment in intel_cbphy_set_mode
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 8:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/phy/intel/phy-intel-combo.c:202:34: warning: implicit conversion
> from enumeration type 'enum intel_phy_mode' to different enumeration
> type 'enum intel_combo_mode' [-Wenum-conversion]
>         enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>                               ~~~~~~~   ^~~~~~~~~~~~~
> 1 warning generated.
>
> The correct enum to use would be PCIE0_PCIE1_MODE. However, eliminating
> this assignment is a little better because the switch statement always

Indeed, the switch is exhaustive.  Might be a risk if new enumeration
values are added to the enum, though.

Probably should just initialize it to PCIE0_PCIE1_MODE, then you can
simplify the PHY_PCIE_MODE case a little (replace ternary with
if+assignment).

> assigns a new value to cb_mode, which also takes care of the warning.
>
> Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1034
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/phy/intel/phy-intel-combo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> index c2a35be4cdfb..4bc1276ecf23 100644
> --- a/drivers/phy/intel/phy-intel-combo.c
> +++ b/drivers/phy/intel/phy-intel-combo.c
> @@ -199,9 +199,9 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
>
>  static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
>  {
> -       enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>         enum aggregated_mode aggr = cbphy->aggr_mode;
>         struct device *dev = cbphy->dev;
> +       enum intel_combo_mode cb_mode;
>         enum intel_phy_mode mode;
>         int ret;
>
>
> base-commit: c11d28ab4a691736e30b49813fb801847bd44e83
> --

-- 
Thanks,
~Nick Desaulniers
