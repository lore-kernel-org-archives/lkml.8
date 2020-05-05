Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688EC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FB720746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588706287;
	bh=B1klzDQVK7YKyYcQEg165w2ZvInxV5HQ5ljlSWKecVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vzsW23aZ0pfYxchaFCxTAkiwbP4QK1GGoTj9i5Pgqmn/6oSjQrH71yFFAkzHG+loW
	 aPWYfSUdCtf4L4apGXGIKEmFOKeKRnXPxHGY0ak66yZbfeUe6wtlUsUFYrZLYa39RD
	 Dmxg+Z1gE+1TKsS+EsP1LTgOeCT8MIry/q/rF36s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEETSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEETSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:18:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27C6206B9;
        Tue,  5 May 2020 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588706285;
        bh=B1klzDQVK7YKyYcQEg165w2ZvInxV5HQ5ljlSWKecVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O2A12MGWgReI6iEWxxcspGQtX8FpUPNjN7J8Pk0Ieua87xfoREq3FfJ8qAjU9Y7SO
         47dT4uSZ0ruchymZPRXe0I5NIRFtTstGelbOyOpFwB3gtvrYGh2wSNLUoNeSTDkwh7
         JGi55cTemT/vKgMGvTCu254ZRU19qED6/Wmnx8Bg=
Date:   Tue, 5 May 2020 12:18:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org
Subject: Re: [PATCH v2] checkpatch: use patch subject when reading from
 stdin
Message-Id: <20200505121805.cb29ea992ec3e3b445f4b707@linux-foundation.org>
In-Reply-To: <20200505132613.17452-1-geert+renesas@glider.be>
References: <20200505132613.17452-1-geert+renesas@glider.be>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 May 2020 15:26:13 +0200 Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> While "git am" can apply an mbox file containing multiple patches (e.g.
> as created by b4[1], or a patch bundle downloaded from patchwork),
> checkpatch does not have proper support for that.  When operating on an
> mbox, checkpatch will merge all detected tags, and complain falsely
> about duplicates:
> 
>     WARNING: Duplicate signature
> 
> As modifying checkpatch to reset state in between each patch is a lot of
> work, a simple solution is splitting the mbox into individual patches,
> and invoking checkpatch for each of them.  Fortunately checkpatch can read
> a patch from stdin, so the classic "formail" tool can be used to split
> the mbox, and pipe all individual patches to checkpatch:
> 
>     formail -s scripts/checkpatch.pl < my-mbox
> 
> However, when reading a patch file from standard input, checkpatch calls
> it "Your patch", and reports its state as:
> 
>     Your patch has style problems, please review.
> 
> or:
> 
>     Your patch has no obvious style problems and is ready for submission.

Showing the proposed "after patch" output would be helpful.  It seems
that it will be

	"checkpatch: use patch subject when reading from stdin" has no obvious style problems and is ready for submission.

yes?

> Hence it can be difficult to identify which patches need to be reviewed
> and improved.
> 
> Fix this by replacing "Your patch" by (the first line of) the email
> subject, if present.
> 
> Note that "git mailsplit" can also be used to split an mbox, but it will
> create individual files for each patch, thus requiring cleanup
> afterwards.  Formail does not have this disadvantage.
> 

