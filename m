Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F3AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EBF20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VAJ7aZcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFVJDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFVJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:03:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F073DC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:03:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so7295583plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=VH0r0uZC1wtlOrO1ywGA0KQHRUl0p+vXgdBe48JFKCA=;
        b=VAJ7aZcndX+hJj7qt2LQqJg/H6PgLgjWrr+PCPom7NznZZZNa6+M3MJfT3hMhEXSUw
         7m4GPLOCCdu4EKKd8h/o2tD8izj8Rc9onLmnG5SJDvEXeU1HJSzMsWXe1k3wPHhJyIis
         IhDTzKRPLb2s4V9ERRwLXeVVc6sJmklMi1RX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=VH0r0uZC1wtlOrO1ywGA0KQHRUl0p+vXgdBe48JFKCA=;
        b=F+dfStq3Mxt60DSprHYYM1SrzLK4IMoYF7zGmcK2Rw/3ZUxnVKamW8HxpqAgMeFYr4
         BN6LbcDH8d6thYmvAgA7bn6xhABuXfxOk9DnvIjPwkU+b1MUbT1KFfjpbeJQhTEhoG+r
         pCv9ZXlxfiHkBSP8V/UQ1zP5czOjMjzD97cg/S8wmxSZr0WVVUwv0eLSaTeRRaA1tnOa
         iqpxiyYEW8W6do/LGmykvAASHGcRACPCx96VMp1veykIwDFY8oEl9I9qcJQ9FOqex8vg
         4Wal2bjWWhW6POkk0bG3qlv9HkxqDR3jNzLmUdrr2KT5m9rWfWmqwScFTTo9zIpL8TqU
         SS6Q==
X-Gm-Message-State: AOAM531RKCgR7GCOplXv464iHAM8dhCgUVgjfQdbOujXw315C3yUe43c
        +9L65fE9r4qOUT2eqXX0Y0xsD97h0gA=
X-Google-Smtp-Source: ABdhPJzx9iJyTpafAjDQCcomXRFmiighh6Y3XbMiQq3c1qBE+hl+fSbPVA4DIj4FPJK2DsriskyHbQ==
X-Received: by 2002:a17:90a:68ca:: with SMTP id q10mr17572752pjj.120.1592816591359;
        Mon, 22 Jun 2020 02:03:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y3sm13650985pff.37.2020.06.22.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:03:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1592808805-2437-1-git-send-email-mkshah@codeaurora.org>
References: <1592808805-2437-1-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Set suppress_bind_attrs flag
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>,
        <john.stultz@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Date:   Mon, 22 Jun 2020 02:03:09 -0700
Message-ID: <159281658960.62212.15968925558324290917@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-06-21 23:53:25)
> rpmh-rsc driver is fairly core to system and should not be removable
> once its probed. However it allows to unbind driver from sysfs using
> below command which results into a crash on sc7180.

What is the crash? The world falls apart because rpmh APIs start
referencing pointers that point to freed memory?

>=20
> echo 18200000.rsc > /sys/bus/platform/drivers/rpmh/unbind
>=20
> Lets prevent unbind at runtime by setting suppress_bind_attrs flag.

Ok. But when the Android module brigade comes knocking they'll have to
revert this change and solve this problem too. Have fun!

>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
