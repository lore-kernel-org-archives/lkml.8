Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F90BC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462C921569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="etSOx2QQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgBLXEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:04:41 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:34001 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgBLXEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:04:41 -0500
Received: by mail-pl1-f175.google.com with SMTP id j7so1533845plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=PhL4y2Ns/NFToQF8DJTrK0HgwaVtHS/iKBzX00SobGg=;
        b=etSOx2QQEAZg4TSjUxAks7fbX9BcsRkiVRRMYr6FIwMR3psVVZ5yLkRbRsEvo+digw
         xIvPLGAyoOVYrzyaTe6ptofGbcLLTD8Tqobl/9QXZJhfW6O2F2FEKHl1Pwa0mrPViUMW
         YdFchCgHQPcm64dUWuclWZGdJc2pBos0E7WUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=PhL4y2Ns/NFToQF8DJTrK0HgwaVtHS/iKBzX00SobGg=;
        b=Sxec0JaLfzPxKtsO3Iwz0COILE+UdScC1Dato4DDR08jNte3fsy3QAiK6J1rN17kTe
         dgDfTQJzK8dn4nBKBZIhNEq1YEWPlXk8oVriSJYMrHEgv9BvlFpuspvIisK56qMgT5ku
         wQsHECsRhKa92Hmxbo8GpXcQg4+3CjmhCFMO9mkJfspRylMhZ4msbjve2+h5tbXNAmbI
         EuHz+2p/fg7t4DPva9kWFlT76ybmv5hxNvCLKvFKIc0Nhg0zPMBYcHRIFW7QP4C2B+Z6
         mTu2SCvR7rztE4kZIyJ3Fe6GctNXH/mvqf6iGqfAc4pYcjKWctcN0pbnJzmwc4g6idkv
         7KGQ==
X-Gm-Message-State: APjAAAUrQ92UzCJmPBGWI7lXjKqD4PdcQCThSaB869/9ne4grOUHcPtp
        hz3xcv6Tr2ntYXwOU2YecSlRj2hjgtI=
X-Google-Smtp-Source: APXvYqzxgU+5yuNF5Rv0HXS9zL8x4pILgTjsHg6W5JxhCX4rgS04HgMQN0+uAntRPS6fbBe1asYfFA==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr10720820plj.146.1581548679950;
        Wed, 12 Feb 2020 15:04:39 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v5sm191562pgc.11.2020.02.12.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:04:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205065421.9426-1-swboyd@chromium.org>
References: <20200205065421.9426-1-swboyd@chromium.org>
Subject: Re: [PATCH] clk: qcom: alpha-pll: Make error prints more informative
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 12 Feb 2020 15:04:38 -0800
Message-ID: <158154867848.184098.3370579513642470683@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-04 22:54:21)
> I recently ran across this printk error message spewing in my logs
>=20
>  Call set rate on the PLL with rounded rates!
>=20
> and I had no idea what clk that was or what rate was failing to round
> properly. Make the printk more informative by telling us what went wrong
> and also add the name of the clk that's failing to change rate.
> Furthermore, update the other printks in this file with the clk name
> each time so we know what clk we're talking about.
>=20
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied to clk-next
