Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF019C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997CD206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFJUY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:24:57 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:42002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726982AbgFJUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:24:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 647F918028E68;
        Wed, 10 Jun 2020 20:24:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wing27_440e66526dce
X-Filterd-Recvd-Size: 1668
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 20:24:55 +0000 (UTC)
Message-ID: <2024b2594378686f24279488f0d80ad8f13a9181.camel@perches.com>
Subject: Re: WIP generic module->debug_flags and dynamic_debug
From:   Joe Perches <joe@perches.com>
To:     jim.cromie@gmail.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Wed, 10 Jun 2020 13:24:54 -0700
In-Reply-To: <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
         <20200609104604.1594-7-stanimir.varbanov@linaro.org>
         <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 12:32 -0600, jim.cromie@gmail.com wrote:
> so Ive got a WIP / broken / partial approach to giving all modules a
> u32 flagset,
> and enabling pr_debug based upon it.  I leave out the "pr_debug_typed(
> bitpos )" for now.  For Stanimir, bits 1,2,3 could be high, middle,
> low.

Can you change this please to be a pointer to an unsigned long/int?

That way, existing non-dynamic debug uses like

MODULE_PARM_DESC(debug, "module specific debug control");

maybe could use the same mechanism to enable/disable by class.


