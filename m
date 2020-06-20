Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F803C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE352467D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4MWs4Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgFTURq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:17:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40046 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgFTURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:17:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id n23so15183562ljh.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6m7+gpeOkK3Lv52EKBvb5ieDP/yFrERJNboPKgq1eYE=;
        b=J4MWs4ZlPiCtkRlFEjVF0x0va6nMdJv3bwk3cpRdOwv0cDI8kZxFV4p2rpCyU1jOY7
         aAdHzusjPEUqIJvzDGvLoPNFFYsQrszvNxBicmP7gJqYq4qEeDG5HaKbBuS5VsOYITDf
         PWcQnqShbWnJhlysEMv61PzXsb7fEZ0XUY/o7/JpChHfbNLJQFdDsyetEqHU3zmy4AHo
         j+IjCmRxQPkqJEttx2oEpzbj69SVxqKKcB3y/0ffviL6oUpExBoWuGCY0kYZUshKXAs/
         zrtPS3B9cE/Rad5w6COID6EUlFMOi/Fn7tS4Vq4Oom52O/BYtF6prv1AJeH2Aye5wa4T
         BfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6m7+gpeOkK3Lv52EKBvb5ieDP/yFrERJNboPKgq1eYE=;
        b=bfrk7gavGDeAZVGi2oWqlWiNE/Q0u1kUreTobfH9UIgoWc93AWeBSSJGjdc1omZEzu
         1UkboU0/7oTSL65t6ehA1RP98PXm1AP1xYv05TDqMNCFiNKRbHmyerC+4VIPpmoPCSRe
         58mHVN/W0UmSAppWPLXrCC8M9qJXgCMHqcYy/vs6SbBgIZxBxz1rXlqBKzhNdosjMIIt
         8ZTHn8G+/Xvj/0PwrO/TTRNeMg5dVS/enVRs39Iod37oqZXWRSEIxu38nHloBXsKa3Sy
         Mgm7Q8qUN1S9vvJ+O+1ylcP97u45mgAMww/+usc5kgIMSZHNlhf7XJgcV29/hn3SWIS5
         r/PA==
X-Gm-Message-State: AOAM5323jtMPAHBdH4eJsA1FhwNL36QpDHQ9p/CzkAUMsBDJfIYkqPuT
        7fHR6f21DLzqfhv1d65FrDPwwmY2ybtKSrTkjbnlxQ==
X-Google-Smtp-Source: ABdhPJykaEObVR+0S9AD75omN7upramsv7DyP4Y1nkN6kNG0Q/F+YisTVXROXzIqvqRXZOeLusqiEKkZaSEq395PekU=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr4503172ljo.338.1592684203622;
 Sat, 20 Jun 2020 13:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200610113630.11922-1-gaurav1086@gmail.com>
In-Reply-To: <20200610113630.11922-1-gaurav1086@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:16:32 +0200
Message-ID: <CACRpkdaAk+Sh7K5KG_-ygObQ9STUB0v+E7NsRVBHeTBJ6buWBg@mail.gmail.com>
Subject: Re: [PATCH] max732x_probe: remove redundant check
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 1:36 PM Gaurav Singh <gaurav1086@gmail.com> wrote:

> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
>
> The pdata is already checked for its validity. Remove
> this redundant check.

Patch applied.

Please put signed-off-by at the end of the mail.

Yours,
Linus Walleij
