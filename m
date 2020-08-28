Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A04C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6317320776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgH1JLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:11:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgH1JLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:11:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62F8DB64B;
        Fri, 28 Aug 2020 09:12:16 +0000 (UTC)
Date:   Fri, 28 Aug 2020 11:11:43 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, benh@kernel.crashing.org
Subject: Re: [PATCH v4 2/4] objtool: Move orc outside of check
In-Reply-To: <20200825124742.29782-3-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2008281111310.29208@pobox.suse.cz>
References: <20200825124742.29782-1-jthierry@redhat.com> <20200825124742.29782-3-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020, Julien Thierry wrote:

> Now that the objtool_file can be obtained outside of the check function,
> orc generation builtin no longer requires check to explicitly call its
> orc related functions.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
