Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6D3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC49B20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgCWULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:11:42 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:44634 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgCWULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:11:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B46D3837F24D;
        Mon, 23 Mar 2020 20:11:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blood13_2b83efc501e40
X-Filterd-Recvd-Size: 3004
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 20:11:38 +0000 (UTC)
Message-ID: <03547be94c4944ca672c7aef2dd38b0fb1eedc84.camel@perches.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
From:   Joe Perches <joe@perches.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Mon, 23 Mar 2020 13:09:50 -0700
In-Reply-To: <57C56801-7F3B-478A-83E9-1D2376C60666@holtmann.org>
References: <20200323072824.254495-1-mcchou@chromium.org>
         <20200323002820.v1.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
         <04021BE3-63F7-4B19-9F0E-145785594E8C@holtmann.org>
         <421d27670f2736c88e8c0693e3ff7c0dcfceb40b.camel@perches.com>
         <57C56801-7F3B-478A-83E9-1D2376C60666@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 19:48 +0100, Marcel Holtmann wrote:
> Hi Joe,

Hello Marcel.

> > > > This adds a bit mask of driver_info for Microsoft vendor extension and
> > > > indicates the support for Intel 9460/9560 and 9160/9260. See
> > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> > > > microsoft-defined-bluetooth-hci-commands-and-events for more information
> > > > about the extension. This was verified with Intel ThunderPeak BT controller
> > > > where msft_vnd_ext_opcode is 0xFC1E.
> > []
> > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > []
> > > > @@ -315,6 +315,10 @@ struct hci_dev {
> > > > 	__u8		ssp_debug_mode;
> > > > 	__u8		hw_error_code;
> > > > 	__u32		clock;
> > > > +	__u16		msft_vnd_ext_opcode;
> > > > +	__u64		msft_vnd_ext_features;
> > > > +	__u8		msft_vnd_ext_evt_prefix_len;
> > > > +	void		*msft_vnd_ext_evt_prefix;
> > 
> > msft is just another vendor.
> > 
> > If there are to be vendor extensions, this should
> > likely use a blank line above and below and not
> > be prefixed with msft_
> 
> there are other vendors, but all of them are different. So this needs to be prefixed with msft_ actually. But I agree that having empty lines above and below makes it more readable.

So struct hci_dev should become a clutter
of random vendor extensions?

Perhaps there should instead be something like
an array of char at the end of the struct and
various vendor specific extensions could be
overlaid on that array or just add a void *
to whatever info that vendors require.



