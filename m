Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D93C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C7206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgD1Som (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731383AbgD1Soh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:44:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B2C03C1AB;
        Tue, 28 Apr 2020 11:44:37 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 468FE44A;
        Tue, 28 Apr 2020 18:44:37 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:44:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: LSM: Correct the basic LSM description
Message-ID: <20200428124436.1c7463ee@lwn.net>
In-Reply-To: <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
References: <4c053d72-2d58-612f-6d6b-f04226d0181e.ref@schaufler-ca.com>
        <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 14:48:34 -0700
Casey Schaufler <casey@schaufler-ca.com> wrote:

> This is a first pass at updating the basic documentation on
> Linux Security Modules (LSM), which is frighteningly out of date.
> Remove untrue statements about the LSM framework. Replace them
> with true statements where it is convenient to do so. This is
> the beginnig of a larger effort to bring the LSM documentation
> up to date.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/security/lsm.rst | 202 ++++++++++++++---------------------------
>  1 file changed, 66 insertions(+), 136 deletions(-)

James, are you planning to pick this up, or should I grab it?

Thanks,

jon
