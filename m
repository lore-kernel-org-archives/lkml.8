Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F0C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151324649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCIWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:31:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32870 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:31:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBQw5-008SiW-0w; Mon, 09 Mar 2020 22:31:45 +0000
Date:   Mon, 9 Mar 2020 22:31:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] xattr: NULL initialize name in simple_xattr_alloc
Message-ID: <20200309223145.GI23230@ZenIV.linux.org.uk>
References: <20200309183719.3451-1-dxu@dxuuu.xyz>
 <19abedb11fae1b96aa052090e7a0d5bbea416824.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19abedb11fae1b96aa052090e7a0d5bbea416824.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:30:07PM -0700, Joe Perches wrote:
> On Mon, 2020-03-09 at 11:37 -0700, Daniel Xu wrote:
> > It's preferable to initialize structs to a deterministic state.
> 
> Thanks Daniel.

Not much point, TBH - there are only two callers, both assigning
that field very shortly.  If you want to do it, do it right -
make that
	simple_xattr_alloc(name, value, len)
with kfree(name) done on failure.  And make the callers allocate
the name first.  Simpler cleanup rules on failure exits that
way...
