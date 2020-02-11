Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19554C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD81C20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581439203;
	bh=C9T10J9m3j/fSDpeitNSnf+yQc+1UCLPMTcmLnxvTsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ND62doJZjiewphzi6w4lL0omvpIY5U/vKQUZkHWbfH54oRE3NOC80rIaCdtD+q9VT
	 CUMhm/TP1A9znKzf3+qzxeHAjQ3uPfIzxHGe2iV68dODzeyJis9xUERVSCB5nAHj9S
	 FVTW5XduEe6Upl3NQSSqvmcBWyHTnEoKGsZTBTUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgBKQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBKQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:40:01 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A51D20714;
        Tue, 11 Feb 2020 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581439200;
        bh=C9T10J9m3j/fSDpeitNSnf+yQc+1UCLPMTcmLnxvTsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQDyW1I/zB83Q58sWcZoNS+5WGf0xFZHgNSDajCzvvgpkpn85dORflqZoEUe9xZZm
         gOGZCbPkdwVXNr7N1zWMWeVtyhGZuehfIbPdQ1EHMKasoRssYxXUTbIv/IEp15Hem+
         zN7VoV9UvivD6xKT6dPjkd5wRPyIoEmB5qewsK/k=
Date:   Tue, 11 Feb 2020 08:39:59 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [PATCH 1/1] usb: Add MA USB Host driver
Message-ID: <20200211163959.GB1931506@kroah.com>
References: <VI1PR10MB1965B4B61D7A9808B2EA095591180@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:21:24PM +0000, Vladimir Stankovic wrote:
> MA-USB Host driver provides USB connectivity over an available
> network, allowing host device to access remote USB devices attached
> to one or more MA USB devices (accessible via network).
> 
> This driver has been developed to enable the host to communicate
> with DisplayLink products supporting MA USB protocol (MA USB device,
> in terms of MA USB Specification).
> 
> MA-USB protocol used by MA-USB Host driver has been implemented in
> accordance with MA USB Specification Release 1.0b.
> 
> This driver depends on the functions provided by DisplayLink's
> user-space driver.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> ---
>   drivers/usb/Kconfig                           |    2 +
>   drivers/usb/Makefile                          |    2 +
>   drivers/usb/mausb_host/Kconfig                |   15 +
>   drivers/usb/mausb_host/Makefile               |   30 +
>   .../usb/mausb_host/include/common/ma_usb.h    |  873 +++++++++
>   .../mausb_host/include/common/mausb_address.h |   38 +
>   .../include/common/mausb_driver_status.h      |   21 +
>   .../mausb_host/include/common/mausb_event.h   |  228 +++
>   drivers/usb/mausb_host/include/hcd/hub.h      |  115 ++
>   drivers/usb/mausb_host/include/hcd/vhcd.h     |   79 +
>   .../usb/mausb_host/include/hpal/data_common.h |   66 +
>   drivers/usb/mausb_host/include/hpal/data_in.h |   18 +
>   .../usb/mausb_host/include/hpal/data_out.h    |   22 +
>   drivers/usb/mausb_host/include/hpal/hpal.h    |  184 ++
>   .../usb/mausb_host/include/hpal/isoch_in.h    |   22 +
>   .../usb/mausb_host/include/hpal/isoch_out.h   |   20 +
>   .../mausb_host/include/hpal/mausb_events.h    |   99 +
>   .../include/hpal/network_callbacks.h          |   20 +
>   .../mausb_host/include/link/mausb_ip_link.h   |   87 +
>   .../include/utils/mausb_data_iterator.h       |   52 +
>   .../usb/mausb_host/include/utils/mausb_logs.h |   35 +
>   .../usb/mausb_host/include/utils/mausb_mmap.h |   21 +
>   .../include/utils/mausb_ring_buffer.h         |   67 +
>   .../mausb_host/include/utils/mausb_version.h  |   17 +
>   drivers/usb/mausb_host/src/hcd/hub.c          | 1684 +++++++++++++++++
>   drivers/usb/mausb_host/src/hcd/module_init.c  |  219 +++
>   drivers/usb/mausb_host/src/hcd/vhcd.c         |  291 +++
>   drivers/usb/mausb_host/src/hpal/data_common.c |  141 ++
>   drivers/usb/mausb_host/src/hpal/data_in.c     |   73 +
>   drivers/usb/mausb_host/src/hpal/data_out.c    |  202 ++
>   drivers/usb/mausb_host/src/hpal/hpal.c        | 1306 +++++++++++++
>   drivers/usb/mausb_host/src/hpal/isoch_in.c    |  241 +++
>   drivers/usb/mausb_host/src/hpal/isoch_out.c   |  361 ++++
>   .../usb/mausb_host/src/hpal/mausb_events.c    |  659 +++++++
>   .../mausb_host/src/hpal/network_callbacks.c   |  160 ++
>   .../usb/mausb_host/src/link/mausb_ip_link.c   |  354 ++++
>   .../src/utils/mausb_data_iterator.c           |  295 +++
>   drivers/usb/mausb_host/src/utils/mausb_mmap.c |  381 ++++
>   .../mausb_host/src/utils/mausb_ring_buffer.c  |  168 ++
>   39 files changed, 8668 insertions(+)
>   create mode 100644 drivers/usb/mausb_host/Kconfig
>   create mode 100644 drivers/usb/mausb_host/Makefile
>   create mode 100644 drivers/usb/mausb_host/include/common/ma_usb.h
>   create mode 100644 drivers/usb/mausb_host/include/common/mausb_address.h
>   create mode 100644 
> drivers/usb/mausb_host/include/common/mausb_driver_status.h
>   create mode 100644 drivers/usb/mausb_host/include/common/mausb_event.h
>   create mode 100644 drivers/usb/mausb_host/include/hcd/hub.h
>   create mode 100644 drivers/usb/mausb_host/include/hcd/vhcd.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/data_common.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/data_in.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/data_out.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/hpal.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/isoch_in.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/isoch_out.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/mausb_events.h
>   create mode 100644 drivers/usb/mausb_host/include/hpal/network_callbacks.h
>   create mode 100644 drivers/usb/mausb_host/include/link/mausb_ip_link.h
>   create mode 100644 
> drivers/usb/mausb_host/include/utils/mausb_data_iterator.h
>   create mode 100644 drivers/usb/mausb_host/include/utils/mausb_logs.h
>   create mode 100644 drivers/usb/mausb_host/include/utils/mausb_mmap.h
>   create mode 100644 
> drivers/usb/mausb_host/include/utils/mausb_ring_buffer.h
>   create mode 100644 drivers/usb/mausb_host/include/utils/mausb_version.h
>   create mode 100644 drivers/usb/mausb_host/src/hcd/hub.c
>   create mode 100644 drivers/usb/mausb_host/src/hcd/module_init.c
>   create mode 100644 drivers/usb/mausb_host/src/hcd/vhcd.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/data_common.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/data_in.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/data_out.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/hpal.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/isoch_in.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/isoch_out.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/mausb_events.c
>   create mode 100644 drivers/usb/mausb_host/src/hpal/network_callbacks.c
>   create mode 100644 drivers/usb/mausb_host/src/link/mausb_ip_link.c
>   create mode 100644 drivers/usb/mausb_host/src/utils/mausb_data_iterator.c
>   create mode 100644 drivers/usb/mausb_host/src/utils/mausb_mmap.c
>   create mode 100644 drivers/usb/mausb_host/src/utils/mausb_ring_buffer.c
> 
> 

> From 0324b3a49d0ef41480a0a42ab27f70edeb007980 Mon Sep 17 00:00:00 2001
> From: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> Date: Tue, 11 Feb 2020 16:03:43 +0100
> Subject: [PATCH] usb: Add MA USB Host driver
> 
> MA-USB Host driver provides USB connectivity over an available
> network, allowing host device to access remote USB devices attached
> to one or more MA USB devices (accessible via network).

<snip>

You attached the patch, as well as put the description above in the
email as well, so I couldn't apply this even if I wanted to :(

Please just submit the patch all inline, like all other kernel patches
are.

thanks,

greg k-h
