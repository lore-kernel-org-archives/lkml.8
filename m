Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18529C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30462064B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j+YHjrcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgIIPyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgIIPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC3C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 08:51:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id r7so4235886ejs.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebI2CZT5sFSOyIJmsHXUvAoUxP/mIFBJnxrOROHyq1w=;
        b=j+YHjrcPZ12jt2TR6VZ0SQLasTjXLm4QzCvH5I2QEq+TUS19U2aDKWvL4m3OSGEwX1
         27sy149nq1tT/ngLrFPEjv3Qwi7oeD6dbVzHxonhKo90/tZwF9WN8vcMJDyd50A8sMrL
         DzAzS4WAx8T4ldCFNWw2BLm0vsDAwPZU3f0wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebI2CZT5sFSOyIJmsHXUvAoUxP/mIFBJnxrOROHyq1w=;
        b=Leso1MLYSGpBIyrf3zp2Yh2+y5JqD0N0HcArllNfoqsZvi1lofyvVW/ZyXf+Dp2EH1
         wC/ZUEyhAteUpT84rc6nKfcpnalYYe3CVd+7GsSvMMXvssq2XkcYAeHzM33yfpod6pTd
         PTsGnGcjuUIw0JXsjPzv8XItcpV91a3mwGtgdsJ+4DHBf5s/dsi569sOzH2EOX0BMoxm
         ZqJFWJVL9ut8POW+mp7yQGmW1GKiPlvErycnYsRrpNKwTKPXJyEuaEoCwnGYu6L+l9Gs
         nWx9+aI7d82by+dCr0vYivnYKWX5rKME2OYeGjXpbnfY1yzmBCiI2X6qlJqBhxobeQ+Y
         M2oQ==
X-Gm-Message-State: AOAM531sF3oSFNUvsrLT5RktfL9F4APSfcWpi2STcmHMidUP88OxOncF
        7yIgj7VGEGaqD4F3b9USWqIpJaHaDUPI8A==
X-Google-Smtp-Source: ABdhPJxDcq4isM0gfp+X7c73FDf237j86mHAG/o0XXNNl/J7HR03asYzqkykWfFu3nAFlBGQqDuWuw==
X-Received: by 2002:a17:906:850:: with SMTP id f16mr4216651ejd.447.1599666666095;
        Wed, 09 Sep 2020 08:51:06 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id m10sm2995875edf.11.2020.09.09.08.51.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 08:51:05 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id i22so4284389eja.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:51:03 -0700 (PDT)
X-Received: by 2002:a17:906:cec9:: with SMTP id si9mr4172770ejb.351.1599666663650;
 Wed, 09 Sep 2020 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200827170947.429611-1-zwisler@google.com> <20200827200801.GB1236603@ZenIV.linux.org.uk>
 <20200827201015.GC1236603@ZenIV.linux.org.uk> <20200827202517.GA484488@google.com>
In-Reply-To: <20200827202517.GA484488@google.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Wed, 9 Sep 2020 09:50:52 -0600
X-Gmail-Original-Message-ID: <CAGRrVHxj6sJfToQm3-fhDfDbQVuvU+aOnRdnfo4L6CYYnurSew@mail.gmail.com>
Message-ID: <CAGRrVHxj6sJfToQm3-fhDfDbQVuvU+aOnRdnfo4L6CYYnurSew@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] Add a "nosymfollow" mount option.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 2:25 PM Ross Zwisler <zwisler@google.com> wrote:
> On Thu, Aug 27, 2020 at 09:10:15PM +0100, Al Viro wrote:
> > On Thu, Aug 27, 2020 at 09:08:01PM +0100, Al Viro wrote:
> > Applied (to -rc1) and pushed
>
> Many thanks!

(apologies for the resend, the previous one had HTML and was rejected
by the lists)

Just FYI, here is the related commit in upstream util-linux:

https://github.com/karelzak/util-linux/commit/50a531f667c31d54fbb920d394e6008df89ae636

and the thread to linux-man, which I will ping when the v5.10 merge
window closes:

https://lore.kernel.org/linux-man/CAKgNAkiAkyUjd=cUvASaT2tyhaCdiMF48KA3Ov_1mQf0=J2PXw@mail.gmail.com/
