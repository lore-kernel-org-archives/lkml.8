Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB890C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61F3206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujLlWxkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFPA1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPA1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:27:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:27:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t6so14599846otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QgmGpiw00RUbPn0dElJPKuqibpwqFCkOpmWT1FnzDzI=;
        b=ujLlWxkA3umisMZR0JmcKobuKsBtboPaJ1F78cCiizIXQG3HlvznN0deX6FpfW2lWv
         8FpnkainaGzGTHgPSz7kI6VtW6wIVMWMeuekpXFImudZ5mxZ5qyPkySTvQ9+mtXX3zMT
         PJ2CQLqdn0Naj/4OLo4svM8VbdOiN3ZAzg3XVyeBBqSFCyRS8rB2haQ+9YnimvsJlENx
         IYLNQ5f6izdFwPUbY3nQ9S1xnIyFhgIUKHNrIyKRkx9jWCEIWYwEl3Z23kK+EfXkah8O
         RZJAaI/oK3Qy1mQQ2aUzklteTeksJdbBMgImvn/w3sk8Zo7RflVf2HUz06ruoNOqFGzn
         c6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QgmGpiw00RUbPn0dElJPKuqibpwqFCkOpmWT1FnzDzI=;
        b=NofAoqd2mWSryU4Swxj469XOOJxzvQm5b34vMSdL+xlpFoHpVIrqGau9WtLDbqK3xg
         deEoGWEbmKZ53Qqk8kBJLvCrL3o/bckg9IzNhUDsFZMAq2VTAKyXlNNIql3Mkcej41/n
         OGYJFY06gCppKIfVqM9Za3271yY+u2dZ9QLIKy3Wze5V3Prj3So4l9EUZNFn7Zi04XBW
         PfNvVriZfPff3fuBWm271dxWPKu5nuIHgQiYRV+HizNSHC7hm+fMcAibtpkA7GLxeUjS
         VN8SCzhSvirsU13bmi1oxT3s7uZe0gOwhbO1sw2c4MWVjug2YFznWrEqtHGDWnSuSZ7H
         L7DA==
X-Gm-Message-State: AOAM533JgWr10YHe1A0qVN3I9qaoQJ6/HQ8d2s6FPEqUOFNGmUhKTnto
        vtzGH19cBAaEzr/qdUtk4gs=
X-Google-Smtp-Source: ABdhPJz7XarUh553UGUacOtBN5Tyk1+YhQXnamxQscG2gqubATjncfulr8Q1xNAWI1dKmMRSZZxq+Q==
X-Received: by 2002:a9d:6c03:: with SMTP id f3mr467685otq.291.1592267242901;
        Mon, 15 Jun 2020 17:27:22 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id f11sm3769430oib.43.2020.06.15.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:27:22 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:27:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
Message-ID: <20200616002720.GA1307277@ubuntu-n2-xlarge-x86>
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
 <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:55:52PM +0000, Christophe Leroy wrote:
> From: Michal Simek <michal.simek@xilinx.com>
> 
> The latest Xilinx design tools called ISE and EDK has been released in
> October 2013. New tool doesn't support any PPC405/PPC440 new designs.
> These platforms are no longer supported and tested.
> 
> PowerPC 405/440 port is orphan from 2013 by
> commit cdeb89943bfc ("MAINTAINERS: Fix incorrect status tag") and
> commit 19624236cce1 ("MAINTAINERS: Update Grant's email address and maintainership")
> that's why it is time to remove the support fot these platforms.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

This patch causes qemu-system-ppc to fail to load ppc44x_defconfig:

$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux- O=out/ppc distclean ppc44x_defconfig zImage

$ timeout --foreground 30s unbuffer \
qemu-system-ppc \
-machine bamboo \
-no-reboot \
-append "console=ttyS0" \
-display none \
-initrd ../../cbl/github/boot-utils/images/ppc32/rootfs.cpio \
-kernel out/ppc/arch/powerpc/boot/zImage \
-m 128m \
-nodefaults \
-serial mon:stdio
qemu-system-ppc: could not load kernel 'out/ppc/arch/powerpc/boot/zImage'

$ ls out/ppc/arch/powerpc/boot/zImage
out/ppc/arch/powerpc/boot/zImage

Is this expected? Is there some other config or machine that we should
be testing instead?

Cheers,
Nathan
