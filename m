Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C689C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83C820748
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966051;
	bh=ss+qpo3s8H/goxNown6WFKCEXAfAK/KOd3YGrJXIk1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bhE1Q51i1a4aFKi+vLPCJ2ujJdI7lI/pS/vEkfM1/jwxRyKTDul5uCmo7vLoKhGj+
	 ZyKqF20613L17agpPJDtxwj9NdevBiZI2yziETAhFeaEU35cxHZ0iudgitE98tUIkF
	 /pHcS5F8Np1pi9/lXInJFVAD7+bU7tqwvMfGIdn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHTX12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTX11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:27:27 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183F620748;
        Thu, 20 Aug 2020 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966046;
        bh=ss+qpo3s8H/goxNown6WFKCEXAfAK/KOd3YGrJXIk1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILPKEenDNolJ3VS1E+Asq+j+onbm+edbHtt07iPn9ViEgua0toDi1/Shbp6cbaved
         YFBQl7UhZY+nAjJwfy4smXlrc5QTK9BYsgU6E32gE7qS6LA0Y89MeSb0VjS2ijlSrY
         28zBMoRJh/KI3k7AGy421zKB8F01WivBIW6oJNN4=
Date:   Thu, 20 Aug 2020 18:33:13 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, clang-built-linux@googlegroups.com,
        natechancellor@gmail.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: fallthrough pseudo-keyword macro conversions for 5.9-rc2
Message-ID: <20200820233313.GA5113@embeddedor>
References: <20200820220210.GA14894@embeddedor>
 <20200820221511.3328330-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820221511.3328330-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Aug 20, 2020 at 03:15:11PM -0700, Nick Desaulniers wrote:
> Just noticed this on lore.  I'm curious if you'd had a chance to test your PR
> with e2079e93f562c reverted?

Yep; it builds just fine with Clang 11.0.0 :)

Thanks
--
Gustavo
