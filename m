Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C688C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471BF2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgB0M05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:26:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56611 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgB0M05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:26:57 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7IFj-0004nc-Bx; Thu, 27 Feb 2020 12:26:55 +0000
Date:   Thu, 27 Feb 2020 13:26:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 0/3] OpenRISC clone3 support
Message-ID: <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:56:22AM +0900, Stafford Horne wrote:
> This series fixes the clone3 not implemented warnings I have been seeing
> during recent builds.  It was a simple case of implementing copy_thread_tls
> and turning on clone3 generic support.  Testing shows no issues.

This all looks good to me. Thanks for doing this. We're getting closer
and closer to having all architectures supporting clone3()!

You want me to pick this series up for 5.7 or are you going through
another tree?

Christian
