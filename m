Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B557920829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgG3CfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:35:08 -0400
Received: from namei.org ([65.99.196.166]:56480 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgG3CfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:35:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06U2Z3Ml004552;
        Thu, 30 Jul 2020 02:35:03 GMT
Date:   Thu, 30 Jul 2020 12:35:03 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the security tree
In-Reply-To: <20200730093500.334c56cb@canb.auug.org.au>
Message-ID: <alpine.LRH.2.21.2007301233210.3625@namei.org>
References: <20200708140034.546298ff@canb.auug.org.au> <20200713120419.33cf7a87@canb.auug.org.au> <20200730093500.334c56cb@canb.auug.org.au>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020, Stephen Rothwell wrote:

> > I am still applying the above patch ...
> 
> The merge window is coming up fast ... is anything happening about this
> failure?

A new patch is coming, but I'm not sure this code has had enough review 
from the core VFS folk.

Please drop secure_uffd_v5.9 for the time being.


-- 
James Morris
<jmorris@namei.org>

