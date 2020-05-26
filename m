Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71323C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6EC207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590525918;
	bh=w80sfgIp3R5YveQ9sUv97QVAngNOtntSgmorvsNwyR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xXRHsn7Uv6n4Id8J/7LR/WRvwLwxoPXpShgid+ov7TVBXYzEoyk7N0o98WmVy3KKV
	 KUzI6hbh3jfgYa8D/rNhy1ha+xAO+eapIWT6HT6jC+V6VmsifhmiZJ9WxzU5gWejsE
	 X0Urlmo81N3kY/A1zVPwYP+tmB/Zyvd9qKUF0lEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403911AbgEZUpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403895AbgEZUpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:45:15 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681FD20888;
        Tue, 26 May 2020 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590525915;
        bh=w80sfgIp3R5YveQ9sUv97QVAngNOtntSgmorvsNwyR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br8osr+rcBYborGWc/hNWnkzH4wihPwEDw4uWIJxiVUCZWcY3xXR2LUdy7Mz55592
         CwP6VRbpx4/gav2PHlHogWybaB7pqKEt2PbytPqjo9hVQn3Vhq+fTy/dSm2IkzuEPT
         vvIm+oXcTzRz7EyBmQQcSEpyWVz+Slw7lz/5YRlA=
From:   Will Deacon <will@kernel.org>
To:     sudeep.holla@arm.com, guohanjun@huawei.com,
        lorenzo.pieralisi@arm.com, Zenghui Yu <yuzenghui@huawei.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        wanghaibin.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, lenb@kernel.org
Subject: Re: [PATCH] ACPI/IORT: Remove the unused __get_pci_rid()
Date:   Tue, 26 May 2020 21:45:06 +0100
Message-Id: <159052221332.23066.17607984571452199733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509093430.1983-1-yuzenghui@huawei.com>
References: <20200509093430.1983-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 17:34:30 +0800, Zenghui Yu wrote:
> Since commit bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for
> IOMMUs"), __get_pci_rid() has become actually unused and can be removed.

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: Remove the unused __get_pci_rid()
      https://git.kernel.org/arm64/c/09cda9a71350

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
