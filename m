Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D61C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749EE2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592935272;
	bh=+jfly5Ngdrj48jWGMhf0AWiq7rzl82cAMECyjRrpm7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9hEIzzA46q4jrPV39Rj6Q7HIitsoL8g1toRD++u9YlqwKjkYKZiGlIoOVjl+rkut
	 4Fe04c93/FDHTBVLC1WahX8xsON7jt8a7F8EZT547czG5wtJAvB3sDOrBplfZVPsg/
	 rqtmHxjCnlm2v8rZTLRCZMaVPLPYoGFIcRITBul4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgFWSBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732973AbgFWSBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:01:10 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD85020781;
        Tue, 23 Jun 2020 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592935270;
        bh=+jfly5Ngdrj48jWGMhf0AWiq7rzl82cAMECyjRrpm7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbrtIjQNnqzJ0vx63NM4QAOL+qYwxJVWynHFyEuShC/rZ+ieqmI4ZTS75fDGdb522
         TSBwCa5HDHkz//wbdzXSovuFgwf3Og/v++jtLNIqgzJ87H5HU4joqKN9gOFIZUpgAv
         +Lw3pblMKbDwl3D/v6iJM9ScJ5O1x+ccF+ch82Qg=
Date:   Tue, 23 Jun 2020 11:01:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, axboe@fb.com,
        hch@lst.de, baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
 <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:39:01AM -0700, Sagi Grimberg wrote:
> 
> > >  From the NVMe spec, "In order to make efficient use of the non-volatile
> > > memory, it is often advantageous to execute multiple commands from a
> > > Submission Queue in parallel. For Submission Queues that are using
> > > weighted round robin with urgent priority class or round robin
> > > arbitration, host software may configure an Arbitration Burst setting".
> > > Thus add Arbitration Burst setting support.
> > 
> > But if the user changed it to something else that better matches how
> > they want to use queues, the driver is just going to undo that setting
> > on the next reset.
> 
> Where do we do priority class arbitration? no one sets it

Not the priority class, we don't use WRR in this driver. The RR
arbitration can be set from user space and saved across controller
resets, like:

  # nvme set-feature -f 1 -v 3 --save

This patch would undo the saved feature value.
