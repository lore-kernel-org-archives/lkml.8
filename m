Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65004C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B159207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jIR7tO3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHTXMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:12:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB0C061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:12:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b11so16022pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=25VvJRAxxSKZOja+m6/X23XfJDnDiYp/jYGjfMbcAb0=;
        b=jIR7tO3qoi5slAacYS+iETQLXWk1DQkkglZGqJ+4elEWjSZruJbneRmnrPIo97LQvf
         q/vETU/eIWQWYgpnEEuNQU9fPEZ5Ma+G9wHb7cy1QZTLD7+hgcGHlUhec4X+ULeBmuIs
         mZ+EjHo39gcE5PDuOziXfU70k2mkN1S/vFLDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=25VvJRAxxSKZOja+m6/X23XfJDnDiYp/jYGjfMbcAb0=;
        b=PS4wPnW3fanWUeJVRSRcMeZ5kNKMeLxLqjHyau3VBuGY32XdYvgrJlnZ8MDYbwx9m6
         TpSLPKNC066b5iwqODOISL5B1Wcs0A2ZRWvFNrDUDpKN+/TNong17Xa8aDHYb/191CjN
         J+FH4xQDHePhz33UZYTBvHauuyAdwHZNNOBsUKW/LviWQmkvcPPUPTgPoGxdgl4lb1PP
         dj4fav5TEn/UhP0MVdS5e304LER2lQx32uf+WlUWwvPyQ06/1LCP9qlkpPfG+Sx+yJ9W
         Jdm6bzE4sSWe8oGoE9Wt0YDXPFSkXZhwwRjfAh5ANNcxxQtd70taC2dpaL7W6+tMl1Ka
         XcWg==
X-Gm-Message-State: AOAM533DNvTWRCIEENczOGYgmy5uK8u9GeyTLY//4hl6UH5tEq5HOmnb
        WWL1IC1FR16bhWq9XbJHRY+OyB/qV57MqA==
X-Google-Smtp-Source: ABdhPJxg6gWWIr+NYNyeNoh/vt3CrN4ueRdwUBhK+gGqkDpx2GGsrTCxJyCGNkmaTYlqXYnvTmNnvg==
X-Received: by 2002:a17:90b:885:: with SMTP id bj5mr133571pjb.133.1597965124880;
        Thu, 20 Aug 2020 16:12:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 8sm117847pjx.14.2020.08.20.16.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:12:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1597831670-17401-3-git-send-email-mkshah@codeaurora.org>
References: <1597831670-17401-1-git-send-email-mkshah@codeaurora.org> <1597831670-17401-3-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH 2/2] Revert "Revert "soc: qcom: rpmh: Allow RPMH driver to be loaded as a module""
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ulf.hansson@linaro.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Date:   Thu, 20 Aug 2020 16:12:02 -0700
Message-ID: <159796512284.334488.2457174259443414342@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-08-19 03:07:50)
> The _rcuidle tracepoints are removed from RPMH driver which prevented
> to compile it as module. Bring back the change to make it module.
>=20
> This reverts commit 1f7a3eb785e4a4e196729cd3d5ec97bd5f9f2940.
>=20
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Please send the original patch and add your SoB to it. Reverting a patch
out of the history works, but doesn't do justice to the authorship of
the patch.
