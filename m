Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D4C20884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593803613;
	bh=vwpJzue9kpCGDxUY60lJ7utCDQyCAkn8CmpSoe2vSrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fvni/jHnI16cJoW7f6etMqLwHDn1jyUbvDWpdGGDpzlsKz6ikw7P2mPn3xLEpZUPH
	 Kt4UU7+8sRSVqwyMe/2y+Jw9wO3JrYcJuXf0l/W2kYTkOXjowaOqPcG5OdqW4+hX+t
	 KS/NT1cfhp8ok4y4LcUaaMFmFtFTa1arNgM+UiOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGCTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCTNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:13:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B97207FF;
        Fri,  3 Jul 2020 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593803611;
        bh=vwpJzue9kpCGDxUY60lJ7utCDQyCAkn8CmpSoe2vSrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TPGf7FlaltuqIBbWdGffK9g9tLenQCEC4Ns/aRtRsB8hvT/iUZ5COjswh7d6GCfAN
         UXAcsO1J/t3y9kzDJSvkgEgSO0/JPa0oLi8jgr/Y9A8x7idTC4psgpZAywtdYwSMCk
         6uLZaGTy4HvwZFV2rqzpHmFDDh+1WoVH0EEgyrY4=
Date:   Fri, 3 Jul 2020 12:13:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <qiang.zhang@windriver.com>
Cc:     <ben.dooks@codethink.co.uk>, <bfields@redhat.com>,
        <cl@rock-chips.com>, <peterz@infradead.org>, <pmladek@suse.com>,
        <tj@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kthread: work could not be queued when worker being
 destroyed
Message-Id: <20200703121330.5061e3c25a10118660a2586d@linux-foundation.org>
In-Reply-To: <20200702070156.5862-1-qiang.zhang@windriver.com>
References: <20200702070156.5862-1-qiang.zhang@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 15:01:56 +0800 <qiang.zhang@windriver.com> wrote:

> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> The "queuing_blocked" func should print warning message and
> returns true when the worker being destroyed.

Why should it do this?

Please prepare a changelog which contains much more information.

