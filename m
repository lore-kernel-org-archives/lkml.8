Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE69C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C42B21973
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgEBXQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:16:32 -0400
Received: from gentwo.org ([3.19.106.255]:33436 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgEBXQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:16:32 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id E5D683EBBD; Sat,  2 May 2020 23:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id E4E523EBB9;
        Sat,  2 May 2020 23:16:30 +0000 (UTC)
Date:   Sat, 2 May 2020 23:16:30 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Rafael Aquini <aquini@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
In-Reply-To: <20200501211540.71216-1-aquini@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2005022313490.1519@www.lameter.com>
References: <20200501211540.71216-1-aquini@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020, Rafael Aquini wrote:

> Sometimes it is desirable to override SLUB's debug facilities
> default behavior upon stumbling on a cache or object error
> and just stop the execution in order to grab a coredump, at
> the error-spotting time, instead of trying to fix the issue
> and report in an attempt to keep the system rolling.

The stopping of execution on an error is the default behavior. Usually
you get some OOPS somewhere when data is corrupted and that causes a core
dump.

SLUB can fix the issue and continue if enabled by specifying special
options on boot. That is *not* the default.

