Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B226C20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="MHNvtizM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbgFWPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:37:05 -0400
Received: from mail.cock.li ([37.120.193.124]:45232 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733034AbgFWPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:36:54 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1592926611; bh=t9vXHu8nfW1kHDpTQh72tu2e6dfRNNJLUjum428JyaA=;
        h=Date:From:To:Subject:From;
        b=MHNvtizMxxCMf3hUVTmasdwrD1hX0BxmYnuAoR0bRv+kHPA3xbt4MmuScVtb5nn29
         U9TI9MlzXW4hyRgvpsTEXtbIzB9lmU4e1Ep1UqDic8htZ9NvFnUW+CeZJg7p547uPz
         1+U39a7hJ99Zsp1bb3ujuISzwj+DI6lOeiU/x08pqBOunrE/Ky5QTLmrPnK7zX7lQA
         CgOxgJmwrhKslWdUMD73yhvSUJB6gJB0F/SvM/JE/CvJwYzMU5TwnvvDK8xoI5VFsD
         1t1ElpBoJAmKXPADer6c1559YUR0h/dFMqEK6Z3bns/xp39oyeQ+6oLADzfDMb5M/8
         A7iNtvNJeMBGw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Jun 2020 15:36:51 +0000
From:   nipponmail@firemail.cc
To:     linux-kernel@vger.kernel.org, torvalds@osdl.org, esr@thyrsus.com
Subject: I'm being accused of "killing foss", how do I respond?
Message-ID: <986afee43e6dcf11a812a595f1d55c77@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RMS, a commentator is now accusing me of being the executioner of 
"foss" :

> oh it's you, the schizo who killed foss by trying to defend it and 
> thinks he's a lawyer

Later the commentator clarifies :

> You went on a mailing list for some foss project with the intention of 
> exposing a patent violation by some
> other project using the code, but instead of talking about that, you 
> just ranted for a few days about how much
> you want to fuck little girls.
> Then RMS got labeled a pedophile and eaten up by cancel culture.
> I'm flabbergasted you're honestly too stupid to see the connection.


The issue is copyright, not patent, and there was nothing wrong with 
your past statements.

I would think that the fact that the GPL is effectively toothless is 
what would "kill free and opensource software" by causing would-be 
contributors to now lack faith in the "share and share alike" promise of 
the GPL. The FSF won't enforce it's GCC copyrights, nor will the linux 
kernel contributors (both regarding GRSecurity linux kernel patches and 
GCC plugins (and their no-redistribution attached clauses))

I also wonder about this
> for a few days
invective.
Are days suddenly a euphemism such as is imagined regarding various 
creation stories?

How should I respond and set the record straight? And when did "FOSS" 
die? I remember when that term was coined, early 2000s, has it now 
fallen out of favor? Why is it my fault? I never really liked that term 
to begin with: it's a corporate conflation of two specific idea sets: A 
gloss. If said term is gone what is the injury?


