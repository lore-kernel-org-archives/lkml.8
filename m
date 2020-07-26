Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB5F2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpdTiDHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGZJ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:57:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88754C0619D2;
        Sun, 26 Jul 2020 02:57:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so6647723pls.4;
        Sun, 26 Jul 2020 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bEioRYPAU2RstGlAFkLfimzj4h56/cP3ARZGSjW0G+c=;
        b=tpdTiDHFIiZFLuKluIaRVXv06TsoqDVgPwWzaH0QECxEo4oSyVEq1VC0tviqxot+Iw
         cJ6C/bEoWGEN9rDc1Gf7/6xDdUxiWmRhqDIv3t76STpvog04kGjY5KU4TVYansjogzTm
         5PCyq3FdG4f0EQzIfPv4+PnspWSQnnLzpUOzEEeZ3xW3b3opihQLJKNHz4USvyPArOsU
         X8FJZmz/PdQM7ieLTuYNyYZnenAYowmXRwZpnYeABoqj/v2Yv+myAOgwf3FSS3YfI+JT
         SGBwV9zMsC2k3cwYk9LcE2tKUCYEEf5Y4akzhfa3BJmtbAsZQr1ud55k4w+Td+nwmx5m
         TzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bEioRYPAU2RstGlAFkLfimzj4h56/cP3ARZGSjW0G+c=;
        b=VjfRNHGqEyqhksX/zKscQvOy8UJuMXPeubprlQgepjgZQOBV1JRN5bLnzMs6VqCDlV
         +TZNkFwPFrN0DSlAYCfMVWG1eeVSIDS+ZNGc/Y/Odaf/2K5PEYjm5C3qzxGgX9B3oJmw
         u8SLTfvkn5b/wDAapNx5g3n2UuD1J7qBCkf/IxDtAnI829L0qlz1Bu8W6msX9tYMLY0m
         u/UFrUhj5AYkioRTCF8EjGq4zGzf8+RXT/SxK2yiRlhzHu1nkcbW1a5qy1BApBT39i4a
         eBCuGm2jp49LOnXm0RZzLY+RsvSY2A/cbcU6M/kqW1XrEsDm+2a9B3VolLFuE9W0iJFL
         aIHA==
X-Gm-Message-State: AOAM531GYRZRM3lwjPjLdfp/ZMp16ysL7KIfbkJXDtXUZ+QbhVqjpJWJ
        FbuO1HWlgAOPRPvJClALQibxkFmER6M=
X-Google-Smtp-Source: ABdhPJwKh0EIayObse8Qy8n0W1VwaAasvfCJ0LRmd2NS2jKpgG0P1TwE7UAjWyjG34tYjDtaeptBmQ==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr14742514plz.207.1595757421604;
        Sun, 26 Jul 2020 02:57:01 -0700 (PDT)
Received: from [192.168.0.109] ([1.186.115.27])
        by smtp.gmail.com with ESMTPSA id k12sm1101356pjp.38.2020.07.26.02.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 02:57:00 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] staging: media: atomisp: fix style of open brace
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20200726062541.11304-1-bharadwaj.rohit8@gmail.com>
 <20200726090512.20574-2-bharadwaj.rohit8@gmail.com>
 <20200726114224.1825a769@coco.lan>
From:   Rohit K Bharadwaj <bharadwaj.rohit8@gmail.com>
Message-ID: <33c496d9-227e-995e-3b43-3a64bc5163b5@gmail.com>
Date:   Sun, 26 Jul 2020 15:26:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726114224.1825a769@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/20 3:12 pm, Mauro Carvalho Chehab wrote:
> Em Sun, 26 Jul 2020 14:35:12 +0530
> Rohit K Bharadwaj <bharadwaj.rohit8@gmail.com> escreveu:
> 
>> this patch fixes style of open brace after functions and if statements
>>
>> Signed-off-by: Rohit K Bharadwaj <bharadwaj.rohit8@gmail.com>
> 
>> @@ -119,8 +121,9 @@ sh_css_load_blob_info(const char *fw, const struct ia_css_fw_info *bi,
>>  	blob = (const unsigned char *)fw + bi->blob.offset;
>>  
>>  	/* sanity check */
>> -	if (bi->blob.size != bi->blob.text_size + bi->blob.icache_size + bi->blob.data_size + bi->blob.padding_size)
>> -	{
>> +	if (bi->blob.size !=
>> +		bi->blob.text_size + bi->blob.icache_size +
>> +		bi->blob.data_size + bi->blob.padding_size) {
> 
> 
> Please adjust the alignments here. I'm pretty sure checkpatch --strict
> will end complaining with the above, as the first line ends with "=".
> 
> I would, instead, code it as:
> 
> 	if (bi->blob.size != bi->blob.text_size + bi->blob.icache_size +
> 			     bi->blob.data_size + bi->blob.padding_size) {
> 
> 
> Thanks,
> Mauro
> 
sure sir, do I have to make a v4 of the patch and send all the patches in this series again or should I just send this one particular patch again?
