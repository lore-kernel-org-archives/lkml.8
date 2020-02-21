Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5145FC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D7320679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxD7B9dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgBUPYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:24:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40335 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgBUPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:24:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so2574636ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8F1pecknXeZPAGHPwSdHXa2S1HIMEUTEL9qK4pfGkI=;
        b=rxD7B9dqoAiPCPgcPMy3dxnS+3dsZtb0ZYOiZpv7dDIPGvwW3EUh2Y3DvQo/1IuVPB
         B8aCXt3Mbu5JD28DX63Op2V8OkUo8EMGp1u2VcbnQ7vL7goA2vrBUZYCagZosE8dywvW
         Rq1sB1XaqIPDkeGnN0NYXhMQ2QHImd7ijNGmGMyHOQ9ms7ngm6Xn8Qs51/6xbb7mNWU8
         jfVmfeRZO6Mi9nYlrM/p3bSU7gqnhDN9fncaCFUwbXNMTD4sxPCOu62OzH6LrtZgz2oc
         m2DItFi4GJvVvf9V61Qc+jAKPUtgovjrhmeloggKXeeOvSgcj386SgdPSjWybppU2d59
         Z2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8F1pecknXeZPAGHPwSdHXa2S1HIMEUTEL9qK4pfGkI=;
        b=UjLOteUrx2Pjxs7gfIuf7RiiIRXI+Vc+ZJ/RfXhkuatCIgwenFtgzxxCpiz1t8pYvc
         m1X4VNXasqtIOPh+G3fvzqKprcfKihspUnzoOwdqaTFinDf/O1jEtXYgIuSpFEYj6VJL
         +q7B4Z29o8+EvJ35m6IXlRzZzSdiFVmgQaD1ln9IAiKvxC2AhP4iAwONBKtedUyrNM6a
         kSxVxcQO1SzkneDV1rbq+aaPyG17TYRMrfpmBMHEJKAkyD45BZqBxGHXENV1KNyVnppW
         9WmNaLiygigP9ITXer/kau2ylZ3PM5vIPxtDGW0etaFH1x8wcMzHLErDZAgSBEfpkbsT
         yZzA==
X-Gm-Message-State: APjAAAV2HHvgwWrA/97ZG/d4sj3vRJpdxs+WoFOaiL/lqU4pFY64CbJI
        AeUtBEFfQdT7U3ONrmBlf3e0iTU1V0h+l8fH3KaZpg==
X-Google-Smtp-Source: APXvYqziIUztxmcLeCs99putNp5eHfPKwvYYqzEsStcEDA0FthIqEITMkvuS+XoCG6v5robD0BZiVwXwVCyqWa3dCL4=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr20900215ljo.99.1582298668773;
 Fri, 21 Feb 2020 07:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20200219175940.744-1-ansuelsmth@gmail.com>
In-Reply-To: <20200219175940.744-1-ansuelsmth@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 16:24:17 +0100
Message-ID: <CACRpkdZfHRuPwM8uFnzAYwCe3WeURPwX06arrZi+70aOwbcdGQ@mail.gmail.com>
Subject: Re: [PATCH] ipq8064: pinctrl: Fixed missing RGMII pincontrol definitions
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ram Chandra Jangir <rjangir@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 7:00 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:

> Add missing gpio definition for mdio and rgmii2.
>
> Signed-off-by: Ram Chandra Jangir <rjangir@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Patch applied with Bjorn's ACK!

Yours,
Linus Walleij
