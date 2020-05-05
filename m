Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64119C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4930C206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgEEPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgEEPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:41:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13825C061A0F;
        Tue,  5 May 2020 08:41:16 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ADE5A737;
        Tue,  5 May 2020 15:41:15 +0000 (UTC)
Date:   Tue, 5 May 2020 09:41:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joshua Abraham <j.abraham1776@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: kvm: Fix KVM_KVMCLOCK_CTRL API doc
Message-ID: <20200505094114.5b346623@lwn.net>
In-Reply-To: <20200501223624.GA25826@josh-ZenBook>
References: <20200501223624.GA25826@josh-ZenBook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 18:36:24 -0400
Joshua Abraham <j.abraham1776@gmail.com> wrote:

> The KVM_KVMCLOCK_CTRL ioctl signals to supported KVM guests
> that the hypervisor has paused it. Update the documentation to
> reflect that the guest is notified by this API.
> 
> Signed-off-by: Joshua Abraham <sinisterpatrician@gmail.com>
> ---
> Changes in v2:
>     - Re-word documentation to be clearer. Also fix a small grammar
>       error.
> 
>  Documentation/virt/kvm/api.rst | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied, thanks.

jon
