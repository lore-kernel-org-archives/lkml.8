Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E32C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A207F2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b1VqxNml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAQFc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:32:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55150 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgAQFc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 00:32:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00H5WuWm114765;
        Thu, 16 Jan 2020 23:32:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579239176;
        bh=Ws2WtoCm7DGHYFLkEAhjOgMut0ka+e3bXSjse0r0CFM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b1VqxNmlC0FZzdhCnbVCWtz4suThfQliLrk41b2p0mJrXJeJvEiOH5ZFQg0taTk5C
         et4CI1cKlFHBOUKqz8APvFKBqiNgx0lnkhloEybFcLZnX3/NFMXx4sIwtHpsCsvgQT
         Vmn7rIZgCJzd1fpGVnn035G+06941Xjjot0aLjlU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00H5WtnW121300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 23:32:55 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 23:32:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 23:32:55 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00H5WqDH067616;
        Thu, 16 Jan 2020 23:32:54 -0600
Subject: Re: [GIT PULL] PHY: For 5.6
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20200116110515.20480-1-kishon@ti.com>
 <20200116195524.GA1096827@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c6b3e4fe-38ae-4c62-e54a-c56804338b0e@ti.com>
Date:   Fri, 17 Jan 2020 11:05:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200116195524.GA1096827@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 17/01/20 1:25 AM, Greg Kroah-Hartman wrote:
> On Thu, Jan 16, 2020 at 04:35:15PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Greg,
>>
>> Please find the pull request for 5.6 merge window below.
>>
>> PHY core now creates a device link between PHY consumer and PHY
>> provider required for suspend/resume ordering and also adds support
>> for DisplayPort controller to pass configuration parameters to PHY.
>>
>> It includes new PHY drivers for TI's J721E SoC (PCIe and USB), eMMC
>> PHY driver for Intel's LGM SoC and USB PHY driver for Broadcom
>> SoC.
>>
>> For the detailed list of changes, please see the tag message below.
>> All these changes have been in linux -next for a while now.
>> Consider merging this for the next merge window and let me know if I
>> have to change something.
> 
> I got the following warning, which linux-next should also reported:
> Commit: 56b337ef505d ("phy: ti: j721e-wiz: Fix return value check in wiz_probe()")
> 	Fixes tag: Fixes: b46f531313a4 ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> 	Has these problem(s):
> 	        - Target SHA1 does not exist
> 
> Maybe I am merging into the wrong tree?
> 
> Anyway, I'll take this, hopefully that id shows up somewhere :)

Looks like this is a real issue as I might have not updated the commit
ID in Fixes tag after a rebase. Not sure why linux-next didn't report
this. Anyways I'll fix that up and send a new Pull Request.

Thanks
Kishon
