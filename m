Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB96C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502CA20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2QqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:46:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgD2QqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:46:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB1C4AC69;
        Wed, 29 Apr 2020 16:46:06 +0000 (UTC)
Date:   Wed, 29 Apr 2020 18:46:07 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v2 00/14] objtool vs retpoline
In-Reply-To: <20200428191101.886208539@infradead.org>
Message-ID: <alpine.LSU.2.21.2004291843270.3662@pobox.suse.cz>
References: <20200428191101.886208539@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Peter Zijlstra wrote:

> Hi,
> 
> Based on Alexandre's patches, here's a few that go on top of tip/objtool/core.
> 
> With these patches on objtool can completely understand retpolines and RSB
> stuffing, which means it can emit valid ORC unwind information for them, which
> in turn means we can now unwind through a retpoline.
> 
> New since last time:
> 
>  - 1-3, alternatives vs ORC unwind
>  - 7-9: implement some suggestions from Julien
>  - addressed feedback

You can add my

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

to patches 1A, 1B and 2-10 (objtool patches and updated smap fix). The 
other four patches should be fine too, but I am not well versed in the 
speculation stuff.

Miroslav
