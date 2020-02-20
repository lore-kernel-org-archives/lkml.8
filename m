Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B8C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BE320659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582215103;
	bh=OHPpGTXwOBTQ+2n7AONE/bLL7UPY/3XpZR9aEfGY5xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IKEBQ0DJJezpPsA/tQSMbfPyoazDj21MC1wtZaM+35//vBHPAAf/W0JjUSkUZU4FJ
	 Wd5ebVcUXrSsr13fnnY8EzsKQeT8AhAEW+HCVrynXOUQr0QiUPfg9n/9SpJ8CeXYs4
	 UwMWRCTOMR0aR+tokj6DR6WYsdHBpP5gLu65MR7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgBTQLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:11:42 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231F820659;
        Thu, 20 Feb 2020 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582215101;
        bh=OHPpGTXwOBTQ+2n7AONE/bLL7UPY/3XpZR9aEfGY5xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUpBRmCOj/opRcbrtI1aId22Ku/rmQkrAvKDjrHQ9UQnEOF9zU5nQveqius779w6P
         3WK8hA9fioJujhP9U61mzeSVz9jctGiGohQnifWGjyldb4iPU+dc55b3nqVFGq8vJ2
         FXfehNGI2V6JI/1SfZTFo8ZC/gNCOTUVi4swLx8s=
Date:   Thu, 20 Feb 2020 11:11:39 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.5 094/542] s390/pci: Fix possible deadlock in
 recover_store()
Message-ID: <20200220161139.GB1734@sasha-vm>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-94-sashal@kernel.org>
 <20200217093156.GB42010@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217093156.GB42010@tuxmaker.boeblingen.de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:31:56AM +0100, Niklas Schnelle wrote:
>On Fri, Feb 14, 2020 at 10:41:26AM -0500, Sasha Levin wrote:
>> From: Niklas Schnelle <schnelle@linux.ibm.com>
>>
>> [ Upstream commit 576c75e36c689bec6a940e807bae27291ab0c0de ]
>>
>> With zpci_disable() working, lockdep detected a potential deadlock
>> (lockdep output at the end).
>>
>> The deadlock is between recovering a PCI function via the
>>
>> /sys/bus/pci/devices/<dev>/recover
>>
>> attribute vs powering it off via
>>
>> /sys/bus/pci/slots/<slot>/power.
>>
>> The fix is analogous to the changes in commit 0ee223b2e1f6 ("scsi: core:
>> Avoid that SCSI device removal through sysfs triggers a deadlock")
>> that fixed a potential deadlock on removing a SCSI device via sysfs.
>[ ... snip ... ]
>
>While technically useful on its own this commit really should go together with
>the following upstream commit:
>
>17cdec960cf776b20b1fb08c622221babe591d51
>("s390/pci: Recover handle in clp_set_pci_fn()")
>
>While the problem fixed here is independent,  writing to the power/recover
>attributes will often fail due to an inconsistent function handle without the
>second commit.
>In particular without it a PCI function in the error state can not be
>recovered or powered off.
>
>I would recommend adding the second commit to the backports as well.

I took that commit as well, thank you.

-- 
Thanks,
Sasha
