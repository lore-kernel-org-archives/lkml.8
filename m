Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3078620674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594401361;
	bh=8BlM6oYrDWVXFwdkiKVw0CvLzU+HCpGIc+rJuBWYCxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5cYzLbrYclD/+uZeO4c8R9vN4/QvdPxoNL+mKusX8gw3G0xvGV26d/WACmGfT49X
	 fO4PgW/W1XbTq35OCAd6p0KbYoyd7ScSNquS8BeTRNEQWrAFcC/e0nV63i+lRBdTBt
	 i0q65XUybJ/HfyVb3d9lAeyMwc67CTfQE3KtM0g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGJRP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgGJRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:15:57 -0400
Received: from embeddedor (unknown [200.39.25.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C9D20674;
        Fri, 10 Jul 2020 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594401357;
        bh=8BlM6oYrDWVXFwdkiKVw0CvLzU+HCpGIc+rJuBWYCxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBC59ssUIz4aHv6uokkVYB3PO6+eBcxcrP0+g0UwBhDwXCqNru5WyOjP0Q62C4Oxl
         lSyzkqnvHikOT7xhtOhttveiJ0tzj3HkNXMWNhLMDB+Dmq313C7yuDpD4Tw8hKONYw
         BWZrxO4wBDXLzZLpeHlDOWFNS7HifqqNwwk19fWg=
Date:   Fri, 10 Jul 2020 12:21:31 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use fallthrough pseudo-keyword
Message-ID: <20200710172131.GA21202@embeddedor>
References: <20200708202650.GA3866@embeddedor>
 <DAA2B121-5D77-4611-86BB-BFBE9200DB7C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAA2B121-5D77-4611-86BB-BFBE9200DB7C@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:10:55PM +0200, Marcel Holtmann wrote:
> Hi Gustavo,
> 
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > drivers/bluetooth/bcm203x.c     | 2 +-
> > drivers/bluetooth/bluecard_cs.c | 2 --
> > drivers/bluetooth/hci_ll.c      | 2 +-
> > drivers/bluetooth/hci_qca.c     | 8 +-------
> > 4 files changed, 3 insertions(+), 11 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 

Thanks, Marcel.

--
Gustavo
