Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FF0246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCBHnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:43:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47393 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:43:22 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8fjS-00012G-Sr; Mon, 02 Mar 2020 07:43:19 +0000
Date:   Mon, 2 Mar 2020 08:43:18 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] openrisc: Convert copy_thread to copy_thread_tls
Message-ID: <20200302074318.oekwyowoej5777cn@wittgenstein>
References: <20200301213851.8096-1-shorne@gmail.com>
 <20200301213851.8096-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200301213851.8096-2-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 06:38:49AM +0900, Stafford Horne wrote:
> This is required for clone3 which passes the TLS value through a
> struct rather than a register.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
