Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C4C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57E2221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKLQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:16:33 -0400
Received: from foss.arm.com ([217.140.110.172]:60196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgIKLQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:16:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 710BC113E;
        Fri, 11 Sep 2020 04:16:08 -0700 (PDT)
Received: from [192.168.1.205] (unknown [10.37.8.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3E73F68F;
        Fri, 11 Sep 2020 04:16:04 -0700 (PDT)
Subject: Re: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
To:     Mark Brown <broonie@kernel.org>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <20200911110018.GD4895@sirena.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <9a6ce5d0-2f39-eb55-c3a9-cae2a8093fbc@arm.com>
Date:   Fri, 11 Sep 2020 14:16:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200911110018.GD4895@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 1:00 PM, Mark Brown wrote:
> On Fri, Sep 11, 2020 at 01:58:06PM +0530, kuldip dwivedi wrote:
> 
>>   	/* find the resources - configuration register address space */
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
>> +#ifdef CONFIG_ACPI
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +#endif
> 
> This is buggy, it is equivalent to just removing the name based lookup
> since we'll do the name based lookup then unconditionally overwrite the
> results with an index based lookup.
> 

Also, note that CONFIG_ACPI kernels may still boot in DT mode.
