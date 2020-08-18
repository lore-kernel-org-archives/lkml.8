Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E0206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oekTgrwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHRVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHRVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:42:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB9C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:42:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so5932640plj.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=e5nsLglQi6iq0gXD4/ZLbxZPHmUiCWsoxGRyVuLjB/c=;
        b=oekTgrwzSs/TnRji4n7Ia1KRw2sKFuCY6qwuXQcuT84qxYNIQBTvSVH5zSdQoh3F1L
         uAmAKAJagFUtKA5NCI6262idBc6YE3mg3C8P5KXEG9A53xdLiIZsbpEfCEA3ovO+r+bw
         D1Dbnfw3JW6d3gniWTVyrMYPGrYKyffZ21TC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=e5nsLglQi6iq0gXD4/ZLbxZPHmUiCWsoxGRyVuLjB/c=;
        b=Ra9UH9gtZt11BeWs3epRJTuk20CT4qyi+vD8rtHv6Ob85keGnc7Om9BPr88VzuY3oD
         zLTkogiT/2go7hC9ccc7zkrXOLEK+arftEYvn0OqrcKnLKiKN9JoXDbpGck2KlkOwaEd
         tazlk2R2JrI3YVMUqg3hcSuo598BRciKvwoKAMbv5u4f6kzfVahXGCWZtFr2tDuLmtHb
         lwt0fDVtTpGjZ8l4mDKUHhuIva7LJB4UqE9/qZ9mnICmAAoGDFNbW/tK6xTBzd2njzb4
         Toj1ZOdrkTpw6YPoh6eyVUz3zRBpQjXKYqusTXna7nuzb7+qpU0jHCX2XRJge7hKiTnh
         zRig==
X-Gm-Message-State: AOAM530nmkKDl0+Vm5MhnrDeotQScdZbNoy6OdCma7MIthWvdUlKmHUq
        M6zYTXaKHZ2svpfzerl4CWqZ7CDyxIpvnA==
X-Google-Smtp-Source: ABdhPJxNWxWkdy4uYKtZpGauvgOCAqO43bYBYkbW03fwXdZ7RgGCLEOkwT4RULfvoamziaSpULpFwQ==
X-Received: by 2002:a17:90a:d597:: with SMTP id v23mr1471836pju.24.1597786944417;
        Tue, 18 Aug 2020 14:42:24 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e7sm22363954pgn.64.2020.08.18.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:42:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200818033657.16074-1-tanmay@codeaurora.org>
References: <20200818033657.16074-1-tanmay@codeaurora.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        seanpaul@chromium.org, robdclark@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
To:     Tanmay Shah <tanmay@codeaurora.org>, devicetree@vger.kernel.org
Date:   Tue, 18 Aug 2020 14:42:22 -0700
Message-ID: <159778694245.334488.3352871644651964381@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tanmay Shah (2020-08-17 20:36:57)
> This node defines alternate DP HPD functionality of GPIO.
>=20
> Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
