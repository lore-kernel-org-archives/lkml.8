Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC17206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgFEHut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgFEHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:50:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D9E9AB7D;
        Fri,  5 Jun 2020 07:50:51 +0000 (UTC)
Date:   Fri, 5 Jun 2020 09:50:47 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Max Filippov <jcmvbkbc@gmail.com>
cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, jeyu@kernel.org
Subject: Re: [PATCH] kernel/modules: fix build without
 ARCH_HAS_STRICT_MODULE_RWX
In-Reply-To: <20200604210115.16826-1-jcmvbkbc@gmail.com>
Message-ID: <alpine.LSU.2.21.2006050949210.10354@pobox.suse.cz>
References: <20200604210115.16826-1-jcmvbkbc@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1678380546-113731455-1591343447=:10354"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678380546-113731455-1591343447=:10354
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 4 Jun 2020, Max Filippov wrote:

> On configurations with CONFIG_ARCH_HAS_STRICT_MODULE_RWX disabled kernel
> build fails with the following message:
> 
>   kernel/module.c:3593:2: error: implicit declaration of function
>   ‘module_enable_ro’;
> 
> Add empty module_enable_ro definition to fix the build.
> 
> Fixes: e6eff4376e28 ("module: Make module_enable_ro() static again")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

I think the problem should disappear once Jessica sends her pull request 
for modules tree.

Unfortunate though.

Miroslav
--1678380546-113731455-1591343447=:10354--
