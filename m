Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD4BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2E20723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y8CfC4Qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEZOmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:42:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59590 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEZOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:42:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QEg2ZG031459;
        Tue, 26 May 2020 09:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590504122;
        bh=kEUtdtJZcvSXue8IMnS39FnD+QBwkTQxI7JxWo4gA6I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y8CfC4Qv6HujKH0uud3dTelxQxNxL/RVthxxCrJbjAO3WrPhtKZZGFVZE9TyX/vsr
         4GBPI6EjxvWfO1bM+P7zyYgsdujy0SCTf0DU8KZ+4GaO2C079sIEoZUuBouwefpPv2
         0jotwPZHavrwV/7ZoQlVaqSDZE6gmmfrV2FZ0Fq4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04QEg2OA004826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 09:42:02 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 09:41:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 09:41:06 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QEf5QL004730;
        Tue, 26 May 2020 09:41:06 -0500
Subject: Re: sound/soc/codecs/tlv320adcx140.c:776:34: warning: unused variable
 'tlv320adcx140_of_match'
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
References: <202005230320.TWdmRD2n%lkp@intel.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a9949577-92ce-75dc-f8d7-96d758f3f1c0@ti.com>
Date:   Tue, 26 May 2020 09:41:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005230320.TWdmRD2n%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 5/22/20 2:16 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4286d192c803571e8ca43b0f1f8ea04d663a278a
> commit: 689c7655b50c5de2b6f0f42fecfb37bde5acf040 ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family
> date:   3 months ago
> config: mips-randconfig-r014-20200522 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 3393cc4cebf9969db94dc424b7a2b6195589c33b)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install mips cross compiling tool for clang build
>          # apt-get install binutils-mips-linux-gnu
>          git checkout 689c7655b50c5de2b6f0f42fecfb37bde5acf040
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> sound/soc/codecs/tlv320adcx140.c:776:34: warning: unused variable 'tlv320adcx140_of_match' [-Wunused-const-variable]
> static const struct of_device_id tlv320adcx140_of_match[] = {
> ^
> 1 warning generated.
>
> vim +/tlv320adcx140_of_match +776 sound/soc/codecs/tlv320adcx140.c
>
>     775	
>   > 776	static const struct of_device_id tlv320adcx140_of_match[] = {
>     777		{ .compatible = "ti,tlv320adc3140" },
>     778		{ .compatible = "ti,tlv320adc5140" },
>     779		{ .compatible = "ti,tlv320adc6140" },
>     780		{},
>     781	};
>     782	MODULE_DEVICE_TABLE(of, tlv320adcx140_of_match);
>     783	

I am not sure about this issue the same code appears in many drivers ie 
the TAS2562 and that did not create a warning within this build AFAIK

Dan

