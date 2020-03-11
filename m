Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B913CC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFBC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583914011;
	bh=wrkxLkNSJuSFWkXso1jggtLZ/EMJmTIF6RreW9CZSUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+OlPSZMZg4sxlLr3/9j7lRfQjKaO74um7CNy/X740sqM+SKRKRwvaaPOp9KMQDHk
	 /czlPv/sCSv3JMgGBLVQhmDX6slXxLYXUIleIaVBkUWJxgMVOC7NHVBhFOL+KqdCe4
	 JOpuo44TpsJCoESjkmdXhp08JinEa1sJDeSh0PQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgCKIGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKIGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:06:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9742051A;
        Wed, 11 Mar 2020 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583914007;
        bh=wrkxLkNSJuSFWkXso1jggtLZ/EMJmTIF6RreW9CZSUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guynm0uwX1mGSSNdN3g22RSoCjQdqU9tFZRyO10WAeSyD1hJXe+2a28MTzu0iXswj
         4gJVMDMJ8s1vrwtTGemTvyUiC5jz+SzDSG5/0L/cRszH9kV8vfwUJdJ3D6pLIB3Ndq
         7oU59LQIiXk44ncO/P+rYnTR70f5QYcriceTRdog=
Date:   Wed, 11 Mar 2020 09:06:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drivers/base/cpu: s*nprintf() usage fixes /
 cleanups
Message-ID: <20200311080642.GA3662448@kroah.com>
References: <20200311080207.12046-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311080207.12046-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:02:05AM +0100, Takashi Iwai wrote:
> Hi,
> 
> this is a respin of my previous patch [*].
> Now the scnprintf() conversion is done only in the needed places,
> and the second patch cleans up the superfluous s*nprintf() usages.
> 
> Takashi
> 
> [*] https://lore.kernel.org/r/20200311071200.4024-1-tiwai@suse.de

Thanks for these, much nicer, I'll go queue them up now.

greg k-h
