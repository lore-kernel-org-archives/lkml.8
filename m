Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B31C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A152E2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgGPPq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:46:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60324 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgGPPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:46:25 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jw65X-0005hh-Ci
        for linux-kernel@vger.kernel.org; Thu, 16 Jul 2020 15:46:23 +0000
Received: by mail-vk1-f200.google.com with SMTP id g131so2199654vke.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49511E8U5NzXj6XxH4TCed0T2TTPIp8dIWRGqxsbGQ8=;
        b=p+K+HIRKDra09sSMY9mR0vLmu6NbF+dN88Wx4BfNcDIG3iQZ2R4U4Y2yuoa3sxYwMo
         jKQDpoxTN4iVITOQ9q6ZANJz6bHPDhpAJyI+0I8gZTh9jDPT5abJ5hIjG1ARo+6bCV73
         Zm3bB81S2bM8IDma/Ait+lBniVXr9zSUmnsJz0I1td3uJMFJkw0JtqrA/DI5KCNyVyQP
         /CBeOjGZ4znjHD2YH6qbjwKH/UOhOdKvCeKq5L7bcnZ4eMfZipK+iOo2sHYzmQO1OAaY
         OkTFyiXBbTI3R8B2sECx2q6OQvaR4pFpK09OlZaHXLyYhjOaf8hTHwWfETqoV9IaupjM
         3VXw==
X-Gm-Message-State: AOAM532zbxm8xuEwm3v58IWXKGgR/iOZ23ipOxx99VVhJ/t2AlOMALIJ
        8Upo7mmoRx33yhHNFa6YnHJXfGL2j5vIFmsMTmXOipXzvye4eiAE2uR2K6JM5YiOWIHKhg/orHT
        Bf5uWUS/r0dsdq3cY/0jlmonHkf9eeMky256TU/vekkW6lnOufuUPJPWlJg==
X-Received: by 2002:ab0:316:: with SMTP id 22mr4021374uat.41.1594914382443;
        Thu, 16 Jul 2020 08:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjBUFlT4V7UrutO5eSdMrKrzPd3+TUuc1pXG56i1MfLoBhtZFvasxN99/Oi07H7IokRV/M1tkLBOlMIoeNZWY=
X-Received: by 2002:ab0:316:: with SMTP id 22mr4021357uat.41.1594914382214;
 Thu, 16 Jul 2020 08:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200714124032.49133-1-paolo.pisati@canonical.com>
 <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMsH0TQLKba_6G5CDpY4pDpr_PWVu0yE_c+LKoa+2fm2f4bjBQ@mail.gmail.com> <20200716083844.709bad58@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200716083844.709bad58@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Paolo Pisati <paolo.pisati@canonical.com>
Date:   Thu, 16 Jul 2020 17:46:11 +0200
Message-ID: <CAMsH0TT0yYr0R99aN8sn8nTjWryt0wo+4wHLbQsNuPTruXk8qA@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: ip_defrag: modprobe missing
 nf_defrag_ipv6 support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 5:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> I don't think modprobe fails when code is built in.
>
> $ sudo modprobe pstore
> $ echo $?
> 0
> $ grep CONFIG_PSTORE= /boot/config-5.7.8-200.fc32.x86_64
> CONFIG_PSTORE=y
> $ lsmod | grep pstore
> $

Ah, i didn't know - i'll send a V2 then.
-- 
bye,
p.
