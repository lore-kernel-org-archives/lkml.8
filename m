Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE09C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C71215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCaL00L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCCHnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:43:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:43:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id g134so532932wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=19y8hOwEla5LQ3+q+f8D7McftSkNCumM9N4Er3lVr7E=;
        b=qCaL00L+lgluqeD7V6Li2FtyeNm4SiJjl2I3OZo+ttzhqvUyXsu+W8M2GcGpzr5z1U
         Js/ngQ7Uq4qVDuioB6r6A1dtezHGNWmjaxoEkddUzlLZbs9kfRyn11bccHe+1bAo2O6T
         f47JDo8Chc156DXbObyfI6o6WmDtcgofD+v8e66DxWQAsFNi91ho7u9TjLS2LL8uzv8r
         L3wtY0IZKM3GSNQiwTTWCi6cGh0EDwsZEPyDE1bcYSILnDT6raz8lKAPbFZbUJjUsg12
         RBocHthCRJ370sbl4DLbaEPPYIEbWojWy1YCjZJ8ZgUVY/8C7Ws8vAbJ665D3yRCzamO
         xzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=19y8hOwEla5LQ3+q+f8D7McftSkNCumM9N4Er3lVr7E=;
        b=kkEIk401V1g6O9RIntQlfVef863n/sfw9aZnpFZzCLpGLNjxteqagNQUKPXKvwXl4S
         E1Nhkg+y8HiygcJte1HFiHHrsDP/EyQ8RaWlhW+9sgtzb9GQrQYzmlx5IrcCLvQCKeQs
         1uVCLdgXvrZw18j8FjimVkTwh21+K+v/+PCEcIeixA9+gkWMw7i/FBI5VhuubTG2ePHp
         Rvds3iDnIzqWDMYyLV22hQ6LgzYTBSy4DVSNPDWaOf2WojslMmyeZRTxNXWGiyQlmaLs
         ywJrK9/4LgnGanCMPZVE9snkQbIzFzGvdy2FWmuqUYA8dnnrpCcnx2GKG0orpXId2bgB
         ZVGg==
X-Gm-Message-State: ANhLgQ1dx6mPqmomUaaVMh8oa6Lg2UeQ7xqOlIdyv3Py5kxEqEE48sMj
        GmvXph175sPi45Fr5KOoDrE=
X-Google-Smtp-Source: ADFU+vuw49wz51LirDGbH9qymWMVbsh0ZceIk1lUYnfagI/ccly8un3TZ7OYV+RRC94XY7n1OvtE5Q==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr2763832wmj.19.1583221409141;
        Mon, 02 Mar 2020 23:43:29 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g7sm32066854wrq.21.2020.03.02.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 23:43:28 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:43:26 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     maz@kernel.org, wens@csie.org, mripard@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com
Subject: sunxi: a83t: does not boot anymore in BigEndian
Message-ID: <20200303074326.GA9935@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

My sun8i-a83t-bananapi-m3 does not boot anymore in BE.
Others sunxi platform I have seems not affected (a10, a20, a64, h3, h5, h6)

I have bisected this problem:
git bisect start
# bad: [98d54f81e36ba3bf92172791eba5ca5bd813989b] Linux 5.6-rc4
git bisect bad 98d54f81e36ba3bf92172791eba5ca5bd813989b
# bad: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
git bisect bad d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
# good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
# bad: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad 8c39f71ee2019e77ee14f88b1321b2348db51820
# bad: [3b397c7ccafe0624018cb09fc96729f8f6165573] Merge tag 'regmap-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad 3b397c7ccafe0624018cb09fc96729f8f6165573
# good: [924ea58dadea23cc28b60d02b9c0896b7b168a6f] Merge tag 'mt76-for-kvalo-2019-11-20' of https://github.com/nbd168/wireless
git bisect good 924ea58dadea23cc28b60d02b9c0896b7b168a6f
# good: [3f3c8be973af10875cfa1e7b85a535b6ba76b44f] Merge tag 'for-linus-5.5a-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good 3f3c8be973af10875cfa1e7b85a535b6ba76b44f
# bad: [642356cb5f4a8c82b5ca5ebac288c327d10df236] Merge git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 642356cb5f4a8c82b5ca5ebac288c327d10df236
# good: [57d8154f15e89f53dfb412f4ed32ebe3c3d755a0] crypto: atmel-aes - Change data type for "lastc" buffer
git bisect good 57d8154f15e89f53dfb412f4ed32ebe3c3d755a0
# bad: [752272f16dd18f2cac58a583a8673c8e2fb93abb] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 752272f16dd18f2cac58a583a8673c8e2fb93abb
# good: [9477f4449b0b011ce1d058c09ec450bfcdaab784] KVM: VMX: Add helper to check reserved bits in IA32_PERF_GLOBAL_CTRL
git bisect good 9477f4449b0b011ce1d058c09ec450bfcdaab784
# bad: [cd7056ae34af0e9424da97bbc7d2b38246ba8a2c] Merge remote-tracking branch 'kvmarm/misc-5.5' into kvmarm/next
git bisect bad cd7056ae34af0e9424da97bbc7d2b38246ba8a2c
# bad: [c7892db5dd6afe921ead502aff7440a1e450d947] KVM: arm64: Select TASK_DELAY_ACCT+TASKSTATS rather than SCHEDSTATS
git bisect bad c7892db5dd6afe921ead502aff7440a1e450d947
# bad: [8564d6372a7d8a6d440441b8ed8020f97f744450] KVM: arm64: Support stolen time reporting via shared structure
git bisect bad 8564d6372a7d8a6d440441b8ed8020f97f744450
# bad: [55009c6ed2d24fc0f5521ab2482f145d269389ea] KVM: arm/arm64: Factor out hypercall handling from PSCI code
git bisect bad 55009c6ed2d24fc0f5521ab2482f145d269389ea
# bad: [6a7458485b390f48e481fcd4a0b20e6c5c843d2e] KVM: arm64: Document PV-time interface
git bisect bad 6a7458485b390f48e481fcd4a0b20e6c5c843d2e
# bad: [dcac930e9901d765234bc15004db4f7d4416db71] Merge remote-tracking branch 'arm64/for-next/smccc-conduit-cleanup' into kvm-arm64/stolen-time
git bisect bad dcac930e9901d765234bc15004db4f7d4416db71
# first bad commit: [dcac930e9901d765234bc15004db4f7d4416db71] Merge remote-tracking branch 'arm64/for-next/smccc-conduit-cleanup' into kvm-arm64/stolen-time

But bisect lead to a merge request.

Regards
