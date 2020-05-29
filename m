Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6678020723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e+r/k5Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgE2TPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:15:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10448 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2TPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:15:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed15f3c0001>; Fri, 29 May 2020 12:15:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 12:15:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 May 2020 12:15:20 -0700
Received: from [10.2.87.173] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 19:15:20 +0000
Subject: Re: [PATCH 0/3] misc: xilinx-sdfec: convert get_user_pages() -->
 pin_user_pages()
To:     Dragan Cvetic <draganc@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200527012628.1100649-1-jhubbard@nvidia.com>
 <DM6PR02MB41405A1300813F8A511BE449CB8F0@DM6PR02MB4140.namprd02.prod.outlook.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c01d2d45-250f-e8a9-cfc0-0f0df6db13b4@nvidia.com>
Date:   Fri, 29 May 2020 12:15:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR02MB41405A1300813F8A511BE449CB8F0@DM6PR02MB4140.namprd02.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590779708; bh=fzhGtzZMcfGKFcA4Tvhs0mwDOSypFMG8kMfO5rPUm/E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=e+r/k5WqVFkAi2PibQRZ6bmKhraegciNQsi76G3cRF+zPtEfWvG/Fptuf90ZMBfnc
         20fqiotqN8AdRUzB6gPpRSJFcRRzRQX9/XdpQb7nScTTu876Bz7/PsSZCa0XzfIiEn
         5M2ut6nC9ozgHHDK3uTQWTMSfMtsMkJdpm0jlWx1CzTkoe4N9jHBilpG6wQ8hoGMDE
         hCsDoWDlGmfXlB3BpEl72NLx0PixwbxJM/2i4ojGR2ECEtd4XpcTlmE7ikP9mzjp3S
         xz2H5RgtgoEf4qPfE2o/eU2TFtKNRDcKTP+m8qwgjI/0tO4UIDPsQIBWaJ2JpnMVDF
         j49Xc5ebg7z4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 01:29, Dragan Cvetic wrote:
> Hi John,
> 
> Thank you for the suggestion, please find my comment below:
> 
>> -----Original Message-----
>> From: John Hubbard <jhubbard@nvidia.com>
>> Sent: Wednesday 27 May 2020 02:26
>> To: LKML <linux-kernel@vger.kernel.org>
>> Cc: Souptick Joarder <jrdr.linux@gmail.com>; John Hubbard <jhubbard@nvidia.com>; Derek Kiernan <dkiernan@xilinx.com>; Dragan
>> Cvetic <draganc@xilinx.com>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Michal Simek
>> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org
>> Subject: [PATCH 0/3] misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()
>>
>> Hi,
>>
>> There are also a couple of tiny cleanup patches, just to fix up a few
>> minor issues that I spotted while converting from get_user_pages_fast()
>> to pin_user_pages_fast().
>>
>> Note that I have only compile-tested these patches, although that does
>> also include cross-compiling for a few other arches. Any run-time
>> testing would be greatly appreciated!
>>
>> Cc: Derek Kiernan <derek.kiernan@xilinx.com>
>> Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>>
>> John Hubbard (3):
>>    misc: xilinx-sdfec: improve get_user_pages_fast() error handling
>>    misc: xilinx-sdfec: cleanup return value in xsdfec_table_write()
>>    misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()
> 
> 
> Reviewed-by:
> 	Technically there is no problem in this patch, but as you said this should be tested.
> 	Currently due to Covid-19 I'm not able to access the HW and I cannot validate this suggestion.
> 

Hi Dragan,

Thanks for the review, and for *wanting* to do the testing, even though you
can't right now. :)

thanks,
-- 
John Hubbard
NVIDIA

>>
>>   drivers/misc/xilinx_sdfec.c | 30 +++++++++++++++++-------------
>>   1 file changed, 17 insertions(+), 13 deletions(-)
>>
>>
>> base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
>> --
>> 2.26.2
> 
