Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338EAC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC6E24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579034859;
	bh=JwqMeuzEMs2K8NjRxrDLFfh8WurFpYlXSxqtUPvHMUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEphgi2CEubdbq/Pga5IuozRrzA7n/D6uQ4avgfCUfhdiK5CFfvjUjf7nFI6t6ZpF
	 uzzxZLiobsAzhd6z4ch8n8G4SYVT6aWDk+kMcMfIbcII9aDgzbFR1vmtumNvW59X5y
	 8J06Z8OW93niqZLPI0/b9UcZnb/l0xC6P995fShU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgANUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANUrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:47:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2E024656;
        Tue, 14 Jan 2020 20:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579034857;
        bh=JwqMeuzEMs2K8NjRxrDLFfh8WurFpYlXSxqtUPvHMUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NloaP3Dt8FDbDxVFLVe0PEYEiqjpJ7iqNP6bAi2W2DM6umbtwSLpG/D/9xVRkIO5H
         b8pIexYKxWy/mc9RzYpGpCY1CvjbDSZ9dY+am4CeWW29PC8TZDcMtDxhmDmx6rUXp7
         CfW/M6nf5bXTc5UOm0rHY6TGB0k2SCa4PxaY+egc=
Date:   Tue, 14 Jan 2020 21:47:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thorsten Scherer <thorsten.scherer@eckelmann.de>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] siox: Use the correct style for SPDX License
 Identifier
Message-ID: <20200114204734.GA2221856@kroah.com>
References: <20200101131418.GA3110@nishad>
 <20200107063250.GA30387@ws067.eckelmann.group>
 <20200107073204.k4t25kchrpczekfc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107073204.k4t25kchrpczekfc@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 08:32:04AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Jan 07, 2020 at 07:32:50AM +0100, Thorsten Scherer wrote:
> > On Wed, Jan 01, 2020 at 06:44:23PM +0530, Nishad Kamdar wrote:
> > > This patch corrects the SPDX License Identifier style in
> > > header file related to Eckelmann SIOX driver.
> > > For C header files Documentation/process/license-rules.rst
> > > mandates C-like comments (opposed to C source files where
> > > C++ style should be used).
> > > 
> > > Changes made by using a script provided by Joe Perches here:
> > > https://lkml.org/lkml/2019/2/7/46.
> > > 
> > > Suggested-by: Joe Perches <joe@perches.com>
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > Acked-by: Thorsten Scherer <thorsten.scherer@eckelmann.de>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Ah, this is why I had 2 acks, you acked it twice :)

