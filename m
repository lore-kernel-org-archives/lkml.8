Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B266216FD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgEBNI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:08:58 -0400
Received: from mail.secom.com.pl ([213.216.87.26]:44139 "EHLO
        mail.secom.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgEBNI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:08:58 -0400
Received: from [192.168.1.110]
        (host-85.14.70.3.static.3s.pl [85.14.70.3])
        by mail.secom.com.pl; Sat, 02 May 2020 15:08:20 +0200
Subject: Re: [PATCH] dma: zynqmp_dma: Initialize descriptor list after freeing
 during reset
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200428143225.3357-1-rafal.hibner@secom.com.pl>
 <20200502123242.GB1375924@vkoul-mobl>
From:   =?UTF-8?Q?Rafa=c5=82_Hibner?= <rafal.hibner@secom.com.pl>
Message-ID: <1330934e-342e-1e16-6451-d8952463119c@secom.com.pl>
Date:   Sat, 2 May 2020 15:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200502123242.GB1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinod,

On 02.05.2020 14:32, Vinod Koul wrote:
> Would it not be better to use list_del_init() where we delete it rather
> than do the init here?
>

It is not a problem of list element itself not being initialized.
The problem is that during fault conditions (zynqmp_dma_reset) all
elements are moved to free list. List head however is not reinitialized.

In normal flow elements are removed by list_del and resubmitted to
free list with zynqmp_dma_free_descriptor.

static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
{
    ...
    list_for_each_entry_safe(desc, next, &chan->done_list, node) {
        ...
        list_del(&desc->node);
        ...
        zynqmp_dma_free_descriptor(chan, desc);
    }
}

The zynqmp_dma_free_descriptor does not delete elements from the
list by itself.
I am not he author of this driver so I fixed it by
doing non intrusive changes.

Anyways, I do not see how using list_del_init would fix the bug.

Regards, Rafal

