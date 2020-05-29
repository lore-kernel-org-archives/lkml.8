Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD079C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F40A207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgE2AaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:30:23 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:55016 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgE2AaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:30:20 -0400
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.137])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9CA3120066;
        Fri, 29 May 2020 00:30:18 +0000 (UTC)
Received: from us4-mdac16-42.at1.mdlocal (unknown [10.110.48.13])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9BB57600A1;
        Fri, 29 May 2020 00:30:18 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.49.102])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3B763220072;
        Fri, 29 May 2020 00:30:18 +0000 (UTC)
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0AEE26C0081;
        Fri, 29 May 2020 00:30:18 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 29 May
 2020 01:30:07 +0100
Subject: Re: [PATCH] [net-next] sfc: avoid an unused-variable warning
To:     David Miller <davem@redhat.com>, <arnd@arndb.de>
CC:     <linux-net-drivers@solarflare.com>, <mhabets@solarflare.com>,
        <kuba@kernel.org>, <amaftei@solarflare.com>,
        <tzhao@solarflare.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200527134113.827128-1-arnd@arndb.de>
 <20200528.124946.275321353658990898.davem@redhat.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <8e7598b2-3301-1af4-8c2f-b40cdc5166a3@solarflare.com>
Date:   Fri, 29 May 2020 01:30:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200528.124946.275321353658990898.davem@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1020-25448.003
X-TM-AS-Result: No-6.930600-8.000000-10
X-TMASE-MatchedRID: csPTYAMX1+HmLzc6AOD8DfHkpkyUphL93FYvKmZiVnNjLp8Cm8vwFwoe
        RRhCZWIBonge81At2M2V8Dyw8OwGlWohFAYfTz4eAI0UpQvEYJmpR2kMGcsw7fn6214PlHOFJPg
        Vsf4l5dpxx+F9iqJ6LbQZQR+hJY7HCwCgoOlMqt+3RxL+7EfzsC+cnbmQwgrbB/FMznsE8cMrLG
        zQLeAjoV0EtLM2oIeD+Lgq7OToUuqPaFHMfVTC4IMbH85DUZXy3QfwsVk0UbtuRXh7bFKB7t3R0
        ll3p4Z9AJNL/u1BBC+M5rZkaybOHls39i4wtF6DWClYJu9r4yY=
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.930600-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1020-25448.003
X-MDID: 1590712218-5HbRA0ZXZLm1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2020 20:49, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 27 May 2020 15:41:06 +0200
>
>> 'nic_data' is no longer used outside of the #ifdef block
>> in efx_ef10_set_mac_address:
>>
>> drivers/net/ethernet/sfc/ef10.c:3231:28: error: unused variable 'nic_data' [-Werror,-Wunused-variable]
>>         struct efx_ef10_nic_data *nic_data = efx->nic_data;
>>
>> Move the variable into a local scope.
>>
>> Fixes: dfcabb078847 ("sfc: move vport_id to struct efx_nic")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Applid, thanks.
Sorry I didn't see the original patch (I think it disappeared
 into a mail outage).  Fix is good, but I think we can improve
 the code further by moving the declaration down another block,
 into the 'if (rc == -EPERM)', at which point it is no longer
 shadowed by the other nic_data declaration in the
 'else if (!rc)' block.
Alternatively, we could rename the latter to 'pf_nic_data' or
 something.  Any opinions/preferences on which way to go?  We
 could even do both...
When I make up my mind I'll spin an incremental patch.

-ed
