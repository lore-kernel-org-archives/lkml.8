Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B65C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27901206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLLtK1Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGXU1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:27:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB2C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:27:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f7so297149pln.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=FvJp6KRxuCLfQ1LrQuFAFBgfAkQQ7QvIAiuIgT4S7HI=;
        b=bLLtK1ZeE35eR4FeMC+fIRZcgm/BS04TxFnqA147MIiBhcPUrpTjQ8mBLU2R2PtCm9
         CUVySufyEYz8uVUJpQ49823cuD7nd7ZhKLAi1xYUsl3Pn6QhRjbfekw074vqy7qJrFyO
         OmkvtFikiS+cJRmGZVH7c4nQhXUT68Q9nduVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=FvJp6KRxuCLfQ1LrQuFAFBgfAkQQ7QvIAiuIgT4S7HI=;
        b=S9wsYKGjBr9+4vVggyLzLXYg9YMKRZ7ZKH+y0oIHqoEfOzX6j41QLnU2Huxh5XvkCl
         ny6IWvb3xmGzt1bVBjyO4Nj6aWKMG2VnJTA8T1yxMvEvmgs+m1c7YCRD16P2Rgs5mMAk
         H5dygUS+Ogq+XI5Mugps669XjGkAPJiyDZk+7v0EYByEJEn9QDpHmRppIqZwou/5se6u
         rGKMN3R9vWKbEtNnS/qLHLU0jeN/wBV8wcyspFU0/2sPhSwJ1uwqU2OnaW5IArWR4x4W
         E0qHZNUAF0vf2ioKR8DwPphO9WQW0b3x436T+iHwEuRo6edQklEidevWgI84OHnw1jtP
         baAQ==
X-Gm-Message-State: AOAM531Ovbjfjc0m6ogg9IlwNAy+lYJ4vRhDhnvthRWyO+rd4iQJ4pPp
        +FsRKrj7z84FiW/TzJrKK02k1Q==
X-Google-Smtp-Source: ABdhPJzNm0R7S4KH72z9GGjwL6AJWsQTruzmVb+ywN6nSy348ghglA8LdzPaCVFFbhqmejehPPY8sQ==
X-Received: by 2002:a17:90a:d181:: with SMTP id fu1mr6839522pjb.60.1595622442012;
        Fri, 24 Jul 2020 13:27:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id nh14sm6590084pjb.4.2020.07.24.13.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 13:27:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VUSwsP_xrHsufLjZqbWdn5V8rybtv2DWad2nBfU+VJ9w@mail.gmail.com>
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com> <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com> <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com> <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com> <CAD=FV=VUSwsP_xrHsufLjZqbWdn5V8rybtv2DWad2nBfU+VJ9w@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:27:20 -0700
Message-ID: <159562244072.3847286.7905035931282026601@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-07-24 13:11:59)
>=20
> I wasn't suggesting adding a timeout.  I was just saying that if
> claim_tcs_for_req() were to ever return an error code other than
> -EBUSY that we'd need a check for it because otherwise we'd interpret
> the result as a tcs_id.
>=20

Ok that sounds like you don't want a check for -EBUSY so I'll leave this
as >=3D 0.
