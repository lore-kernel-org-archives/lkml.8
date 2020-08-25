Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D0FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F65420706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598354161;
	bh=2hpbqJGuHjiQno3XjASV22A5GOhSd7ILZrgV7g5Hy1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lMoSxXl1esYTFybf5d2lzKBdxi59+IfeHisfOFRTkGuWZuNYIFaHPVBMq1aCR4kU8
	 IgI2JQR600HlboYQCmqASJO0mde/BoVJdo15tvtAdtRCAv+TU7SWHkNOyPdLUKr3mR
	 ViPGot+CD1Tbl+8RPjcJnWGN4eymBFo0Jt6upn0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgHYLPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHYLPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:15:43 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8402067C;
        Tue, 25 Aug 2020 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354138;
        bh=2hpbqJGuHjiQno3XjASV22A5GOhSd7ILZrgV7g5Hy1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSacWtneFSqukptHfSoMOOie4Xt42Uba/lDththUxKnzQR0hW89Qa9I7BKcPIGUwG
         fCvcWaPEON1nQ8RMp2Nb3esasrrbtU5FP+T8neVtFpBJYfrCkEx5L4jo3cLHxx6OTi
         A8I0Na9FDnOG8LIUiLRPUBnVaSa4uO/UuWUFIHYI=
Date:   Tue, 25 Aug 2020 16:45:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     paul@crapouillou.net, dan.j.williams@intel.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] drivers/dma/dma-jz4780: Fix race condition between
 probe and irq handler
Message-ID: <20200825111533.GL2639@vkoul-mobl>
References: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 09:14, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> In probe, IRQ is requested before zchan->id is initialized which can be
> read in the irq handler. Hence, shift request irq after other initializations
> complete.

Applied, thanks

-- 
~Vinod
