Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E120C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4220A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WGIsw95l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgELGuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:50:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgELGuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:50:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04C6mDFD014173;
        Tue, 12 May 2020 08:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iEKjer/AUZHyZOt8W1uqSZTqu50DObD4a45HBZNn1gg=;
 b=WGIsw95lqD0h3WMhec/jt5cW8wF8MlhfrFKGP/m06rYBvMAlXVCoO0WSKxYFbboKoxmZ
 D0rtymgEp5jsRaZcCf1ON6ck6FQb1fhal73CUajnkQRUvvhEbqQJEMlPA/iVdUALLAw7
 JeQrggkQ81PpYnIfDJHkGbVBehC0DcdJbsTYtgcVFE4Yk9lBkIAom7oXKfJ2G8ZNQm0c
 U/mMkY9GHTTVaOMCp+UtVazLUAg0REwjobdpNhBPNmqiK7FUZbfonJZKZ6sdYPswEyMU
 ra6sXeG8e8tlvbALus+swRodDS9Fsvk2kjSTQxCRX5uB9AdGv1INMl0TJ4eCzMxWX8DZ BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30whn9ekuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 08:49:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6295100034;
        Tue, 12 May 2020 08:49:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B8BCD221A49;
        Tue, 12 May 2020 08:49:57 +0200 (CEST)
Received: from [10.211.13.100] (10.75.127.46) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 May
 2020 08:49:56 +0200
Subject: Re: [PATCH v4 04/10] mtd: rawnand: stm32_fmc2: cleanup
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <1588756279-17289-5-git-send-email-christophe.kerello@st.com>
 <20200511223900.030fe5f4@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <49c51a13-96a1-0241-f4d1-c5ff7d52921d@st.com>
Date:   Tue, 12 May 2020 08:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200511223900.030fe5f4@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_01:2020-05-11,2020-05-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 5/11/20 10:39 PM, Miquel Raynal wrote:
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
> 11:11:13 +0200:
> 
>> This patch renames functions and local variables.
>> This cleanup is done to get all functions starting by stm32_fmc2_nfc
>> in the FMC2 raw NAND driver when all functions will start by
>> stm32_fmc2_ebi in the FMC2 EBI driver.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Applied to nand/next as well but for an unknown reason I had to do it
> by hand because the patch would not apply.
> 
> Thanks,
> Miquèl
> 
This is strange, I can apply this patch on my tree without any conflicts.
There is a compilation issue line 1301.

@@ -1302,44 +1298,45 @@ static void stm32_fmc2_write_data(struct 
nand_chip *chip, const void *buf,

  	if (force_8bit && chip->options & NAND_BUSWIDTH_16)
  		/* Reconfigure bus width to 16-bit */
-		stm32_fmc2_set_buswidth_16(fmc2, true);
+		stm32_fmc2_nfc_set_buswidth_16(nfc, true);
  }

I will rebase on top of nand/next today to check that there is no issues 
with the driver.

Regards,
Christophe Kerello.
