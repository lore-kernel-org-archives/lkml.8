Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67496C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C1121D82
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd2aQnLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD0Sl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgD0Sl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:41:56 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:41:55 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so17726744ilf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsIcMz/g/OO/+4cEowEjMaQCeoe1LlojgP7zMrqN/+g=;
        b=Sd2aQnLa+RIYS/b7j/xNnDoGlU7nfP4c6OQ53HE1g6UdzQ0dcWXJaZU04FnlXgS2yA
         ZDL3JV7igfI2w4avEJS6aCD/Yg+dyPam79SFTrvxpeDTknA0LqIZrzHqlAcR3tjESCoe
         eiJlV/rc0KZbDYD0S5x6BetYZ2VWccCU8dS60dUGwopEFnPuov6tWdLkWq7id7o34Kc0
         V8rHny98Mbs6+tjACqAp8Fvz4Gr+QIeof2tpIcJFfFE5MXLhEbg0osxXUQhL/swY2+4l
         Su3fRNcDULVpucN2AYq5BXVEIIcIBVOXimiepsJ8b2al3hjmbHSJSmShkKXj0A1FmpJj
         TzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsIcMz/g/OO/+4cEowEjMaQCeoe1LlojgP7zMrqN/+g=;
        b=cBd1rjooWuQ9EZ34z8yrkV/G1i7Z7MORcGr66Ntp4PBktfMY0tOHW+gIq8Gcp+Wy4n
         KsmzIO8fLKmKl2CyzG5cwDGEfyrFEAI+V4zy14CwVOSa1NycuyltDFPbbe0YBXqR/Z+9
         AerMsVCWiIczagY8iw8hjj6/E8vy8qGPRngQffMNtuqJDKUJcTpb+nRJ0Dkkw37clbeR
         IWDERyoAPwkJvIi0SUoj8Wji38wqQh5FIRA4oEPySMSyIB1Oy1foBBwgwEZLVt1ksnX6
         JNqS/tgYEQksEuoEL3qy2aYhjN91dJ2lF4mG0Fx5nxuBlJyOnqSZ1+bspeO1mb9v40B6
         3j5g==
X-Gm-Message-State: AGi0PuaUDWspSKzmMkBxzNX3nNH4e6rRnzyQp5VWvICg7D+eRazx1CT7
        ziFxR7RzEMtYaHczVkXNe3z3Ot6TbF3dXs+oSr8=
X-Google-Smtp-Source: APiQypINnvBUq9X38wYIL0TOt6wepZ9udKPO/g1h607/WS+S/bA0AE4kcIrnU+xU5C8RAoCnLG+4PnHGa0XxZS28xGY=
X-Received: by 2002:a92:cac7:: with SMTP id m7mr23303937ilq.6.1588012915175;
 Mon, 27 Apr 2020 11:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1578789410.git.robin.murphy@arm.com>
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 28 Apr 2020 00:11:44 +0530
Message-ID: <CANAwSgSFPtdvEvacNf6DhzE2fCabgZSBNnZUf0+nQErDWpErOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mfd: RK8xx tidyup
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-rockchip@lists.infradead.org, Soeren Moch <smoch@web.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Sun, 12 Jan 2020 at 07:25, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi all,
>
> Here's a second crack at my RK805-inspired cleanup. There was a bit
> of debate around v1[1], but it seems like we're now all happy that this
> is a reasonable way to go. For clarity I decided to include Soeren's
> patch as #1/5, but since I've rewritten most of my patches I've not
> included the tested-by tags.
>
> Robin.
>

Can you re-spin this series, it seem these patches are lost.

-Anand
