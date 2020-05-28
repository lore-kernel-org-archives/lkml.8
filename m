Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247A7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC16207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VmAFHRbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437311AbgE1Woy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437279AbgE1Wou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:44:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4687C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:44:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so312880pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CzlwaQBhB6X7vtfLTVD7DA58u/rA562/f1SXevkBPwc=;
        b=VmAFHRbfcJExWJg8IgA6FKmejubQ9aKrIMIpPgpBFIhi+OMjmGfyYIhaTxzH6Poy/w
         jdvuOtq2cPl5F0semT5ERouwcWiYv5TlPYJ933Xqr+/eboqx/JeNEHqXDYbWa6RA3L5u
         gvsCSQ26kDVhEfH0T0/kDNwzv32S1XZYOCkFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CzlwaQBhB6X7vtfLTVD7DA58u/rA562/f1SXevkBPwc=;
        b=B8gj4/mYXaUecEzrHZqSh1HhlS8Sq62IN1dID0d5hoYzvBMYqoJOCd31oZMg3yBnBA
         2CkonpSUqUprCmWepy66dxAFnQsZtinRPB9yMCqP1FZ+7SdQvd63+FI4pt44GASleZFr
         z1ZWZK6skzLtcCgeeWkRkLWShlMW3Yp5viihVItf6HNgmgH67zlrBHeQS2b/fib4roSK
         eAB3BWyen+NVCrWOHheBR5CDuy0enqB3/n9btCTo78Kb9/hfvPLDrFINR9Ofs5SQDWjZ
         MWyqWUm7RZeUpLib30zaxyAIPlNGFxlQf/7UaYBSsvwig0mMJAVWITYY9WA/we9A1ik5
         72qA==
X-Gm-Message-State: AOAM530MLd39pw/IxDKUNvC8CuoggPu59MiS8oZ1zm+kLRwWVTk0J3ME
        mR3TfhZNuPQfDYFJ9c0UtlKvRg==
X-Google-Smtp-Source: ABdhPJydC1Uuong0oSvH9QsEwRg5vR0vIvCmTEg9LwzUV3nx+omAdHyv2zklrA8Igo05zSZkK9WQYQ==
X-Received: by 2002:a05:6a00:1486:: with SMTP id v6mr5324082pfu.83.1590705890029;
        Thu, 28 May 2020 15:44:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z18sm5600812pfj.148.2020.05.28.15.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:44:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid>
References: <20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Don't use ktime for timeout in write_tcs_reg_sync()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Thu, 28 May 2020 15:44:48 -0700
Message-ID: <159070588846.69627.5268638209383373410@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-05-28 07:48:34)
> The write_tcs_reg_sync() may be called after timekeeping is suspended
> so it's not OK to use ktime.  The readl_poll_timeout_atomic() macro
> implicitly uses ktime.  This was causing a warning at suspend time.
>=20
> Change to just loop 1000000 times with a delay of 1 us between loops.
> This may give a timeout of more than 1 second but never less and is
> safe even if timekeeping is suspended.
>=20
> NOTE: I don't have any actual evidence that we need to loop here.
> It's possibly that all we really need to do is just read the value
> back to ensure that the pipes are cleaned and the looping/comparing is
> totally not needed.  I never saw the loop being needed in my tests.
> However, the loop shouldn't hurt.
>=20
> Fixes: 91160150aba0 ("soc: qcom: rpmh-rsc: Timeout after 1 second in writ=
e_tcs_reg_sync()")
> Reported-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Although I don't think ktime_get() inside of readl_poll_timeout_atomic()
is correct. The timekeeping base won't be able to update when a loop is
spinning in an irq disabled region. We need the tick interrupt to come
in and update the base. Spinning for a second with irqs disabled is also
insane for realtime so there's that problem too. Maybe we should try to
kick timekeeping forward from these loops manually. Anyway, not problems
with this patch so not important to fix immediately.
