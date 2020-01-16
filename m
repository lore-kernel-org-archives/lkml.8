Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA1C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3371B2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbgAPTw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:52:57 -0500
Received: from ms.lwn.net ([45.79.88.28]:44586 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbgAPTw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:52:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 24C8A1E5;
        Thu, 16 Jan 2020 19:52:56 +0000 (UTC)
Date:   Thu, 16 Jan 2020 12:52:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] kconfig: fix documentation typos
Message-ID: <20200116125255.56eba406@lwn.net>
In-Reply-To: <20200113232212.138327-1-helgaas@kernel.org>
References: <20200113232212.138327-1-helgaas@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 17:22:11 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix a couple typos in kconfig-language documentation.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/kbuild/kconfig-language.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good to me; Masahiro I assume you'll be taking this one?

Thanks,

jon
