Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51AAC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964B420752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nShgZuGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCRRY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:24:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46487 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCRRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:24:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id r3so3425717pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=rRLYiVDNdoFKaz44hzKF+TYh+5BDTb1jEIAXmQ8LTpM=;
        b=nShgZuGYvfg/lm0eV6nf2boUKEIhzQmCDFJo5lIjTLtvcWJ43RSDwt2OkCjpmiwmg7
         QIUuMhTV3krbGiQsBuNsy3XkcD2oh3Y5GbCkaeb9Amy2ocmr3I+788/SVSzDoiFAg65k
         P7DpdggDgYopjZCY86UzGa6uO3Jl9VhjFvsHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=rRLYiVDNdoFKaz44hzKF+TYh+5BDTb1jEIAXmQ8LTpM=;
        b=C9Do9q2WiPGFtXr/Ve781I0zvejhexPhtpghP2HwYwugmAGntuC3/au+hoYhZCjlTp
         NyALeUu4YEE6NGKpRWNeLz+deyaDxo6g6cMThRwnLTSlq25FWEMJsDiSBN9PFHRGKhgN
         Nh7a2x+bHbURdP3vcQXW3+aBRE6ls+/wudhDHqEl9WXAhwkibHqaoqFEowqdHZ1lBMqy
         ZLgg+EBaX61MGfnakk8OBeKFcxtI/Afn2KkObwpfud18RWHSwFBPju6jjVCinXzMiZFZ
         IoDw3TcH4kKNFrb1sgILsrl+0z81gP7Bi/a3A9mpXc39x+vCUb2OjE6MMQusNMveNBfh
         rgkA==
X-Gm-Message-State: ANhLgQ0UraeVJDaQABLY6C25TCzHiQii0TSH4vH7q0Ja6TJIhGQcqEaU
        jfF6GP1Q8IW5g58ExkQAAGvILw==
X-Google-Smtp-Source: ADFU+vsL6KLzScjymJt4WsBhfm+VpoTPWtgYlDZySTyomnvSnr/Veib9XWetxg0wOC/I0+mnxFfLJQ==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr4780076pls.176.1584552297314;
        Wed, 18 Mar 2020 10:24:57 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y125sm7486177pfy.195.2020.03.18.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:24:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2526d2b2907116d1bb6f7edd194226eb7e24c333.1584516925.git.amit.kucheria@linaro.org>
References: <cd0f3d35ca0fc2944fd97e030a28318ff82dd5c1.1584516925.git.amit.kucheria@linaro.org> <2526d2b2907116d1bb6f7edd194226eb7e24c333.1584516925.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Fix cpu compatible
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org
Date:   Wed, 18 Mar 2020 10:24:56 -0700
Message-ID: <158455229603.152100.18101475238223716722@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-03-18 02:08:17)
> "arm,armv8" compatible should only be used for software models. Replace
> it with the real cpu type.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Maybe add a fixes tag too?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
