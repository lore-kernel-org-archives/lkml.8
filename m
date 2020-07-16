Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BDCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA12067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGPHX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:23:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgGPHX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:26 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jvyEm-00048z-FZ
        for linux-kernel@vger.kernel.org; Thu, 16 Jul 2020 07:23:24 +0000
Received: by mail-vs1-f72.google.com with SMTP id h1so843533vsk.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VmvjZDsnQSCsnAdrtuni5GNCSEbuCmNLcMY3wa2Le0=;
        b=q+TbdSrYoZZ6HHvEyO2sOWiqToh8zwJkwlXnKoGuAkesuOrgWI55Q1Enz/NhL6Aj0x
         ChK2omhVxOM+A4ZWfEmM7aC491X3XxwqVPAqtTHYs7fzUPOprAjOJrDuI28zY7XPj1Td
         q6h8UyBXTkZDkvt+CMh+g2QDA6AmYBMmeUtJnWdDEo3L+jXDn/D/pL2Opt5MHQ1vO8+y
         0knpLT8GwFF8taMSBXNvgZHifBn+s/GHY7Y3p1iuzPsqOhNGHo1T5Z2mDW/8FigllfHY
         byyMf5e+RCGbqUU+iAP5FU7LY/hscNfT9e8obDDAxR2nztd/HeYbQMiQbLVa2naVeJ6t
         DwWw==
X-Gm-Message-State: AOAM530oi3yjdUzlYK2ZEtVQXirCiuQrEDwQXb4xe1cmwUGsjFQa0/J7
        nS/abdxbbOY2DEVcNGhZP2So1ATheOxKg6W2NfViFQUWqZATGwDLFBt4bDkIWwfuOBD1o3T2Wtx
        KTmvqdc4PJhILwrdY18jFNe0t3ie4R6rKxnTUNe3K1MghA7+0vi6P9Vobjg==
X-Received: by 2002:a67:ea92:: with SMTP id f18mr2022730vso.223.1594884203580;
        Thu, 16 Jul 2020 00:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS+5S514mTPFzXqUXVOTEZkeMuUy2FYfT9xaHwmafmZRwQscM2lA1wpLggKg5Y3dTj0KuOtDWJMMfXoNs0idk=
X-Received: by 2002:a67:ea92:: with SMTP id f18mr2022712vso.223.1594884203322;
 Thu, 16 Jul 2020 00:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200714124032.49133-1-paolo.pisati@canonical.com> <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Paolo Pisati <paolo.pisati@canonical.com>
Date:   Thu, 16 Jul 2020 09:23:12 +0200
Message-ID: <CAMsH0TQLKba_6G5CDpY4pDpr_PWVu0yE_c+LKoa+2fm2f4bjBQ@mail.gmail.com>
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

On Thu, Jul 16, 2020 at 3:01 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Any reason you add this command before set -e ?
>
> It seems we want the script to fail if module can't be loaded.

Cause if CONFIG_NF_DEFRAG_IPV6=y, the script would unnecessarily fail.

-- 
bye,
p.
