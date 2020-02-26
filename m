Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBCEC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DFE24656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBZSOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:14:25 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50856 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726970AbgBZSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:14:25 -0500
Received: (qmail 2447 invoked by uid 2102); 26 Feb 2020 13:14:24 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2020 13:14:24 -0500
Date:   Wed, 26 Feb 2020 13:14:24 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
cc:     linux-usb@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Lee, Chiasheng" <chiasheng.lee@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <stable@vger.kernel.org>, <scan-admin@coverity.com>
Subject: Re: [PATCH v3 1/3] usb: core: hub: fix unhandled return by employing
 a void function
In-Reply-To: <20200226175036.14946-1-erosca@de.adit-jv.com>
Message-ID: <Pine.LNX.4.44L0.2002261313390.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Eugeniu Rosca wrote:

> Address below Coverity complaint (Feb 25, 2020, 8:06 AM CET):
> 
> *** CID 1458999:  Error handling issues  (CHECKED_RETURN)
> /drivers/usb/core/hub.c: 1869 in hub_probe()
> 1863
> 1864            if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
> 1865                    hub->quirk_check_port_auto_suspend = 1;
> 1866
> 1867            if (id->driver_info & HUB_QUIRK_DISABLE_AUTOSUSPEND) {
> 1868                    hub->quirk_disable_autosuspend = 1;
>  >>>     CID 1458999:  Error handling issues  (CHECKED_RETURN)
>  >>>     Calling "usb_autopm_get_interface" without checking return value (as is done elsewhere 97 out of 111 times).
> 1869                    usb_autopm_get_interface(intf);
> 1870            }
> 1871
> 1872            if (hub_configure(hub, &desc->endpoint[0].desc) >= 0)
> 1873                    return 0;
> 1874
> 
> Rather than checking the return value of 'usb_autopm_get_interface()',
> switch to the usb_autopm_get_interface_no_resume() API, as per:
> 
> On Tue, Feb 25, 2020 at 10:32:32AM -0500, Alan Stern wrote:
>  ------ 8< ------
>  > This change (i.e. 'ret = usb_autopm_get_interface') is not necessary,
>  > because the resume operation cannot fail at this point (interfaces
>  > are always powered-up during probe). A better solution would be to
>  > call usb_autopm_get_interface_no_resume() instead.
>  ------ 8< ------
> 
> Fixes: 1208f9e1d758c9 ("USB: hub: Fix the broken detection of USB3 device in SMSC hub")
> Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org # v4.14+
> Reported-by: scan-admin@coverity.com
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

For all three patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

