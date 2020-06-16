Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0249C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998C42071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgFPOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:02:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60875 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729289AbgFPOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:02:47 -0400
Received: (qmail 31737 invoked by uid 1000); 16 Jun 2020 10:02:46 -0400
Date:   Tue, 16 Jun 2020 10:02:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: introduce flag for large request
Message-ID: <20200616140246.GA30975@rowland.harvard.edu>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:34:43PM +0800, Macpaul Lin wrote:
> Some USB hardware like DMA engine can help to process (split) the data
> of each URB request into small packets. For example, the max packet size
> of high speed is 512 bytes. These kinds of hardware can help to split
> the continue Tx/Rx data requests into packets just at the max packet
> size during transmission. Hence upper layer software can reduce some
> effort for queueing many requests back and forth for larger data.
> 
> Here we introduce "can_exceed_maxp" flag in gadget when these kinds of
> hardware is ready to support these operations.

This isn't needed.  All UDC drivers must be able to support requests that 
are larger than the maxpacket size.

Alan Stern
