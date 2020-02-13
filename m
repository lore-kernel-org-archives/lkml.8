Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D825C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F6E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="asQduntX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgBMNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:50:07 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36766 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgBMNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:50:07 -0500
Received: by mail-qt1-f172.google.com with SMTP id t13so4399960qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=hYWzdyVfx8Qtyuo6FsSKCev9Wngp3vI5dQBFQPr+z38=;
        b=asQduntXxoDqj4rpCaoGvHOQ1wkbE2AIP+WmNjqJd4jJ98NSHc6WIIqySVY11MhBmc
         HiFoySnWDJCxGHwvHEM9glItkO9hpTzcFtUckVvstoeeSNOAqdHXoXrg3zz00XXxdOjM
         Y5lTj22qEBaKgI2eyn4DhbDnhs2dwiB9Z2aiYqv5GWtqDVXn7aszCbsYAR0AGus8FuVo
         qQjEc87hgGcZYHnqmfOI/c+pfSsXTLkG0iRDvDqmccu2soP5bnV0VlNytNIQUpLvuerO
         k4oKTneOg6Arr1DH2cceGUoO0HzMRStdSMUfpve35PAuhJhH6EZHqU4aKC8Gf0jzcQPR
         GUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=hYWzdyVfx8Qtyuo6FsSKCev9Wngp3vI5dQBFQPr+z38=;
        b=N8HyBAaxxaPecQhCnp2jDe4C2AQ2HYYSmUJmwt7YWgDtiGfimNQ9JyTiBaqu/liz9y
         YmQQW37+7XU4deTTw1XMyQeXfXzAGG0v9VSw7JoWsAtWLbJ5DW1ttuu3yuoRk9Oh8ZCl
         5hmo7ojt3lg7kC0ZkJ+rNP7Iq0ZPV6EVIGRApOcLOljNU4g+P7GF8nIkDI4joiN6pJY/
         9OhXxx5Z8B0fZEUuEtSH2lckM6JPWJRCHmwgUaL5xT6o1wQ5KYidAvt5vSyUks33sZAS
         NDe5glcdNtmHlzhUd+GSDfoGqjo8Bz4WEZVDLOdDHMSxzEFKcaiK/n9uwx2Zq5IbRTf8
         2KQg==
X-Gm-Message-State: APjAAAVbwBCjmfnoBgYazcn8fWvKYJSBnWcXzn6hgAolG+s6JOqa8iYl
        NiV0uHeldBxhnDl6i8Z8kmObww==
X-Google-Smtp-Source: APXvYqwA+9/ZAaF2KlXuLlj8Uncda4mkIqcNiui+fb6MIQTtai11Pu7pHSfxSn6DOLXREHif/a9goA==
X-Received: by 2002:ac8:1a19:: with SMTP id v25mr24196508qtj.146.1581601805810;
        Thu, 13 Feb 2020 05:50:05 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c14sm1327859qkj.80.2020.02.13.05.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 05:50:05 -0800 (PST)
Message-ID: <1581601803.7365.57.camel@lca.pw>
Subject: "KVM: x86: enable -Werror" breaks W=1 compilation
From:   Qian Cai <cai@lca.pw>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     joe@perches.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 08:50:03 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People have been running W=1 to catch additional compilation warnings with an
expectation that not all of warnings will be fixed, but the linux-next commit
ead68df94d24 ("KVM: x86: enable -Werror") breaks the build for them.

arch/x86/kvm/../../../virt/kvm/kvm_main.c:663:12: error: no previous prototype
for ‘kvm_arch_post_init_vm’ [-Werror=missing-prototypes]
 int __weak kvm_arch_post_init_vm(struct kvm *kvm)
            ^~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/../../../virt/kvm/kvm_main.c:672:13: error: no previous prototype
for ‘kvm_arch_pre_destroy_vm’ [-Werror=missing-prototypes]
 void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
