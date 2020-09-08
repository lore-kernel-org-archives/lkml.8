Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C300BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CCD20658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JM1teX8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbgIHTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730627AbgIHTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:55:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D84C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:55:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so304950edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qyyoit1klEBl04XmzBDYSuFu0B8oH25yDBH/PKvgEzU=;
        b=JM1teX8y1L/bp3ig5jMNwEX1U9kAVue9D0LgzT9QQNL4iwKtHw3PdxCnmMSbPiKBwU
         EI1/sf+0QrTFUHFgP8ItN3y58UIYw9lLJXknJ7SwssKi22lZwvxuc4RqRg/vbt9Jxqbk
         pgZgVRFy/4cll1LwZvFKCp9wUQhLYDxuOoRrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qyyoit1klEBl04XmzBDYSuFu0B8oH25yDBH/PKvgEzU=;
        b=YvxrbCeVXrNPUFF5uUQInOhqnBK5BE+uULqA0gUswMV6r04riQYVeggncvezHMfgaV
         9eOuraTlZkcJQJVuCw0zFHzdUoIckQs3e4JM7DZGO5BVF1lPXtfbjWnZ35ALZ8oOYr4J
         jzLXdWOWT/3GkEAJBtZuc6AyvZL3z5tEO8bYVXn8lYVekbASE7vRUiTIL4wV5G4P9MeH
         2U4warML9KJ1Gc5jJkjGKV6lBo5YnAvyWtJe00qNDc7YbtW/KCq9pFowfyBlJHzv48HD
         F7n8NnH0/ykqEb9wH7EHyuUPD+8L47ipa+iAhTBb7Ghyn8Ly3akgWyNf6XUdfS/fJnkj
         oDew==
X-Gm-Message-State: AOAM533YQRn7wE5B+s2kLcRCKpcm9KKZJqLr2N0M6QztenMKgWUUSkaH
        dmCa/Ec/nuzg+IKF7GtXKFodm0f1bs6D/Q==
X-Google-Smtp-Source: ABdhPJxpvVi44z+w8NNZUW0QodISNF5/TCXEP8p3nfiGGNvd1SWhbQE31QYf9sRg/Tc7mTmJyroAHg==
X-Received: by 2002:a05:6402:45a:: with SMTP id p26mr762518edw.8.1599594911837;
        Tue, 08 Sep 2020 12:55:11 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id c5sm275922edt.24.2020.09.08.12.55.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 12:55:11 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id r7so102836ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:55:11 -0700 (PDT)
X-Received: by 2002:a17:906:4101:: with SMTP id j1mr49953ejk.473.1599594910694;
 Tue, 08 Sep 2020 12:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200908152229.689878733@linuxfoundation.org> <20200908152231.250461330@linuxfoundation.org>
 <CAHQZ30B5JzOwUhiyLsbbYpFJdWQeH6vR3Ze-Gtr5-BCnw1AVBw@mail.gmail.com> <20200908173542.GA220950@kroah.com>
In-Reply-To: <20200908173542.GA220950@kroah.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 8 Sep 2020 13:54:59 -0600
X-Gmail-Original-Message-ID: <CAHQZ30C8eQ7tq7LteFpz5BQFdtgEeJAdz9FxbqKk8pr+vcRFMA@mail.gmail.com>
Message-ID: <CAHQZ30C8eQ7tq7LteFpz5BQFdtgEeJAdz9FxbqKk8pr+vcRFMA@mail.gmail.com>
Subject: Re: [PATCH 5.4 031/129] mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Should we pull that in too, or is it fine to wait for the next merge?
>
> It depends on wha tyou want to do.  I can drop this now and add both
> later, or just be "bug compatible" with Linus's tree until this patch
> gets merged into it, and then I can take it.
>
> Your call...
>
The patch got pulled into a few branches, so not sure how easy it is
to drop it from all of them. I guess let's just leave it and be "bug
compatible".

Thanks,
Raul
