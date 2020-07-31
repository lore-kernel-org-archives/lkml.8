Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BCEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B923721883
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgGaJOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:14:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:60100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgGaJOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:14:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8158B622;
        Fri, 31 Jul 2020 09:14:35 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:14:21 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com,
        benh@kernel.crashing.org
Subject: Re: [PATCH v2 0/9] Make check implementation arch agnostic
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2007311113140.19678@pobox.suse.cz>
References: <20200730094652.28297-1-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've push both series base on top of tip/objtool/core at [3].
> 
> - The first two patches make it simpler for new arches to provide their
> list of kernel headers, without worrying about modifications in the x86
> headers.
> - Patch 3 Moves arch specific macros to more suitable location
> - Patches 4 and 5 add abstraction to handle alternatives
> - Patch 6 adds abstraction to handle jump table
> - Patches 7-9 abstracts the use of unwind hints, so some definitions
>   can be shared across architectures while keeping arch specific
>   semantics
> 
> Changes since v1 [4]:
> - Rebased on recent tip/objtool/core
> - Split the unwind hint rework into multiple patches as suggested by
>   Miroslav

For remaining patches 7-9

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
