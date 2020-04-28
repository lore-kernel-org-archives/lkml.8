Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C4C83009
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC3B206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKRvwPTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgD1OCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgD1OCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:02:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB3C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:02:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u10so16976707lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jE1ry3/WH39fvkitlEImOc9VA+8Es26FANSqOuJc04E=;
        b=gKRvwPTf1AvgqGtJF+/FWCwKJY0q95FhYY5JScuWdpMP00paUsHcpU/fjv1hAk55r6
         Jl5fmzws4VNaXL2yAhSpQQszWnHHFbzhEUPa/Y4v48vDg0kbPDMSKabG27po61hR/aXq
         vu6pds4YpVzMlDJxQVebXZkDTCaZpbWf/FSkrRATp2ING17+GqmKftnjbOCGa8/oTchm
         XSw1ceWIBF9nM8my4ojkw96invyr0LWcGXIJV4S9THUjC2bTs7yFx8uZzA9KpVVnIDld
         3Lf1AD4KpBIDY25xy9EX9h/ggg/yxqsKIN/lmmMJIxt08GiaJ7d4xi1WQowSIOMibw9A
         ZgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jE1ry3/WH39fvkitlEImOc9VA+8Es26FANSqOuJc04E=;
        b=cIMUHoAkb27OH8Ks6Z+CEghKYL9smg09FwvWgCkvQpHeV4gN9jIKf75fkwW95hY9GP
         6VWu8Sb3uVcGGxqfq4iNh3nQawkJ7efv6JopNc6O8WIQYcuaF3k5yGMTc14CNPi5wgka
         E/sUVMjiesB5iVn32k6+79WguzSUw98GxzWkqQp4N5Nqk+fOhWcyf2UsNoeXg98siVO+
         R84IuEhieloNiffoolQY1iL5aRpMqWiSB7XeLg//nOQ99trD0T0doXKTI3+GlbXLeHbk
         DwxLjClLAmF/0PlVt4437akSUnOqk9Ahir4kSTuMD/6vtOFFZ/ZdqNKHR9FYow5YW/Kj
         8pYQ==
X-Gm-Message-State: AGi0PuZ74hXmoSlDuqLKephvrD8ZkqtmpF/uyxzSphqfIdp5c8IQgHxp
        VgfeF0oCyD+G8npy3ZW1gyoVJXyDp65FPs9JkFyIuw2M
X-Google-Smtp-Source: APiQypJbBQG+lZGnEgJPVGO7k2y8d3LYISivUTbhjYNTeX3f5ZWBtN9OGNiQwGYtCNT0qnO4WCiwZG8ZYp8xJeFGyA4=
X-Received: by 2002:a19:700b:: with SMTP id h11mr19393584lfc.89.1588082563613;
 Tue, 28 Apr 2020 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200426094250.23995-1-yanaijie@huawei.com>
In-Reply-To: <20200426094250.23995-1-yanaijie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 16:02:31 +0200
Message-ID: <CACRpkdYwu3LnN9KGfbjhnJu75hmKBKgnSWnDCWmdnGWGGGYPTw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500_fg: remove comparison to bool
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:43 AM Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following coccicheck warning:
>
> drivers/power/supply/ab8500_fg.c:2402:5-24: WARNING: Comparison to bool
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
