Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00212C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38112081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgFZEqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgFZEqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:46:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFFFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:46:02 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTg0x1Nz9sTF; Fri, 26 Jun 2020 14:45:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        John Crispin <john@phrozen.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Imre Kaloz <kaloz@openwrt.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1482393968-60623-1-git-send-email-john@phrozen.org>
References: <1482393968-60623-1-git-send-email-john@phrozen.org>
Subject: Re: [PATCH] arch: powerpc: ppc4xx compile flag optimizations
Message-Id: <159314672783.1150869.15085498536728162262.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:45:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2016 09:06:08 +0100, John Crispin wrote:
> This patch splits up the compile flags between ppc40x and ppc44x.

Applied to powerpc/next.

[1/1] powerpc/4xx: ppc4xx compile flag optimizations
      https://git.kernel.org/powerpc/c/548ad77d10f7ad6e5f84a0026978da2ed1df0dae

cheers
