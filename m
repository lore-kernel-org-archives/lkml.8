Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C920DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9951920823
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="hbBdgWq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFBC44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgFBC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:56:54 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848BCC061A0E;
        Mon,  1 Jun 2020 19:56:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49bcBn3GWMz9sSg;
        Tue,  2 Jun 2020 12:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591066611;
        bh=YCwgkBAIWR9lwcZTT3gJGRHrETSDKFKv9oHQKKerD1g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hbBdgWq/e1Emt3gRHmqD91+k4UdRYjXCpeFqENlHwoArQaV+KU7uWGLPbrf5+6Trr
         Fqj/ynRGm/Lfi0OnBPtSJmw41FmwJq9Imu80idpvhtdRhtX7lStU/LJAP5M5khPQm+
         8+MwVX42mFeaetY8yuod+gPeLHl9z0gsE04oJor+DF3BIskjXraOCLxzzxpLOfLNPz
         gK6Rxx4IzvN8CZnX4iVw2uflA+suvEVTUjyGExPXzSPZ5/WPxVL7RMquIsh75zaXsl
         CoF+zwYUD2yso3mE3N7oW9Yb61Shiw7rcqu1KRC4WQfh4f7qyw5k4uPG1PNvvl3tzt
         jmTVNMdNqKBag==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Allison Randal <allison@lohutok.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Cross <ccross@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error message
In-Reply-To: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
References: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
Date:   Tue, 02 Jun 2020 12:57:11 +1000
Message-ID: <87imgai394.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> writes:
>> Please just remove the message instead, it's a tiny allocation that's
>> unlikely to ever fail, and the caller will print an error anyway.
>
> How do you think about to take another look at a previous update suggestion
> like the following?
>
> powerpc/nvram: Delete three error messages for a failed memory allocation
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> https://lore.kernel.org/linuxppc-dev/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> https://lore.kernel.org/patchwork/patch/752720/
> https://lkml.org/lkml/2017/1/19/537

That deleted the messages from nvram_scan_partitions(), but neither of
the callers of nvram_scan_paritions() check its return value or print
anything if it fails. So removing those messages would make those
failures silent which is not what we want.

cheers
