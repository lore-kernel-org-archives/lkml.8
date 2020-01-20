Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9EAC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CFB21835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgATRcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:32:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38229 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgATRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:32:46 -0500
Received: from callcc.thunk.org ([38.98.37.142])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00KHWHXu003876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 12:32:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 51823420057; Mon, 20 Jan 2020 12:32:15 -0500 (EST)
Date:   Mon, 20 Jan 2020 12:32:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120173215.GF15860@mit.edu>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgkan57p.fsf@mail.parknet.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 01:04:42PM +0900, OGAWA Hirofumi wrote:
> 
> To be perfect, the table would have to emulate what Windows use. It can
> be unicode standard, or something other. And other fs can use different
> what Windows use.

The big question is *which* version of Windows.  vfat has been in use
for over two decades, and vfat predates Window starting to use Unicode
in 2001.  Before that, vfat would have been using whatever code page
its local Windows installation was set to sue; and I'm not sure if
there was space in the FAT headers to indicate the codepage in use.

It would be entertaining for someone with ancient versions of Windows
9x to create some floppy images using codepage 437 and 450, and then
see what a modern Windows system does with those VFAT images --- would
it break horibbly when it tries to interpret them as UTF-16?  Or would
it figure it out?  And if so, how?  Inquiring minds want to know....

Bonus points if the lack of forwards compatibility causes older
versions of Windows to Blue Screen.  :-)

      	     	   	  		   	- Ted

P.S.  And of course, then there's the question of how does older
versions of Windows handle versions of Unicode which postdate the
release date of that particular version of Windows?  After all,
Unicode adds new code points with potential revisions to the case
folding table every 6-12 months.  (The most recent version of Unicode
was released in in April 2019 to accomodate the new Japanese kanji
character "Rei" for the current era name with the elevation of the new
current reigning emperor of Japan.)
