Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212E9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90D720734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qu8JISPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGQF6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgGQF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:58:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEDC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:58:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so9756388wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=y+sfitwB9RQXaHMyhrlOuoxQi7jIpz91CNFJlZFY97c=;
        b=qu8JISPQkUB+/IPHcl7tm++fpzdju53pbghz0M3vQRg3INR1HbX2hwy6yUQtMYS64+
         Q1kS18Kh+E0JPqarrQf9TgLpRss2QNRjGGdLKafs4z0MQ0aQsYMUIc+T6GJQcoecm++G
         1VIo7+n5BELKEg6j1MrNrovTgKRBY4PLAUr8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=y+sfitwB9RQXaHMyhrlOuoxQi7jIpz91CNFJlZFY97c=;
        b=Ra0DLb27OM2pYK0pH3qWRGNE5Vfj0ouiAyIfnMyOgEt8AjIaKaIVS8P8UKJgXJYJXh
         P9dNNYgkxGovdGiAOkIDx9HDlk0BupJRkrGGFr34HwTZDptnJiO5XGYlHd3nNwiEwz8O
         a7BPBg3bIZvWJCZTQshNbCh3koqmq6KN4y1yXW0LGkx8GC18JlKBrWNyfctipKryuAK2
         FH8LJM6dGkc3tRChLSg+oVJvI4diuXBUlFACF6colzdCt/c4uo2pghWVe0w+pQD3cHBV
         bqi0OAfMEXcBTnb7aG/2XdiTAtdIlhX8gK5TgDpnJ/C/e4+H2LUf+w4qDTeiI9QP/xRA
         gsCA==
X-Gm-Message-State: AOAM530sla4UTMVnbjHcMVCluZvIs2fX+ihDd0ojOGIymebiRrpGr2rq
        B+4tC4dL31nVgBhKgFe68EPdwDOXtO8=
X-Google-Smtp-Source: ABdhPJy+tMl3Mc4bvC023mYG8ty1ClwLPLvia450TWxXXjtuL1Pi3mo4227XLeRNv+QHyYzCwL72eA==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr8433221wro.126.1594965487346;
        Thu, 16 Jul 2020 22:58:07 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-d401-59e4-6cf2-294a.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:d401:59e4:6cf2:294a])
        by smtp.gmail.com with ESMTPSA id j4sm13167679wrp.51.2020.07.16.22.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:58:06 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <20200716081337.GB32107@kitsune.suse.cz>
References: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com> <20200716081337.GB32107@kitsune.suse.cz>
Date:   Fri, 17 Jul 2020 15:58:01 +1000
Message-ID: <87pn8uu1hy.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Wed, Jul 15, 2020 at 07:52:01AM -0400, Nayna Jain wrote:
>> The device-tree property to check secure and trusted boot state is
>> different for guests(pseries) compared to baremetal(powernv).
>>=20
>> This patch updates the existing is_ppc_secureboot_enabled() and
>> is_ppc_trustedboot_enabled() functions to add support for pseries.
>>=20
>> The secureboot and trustedboot state are exposed via device-tree propert=
y:
>> /proc/device-tree/ibm,secure-boot and /proc/device-tree/ibm,trusted-boot
>>=20
>> The values of ibm,secure-boot under pseries are interpreted as:
>                                       ^^^
>>=20
>> 0 - Disabled
>> 1 - Enabled in Log-only mode. This patch interprets this value as
>> disabled, since audit mode is currently not supported for Linux.
>> 2 - Enabled and enforced.
>> 3-9 - Enabled and enforcing; requirements are at the discretion of the
>> operating system.
>>=20
>> The values of ibm,trusted-boot under pseries are interpreted as:
>                                        ^^^
> These two should be different I suppose?

I'm not quite sure what you mean? They'll be documented in a future
revision of the PAPR, once I get my act together and submit the
relevant internal paperwork.

Daniel
>
> Thanks
>
> Michal
>> 0 - Disabled
>> 1 - Enabled
>>=20
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> Reviewed-by: Daniel Axtens <dja@axtens.net>
>> ---
>> v3:
>> * fixed double check. Thanks Daniel for noticing it.
>> * updated patch description.
>>=20
>> v2:
>> * included Michael Ellerman's feedback.
>> * added Daniel Axtens's Reviewed-by.
>>=20
>>  arch/powerpc/kernel/secure_boot.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/sec=
ure_boot.c
>> index 4b982324d368..118bcb5f79c4 100644
>> --- a/arch/powerpc/kernel/secure_boot.c
>> +++ b/arch/powerpc/kernel/secure_boot.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/types.h>
>>  #include <linux/of.h>
>>  #include <asm/secure_boot.h>
>> +#include <asm/machdep.h>
>>=20=20
>>  static struct device_node *get_ppc_fw_sb_node(void)
>>  {
>> @@ -23,12 +24,19 @@ bool is_ppc_secureboot_enabled(void)
>>  {
>>  	struct device_node *node;
>>  	bool enabled =3D false;
>> +	u32 secureboot;
>>=20=20
>>  	node =3D get_ppc_fw_sb_node();
>>  	enabled =3D of_property_read_bool(node, "os-secureboot-enforcing");
>> -
>>  	of_node_put(node);
>>=20=20
>> +	if (enabled)
>> +		goto out;
>> +
>> +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot))
>> +		enabled =3D (secureboot > 1);
>> +
>> +out:
>>  	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
>>=20=20
>>  	return enabled;
>> @@ -38,12 +46,19 @@ bool is_ppc_trustedboot_enabled(void)
>>  {
>>  	struct device_node *node;
>>  	bool enabled =3D false;
>> +	u32 trustedboot;
>>=20=20
>>  	node =3D get_ppc_fw_sb_node();
>>  	enabled =3D of_property_read_bool(node, "trusted-enabled");
>> -
>>  	of_node_put(node);
>>=20=20
>> +	if (enabled)
>> +		goto out;
>> +
>> +	if (!of_property_read_u32(of_root, "ibm,trusted-boot", &trustedboot))
>> +		enabled =3D (trustedboot > 0);
>> +
>> +out:
>>  	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
>>=20=20
>>  	return enabled;
>> --=20
>> 2.26.2
>>=20
