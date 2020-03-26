Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64732070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgCZIQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:16:30 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:39990 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgCZIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:16:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 74954182CED5B;
        Thu, 26 Mar 2020 08:16:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cart64_548b3b72c1009
X-Filterd-Recvd-Size: 1972
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 08:16:20 +0000 (UTC)
Message-ID: <0cb96a93000c02e4c4816c64492afef10bc76fd9.camel@perches.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
From:   Joe Perches <joe@perches.com>
To:     Miao-chen Chou <mcchou@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 26 Mar 2020 01:14:29 -0700
In-Reply-To: <20200326005931.v3.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
References: <20200326075938.65053-1-mcchou@chromium.org>
         <20200326005931.v3.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-26 at 00:59 -0700, Miao-chen Chou wrote:
> This adds a bit mask of driver_info for Microsoft vendor extension and
> indicates the support for Intel 9460/9560 and 9160/9260. See
> https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> microsoft-defined-bluetooth-hci-commands-and-events for more information
> about the extension. This was verified with Intel ThunderPeak BT controller
> where msft_vnd_ext_opcode is 0xFC1E.
[]
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
[]
> @@ -414,6 +414,8 @@ struct hci_dev {
>  	void			*smp_data;
>  	void			*smp_bredr_data;
>  
> +	void			*msft_ext;

Why should this be a void * and not a msft_vnd_ext * ?


