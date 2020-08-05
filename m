Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 10:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B533F207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596622314;
	bh=Sm0yiw6SpzhdoBfFn2Rjd30/YsktE75liIAYWXM5W6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aDKaF56myDhPXsEayzg/RwASNdS+Q+0w+QBNAdxnxs1ZIouHy1D0sIJuNW3tViFI5
	 bZTZB4lht45sTFVAX9gku0iX2v+GeXgP1rU5aUA1ToBD86PCJ+7WL8X4a8ebta9kLM
	 PF7Mog1fpIHNAjcw1HXcnEdlxC95ywHwVafHdjuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHEKLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 06:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHEKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 06:11:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7E9207FC;
        Wed,  5 Aug 2020 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596622304;
        bh=Sm0yiw6SpzhdoBfFn2Rjd30/YsktE75liIAYWXM5W6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgtpXUO33hDp1HWpRJUkpJDQN4f/IHSuvFvbhXGWbITUUuLWmrbRk1WmBQgxQKekC
         ZLzL+g5gmf/4RWtqvPLWC+crJOaa/lX6ARsWSaeOfWHvvCB83UcLrEiYb7rlQMxqF6
         9TQnw8l3UM9iqAaXrpgl9Ag5z9DNGopNNqWnXaA4=
Date:   Wed, 5 Aug 2020 12:12:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Patrick Riphagen <ppriphagen@gmail.com>
Cc:     stable@vger.kernel.org, patrick.riphagen@xsens.com,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add IDs for Xsens Mti USB
 converter
Message-ID: <20200805101201.GA1647936@kroah.com>
References: <20200805100558.18593-1-patrick.riphagen@xsens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805100558.18593-1-patrick.riphagen@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 12:05:57PM +0200, Patrick Riphagen wrote:
> The device added has an FTDI chip inside.
> The device is used to connect Xsens USB Motion Trackers.
> 
> Signed-off-by: Patrick Riphagen <patrick.riphagen@xsens.com>
> ---
>  drivers/usb/serial/ftdi_sio.c     | 1 +
>  drivers/usb/serial/ftdi_sio_ids.h | 1 +
>  2 files changed, 2 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
