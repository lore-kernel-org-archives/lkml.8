Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF032C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A06422464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgATP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:57:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:53440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgATP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:57:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B7AFAC22;
        Mon, 20 Jan 2020 15:57:19 +0000 (UTC)
Date:   Mon, 20 Jan 2020 16:57:18 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: avoid setting info->name early in case we can
 fall back to info->mod->name
In-Reply-To: <20200117145306.15509-1-jeyu@kernel.org>
Message-ID: <alpine.LSU.2.21.2001201656100.2671@pobox.suse.cz>
References: <20200117145306.15509-1-jeyu@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Jessica Yu wrote:

> In setup_load_info(), info->name (which contains the name of the module,
> mostly used for early logging purposes before the module gets set up)
> gets unconditionally assigned if .modinfo is missing despite the fact
> that there is an if (!info->name) check near the end of the function.
> Avoid assigning a placeholder string to info->name if .modinfo doesn't
> exist, so that we can fall back to info->mod->name later on.
> 
> Fixes: 5fdc7db6448a ("module: setup load info before module_sig_check()")
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
