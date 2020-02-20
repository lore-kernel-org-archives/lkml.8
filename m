Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFC4C11D19
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5112467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582224660;
	bh=Q5CZuZWi1DSDJyVpY9xS+DmKo4lBYMFB8JrrBsjqGUY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=nIMrGZ33fxJmb/yMLyrzzsCE34h9ClNjP9lfAICe4yPXwJBlqSMj7VyicRY5jhn+Y
	 YtMMplAyz3x4tOgvtc9aD+6oqp/0uhPLQWo3L5gQ0vPjfb1gVOJHyf6ldAZX+GJmcK
	 2jAMVbJ00LCCVwOXwfDJdO6inOHBS9UGlabvQI1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBTSu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:50:58 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38871 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgBTSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:50:58 -0500
Received: by mail-ot1-f47.google.com with SMTP id z9so4669817oth.5;
        Thu, 20 Feb 2020 10:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q5CZuZWi1DSDJyVpY9xS+DmKo4lBYMFB8JrrBsjqGUY=;
        b=Vr1iV1DjWL1dPXd9YgPGJHT/oo/vxVmxRWd5Yct+Wyw9IePTvbfxIYM708KARQ6Q6W
         jZ+9fwWBzp36qYE2jU/DfCOJanMtZFeeGSKRf5kOf5NCsG1VaMmlkRJoDeD5b55ASmev
         L4gTp965OyJNG41/ERX5naumZymOyXHmUs+ZHUuxR9AYB4R7RL6ieZ8NUlwcOUg7dmkA
         UUnxDui0LNNspLGDUJlTxxkAR79GgPhwpbCOjyw/pxIDbZU2YXB5QCGClk608O/W9teZ
         aKchCazLkJ5ZpKOB5jPQveLcd7cQF0LDhTvATWrrFomRGbyfB37jILeFEHAQJ3qu1eoU
         CsmQ==
X-Gm-Message-State: APjAAAVnI+aysoyxjMcBQ0mJw5A10U3O4jmRW+j20ZXTmBxYGHESjEtt
        31dtU/S30wwLCg6y6HLwtbM0hE9+BLyD+0cJKnw=
X-Google-Smtp-Source: APXvYqyWRvtcUboyeW4G0KBUMExDffyDfxpoi9QiJR7R5ZLxIG5F8P2fN8Y3mFdLrq+ZgZQacKKfJYjcIVY5Tv4xRac=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr24878961otn.262.1582224657794;
 Thu, 20 Feb 2020 10:50:57 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 19:50:47 +0100
Message-ID: <CAJZ5v0he=WQ6159fyaYYffdi66y596rVo7z1yLyGFcH45PXNUg@mail.gmail.com>
Subject: [Regression] Docs build broken by commit 51e46c7a4007
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On two of my systems the docs build has been broken by commit
51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations
are made").

The symptom is that the build system complains about the "output"
directory not being there and returns with an error.

Reverting the problematic commit makes the problem go away.

Please advise. :-)

Cheers,
Rafael
