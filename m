Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BnlGW96a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgCDR1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:27:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45887 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:27:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so1283974pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=74P0B3neZZuder24JFAe+h37tZ3yaclWrx96mmitxFw=;
        b=BnlGW96a7KFcplXPG+JtXhFdTR0rjDo+A+Hzm0N6hmOjfZjWfH7tmd6w3B2Y/+ZY1R
         UJw695NC2b7tTGsoTIWIF0XipjDd9h5nkmsU0WocBuAZ+EPfx6+DULv6RWrmw9YqtQVc
         G2s4RibC/YTEsjbOg6kUxF4jiFgzNxYAPadHvjyzbFBRLPoQE0sUxCa/obNTMPBnZ0JD
         pYuzry5dds/uvDl0JAUsx7HfmW4zsUtUp0s5Oh5D3f2YczUeOSTkLqueBRTZxMVZrZ+i
         Yzrr5QknUYjbwfWABGGVwR4xs95gZfb4gci08aeY4lI0fseNNxdBoIX+NxoFeApqM+FS
         p9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=74P0B3neZZuder24JFAe+h37tZ3yaclWrx96mmitxFw=;
        b=BcA4aMEQBuWAcxEEE70bL8SooXCSuNqgeAMGVX6LM7OWfirDKjelrB3YQq7aPzq7/O
         R0aSsecrdpJ6m85TyejHEi4bBuF2jEYr42SyHXYduSwBYgdiM3sQ5tFPwHBg/Vw1TWM8
         T8uY8vXK68glT0Rh9qDjW9AsVjK71HWq9Jr95xbQCqH3F8YWUYMlowLGU+1pwflP63u/
         sU45f0GwqQtmHBA3z/HBLrAoDYpJ4YKU71Us9QWED9bm1DwGchSZS5i2zGgQitOp96Ny
         osSfncAWZUt9j1x9uyj41GhHX3X8CU8M18++qagKTK3FQEuZjUj8shT5zJeJYek1GbCV
         d9Ig==
X-Gm-Message-State: ANhLgQ299Kb5+o5kevW/TO1TD0jpvJ1STOaHbQm6VKD0mn3xDMDUHZZC
        1YDHrqqAzzJSVq5AEs0yKj8IPw==
X-Google-Smtp-Source: ADFU+vtsjhx5/sY+nX6LOWlNWh5qsA8lhTawE4vjv4t3oH1CXuPXKXaQO4QVQc/f0PzF9DgReb2Crw==
X-Received: by 2002:a17:90a:3730:: with SMTP id u45mr4047133pjb.8.1583342852552;
        Wed, 04 Mar 2020 09:27:32 -0800 (PST)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z20sm831526pge.62.2020.03.04.09.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Mar 2020 09:27:31 -0800 (PST)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     kishon@ti.com
Cc:     alan.mikhak@sifive.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, tjoseph@cadence.com
Subject: [PATCH v2 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
Date:   Wed,  4 Mar 2020 09:27:16 -0800
Message-Id: <1583342836-10088-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200303103752.13076-1-kishon@ti.com>
References: <20200303103752.13076-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

I applied this v2 patch series to kernel.org linux 5.6-rc3 and
built for x86_64 Debian and riscv. I verified that when I execute
the pcitest command on the x86_64 host with -d flag, the riscv
endpoint performs the transfer by using an available dma channel.

Regards,
Alan

Tested-by: Alan Mikhak <alan.mikhak@sifive.com>

