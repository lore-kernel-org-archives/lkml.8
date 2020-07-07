Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B4BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC34206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="HyYZhLAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGGCyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGGCyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:54:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5BC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 19:54:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so2741409pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 19:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uL+u54kAN0vdigP3z+4QjbZ4X6Oq7pDJNkdTZIlJYJ4=;
        b=HyYZhLAPV/GbIMvVEvXnaysuK+pvXqXZMlpg2LhQm2tg6Kff2t5NOAkAliIMIvSRSW
         ne3kFud0soOOpwu5sJDBx29IsRgeMZJ/+/TIk14hHTtB7klyayK6z6FJC7A72N1zWOGM
         Vm2mdyPUQeYLf8NMb1t1uNPx5Fd2k/gsmYQg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uL+u54kAN0vdigP3z+4QjbZ4X6Oq7pDJNkdTZIlJYJ4=;
        b=m2tagkd0KKToVK1lwHEYcd0FtFVOIMz54wd1/B9uwITc/BngAO/Wnolxx9gCFKoa3I
         XMc077vxIMyNQat8nb3GSPmkaetAue12xNFnWWz92/Eu8VHOXBr4Y9MH220vF9pusxCQ
         Cu5uw7EVtF/IP8HMBuUVtMkRsVbrf10jMncoBiYQ9UwtWeY1TfEXM4YcpAR34wiB4tpm
         yaNUnZUFcuesDOWlBYkY192iFSJ0WRQb4RvlvGsbDVENlIDcp6JxHu40+WV0pvZsQqkd
         D4NYdpzNb3FQaaZk+wKhnAHLiIvQ8rAvpe9qc6IpuzY0FR5QROXWOswyU+vid0cthCFT
         O2Wg==
X-Gm-Message-State: AOAM532yGry5q+iISaLo/IDRX66mls5Zlc85OjZrPU4pCpY1/1www6DP
        mQ6K4fWeLiuZEGyJsoSFv8mYWNPo+zk=
X-Google-Smtp-Source: ABdhPJydTedQP0WCMt9r+mt/YvU9qMMT2g6MeCJlK1HVDrQjvQTz9fcC4hWG4HDltBMzOluGZFi8Yg==
X-Received: by 2002:a17:902:c181:: with SMTP id d1mr41865027pld.176.1594090439689;
        Mon, 06 Jul 2020 19:53:59 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-4ddf-cfaf-3be5-4008.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4ddf:cfaf:3be5:4008])
        by smtp.gmail.com with ESMTPSA id s36sm20319480pgl.35.2020.07.06.19.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 19:53:58 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <87a70c3wpj.fsf@dja-thinkpad.axtens.net>
References: <1593882535-21368-1-git-send-email-nayna@linux.ibm.com> <87a70c3wpj.fsf@dja-thinkpad.axtens.net>
Date:   Tue, 07 Jul 2020 12:53:56 +1000
Message-ID: <875zb03uij.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a final extra note,

  https://github.com/daxtens/qemu/tree/pseries-secboot

is a qemu repository that fakes out the relevant properties if anyone
else wants to test this.

Also,

>  3-9 - enabled, OS-defined behaviour. In this patch we map all these
>        values to enabled and enforcing. Again I think this is the
>        appropriate thing to do.

this should read "enabled and enforcing, requirements are at the
discretion of the operating system". Apologies.

Regards,
Daniel

> ibm,trusted-boot isn't published by a current PowerVM LPAR but will be
> published in future. (Currently, trusted boot state is inferred by the
> presence or absense of a vTPM.) It's simply 1 = enabled, 0 = disabled.
>
> As for this patch specifically, with the very small nits below,
>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
>
>> -	node = get_ppc_fw_sb_node();
>> -	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
>> +	if (machine_is(powernv)) {
>> +		node = get_ppc_fw_sb_node();
>> +		enabled =
>> +		    of_property_read_bool(node, "os-secureboot-enforcing");
>> +		of_node_put(node);
>> +	}
>>  
>> -	of_node_put(node);
>> +	if (machine_is(pseries)) {
> Maybe this should be an else if?
>
>> +		secureboot = of_get_property(of_root, "ibm,secure-boot", NULL);
>> +		if (secureboot)
>> +			enabled = (*secureboot > 1) ? true : false;
>> +	}
>>  
>>  	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
>>  
>> @@ -38,11 +48,20 @@ bool is_ppc_trustedboot_enabled(void)
>>  {
>>  	struct device_node *node;
>>  	bool enabled = false;
>> +	const u32 *trustedboot;
>>  
>> -	node = get_ppc_fw_sb_node();
>> -	enabled = of_property_read_bool(node, "trusted-enabled");
>> +	if (machine_is(powernv)) {
>> +		node = get_ppc_fw_sb_node();
>> +		enabled = of_property_read_bool(node, "trusted-enabled");
>> +		of_node_put(node);
>> +	}
>>  
>> -	of_node_put(node);
>> +	if (machine_is(pseries)) {
> Likewise.
>> +		trustedboot =
>> +		    of_get_property(of_root, "ibm,trusted-boot", NULL);
>> +		if (trustedboot)
>> +			enabled = (*trustedboot > 0) ? true : false;
>
> Regards,
> Daniel
