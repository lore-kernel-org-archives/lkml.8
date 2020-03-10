Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E87C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C4C20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgCJSU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:20:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53445 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCJSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:20:55 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jBjUq-0005FT-W6
        for linux-kernel@vger.kernel.org; Tue, 10 Mar 2020 18:20:53 +0000
Received: by mail-lf1-f69.google.com with SMTP id 6so4274557lft.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/HvhUt0ysFx0Jm3cdreQunT4799OHITOZy4NURukkw=;
        b=kTEy0vWS6tcwLcErhL+HVBaj9r/Ahqh4ZTFOAldDCFg1pB23/155jZryGyvIVIvW+n
         r4O8M00le5PZ97tH8CyEpKTQ7mA4QlSAJXkcypGrvOb2zuCgz/8WZSK3sGuQSJ5y5Fqx
         2WWUPBJ0fhhkcG5sJUsDzlsq0WvAnv2ct2kVF73eWKv3saoPlnVkD8ky0+Wfo6ds9Q0a
         MAob16FgVdZpX6gCdDmsw27RV7Qoxh4P9/jQwEyKXic3Mu037i9rDgjWLCdw8qRMYORC
         SuzCJfYM7U0hahbDYAd/Qw4lAYBwbcahEp1Jv179Vxh6Wv6LkFdrUZF9C2O91B+vCTFo
         o26Q==
X-Gm-Message-State: ANhLgQ1/xBC8ESMex0YzasIy7Nc5dz32knUCfS1mdtOINQRW/YrxgzqQ
        TGWldd7E6T2XmHgRyDG3PLyb6/PQjoDgU7fkiz3md3Gn3psaaH/1ZFUJ+WiTlGVAK6xdAH3JhzO
        f/YnHqPUchbN8ACZRPjJRAdcZlZUNvk0L/Vk/4g2J0l+ePpDFNcstig86Lg==
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr322956ljk.2.1583864452485;
        Tue, 10 Mar 2020 11:20:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv1foG7lISXTxzcKfKe32bPMb6/YSMz1BE1vbeu9A+TuE7+TSTV4C6X+XoeiJI8/tOm0zC6H7DeRMp6mZnlgAU=
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr322946ljk.2.1583864452275;
 Tue, 10 Mar 2020 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200310151503.11589-1-gpiccoli@canonical.com> <20200310110554.1fc016ad@lwn.net>
In-Reply-To: <20200310110554.1fc016ad@lwn.net>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 10 Mar 2020 15:20:15 -0300
Message-ID: <CAHD1Q_w26XP5fOcqW_toDLvEU0crt1dUUjiwCyWTn_U1-Nh=1g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Better document the softlockup_panic sysctl
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        swood@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, mingo@kernel.org,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 2:05 PM Jonathan Corbet <corbet@lwn.net> wrote:
> So this doesn't even come close to applying; could you respin it against
> docs-next, please?

Sure, will resubmit soon. I understand docs-next is just linux-next
correct? I couldn't find any specific docs tree on kernel.org ...


>
> ..and while you're at it, make it "*the* kernel.softlockup_panic sysctl" :)


Sure! Thanks for the review,


Guilherme
