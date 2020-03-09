Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC10C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D13D21739
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V8wRSWUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCIJBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:01:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33370 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgCIJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:01:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02991VlY088460;
        Mon, 9 Mar 2020 04:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583744491;
        bh=mDssdW4CESBzqR0FRW9NV2aVOuzmk9PsDFL1wyptnLs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V8wRSWUVVXJqysDSAx+eNJJo4D7E07j5+KLrB3444Mqf2VD94O/ieuxBBJa0Oikp2
         tqH/rD0R2KqNtoRFO9m48T+YLioOJp+0K0IPt5rYhmZd9+OuV6/I7+9+AAAXBGBADb
         fSUDmxPuzbgpIRYIyKtbCyFVyY6Qd9h+LlBk4sww=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02991U9l018016;
        Mon, 9 Mar 2020 04:01:30 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Mar
 2020 04:01:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Mar 2020 04:01:30 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02991TP8068879;
        Mon, 9 Mar 2020 04:01:30 -0500
Subject: Re: [GIT PULL] PHY: For 5.6 -rc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20200221115356.6587-1-kishon@ti.com>
 <20200304124104.GA1629188@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <66e2637d-a9b7-82f5-16a5-1dfaf513374f@ti.com>
Date:   Mon, 9 Mar 2020 14:36:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304124104.GA1629188@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 04/03/20 6:11 pm, Greg Kroah-Hartman wrote:
> On Fri, Feb 21, 2020 at 05:23:56PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Greg,
>>
>> Please find the pull request for 5.6 -rc cycle below.
>>
>> It fixes an issue caused because of adding device_link_add() on platforms
>> which have cyclic dependency between PHY consumer and PHY provider.
>>
>> It also includes misc fixes in Motorola, TI and Broadcom's PHY driver.
>> Please see the tag message for the complete list of changes and let me
>> know if I have to change something.
>>
>> Thanks
>> Kishon
>>
>> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
>>
>>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.6-rc
> 
> Oops, just saw this now, sorry for not getting to it.  HOpefully all of
> these were in the pull request I just took.

No issues. All these were also part of my v2 pull request which you
already merged.

Thanks
Kishon
