Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D455FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58F2072F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585380038;
	bh=83z2KvWH31+Evr36F8PQM6p6cBOnviWjG9oMk4xuN3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mk5Ofm4NkEFOYc8/mtrLlrYj2TEFfY7HgEzy7mgIIJicuJvo3voO58LBdOtn9KXTu
	 y2JStdCnDS5p5/yhheYkKWs5eoxy+p776Bncn7LvDAABNDx1H+uIn3mHX+m5kAWEPw
	 2uUkPmEhvvRA8iG+tsPFLIfpY+N6PcpAgpUaMxz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgC1HUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgC1HUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:20:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF8520716;
        Sat, 28 Mar 2020 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585380034;
        bh=83z2KvWH31+Evr36F8PQM6p6cBOnviWjG9oMk4xuN3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xC47s4ND2qKmfYws+k2HXqzYICSHf3VVf5zNuQ5SKbC7nPIgln3Gc8cVZOK92Y36M
         pAC+F1o4enSsrpgjwILGs9fjAAoxF815GziC9SUFL85X6rO8/66lTqKct/4J5X6K85
         IdHHpcQ3k1eBNWm2R2FPNeeaGHe5RAGEhWAfbWQ4=
Date:   Sat, 28 Mar 2020 08:20:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, rajatxjain@gmail.com
Subject: Re: [PATCH] Input: input-event-codes.h: Update the deprecated license
Message-ID: <20200328072031.GA3651219@kroah.com>
References: <20200328004832.107247-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328004832.107247-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 05:48:32PM -0700, Rajat Jain wrote:
> >From https://spdx.org/licenses/
> 
> "Release 3.0 replaced previous Identifiers for GNU licenses with more
> explicit Identifiers to reflect the "this version only" or "any later
> version" option specific to those licenses. As such, the previously used
> Identifiers for those licenses are deprecated as of v3.0."
> 
> Replace the
> /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> with
> /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

If you like reading documentation for stuff like this, how about reading
LICENSES/preferred/GPL-2.0 which shows that both examples are just fine
and we are going to stick with that for now as we don't want to do a
wholesale change at this point in time.

In other words, we do not follow the 3.0 version of the SPDX spec as we
think it's pretty silly :)

thanks,

greg k-h
