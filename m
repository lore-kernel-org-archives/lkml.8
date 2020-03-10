Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D86C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905DD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S+pLjMqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCJSL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:11:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36538 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:11:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id c7so940266pgw.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yrVZjd8gZ0Ysia7WKkOlNyA8gHSCOfIvJw2hn5fXOTo=;
        b=S+pLjMqdeN6mnY8CQehC3nBw/yA6NMpCjF8qbgxUBM1lcueUbng2IKM5q69nW9YMLI
         1K9oW8b1DaZDeSNKGBvlwA1Q+d9J2pBu/3a4VL6E7nlJ3ZWwc2zSouHg+21N2OJ6NviD
         shULJYOBdJPXnC8VaRxjyev4hoQU5eXx2v66k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yrVZjd8gZ0Ysia7WKkOlNyA8gHSCOfIvJw2hn5fXOTo=;
        b=gm1bccVQWuNRdL4v71bgpiNhqMUik52dg7MtuX+AlNY4aD6Kr3XIJDWd3/bX0IIoub
         qF+/MEpJf/7KVVXFZuXIfVmKimJ1QqH6jX/8MmjMBRZlF+TtBLdue9tnqLSJPgYhSu5/
         H624LHL3BJ7gAxc3AN+2pS/959HX/CJMxxfPUKZyjxWPWcotZcirSZKOH0anEUklkQGL
         R4614UZ2EPHmpAvhLxU0Esvtrkti8omP6YkJXwosgjOr6GW1dVvGijh7euXUvr78kojX
         RTBSBlG0u1mE2GJyWYs2NqyVe2AtmOmXlP31NeJQJukLNA8dnD3rNOub0/IBR6fPloO3
         kiXw==
X-Gm-Message-State: ANhLgQ2rKQ2p6gEWjWd1Tb3a5TJA3Gb+F5jnkGNmYLxx2adFEWk8bppq
        c9490xqBxbqsaDeVDLrME7sSkg==
X-Google-Smtp-Source: ADFU+vuipIwBt7HZ/eXbGMHyK0C9Xm3ciUBrtc453qCMfM4q/YxsgsKOtlO41E3QCYP95HQyqRhlwA==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr6992656pgc.412.1583863885067;
        Tue, 10 Mar 2020 11:11:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c17sm27415625pfo.71.2020.03.10.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:11:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200310063338.3344582-5-bjorn.andersson@linaro.org>
References: <20200310063338.3344582-1-bjorn.andersson@linaro.org> <20200310063338.3344582-5-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: qcs404: Add IMEM and PIL info region
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 10 Mar 2020 11:11:23 -0700
Message-ID: <158386388355.149997.17460216194595657584@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-03-09 23:33:37)
> Add a simple-mfd representing IMEM on QCS404 and define the PIL
> relocation info region, so that post mortem tools will be able to locate
> the loaded remoteprocs.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
