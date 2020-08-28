Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199FFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E3B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600228;
	bh=TPzU+ne6lWyUaBunEnndm3XP49gskrG9vdKDqsGEFEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5gAJjEUzUSfyVsoUXLkkOFRdy6z186nwdi7BHGnK7mYC0dGdTYq8GM/SD2kVH2MM
	 jqt6qHUleludTXJjR2CqKn1wl3wNIBrmg9AixvyRejxRvw65nA9snnjWwURsNr8AiP
	 yFWxWsbqKUu4fbinInDgKP3fvoT20x7OFLAgzCNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgH1HhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgH1Hg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:36:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A3BE20776;
        Fri, 28 Aug 2020 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600217;
        bh=TPzU+ne6lWyUaBunEnndm3XP49gskrG9vdKDqsGEFEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksbEVTGrfCApRpy8fEr6o4fImtuJP5woYut7dX5Pe3r07H4ZxlQqXoPIH14fl9K+m
         YJ6M5N7eU70NhI5MZZOp8oaLyANVd3zizpQbpGbzcZzvtValwVVkexQEGBH9w/TxsP
         fm+I0gnwxe6bvA338yfqVjFzU5KjduAHfJXGvlXA=
Date:   Fri, 28 Aug 2020 09:37:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14 v5] usb: typec: tcpci: Add set_vbus tcpci callback
Message-ID: <20200828073709.GA942935@kroah.com>
References: <20200825042210.300632-1-badhri@google.com>
 <20200825042210.300632-6-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825042210.300632-6-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:22:01PM -0700, Badhri Jagan Sridharan wrote:
> set_vbus callback allows TCPC which are TCPCI based, however,
> does not support turning on sink and source mode through
> Command.SinkVbus and Command.SourceVbusDefaultVoltage.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 7 +++++++
>  drivers/usb/typec/tcpm/tcpci.h | 1 +
>  2 files changed, 8 insertions(+)

Why is this patch "v5" and the others "v1" in this series?

That's totally confusing, please just version the whole series, not
individual patches, as you are not providing version information about
what changed in this patch, right?

Make it easy for reviewers please...

thanks,

greg k-h
