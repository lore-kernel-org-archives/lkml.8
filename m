Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB1C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F59720719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584364468;
	bh=LmU7P8pTU610kxZnULxwK7dksMsqCbNn4F4inI+WiXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wkFzfqTw8MCzVKCKgHvSR1pz5dxD7+opB5S3RKUi+nxxyPaWp5ZnWXAXr/Bh0Bq3j
	 oJZLCresdgAAua771je+yeDtsf8pIxuNUPLkpdB3JTrmWASpddxn1qDht+292prc36
	 2+EU7YAVpjPH67mA9PNnDJET+56KsP3YlCa+8/yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgCPNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbgCPNO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:14:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29AFC20663;
        Mon, 16 Mar 2020 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584364466;
        bh=LmU7P8pTU610kxZnULxwK7dksMsqCbNn4F4inI+WiXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bOc05CrcR9Emny6/CLjvQzRP6g4e7lV/jF56WxstnkltZOCNUUkZMHM4ezxPC6/XB
         pFyzosK7RWC9Nm1suRt1xMatiaj4HXL03w0CC+Xngzdu5ETKQmrCCbXM/UuMPbzQA8
         HLZSWtZY/WDD/PJ9Kux3Dr7pWtJjlrB/Qk666CdI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDpZY-00D5AE-EW; Mon, 16 Mar 2020 13:14:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 13:14:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, luojiaxing@huawei.com
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
In-Reply-To: <2c367508-f81b-342e-eb05-8bbd1b056279@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
 <2c367508-f81b-342e-eb05-8bbd1b056279@huawei.com>
Message-ID: <9ce0b23455a06d92161c5302ac28152e@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de, luojiaxing@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-16 13:02, John Garry wrote:

Hi John,

> Hi Marc,
> 
>> +		int this_count = its_read_lpi_count(d, tmp);
> 
> Not sure if it's intentional, but now there seems to be a subtle
> difference to what Thomas described for non-managed interrupts - for
> non-managed interrupts, x86 selects the CPU based on the total
> interrupt load per CPU (or, more specifically, lowest vector
> allocation count), and not just the non-managed load. Or maybe I
> misread it.

So far, I'm trying to keep the two allocation paths separate, as the
two systems I have access to have very different behaviours: D05 has
no managed interrupts to speak of, and my top-secret work machine
has almost no unmanaged interrupts, so the two sets are almost
completely disjoint.

Also, it all depends on the interrupt allocation order, and whether
something will rebalance the non-managed interrupts at a later time.
At least, these two patches make it easy to alter the placement policy
(the behaviour you describe above is a 2 line change).

> Anyway, we can test this now for NVMe with its managed interrupts.

Looking forward to hearing from you!

         M.
-- 
Jazz is not dead. It just smells funny...
