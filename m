Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31503C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1350520716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgICPNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:13:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbgICLnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:43:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE9B1B1A7;
        Thu,  3 Sep 2020 11:43:20 +0000 (UTC)
Date:   Thu, 3 Sep 2020 13:43:18 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: support symtab_shndx during dump
In-Reply-To: <20200812175712.9462-1-kristen@linux.intel.com>
Message-ID: <alpine.LSU.2.21.2009031342590.6039@pobox.suse.cz>
References: <20200812175712.9462-1-kristen@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020, Kristen Carlson Accardi wrote:

> When getting the symbol index number, make sure to use the
> extended symbol table information in order to support symbol
> index's greater than 64K.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
