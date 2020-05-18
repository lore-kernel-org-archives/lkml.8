Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9440E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgERKqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:46:32 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10929 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgERKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:46:32 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95ec2676f8b4-36cf1; Mon, 18 May 2020 18:46:08 +0800 (CST)
X-RM-TRANSID: 2ee95ec2676f8b4-36cf1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.146.121] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95ec2676e50b-b7d11;
        Mon, 18 May 2020 18:46:07 +0800 (CST)
X-RM-TRANSID: 2ee95ec2676e50b-b7d11
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix format and unused assignment
To:     Mark Brown <broonie@kernel.org>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
 <20200518102513.GA8699@sirena.org.uk>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <9ab0ef1f-6acf-ac5a-9d16-e00fbb39ae11@cmss.chinamobile.com>
Date:   Mon, 18 May 2020 18:47:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518102513.GA8699@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/18 18:25, Mark Brown wrote:
> On Mon, May 18, 2020 at 03:44:05PM +0800, Tang Bin wrote:
>> In the function fsl_micfil_startup(), the two lines of dev_err()
>> can be shortened to one line. And delete unused initialized value
>> of 'ret', because it will be assigned by the function
>> fsl_micfil_set_mclk_rate().
> This is two separate changes with no overlap so would have been better
> sent as separate patches.

Got it, Thanks

Tang Bin



