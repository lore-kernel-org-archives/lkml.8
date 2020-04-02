Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C08C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A75208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585813215;
	bh=h6Tip+cEf7ukuAyyG2JQMpBDVLJi93fc8bs/kqgJm50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dWM2MZX4XDQCy5RDqaSqyoo/Fbdnbeh3K4YdFT/P/o9HxBh8tx6fw+nicYgOICkbd
	 GZReYgg/eEtcjkfCOicUBDb4Wv5GOtPJjVYTYa5/yAxwNn07XnhjiTq1LueAVdEl/C
	 EyEGzlHAInmAGlYuFCD3eYE/ArPnzgdolAoWbUgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgDBHkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgDBHkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:40:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F32120678;
        Thu,  2 Apr 2020 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585813214;
        bh=h6Tip+cEf7ukuAyyG2JQMpBDVLJi93fc8bs/kqgJm50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwdVnWSzPxCFOLmhvjhSSbwAzB45Jl37eGZM2reH178+0ncx/OtgjgChr4X+gEx+N
         TDrQw61S0VYYLuotclD1h2w8WF0K0+ulTtVtTW29AFRlFANOTpgqkhbgQtLdYZei11
         x1f/PyE0jsEOs1naIzdClhDcLHLA/6yOuC5BUEw0=
Date:   Thu, 2 Apr 2020 09:40:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: bugs: Fix spelling mistake
Message-ID: <20200402074011.GB2755501@kroah.com>
References: <20200401182855.GA16253@embeddedor>
 <202004020008.C3403E1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004020008.C3403E1@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:08:56AM -0700, Kees Cook wrote:
> On Wed, Apr 01, 2020 at 01:28:55PM -0500, Gustavo A. R. Silva wrote:
> > Fix spelling mistake s/Intentially/Intentionally
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Thanks! Greg, can you snag this when you get a chance?
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Will do, after -rc1 is out.

thanks,

greg k-h
