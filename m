Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC62C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDA220873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvqXknVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgCKMdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:33:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33487 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgCKMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:33:45 -0400
Received: by mail-io1-f65.google.com with SMTP id r15so1726519iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SvNsYQlB4kRlIpkiw/5fYDndPLg9lQh4weGxmJ/Njos=;
        b=pvqXknVJpYc5tZn/6PKu/c7IbZom4HSMCLc4HXwmzZZPl8S3fowbFSTZOsvFB3pt92
         jYWOXzXzmNHKIlxbYitDKwIcEPb/Upy9SyaUrzFmXfvHqTKDqnDYrESPB73P0UF2wKLj
         Sad6PfOfUvVaFHFdt7X4XMy2zgmYoD+pom2gHoPmS8Cv+f85q3GxdODWYYnEnuJ6m5fP
         cZgKLtCWvqTvFVKBENyqi3+HNU5sWvRPhLOa5dTYLFCH8lxQNqTL7SxSQuhl+XCsTXhK
         VhvlEyVXpcbIjOtptY9zk97Frq9IirFZ9n7LN+/4fx6NF+9vlbw0cDVUmvM83CPp/NPJ
         vVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvNsYQlB4kRlIpkiw/5fYDndPLg9lQh4weGxmJ/Njos=;
        b=bVhK/Cc9qsSPwWL1ubT8wsGydGVM/44WcQ4/HlIfucQazobJGNeetimipsDts9idg3
         QGbu55HAJpbyTovG/zyb7dRXxvK7khVGZYh3tDhVVyBeo1Cyw29Bn98S6COBOQlsLpPJ
         UGIdFc9l2OaGYwsRhIWpKvBgTrWzwOLOg9SOuwKAr5xq/CqCvcqVDQPXRaqX89KHcx0v
         U49RtX4OWCqBy2uH0idbQjGwlzpLIeXPDmo97oAJnuAy0uTnRtuZNmw40OY62QVuEVVK
         0H4JpVH1AsjX4cbd5OoTIQ262wZQEfERAgdp5asNgAvgT0FYvtjxLPy87+5OU6KUDwjC
         4vfw==
X-Gm-Message-State: ANhLgQ0NqNaV+hvtrmjMWTtsvssE/EX3FJY17N9pOS+VlwRhKqKN7PSW
        J0gfxUNTGl3cRuJA3IDjtgu/lHay8jA=
X-Google-Smtp-Source: ADFU+vvPqMCiIvjyFOh6REmJH5J/TFHvv5f9WRErtO+U7wQcxPktfiBNIAABCB8nwO6KwoU52BzWAQ==
X-Received: by 2002:a02:3808:: with SMTP id b8mr2839716jaa.136.1583930022021;
        Wed, 11 Mar 2020 05:33:42 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id o14sm1923065iob.4.2020.03.11.05.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:33:41 -0700 (PDT)
Subject: Re: [PATCH v2 15/17] soc: qcom: ipa: support build of IPA code
To:     Jon Hunter <jonathanh@nvidia.com>,
        David Miller <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dcbw@redhat.com>,
        Evan Green <evgreen@google.com>,
        Eric Caruso <ejcaruso@google.com>,
        Susheel Yadav Yadagiri <syadagir@codeaurora.org>,
        Chaitanya Pratapa <cpratapa@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200306042831.17827-1-elder@linaro.org>
 <20200306042831.17827-16-elder@linaro.org>
 <33e18aa5-5838-a2f2-7112-542a157bd026@nvidia.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <cdadf72c-0233-91f4-73a5-cee9636d32cc@linaro.org>
