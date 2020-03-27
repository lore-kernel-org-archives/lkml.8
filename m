Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A23C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2E2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgC0Udx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:33:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbgC0Udu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:33:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E88D6ADE3;
        Fri, 27 Mar 2020 20:33:48 +0000 (UTC)
Date:   Fri, 27 Mar 2020 13:33:44 -0700
From:   Tony Jones <tonyj@suse.de>
To:     Arnaldo Melo <arnaldo.melo@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Message-ID: <20200327203344.GC2715@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de>
 <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
 <20200327200934.GB2715@suse.de>
 <C8021C4E-2764-47CE-AF79-10823C7FDBB2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8021C4E-2764-47CE-AF79-10823C7FDBB2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 05:17:59PM -0300, Arnaldo Melo wrote:

> English as a second language, many contributors, please consider sending fixes, would be really appreciated,

Understood and I was planning on doing so.

Tony
