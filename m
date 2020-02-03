Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C52C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32DE20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF3Cwe+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBCKQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:16:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42121 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBCKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:16:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so7319604pfz.9;
        Mon, 03 Feb 2020 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nl2L3p+Ia4E1khnSMhXa3k44nb4cAKeLzB5j1ho5Q4=;
        b=ZF3Cwe+sUYE/i8Qd+9liOcZE8JWFZGEMtPrwkoS1cGWyMawyyFgATWcYlWjBxAqEqq
         tRDzgljJg8FGaiOrfG5tKK/V0wdjrc6M2I/P/8HTV9tVbb6VCwHEFipv+e5xBIr1oxah
         xSYw4D2HCz/TnZpDHZgdhUi/PVnYEGD1lmOHdRdtTTGiriUGs3QyHv/iDBRK7DbZ/7Ct
         TGJ5G/HsZGNhKmZk2X5cpqLRfhlxRoNFdx1dqnA0OQN+8TRW5d10ZKN68x3mNulewkrB
         PX2dL/54OVKP0Wfyb7XGq7knytMTBazsqEsnWID/YCxW5RFcupMs+akZrLcirdB6Y0um
         PbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nl2L3p+Ia4E1khnSMhXa3k44nb4cAKeLzB5j1ho5Q4=;
        b=jlpccHfOyPQO+naiQ1BE7WWr2x8x3QASoklvPnPr3JxHQeeIZgjA0CfcAE0mVgjE03
         EEdMblLRRIg+dkhQIwaC0i36NR6evk2JLGXkI7w/KpNuzAcQG4wa1WHodSUpzc3YwNwn
         7AZcHfJ4IeFdCbp0h7ZGIfSNddYGvyPhJTl1AyXpKt5mA6LZdFYYDEwS738W110PBkXh
         2kVQXQSaUdChktx0iuPAUjGYZHvbeORXM0Sff3pQ1v++Q55HGPBnbh+EvoqHKc5C/Dr2
         QUXwWU8iugoZwvLqLSxOzf/NDP3oemb0ka3O5tQrzLG3S/19N5ckMR+Exhof7VeJSQf7
         Fr5g==
X-Gm-Message-State: APjAAAWe93lhyYWvlONL2Go+AA2ozVjuqw5FZ1tZVef8h3ReSKIkzt8r
        r2rSeks2yktdDnFOLMTIsC7pdtF/k3P1dOZW86Q=
X-Google-Smtp-Source: APXvYqxWutW6pKCGPRKsawlK4lEy7F/4S4tpTZWWYsSKci14dTcyHaWg7CkfIalOcAc/wZQfNq+VazwrNRo8lQ+vWD8=
X-Received: by 2002:a65:4685:: with SMTP id h5mr25618513pgr.203.1580724984426;
 Mon, 03 Feb 2020 02:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org> <20200131135009.31477-14-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20200131135009.31477-14-manivannan.sadhasivam@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 12:16:16 +0200
Message-ID: <CAHp75Vc2Nf9N0cPBmrqb_xZQG-=eczd=gdZxsfXv6OtZ=ysP6w@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] MAINTAINERS: Add entry for MHI bus
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 3:53 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add MAINTAINERS entry for MHI bus.

> +MHI BUS
> +M:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:     Hemant Kumar <hemantk@codeaurora.org>
> +L:     linux-arm-msm@vger.kernel.org
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
> +S:     Maintained
> +F:     drivers/bus/mhi/
> +F:     include/linux/mhi.h
> +F:     Documentation/mhi/

Had you run parse-maintainers.pl afterwards to see if everything is okay?

-- 
With Best Regards,
Andy Shevchenko
