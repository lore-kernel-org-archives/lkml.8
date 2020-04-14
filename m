Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B5C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE282076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iOcrYMBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633107AbgDNU1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633075AbgDNU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:27:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DFC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:27:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u65so467306pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5RliaQQNnLJGpwVof7AGBkAovyUlF93NpEx2vg6GNe4=;
        b=iOcrYMBcdiFRcFr0faRBE/ds07jwz/BEpLwqistfEEFf6yRAe8whtW2CQkBWGZfBsG
         Ywb26Ql5Z/gsMuE8AlDFDpqSPdgIY16FIZDFs5sZascRUrD6fWCXip3cEB65CrTbj3St
         WntNTNQJuzqZQqOkyWQdlR20ejSDlr3lM5/mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5RliaQQNnLJGpwVof7AGBkAovyUlF93NpEx2vg6GNe4=;
        b=eN4lNXHfLg0t1w3qins5p64yG7/IAJSEGfH7Ej+BCp/Pf5OWzcT7MGz1q0dbcDRc7I
         8FS7W4x8OzibcwzySpOkY+lrpm8QrOzClgGCicHze0jWvAZ4y3r3KEFo1TgyFiJeHiNb
         RVVBDpqD5Tx0+64di/zIf6BFM6im1Tf2UGWJur/mB63maF+qA0SATyJIPySEli5/5Lig
         fKL5DzP3F3m9wJB89ccsJdfR0Avrbx546dRz2WXuADGYT7Yknb4lq7B/0m38YNKdaloa
         Gl1Mq0hVjtX2Q27IMyllTKqWli4//16x25O20Lp3unOYyVdGG0p3MF7z2Ls4SbPEyEKK
         WfMw==
X-Gm-Message-State: AGi0PubfSN8YkUMk1kb6BMWCNUx40hnvkrTKA+iSz09UPVPIYiiICaQR
        MjIEY/f/07Fc6YYGNnbW5pbTsg==
X-Google-Smtp-Source: APiQypI31Wb4q3OPBM1+ulbl2yfyn2IeuOw9HklrX+6xp4oesOVGYL42/oWbtNCZaqIQk93D9uOWJQ==
X-Received: by 2002:a62:6204:: with SMTP id w4mr2667614pfb.273.1586896062457;
        Tue, 14 Apr 2020 13:27:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j6sm11873666pfe.134.2020.04.14.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:27:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200414131010.v2.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
References: <20200414131010.v2.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
Subject: Re: [PATCH v2 1/2] soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and "tcs_cmd_addr" calculation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mkshah@codeaurora.org, joe@perches.com, mka@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 13:27:41 -0700
Message-ID: <158689606109.105027.1689640688969579125@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-14 13:10:15)
> We can make some of the register access functions more readable by
> factoring out the calculations a little bit.
>=20
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
