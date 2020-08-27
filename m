Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02552177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jySuFVee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgH0PpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0PpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:45:08 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAD5C061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:45:08 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id x17so1802002uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdB0pPDBq5ZlSvrIwz1JATX0kjJ8iII0iAds3ECexio=;
        b=jySuFVeeNbfR2c8zFN2XhnZFz/Wi84T9HhLrjTppcXCO4HGJwh2J0jsBunahfcPJy9
         pL+NE+pzbJv77HHBDPaunvCXm1mDBE7bn5LNsLJBF9QYy9jlrJBPLKdvMLnF4Pe+eH6y
         Vi0Rc/SAcjS4gaT0/eKBgAGHG6eJJcNb0xq+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdB0pPDBq5ZlSvrIwz1JATX0kjJ8iII0iAds3ECexio=;
        b=O5mRw+057bnIRczkHFj6illd0IAAX9AEOk2SEcbt/tLjN+GL3OzQ8UI+kivDPHdxbB
         03oPgyiT+r8cUTpPMT48EOJwQkqbHWdATJX1awCzTMUAKOiCFsHp1sa0dImoOcIMwAzo
         y4k/tmYBBiG2gsunLA0R4cOFqc9trHcB0KQwD8IIAqGuztTNeFHIrBwYRQuPGfVftnui
         AVpjXRdqNe3DmPQJMvZVWx0iCaNhjOL84+BeE4i9cvjlVm56jxVyODhW9fHU6J4Sqfeh
         g87vcP/vG28nDaob0Si23hDO5vIWDgtpLlOKr0mp2eToN3p1pQ7O/CBP93cWiNM05K9b
         zf/Q==
X-Gm-Message-State: AOAM530aFzJxFTYw7SA9+z7m5QCwKcQ3Qrv9wRVWomQFlEVgmUhdL5KB
        CFXL4w5s7jwm6r+O2GFG+ILSlhibwl43eA==
X-Google-Smtp-Source: ABdhPJxN7pZoQ31ziNhp6t4MX/wTeqbHU1DC3wWABypz6vtn+mmD2qbxYQ8fNLBeE0lmLDdpbe6OLg==
X-Received: by 2002:ab0:65c6:: with SMTP id n6mr8065464uaq.57.1598543106238;
        Thu, 27 Aug 2020 08:45:06 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id e124sm387784vsc.2.2020.08.27.08.45.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:45:05 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id v20so1805309ual.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:45:05 -0700 (PDT)
X-Received: by 2002:a9f:2b89:: with SMTP id y9mr12664378uai.0.1598543104976;
 Thu, 27 Aug 2020 08:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200827084102.1.I7a5f56b411071eeecae84b7e33981d39170ccf2a@changeid>
In-Reply-To: <20200827084102.1.I7a5f56b411071eeecae84b7e33981d39170ccf2a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 Aug 2020 08:44:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4f_aUn2N91yCNXyjTJJkrCaGH-gk_pJeCDJHXPxh=nw@mail.gmail.com>
Message-ID: <CAD=FV=U4f_aUn2N91yCNXyjTJJkrCaGH-gk_pJeCDJHXPxh=nw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: We need to restore_dll_config for sc7180
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 27, 2020 at 8:41 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Although sc7180 is supposed to have a hardware fix that means that we
> don't have to restore the DLL config like we did with sdm845,
> apparently the hardware fix doesn't work in all cases.  Until it's
> understood under exactly which cases we the hardware fix malfunctions,
> let's go back to restoring the DLL config whenever we do runtime
> resume.  This is safe and gets things working again.
>
> NOTE: we don't need to introduce a whole new "struct
> sdhci_msm_variant_info" for sc7180 since it would be exactly the same
> as the sdm845 one.  We'll just refer to that one.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the spam.  I was too busy debugging and preparing my other
patches and didn't realize that Veerabhadrarao was sending at the
exact same time.  Let's take that one, AKA:

https://lore.kernel.org/r/1598541694-15694-1-git-send-email-vbadigan@codeaurora.org

-Doug
