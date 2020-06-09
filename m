Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C33C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BEA206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgFIWup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:50:45 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:51698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728108AbgFIWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:50:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6627218029138;
        Tue,  9 Jun 2020 22:50:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: front10_2d174eb26dc6
X-Filterd-Recvd-Size: 1181
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 22:50:43 +0000 (UTC)
Message-ID: <573b3fbd5927c643920e1364230c296b23e7584d.camel@perches.com>
Subject: RFC: Allow kfree to free all types of allocations ?
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jun 2020 15:50:42 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of patches trying to match
various [kv].alloc allocations to specific frees.

But are there frees in a fast path?

Why not convert kfree to add a few extra tests
and add #defines for existing uses

Something like:

void kfree(const void *addr)
{
	if (is_kernel_rodata((unsigned long)addr))
		return;

	if (is_vmalloc_addr(addr))
		_vfree(addr);
	else
		_kfree(addr);
}

And add defines like:

#define kvfree		kfree
#define vfree		kfree
#define kfree_const	kfree

Does 4 extra tests really matter?


