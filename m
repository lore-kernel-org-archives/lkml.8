Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C58A2074B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxGqwPhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgFGUpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:45:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC37C08C5C3;
        Sun,  7 Jun 2020 13:45:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so1762811iog.0;
        Sun, 07 Jun 2020 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/YnB5fzP1XicKiRcAe2Q8LuxjHO0CMYG9cBtnOKMh4=;
        b=GxGqwPhkkOGRxOBl7vka/S+zbKecUhkFDra1dJfBpBqCyWgA47XutunWnavtjHUHM6
         WoYPyQSIKvsbcMWJJDjIhJOvGhItrkPo/ml6UedBAtjjJeOisKgKVmglPgY+ye0MUQJK
         4QEMRMiFAA21c4zgetYQ0b+Jz4ZD7Dtc1L1PZpZXx4yKmcGpbESP/4BLG5K8P8Ue+WKI
         q/+1Gy0NG7V9wpvE7HGX6FU2ih2pnWv8QNHJl6CfRWLz/EEg7Kb8iNgVjTGQTwmr7O7C
         xQ53yO8+6NXnq6meoVOEd9yRkIV/vl6XeZKCWczaZgE+roIXjLECAkXnF+zgfLv5PmN2
         yVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/YnB5fzP1XicKiRcAe2Q8LuxjHO0CMYG9cBtnOKMh4=;
        b=SnvsJY0k37Ur7FYa9chKvSk0V+78jweUCsmvicf9R6MAb2Mk6CH0TFFImhrsLWAyvn
         FBgKtqkeyOsXtzp5ReLAjmXmKAV8gyifGquWv3bKaSLK+Ms0zLkI2OIW9fMYfkPd6eoa
         4TnU5GK2INt3GbZz5irbQEnbcEHhWsKFCH6Dw7ZT1Ng8EqktX68LErUhVBpGxHyOiTL7
         qNEmj8nBvQmbbzs1gdD3XorCxBi73iCR1OK/AvCQNfTnfJObfnEg7SfQyArVMzAY4nRe
         xo1AVDs4/Jnhbmj9djSKYG892Bzvzss98jyw0l1shcwfavL2YB/xZACJlQa3ibF8ACSO
         7+lA==
X-Gm-Message-State: AOAM532l7xtupFCHuLiYg0PNshchaJBLRRZolKCbP61mOGEGM00P5xXa
        rbgcxAk7eStqeL6KcQHcfbsrgzD53hbba4Em6FHHP8vB
X-Google-Smtp-Source: ABdhPJx8YH0LXzFYGcRU9BI+IR83rM6pbwtkKlIoHSeUClRsZq3D2mgrW0vUmYRP3mkH6A0GPwzANQOxW3Syq3lOEDU=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr18232285iov.80.1591562711809;
 Sun, 07 Jun 2020 13:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <1591441171-20341-1-git-send-email-sivaprak@codeaurora.org> <1591441171-20341-4-git-send-email-sivaprak@codeaurora.org>
In-Reply-To: <1591441171-20341-4-git-send-email-sivaprak@codeaurora.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 7 Jun 2020 15:45:00 -0500
Message-ID: <CABb+yY2HhHSbP7UX_r1bGgpxzQKfC9aS8r9nxX5AOt8ENG5ACQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] mailbox: qcom: Add ipq6018 apcs compatible
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 5:59 AM Sivaprakash Murugesan
<sivaprak@codeaurora.org> wrote:
>
> The Qualcomm ipq6018 has apcs block, add compatible for the same.
> Also, the apcs provides a clock controller functionality similar
> to msm8916 but the clock driver is different.
>
> Create a child platform device based on the apcs compatible for the
> clock controller functionality.
>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V2]
>  * created a new structur for driver data.
>  * re-arranged compatible strings in sorted order
>
Please break this into two patches, first reorganise and then add new
ipq6018 of_match.

thanks.
