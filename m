Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6270208A9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgH2Xt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:49:59 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:56316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728095AbgH2Xt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:49:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3E5A7837F24A;
        Sat, 29 Aug 2020 23:49:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shock04_2e0f26127082
X-Filterd-Recvd-Size: 1596
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 23:49:56 +0000 (UTC)
Message-ID: <461dfa640ae8e98b92ad82b6a5fbef843351d129.camel@perches.com>
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 16:49:55 -0700
In-Reply-To: <31462501-a1fc-7470-ce7c-70e7bd9c0d96@linux.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
         <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
         <fe4de2e9f0a492e66b870cddbadb820e3459cc7a.camel@perches.com>
         <31462501-a1fc-7470-ce7c-70e7bd9c0d96@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-30 at 00:53 +0300, Denis Efremov wrote:
> > Anyway, this will need updating, likely with better examples.
[]
> I think it's good to reflect in docs that sysfs_emit_at/sysfs_emit_pos is
> only for "legacy" code and should not be used in new code (checkpatch.pl warning?)
> because of sysfs design principles.

sysfs_emit_at is also used for arrays.


