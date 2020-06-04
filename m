Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A9D2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgFDRhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:37:00 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:41442 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730083AbgFDRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:37:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EBE1F181B2466;
        Thu,  4 Jun 2020 17:36:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bulb68_170feaa26d99
X-Filterd-Recvd-Size: 1947
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 17:36:58 +0000 (UTC)
Message-ID: <7ea2fe7105006f74337498549f167e01d0fd5fc3.camel@perches.com>
Subject: Re: [PATCH] coccinelle: api: add kzfree script
From:   Joe Perches <joe@perches.com>
To:     efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jun 2020 10:36:56 -0700
In-Reply-To: <d0fced31-f1d7-9e0b-1a58-f441891fcbc7@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
         <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
         <d0fced31-f1d7-9e0b-1a58-f441891fcbc7@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 20:30 +0300, Denis Efremov wrote:
> 
> On 6/4/20 7:27 PM, Joe Perches wrote:
> > On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> > > Check for memset() with 0 followed by kfree().
> > 
> > Perhaps those uses should be memzero_explicit or kvfree_sensitive.
> 
> Thanks, I will add memzero_explicit(). However, I can't find kvfree_sensitive().
> Is it in next already?

Yes

$ git grep kvfree_sensitive
include/linux/mm.h:extern void kvfree_sensitive(const void *addr, size_t len);
mm/util.c: * kvfree_sensitive - Free a data object containing sensitive information.
mm/util.c:void kvfree_sensitive(const void *addr, size_t len)
mm/util.c:EXPORT_SYMBOL(kvfree_sensitive);
security/keys/keyctl.c: kvfree_sensitive(payload, plen);
security/keys/keyctl.c: kvfree_sensitive(payload, plen);
security/keys/keyctl.c:                         kvfree_sensitive(key_data, key_data_len);
security/keys/keyctl.c: kvfree_sensitive(key_data, key_data_len);
security/keys/keyctl.c: kvfree_sensitive(payload, plen);


