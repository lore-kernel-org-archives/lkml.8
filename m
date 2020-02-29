Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94303C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F8C2467D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgB2SIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 13:08:39 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35013 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgB2SIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:08:38 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48VDtD2wlqz1rfPg;
        Sat, 29 Feb 2020 19:08:35 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48VDtC6Sd5z1qql9;
        Sat, 29 Feb 2020 19:08:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZgJXLnzSXOOR; Sat, 29 Feb 2020 19:08:35 +0100 (CET)
X-Auth-Info: uOJgOoUGSWhnpYpJZ6Ce4sZpFOhSnb7o1YTun+Kg6Kk=
Received: from crub (pD95F11D0.dip0.t-ipconnect.de [217.95.17.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 29 Feb 2020 19:08:35 +0100 (CET)
Date:   Sat, 29 Feb 2020 19:08:30 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] powerpc: Update MPC5XXX MAINTAINERS entry
Message-ID: <20200229190830.52eebda0@crub>
In-Reply-To: <20200224233146.23734-6-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
        <20200224233146.23734-6-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 10:31:44 +1100
Michael Ellerman mpe@ellerman.id.au wrote:

>It's several years since the last commit from Anatolij, so mark
>MPC5XXX as "Odd Fixes" rather than "Maintained".
>
>Also the git link no longer works so remove it.
>
>Cc: Anatolij Gustschin <agust@denx.de>
>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Anatolij Gustschin <agust@denx.de>


