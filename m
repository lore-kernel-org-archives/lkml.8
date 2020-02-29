Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CE92469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGaQ5JCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB2AWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:22:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34297 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgB2AWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:22:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id w27so3411300lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+u0gv0tl7AmgLhCL7vM7Tz8IImT4ldCCBT4qkE7ULKY=;
        b=fGaQ5JCVhGTePvUAx++hyza0BfqY9JdB2F2GhfTLy9rPR5cQk5nYiP4YxWG8OFvXIw
         eaxCQprO0+OU8yIrfsI3GJjzKRqnBwA0Up1pGquOWCbSGik5YvXxE4JhmtLjR2sNGlOd
         k3ZQA8sT66ACy9nosyGTOwS19r/nZ2etYGTq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+u0gv0tl7AmgLhCL7vM7Tz8IImT4ldCCBT4qkE7ULKY=;
        b=UFC25wXtesfH0IzqKOmH+24iij0OfpJ3RqOgfg/aGYoxQp/pi3/ff7l/Eni3vYV3Vk
         7OpdYFtS1ZQ1/9mdR1DEuzDVm6prurNUvlc3yi47LvP6Nsc3ciQgxgOIGmxEl4T463ov
         UT4AWJYMvJdmWFjv6vB32D3sEl8hDX4qJkrhBfbH8hdH4sIQCBAcAbCEVojFJIUXq1zY
         8tWJMh2kJpAfrvB4K48i+mzj9W9z2LsMUV7RdmFEJhOy4ViQ6OPNnZLcZGXN18Z+qLpB
         F0vayfp2jHEIBkbtfyR25sy+6lSilr7f7Spc/b4pFlT8JN3/Tcm7DzgJox4R9D3fl11h
         YZfg==
X-Gm-Message-State: ANhLgQ09SlbQB5AZGcmJspjsM5paNl/NVhkqHvvcr+uB5Tv0ZYiMsIJ5
        HVVa+8Jw+i7SWVgbPSdEHawZr5d8YfA=
X-Google-Smtp-Source: ADFU+vtKq5b9dgjp+WUFQuPDTzBC7KZ6btOLpaISx+teVOoXesTOAoBPTgK3nXma/8Qp94Ufgv+10A==
X-Received: by 2002:ac2:5b08:: with SMTP id v8mr4110253lfn.92.1582935728714;
        Fri, 28 Feb 2020 16:22:08 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id i1sm6719395lji.71.2020.02.28.16.22.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 16:22:07 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id s23so3369637lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:22:07 -0800 (PST)
X-Received: by 2002:a19:c611:: with SMTP id w17mr4041445lff.59.1582935726653;
 Fri, 28 Feb 2020 16:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20200227105632.15041-1-sibis@codeaurora.org> <20200227105632.15041-2-sibis@codeaurora.org>
In-Reply-To: <20200227105632.15041-2-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 16:21:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft5=r3MaoAYTn1X416-QGjSBKj5526VDbFoXUbiEvUKO4Q@mail.gmail.com>
Message-ID: <CAE=gft5=r3MaoAYTn1X416-QGjSBKj5526VDbFoXUbiEvUKO4Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] interconnect: qcom: Allow icc node to be used
 across icc providers
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:57 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Move the icc node ids to a common header, this will allow for
> referencing/linking of icc nodes to multiple icc providers on
> SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
