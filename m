Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AFDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18DA2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag+q6kwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391969AbgDNW1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391948AbgDNW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:27:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:27:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d7so6845414oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twQcgd45+lQrfSmknnbfL+q1fVsuWdz4au5BKw4Z1+E=;
        b=Ag+q6kwnWCx1+ljpNf+qWVNNl+ZCr0Jt4Zxhl+xA3bdNcKAf9D3xTp6BQPmR3zDu/D
         f1EF1AWUA4/IrGWbrLkM1icj9HaicqA7TMgplrqDARzA1s1GEBxqkZUgoivvYv6PaG42
         P9I3715KufTjTXe2O6GP+cmbcebtgJCxLHiK3Fra6AaQQCNhYS5+fAVv/dEBA87isWqq
         +B2U2eIRA5bvWMi2NiwE4A5mRLXC7g/cBpW6eBgQA8WLakqQkZYlrIrP6c7D8rU58DeF
         HllT6cDV6y4AL0EIHdo7LWOpdFon884yN4XiXLwD2n6uXPuIV2F7NDLvIwZEG7Lsst4D
         BgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twQcgd45+lQrfSmknnbfL+q1fVsuWdz4au5BKw4Z1+E=;
        b=Vr7UmYSOZnGtCg2mnpLiHL/25SfXq+v9GBeY/3bfNnnXyNSuBJ/L+aDNDFptfWC1fC
         S6tyr9Tewpyr4KgOOHUv7/D1M1ZBIfrNZ9O+RMa3ZCSx4uHa/zaKoVSjSZ27W6TgV86o
         oyAOMLprJ9T3ogBhDG5umLGzYfDf/QEG/Yf1pev/sFOpeKPldHR95HG1M5v6maDT+VC8
         HySzoT0WakVyYkK/PhF2+hFLz8/6X2JU2zVAqgR1Fdv4mw35R0l8QyJ7/q+K7rACcVWf
         JMU6ZNJlhXSAEpWAlueHT1ql39PRapXd1CD5oJ4Qqe46SlCtl65ZRXyvHfuWZ7P1Y+FD
         WbkA==
X-Gm-Message-State: AGi0PuYEDmbID7r8UE3cIDsoZgB6iL+dJZygRzUjlNyQGxU1NVfWWK8h
        +pNa0wK5af5kdus42T1lryl/yMZ7/wUiQRFg47c1SQ==
X-Google-Smtp-Source: APiQypLX2IaDo4jxUH5+hqW48erJPfzTcMuX6kUFwIkYAk9KI1BFjp3NH7sHJfEf0m88KG1UCKAc0hmGm375Z8Z24VI=
X-Received: by 2002:a05:6808:a0a:: with SMTP id n10mr17407259oij.10.1586903249039;
 Tue, 14 Apr 2020 15:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200414164152.2786474-1-vkoul@kernel.org>
In-Reply-To: <20200414164152.2786474-1-vkoul@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 14 Apr 2020 15:27:17 -0700
Message-ID: <CALAqxLWpkf92nXcRp02W0G+Z5Lb+mHVc2ZkLPntwi6GpRx9b0Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] usb: xhci: Add support for Renesas USB controllers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Andreas_B=C3=B6hler?= <dev@aboehler.at>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:42 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> This series add support for Renesas USB controllers uPD720201 and uPD720202.
> These require firmware to be loaded and in case devices have ROM those can
> also be programmed if empty. If ROM is programmed, it runs from ROM as well.
>
> This includes patches from Christian which supported these controllers w/o
> ROM and later my patches for ROM support and debugfs hook for rom erase and
> export of xhci-pci functions.
>
> Changes in v9:
>  Make fw load a sync call and have single instance of probe execute,
>    elimating probe/remove races
>  Add quirk for renesas and use that for loading

Validated on db845c.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
