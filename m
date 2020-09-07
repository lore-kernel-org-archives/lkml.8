Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C32C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8F521897
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599517448;
	bh=Zw8k17EFrc+/63emBncYD49Ff5pxZKxzzOMgy+BQJLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SNHHLjZUA8o1uy7rKR+M4zt+jYjlDM5xs845nNvajDb7PR2+DWmRr2kSUiqbuqLDa
	 dag1mypWnXyO47/Qf+3ngb1Sw7SeHcawUDuusCOAYp7ll9E3PL2vw8wU5L7RTrKweL
	 /8EyESHjwDtf8FOhSB0KhJ10x+c27hXK7wODoV5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgIGWYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgIGWYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:24:05 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC482177B;
        Mon,  7 Sep 2020 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599517445;
        bh=Zw8k17EFrc+/63emBncYD49Ff5pxZKxzzOMgy+BQJLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCQM0mMbBmsuXq6UiB6gfFobsHNxnlX3Kk4wLQa8AevAHky7abtJqi/+ADi5VCech
         AimdyxuYXf0XIhdZP91Xjk4gQYYSIVwEHMDANE0DH5RqXC/Vxo1TxhoENe+na8hCS9
         KpNgXEXwD6oqJYWh/Feb1GZ86rYfY8DK9ZhM4KRM=
Date:   Mon, 7 Sep 2020 18:24:03 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mingming Cao <mmc@linux.vnet.ibm.com>,
        Dany Madden <drt@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.8 14/53] ibmvnic fix NULL tx_pools and rx_tools
 issue at do_reset
Message-ID: <20200907222403.GQ8670@sasha-vm>
References: <20200907163220.1280412-1-sashal@kernel.org>
 <20200907163220.1280412-14-sashal@kernel.org>
 <20200907141026.093fc160@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200907141026.093fc160@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 02:10:26PM -0700, Jakub Kicinski wrote:
>On Mon,  7 Sep 2020 12:31:40 -0400 Sasha Levin wrote:
>> [ Upstream commit 9f13457377907fa253aef560e1a37e1ca4197f9b ]
>
>> @@ -2024,10 +2033,14 @@ static int do_reset(struct ibmvnic_adapter *adapter,
>>  		} else {
>>  			rc = reset_tx_pools(adapter);
>>  			if (rc)
>> +				netdev_dbg(adapter->netdev, "reset tx pools failed (%d)\n",
>> +						rc);
>>  				goto out;
>>
>>  			rc = reset_rx_pools(adapter);
>>  			if (rc)
>> +				netdev_dbg(adapter->netdev, "reset rx pools failed (%d)\n",
>> +						rc);
>>  				goto out;
>>  		}
>>  		ibmvnic_disable_irqs(adapter);
>
>Hi Sasha!
>
>I just pushed this to net:
>
>8ae4dff882eb ("ibmvnic: add missing parenthesis in do_reset()")
>
>You definitely want to pull that in if you decide to backport this one.

Will do, thanks!

-- 
Thanks,
Sasha
