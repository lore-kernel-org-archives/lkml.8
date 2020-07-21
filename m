Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BABC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786012073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LxjD0fjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgGUSRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:17:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37058 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:17:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LIGuxj057476;
        Tue, 21 Jul 2020 13:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595355416;
        bh=u7Atqj1QiHLMgnFA7rcMsvOHhKy09V10c26pBvoOBUw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LxjD0fjIE8uPfmNGEgcRk8r/uRu4VVHGE4ajaEtf2m+IDQk+2nWa+fEnC58fHjYJ1
         0FPJARcC/dSa0r5B6CZc/mQNPudSkGuYDXtCZ5XLbBUIXNdFe2HsPWasWPXF3M5zfd
         bQ7iG6iBaxd0e6tzarFZM2Tm4QjXscuzxmbBz5H4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06LIGulU123278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 13:16:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 13:16:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 13:16:56 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LIGrek080448;
        Tue, 21 Jul 2020 13:16:54 -0500
Subject: Re: [PATCH v2 1/8] arch: arm: mach-davinci: Fix trivial spelling
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
CC:     Jiri Kosina <trivial@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM SUB-ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
 <20200715124839.252822-2-kieran.bingham+renesas@ideasonboard.com>
 <CAMpxmJXhRX1Gpxg2iqX2XXy67BhGrgrqchJb6OOoDz8POo0sgQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <1966fea0-e43f-0936-f839-053f21c8ed90@ti.com>
Date:   Tue, 21 Jul 2020 23:46:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJXhRX1Gpxg2iqX2XXy67BhGrgrqchJb6OOoDz8POo0sgQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 1:32 PM, Bartosz Golaszewski wrote:
> On Wed, Jul 15, 2020 at 2:48 PM Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
>>
>> The word 'descriptor' is misspelled throughout the tree.
>>
>> Fix it up accordingly:
>>     decriptors -> descriptors
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  arch/arm/mach-davinci/board-da830-evm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
>> index a273ab25c668..1076886938b6 100644
>> --- a/arch/arm/mach-davinci/board-da830-evm.c
>> +++ b/arch/arm/mach-davinci/board-da830-evm.c
>> @@ -266,7 +266,7 @@ static struct mtd_partition da830_evm_nand_partitions[] = {
>>         }
>>  };
>>
>> -/* flash bbt decriptors */
>> +/* flash bbt descriptors */
>>  static uint8_t da830_evm_nand_bbt_pattern[] = { 'B', 'b', 't', '0' };
>>  static uint8_t da830_evm_nand_mirror_pattern[] = { '1', 't', 'b', 'B' };
>>
>> --
>> 2.25.1
>>
> 
> Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Fixed up subject prefix to "ARM: davinci: " for consistency, and applied.

Thanks,
Sekhar

