Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D5BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466012073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgC2QpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:45:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37355 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727903AbgC2QpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:45:03 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02TGit5e008654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Mar 2020 12:44:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0AD33420EBA; Sun, 29 Mar 2020 12:44:55 -0400 (EDT)
Date:   Sun, 29 Mar 2020 12:44:54 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Josh Triplett <josh@joshtriplett.org>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error
 message
Message-ID: <20200329164454.GN53396@mit.edu>
References: <20200329024709.GK53396@mit.edu>
 <471D6886-24DF-4AC2-A5F2-DBE7C2B97AE8@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471D6886-24DF-4AC2-A5F2-DBE7C2B97AE8@dilger.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 10:36:07PM -0600, Andreas Dilger wrote:
> You missed the v2 patch, which was better IMHO.

I saw the V2 patch, but the it will print the 32-bit truncated block
count, and it's possible if things are really insane, the number of
block groups calculated will be > 2**32.  In which case the V1 patch
with the format string adjusted will print a less confusing message.
e.g.:

groups count too large: 8589934634 ....

as opposed to: 

groups count too large: 42 ....

					- Ted
