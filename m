Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E80020706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZFZhLqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405099AbgFYNPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404960AbgFYNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:15:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:15:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y13so3179669lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QR42zeOxTbypLVBEYvN0oGwLT+XNTPkg4CKLs7fOlZw=;
        b=hZFZhLqGFkWD9h49jD6CJlTPXP3YL996Dz3eHtbo2MDlkPwK4/UK4sM+I2s1T7Qye4
         EhvYuIhv4wNWTk6S7kedARBMDZZ3skz8ZMb3WBL4qKlrkublXnFmBhbFqvkmFjyHccec
         zNOJgS6VS7A47awqrq3P4OA5sH7c6nRpQo5QAwCuYazZtfs8igl5mNdVqFX4ThMLjy+8
         n7GuogX5mu91modmHWL80aoboFyanW8dz2bMl0mubkmfBIobQsH1tvCAJA0JbasJb2ey
         ZKbraHoUr9gxeLDsZODQ8NQOJjbURyVMSLXNEKZo5iO9ZNGUmLnQMia/wgNRrvHR348j
         Uv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QR42zeOxTbypLVBEYvN0oGwLT+XNTPkg4CKLs7fOlZw=;
        b=p33O2m6ezWFKiEYBacBQY5X8c2lUY3o5QpSm4nkvEgVzucLLGfBX/NEcuS91a2BpwF
         OYvJjF1HEWF51DURkjCxBhVoZImvxDadLh32VlVWB5ZJOqKiHSpPq91kPsFdVW5ipCWz
         0ijldnK0jpU3ujYTCzMdL/6bCLFS5GGQUEhjzuh8+ejxCtrR1B+PB1Q3+x/aX7YVMpRV
         10qeeOEFDY1NPmpftiQ9EjWRwvaKScAhKTkcZ6NhjrcbScYFARLY0iUhTqoHyNxHQiE6
         o22+7MC5PyboIzuedb1IzQdfWXJMsVn/RxT7XbgPMwNthIG0UmOVH9K1+h5a2Ky/TNhe
         WNaw==
X-Gm-Message-State: AOAM532yH3meg3fWW1hFrSPjMDUIz4Q/NfZGoj+OarFC7QCx5wiHHL9A
        jp0t0wA9SE+Uo5w1rh5tuxQ=
X-Google-Smtp-Source: ABdhPJwzgnJuL3K2LW4ohUpxzWu37UAp+RFuOi10vfvqKVDHappu8GzNB5BMfab7VBvLBXPKTc6snw==
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr17880697lfg.196.1593090916198;
        Thu, 25 Jun 2020 06:15:16 -0700 (PDT)
Received: from mail-personal.localdomain ([185.204.1.215])
        by smtp.gmail.com with ESMTPSA id t13sm4809148ljg.78.2020.06.25.06.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:15:15 -0700 (PDT)
Received: by mail-personal.localdomain (Postfix, from userid 1000)
        id A8986611B4; Thu, 25 Jun 2020 16:15:17 +0300 (EEST)
Date:   Thu, 25 Jun 2020 16:15:17 +0300
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     Aiden Leong <aiden.leong@aibsd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        dm-devel <dm-devel@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC] Reed-Solomon Code: Update no_eras to the actual number of
 errors
Message-ID: <20200625131517.GD1036@mail-personal>
References: <20200625041141.8053-1-aiden.leong@aibsd.com>
 <202006242231.E17DAB2@keescook>
 <5f4008d5-1ddd-443e-9190-a8565746698d.aiden.leong@aibsd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5f4008d5-1ddd-443e-9190-a8565746698d.aiden.leong@aibsd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On 2020-06-25 14:46:11, Aiden Leong wrote:
>
>BTW: I do believe these functions should be split into a function family. It's really hard to call them correctly and hard to debug as well.

I don't think the functions should be split up. Most probably it is the
documentation that should be improved :) But, I do agree that it is not
that easy to call the functions correctly.

Best,
Ferdinand

-- 
Ferdinand Blomqvist
ferdinand.blomqvist[at]gmail.com
GPG key: 9EFB 7A2C 0432 4EC5 32BA FA61 CFE9 4164 93E8 B9E4
