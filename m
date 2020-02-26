Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15AC4BA2F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837A821D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUzAuOkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgBZWh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:37:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54169 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgBZWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:37:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so255373pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=MkiYANXNDKKBU04CoetleQBTgLDcDU4gpW2yHn2bIZk=;
        b=QUzAuOkfTreAOpJoiQlWLoPiROWp7KYC1iJAW8U04PHb4HNcpVaobovd8+yYcVaCcm
         3FITmEN9ShOMDXtu0lhwCKYnn+a8izFZZcZYbHjCtpqyVz8DR++HI8K0DZlcv5Vu7pPU
         2nOO4Ibx25LheW8f/J33e/Z+YnEktMRgXj2bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=MkiYANXNDKKBU04CoetleQBTgLDcDU4gpW2yHn2bIZk=;
        b=FtWJhfYV4dbirrsWGfn2K7BNQJRZcC7wkwkCuRC+4/HdjrOhZ5RNjc1MAyOA4AzgJg
         ruWKnAV7CoZvEOdVVbycQCrIcH0AGqRzBNEHu7Cn+n5B6bx4Kn01yjKqB2m2JdNYPb53
         eNiBR+qaCr9dXpV0bxI3+mu8daiudlGqs7po455ZEQchzwwtWoeMZs9lz+c7IAhwUXCd
         zVyg5338flWNHhQI3uj2vfj3+DSfbBoW8nqtr4hUTdex6kxld5gKMHC3w8/fn3IOlR0v
         K4Sbc2zawywuwQcF1iDT5sR7kn13UoCCI0HPkyoyrArTddzI4m30Q/WwiHG1/STOgKLG
         KTdA==
X-Gm-Message-State: APjAAAUt/lpU/lm/2pkM55DNIcxEykw8NY+IpXOqtykBGMCt+uouTK8S
        EJWA6R5Un9/IwZyrOXIL2CpM5arhcrc=
X-Google-Smtp-Source: APXvYqx4pAuCqNuJKULTSNu1E8O8v8SPGjUJtCyCqLQLK6VBYPNxlnO8gYz+J569pQGTu1uqWz6KfA==
X-Received: by 2002:a17:90b:1256:: with SMTP id gx22mr1435935pjb.94.1582756677657;
        Wed, 26 Feb 2020 14:37:57 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y127sm4362635pfg.22.2020.02.26.14.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:37:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582694833-9407-2-git-send-email-mkshah@codeaurora.org>
References: <1582694833-9407-1-git-send-email-mkshah@codeaurora.org> <1582694833-9407-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v7 1/3] arm64: dts: qcom: sc7180: Add cpuidle low power states
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>,
        devicetree@vger.kernel.orgi
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Wed, 26 Feb 2020 14:37:56 -0800
Message-ID: <158275667604.177367.11185757008232316036@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-02-25 21:27:11)
> Add device bindings for cpuidle states for cpu devices.
>=20
> Cc: devicetree@vger.kernel.orgi
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
