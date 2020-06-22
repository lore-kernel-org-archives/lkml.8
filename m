Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A5BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F41025405
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592803991;
	bh=LlY20qnm761fwobPyLQcFs7yCjutoOfn/Lec+Ma6ywc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OdKKPzdCDdnmeAtKemkFnZPmXvywnVlfz6M7KCCRNmnVQ9OT0IvhnkMMWMAEdijjD
	 lqZ0JwfnYDQnAR+34i9BARiHr8h8tu99Or/Q+8kGQGr/U4n4ThA/0daX05psQsvZCB
	 /12EcV/FgCPR2KNpMREgCpyRtcRyj7pvp/phxIXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgFVFdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 01:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgFVFdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:33:09 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C14F25403;
        Mon, 22 Jun 2020 05:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592803989;
        bh=LlY20qnm761fwobPyLQcFs7yCjutoOfn/Lec+Ma6ywc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkOk2StEX2MqAuyXo6cvvRGNmU5lOPgoP82DRRuUq6wSIvWp1z8LtKcyIX+LapHd1
         2uwlOsmtOfegoQgFFwBoggbbnRzNWcg9O5d+KAFASEzNJEh9HrQqFd7X8fTtxEUqAv
         REqcSnDWPidAtAT1DF1Afzfa8bzyleR2zhLiBoyU=
Date:   Mon, 22 Jun 2020 11:03:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: compress: document the compress audio state
 machine
Message-ID: <20200622053304.GD2324254@vkoul-mobl>
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-2-vkoul@kernel.org>
 <8e322574-14bc-aaaa-5fdb-751cb8b97fff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e322574-14bc-aaaa-5fdb-751cb8b97fff@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Pierre,

On 19-06-20, 09:22, Pierre-Louis Bossart wrote:
> 
> > +
> > +                                        +----------+
> > +                                        |          |
> > +                                        |   OPEN   |
> > +                                        |          |
> > +                                        +----------+
> > +                                             |
> > +                                             |
> > +                                             | compr_set_params()
> > +                                             |
> > +                                             V
> > +                                        +----------+
> > +                compr_drain_notify()    |          |
> > +              +------------------------>|   SETUP  |
> > +              |                         |          |
> > +              |                         +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_write()
> > +              |                              |
> > +              |                              V
> > +              |                         +----------+
> > +              |                         |          |
> > +              |                         |  PREPARE |
> > +              |                         |          |
> > +              |                         +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_start()
> > +              |                              |
> > +              |                              V
> > +        +----------+                    +----------+     compr_pause()      +----------+
> > +        |          |                    |          |----------------------->|          |
> > +        |  DRAIN   |<-------------------|  RUNNING |                        |  PAUSE   |
> > +        |          |                    |          |<-----------------------|          |
> > +        +----------+                    +----------+     compr_resume()     +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_free()
> > +              |                              |
> > +              |                              V
> > +              |                         +----------+
> > +              |     compr_free()        |          |
> > +              +------------------------>|          |
> > +                                        |   STOP   |
> > +                                        |          |
> > +                                        +----------+
> 
> 
> The STOP state doesn't seem quite right to me, sorry.

We should call it free, Will update

> the direction of the DRAIN-STOP comp_free() arrow seems wrong? Of if it is
> correct, then something's missing to exit the STOP state so that the stream
> can be opened again.

Once stream is freed, it can't be opened again.

But we have trigger stop which is not comprehended here, I will add
compr_stop() above which would transition to SETUP state. And a stopped
stream can be freed up as well, so one more transition from SETUP to
FREE.

Thanks for reviewing
-- 
~Vinod
