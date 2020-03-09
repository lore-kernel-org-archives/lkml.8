Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B41C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E454920828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="gsbaEB3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCIKys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:54:48 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:50662 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIKys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N+EgSKpUVGvZZBnZhkV/Dsiay1eYCpG7N5qcvOMsZ9A=; b=gsbaEB3nfZ4YckQ3J8MhAzTuUQ
        xqGm6ZNIkQ5aNMW+D7I9tCtXRdKqKbn9ZxYgdsfa2gFp7v+50YQjHG/UeoOSd9v+KPdJnvBPBSKXx
        3Dbal9ApDqBSeIeFdhD5w7iS9ufYzOXTEfyq8KGV5vY6l39nGS1Bj06jHiz8vqJvRTzE=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:61769 helo=[10.97.34.6])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <linux@eikelenboom.it>)
        id 1jBG5b-0000sg-2o; Mon, 09 Mar 2020 11:56:51 +0100
To:     linux-kernel <linux-kernel@vger.kernel.org>, "kvm@"@vger.kernel.org
From:   Sander Eikelenboom <linux@eikelenboom.it>
Subject: linux 5.6-rc5: KVM -Werror Kconfig default yes contradicts
 description which says: If in doubt say N.
Message-ID: <69db5087-c6bb-21e0-55d6-3fbc0fd57881@eikelenboom.it>
Date:   Mon, 9 Mar 2020 11:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,

The Y default for the kconfig option seems to contradict it's
description, which says if in doubt say 'N' ?

--
Sander




Virtualization (VIRTUALIZATION) [Y/n/?] y
  Kernel-based Virtual Machine (KVM) support (KVM) [M/n/y/?] m
  Compile KVM with -Werror (KVM_WERROR) [Y/n/?] (NEW) ?

CONFIG_KVM_WERROR:

Add -Werror to the build flags for (and only for) i915.ko.

If in doubt, say "N".

Symbol: KVM_WERROR [=y]
Type  : bool
Defined at arch/x86/kvm/Kconfig:62
  Prompt: Compile KVM with -Werror
  Depends on: VIRTUALIZATION [=y] && (X86_64 [=y] && !KASAN [=n] ||
!COMPILE_TEST [=n]) && EXPERT [=y]
  Location:
    -> Virtualization (VIRTUALIZATION [=y])



  Compile KVM with -Werror (KVM_WERROR) [Y/n/?] (NEW)
