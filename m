Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499CAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243A62073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590434477;
	bh=dOetpQWCFCq4GaGnPj9d7Xjvd6fSObj/WCvcJX9OwdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mILMRHJzH+N56QCggEJEq07WuSVz0TxWxG3hdgvUvH9n34i6kEfSgfk9PxAqmmKWa
	 KBLr+eJwlF5u1151pS2lzp3eSCKN+GTx+Xo+br8KfiJGuUGujSRPd8/bv+sbF4Ahxi
	 e/JDetjeIMsMYbg6Wc2jN9Iobe+wL9lMrOSBMpp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbgEYTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389460AbgEYTVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:21:15 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227472070A;
        Mon, 25 May 2020 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590434475;
        bh=dOetpQWCFCq4GaGnPj9d7Xjvd6fSObj/WCvcJX9OwdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TK7NAFbFyM5EDaOkX8cTCfDbbRG+Y5iBXKvEfZGm+DTQYM0pdGKFREkAY57zOaPXP
         EO8/UM/M1vNW31VsLqVeTGV4cWYXq/7dE1DQBcAHQ47CMYJDDnC5hVAIDAHkXHinbB
         V9yZt7akxzGPgULyuuTxRnWjlVgYy+pmL856dgqA=
Date:   Mon, 25 May 2020 14:26:09 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] m68k: tools: Replace zero-length array with
 flexible-array member
Message-ID: <20200525192609.GC9247@embeddedor>
References: <20200521185707.GA3661@embeddedor>
 <CAMuHMdUGPMrPTqypGpnhe2wdpnbtUOsdUacnrHAapBM_996F5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGPMrPTqypGpnhe2wdpnbtUOsdUacnrHAapBM_996F5A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:49:02AM +0200, Geert Uytterhoeven wrote:
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v5.8 branch.
> 

Thanks, Geert.

--
Gustavo