Date:   Wed, 11 Mar 2020 07:33:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <33e18aa5-5838-a2f2-7112-542a157bd026@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 5:54 AM, Jon Hunter wrote:
> 
> On 06/03/2020 04:28, Alex Elder wrote:
>> Add build and Kconfig support for the Qualcomm IPA driver.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  drivers/net/Kconfig      |  2 ++
>>  drivers/net/Makefile     |  1 +
>>  drivers/net/ipa/Kconfig  | 19 +++++++++++++++++++
>>  drivers/net/ipa/Makefile | 12 ++++++++++++
>>  4 files changed, 34 insertions(+)
>>  create mode 100644 drivers/net/ipa/Kconfig
>>  create mode 100644 drivers/net/ipa/Makefile
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 66e410e58c8e..02565bc2be8a 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -444,6 +444,8 @@ source "drivers/net/fddi/Kconfig"
>>  
>>  source "drivers/net/hippi/Kconfig"
>>  
>> +source "drivers/net/ipa/Kconfig"
>> +
>>  config NET_SB1000
>>  	tristate "General Instruments Surfboard 1000"
>>  	depends on PNP
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>> index 65967246f240..94b60800887a 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -47,6 +47,7 @@ obj-$(CONFIG_ETHERNET) += ethernet/
>>  obj-$(CONFIG_FDDI) += fddi/
>>  obj-$(CONFIG_HIPPI) += hippi/
>>  obj-$(CONFIG_HAMRADIO) += hamradio/
>> +obj-$(CONFIG_QCOM_IPA) += ipa/
>>  obj-$(CONFIG_PLIP) += plip/
>>  obj-$(CONFIG_PPP) += ppp/
>>  obj-$(CONFIG_PPP_ASYNC) += ppp/
>> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
>> new file mode 100644
>> index 000000000000..b8cb7cadbf75
>> --- /dev/null
>> +++ b/drivers/net/ipa/Kconfig
>> @@ -0,0 +1,19 @@
>> +config QCOM_IPA
>> +	tristate "Qualcomm IPA support"
>> +	depends on ARCH_QCOM && 64BIT && NET
>> +	select QCOM_QMI_HELPERS
>> +	select QCOM_MDT_LOADER
>> +	default QCOM_Q6V5_COMMON
>> +	help
>> +	  Choose Y or M here to include support for the Qualcomm
>> +	  IP Accelerator (IPA), a hardware block present in some
>> +	  Qualcomm SoCs.  The IPA is a programmable protocol processor
>> +	  that is capable of generic hardware handling of IP packets,
>> +	  including routing, filtering, and NAT.  Currently the IPA
>> +	  driver supports only basic transport of network traffic
>> +	  between the AP and modem, on the Qualcomm SDM845 SoC.
>> +
>> +	  Note that if selected, the selection type must match that
>> +	  of QCOM_Q6V5_COMMON (Y or M).
>> +
>> +	  If unsure, say N.
>> diff --git a/drivers/net/ipa/Makefile b/drivers/net/ipa/Makefile
>> new file mode 100644
>> index 000000000000..afe5df1e6eee
>> --- /dev/null
>> +++ b/drivers/net/ipa/Makefile
>> @@ -0,0 +1,12 @@
>> +# Un-comment the next line if you want to validate configuration data
>> +#ccflags-y		+=	-DIPA_VALIDATE
>> +
>> +obj-$(CONFIG_QCOM_IPA)	+=	ipa.o
>> +
>> +ipa-y			:=	ipa_main.o ipa_clock.o ipa_reg.o ipa_mem.o \
>> +				ipa_table.o ipa_interrupt.o gsi.o gsi_trans.o \
>> +				ipa_gsi.o ipa_smp2p.o ipa_uc.o \
>> +				ipa_endpoint.o ipa_cmd.o ipa_modem.o \
>> +				ipa_qmi.o ipa_qmi_msg.o
>> +
>> +ipa-y			+=	ipa_data-sdm845.o ipa_data-sc7180.
Yes, a needed patch defining field_max() is missing.  I sent
an updated request to include it in net-next to resolve this
issue.

  https://lore.kernel.org/netdev/20200311024240.26834-1-elder@linaro.org/

Thank you for pointing it out.

					-Alex

> This patch is also causing build issues on the current -next ...
> 
>   CC [M]  drivers/net/ipa/gsi.o
>   In file included from include/linux/build_bug.h:5:0,
>                    from include/linux/bitfield.h:10,
>                    from drivers/net/ipa/gsi.c:9:
>   drivers/net/ipa/gsi.c: In function ‘gsi_validate_build’:
>   drivers/net/ipa/gsi.c:220:39: error: implicit declaration of function ‘field_max’ [-Werror=implicit-function-declaration]
>     BUILD_BUG_ON(GSI_RING_ELEMENT_SIZE > field_max(ELEMENT_SIZE_FMASK));
>                                          ^
>   include/linux/compiler.h:374:9: note: in definition of macro ‘__compiletime_assert’
>      if (!(condition))     \
>            ^~~~~~~~~
>   include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
>     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>     ^~~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>     ^~~~~~~~~~~~~~~~
>   drivers/net/ipa/gsi.c:220:2: note: in expansion of macro ‘BUILD_BUG_ON’
>     BUILD_BUG_ON(GSI_RING_ELEMENT_SIZE > field_max(ELEMENT_SIZE_FMASK));
>     ^~~~~~~~~~~~
> 
> Jon 
> 

