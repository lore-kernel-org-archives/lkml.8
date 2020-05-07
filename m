Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053E2C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEEC2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgEGBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgEGBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:11:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6545C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 18:11:33 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWV4Q-0007Ow-4G; Thu, 07 May 2020 03:11:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8ECF7102652; Thu,  7 May 2020 03:11:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nelson D'Souza <nelson.dsouza@linux.intel.com>, bp@alien8.de
Cc:     mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v1] x86/cpu/tsx: Change the TSX default from "off" to "auto"
In-Reply-To: <20200506221459.29104-1-nelson.dsouza@linux.intel.com>
References: <20200506221459.29104-1-nelson.dsouza@linux.intel.com>
Date:   Thu, 07 May 2020 03:11:25 +0200
Message-ID: <877dxok0qq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nelson D'Souza <nelson.dsouza@linux.intel.com> writes:
> There are now several commercially available processors that have h/w
> fixes for the TSX Async Abort (TAA) issue as indicated by enumerating
> the ARCH_CAPABILITIES "TAA_NO" bit.
>
> Change the default setting to "auto" so that these CPUs will leave
> TSX enabled by default.

You are telling WHAT the patch does, but not the WHY.

It's completely uninteresting whether TAA is fixed in a particular CPU
simply because:

   1) TAA is only one particular issue of TSX.

   2) The main use case for TSX is to accelerate all sorts of
      speculation attacks and other malignances

   3) There is excatly ONE known use case which cares about TSX and we
      already discussed to death that the machines on which that use
      case runs have admins which are capable of adding tsx=on on the
      command line.

So unless you come up with some really convincing argument why this
should be changed, this is not going to happen.

Thanks,

        tglx




