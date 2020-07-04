Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150C9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42D620EDD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SCXoRevB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGDJRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGDJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 05:17:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49001C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 02:17:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so23265440edz.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/TRH+R1Jd8bkRDtLQE4V1BauMMxUIjDQbhrcVAnS+Y=;
        b=SCXoRevBc0YwM9J9u9Sa97afiHyxdiz7b0+aXHvuS7zS4Pfi7qbP1VfMqEiWoQM5ET
         iTru0AzQeUchb3hj+nbINcockWsxFxRntPxnTA8jFD1jIcHOOqQkygVhv85LIJXGCm7b
         kUkEJHjDU3X3QY5wFGzHlmah96sI8DpQDTMrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/TRH+R1Jd8bkRDtLQE4V1BauMMxUIjDQbhrcVAnS+Y=;
        b=JZPb20xU+O0CJzyzetUn8XADLvOVZ1FdZnAtrbG4Q4xOyTLR0Q1KjZgexjIT9pWQh2
         sjLEjfpEwIWPbyURzkXYXhii5Y/QGTWkOaZ4cbai5T6r+1Qt337I3d47NbMZWpVV/Ydx
         0D3olYZ1roPZ4AKxutFmhlHGLHHcbHWxDz/FeZj0rS3Ko+Y9g5if5nLRqWTgtFtcgt61
         nHykQgCKBuFNuZgMZ+uL1HWVi5XMTOA5oW44X4f8pGvBwBCAMAajJ0AbDvV80k2fXQ4L
         CJj+qBi9HMtG9Adbfd53qRJ3ZEcn+ybPMyHtMw/VbmVke4cpRVdX5zwp/kAVnP9lTLi8
         b9/A==
X-Gm-Message-State: AOAM5314Nih/34/U5tiL47bqrhXOpPn5017iSFepRYEdygA8ZsrI/YQ5
        h8w6Rf2ACEF6zhbFpOzBcTg18vNxIm+CZiOnnz9tjlFHzSPyWg==
X-Google-Smtp-Source: ABdhPJwlefxsAbGTCRPLIBaYv9lxYvdEX0dTSqQ0Eif4z0YohHwTAySzp2vMit7sAuH5RhITj6dd324GeKAxdmHfpCk=
X-Received: by 2002:aa7:ca05:: with SMTP id y5mr18051705eds.204.1593854242943;
 Sat, 04 Jul 2020 02:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200703154948.260369-1-heiko@sntech.de>
In-Reply-To: <20200703154948.260369-1-heiko@sntech.de>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 4 Jul 2020 14:47:11 +0530
Message-ID: <CAMty3ZD7jBSCEWLRK9qNXKGQC2_0eJyo5NkbV4MfaTNbC4Br2A@mail.gmail.com>
Subject: Re: [PATCH v2] clk: rockchip: use separate compatibles for rk3288w-cru
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 9:19 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>
> Commit 1627f683636d ("clk: rockchip: Handle clock tree for rk3288w variant")
> added the check for rk3288w-specific clock-tree changes but in turn would
> require a double-compatible due to re-using the main rockchip,rk3288-cru
> compatible as entry point.
>
> The binding change actually describes the compatibles as one or the other
> so adapt the code accordingly and add a real second entry-point for the
> clock controller.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # rock-pi-n8

Note: These are U-Boot changes,
https://patchwork.ozlabs.org/project/uboot/list/?series=187546

Jagan.
