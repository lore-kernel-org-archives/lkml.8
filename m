Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA62C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF345206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TbBzfxZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgGHEKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGHEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:09:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D00C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 21:09:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so1436893wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ilI7WEFMs52fTeVVrHkeXBa9IJvQJ7qH+weqiuJJPTs=;
        b=TbBzfxZFfsLMcGtGC78q2HblBN9s7ulUr/wTidJf6gF2sH0F3lj7FerTPtq8wbqsvY
         wf6vCxP7JZbWvKDHhlqMlpDIk0yNDclKwTZwmm4HtDzyi0bppXy7QSWfkpSGHtyFWlzB
         v6Zd9iPuBbYIQJZi5tpgLxfTbvnN4znPIvxqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ilI7WEFMs52fTeVVrHkeXBa9IJvQJ7qH+weqiuJJPTs=;
        b=c2bfvAr1G7opVVoPfpnyW0uX6fia/JwNC6waQ4oGnLfgJDaBCF/uyEQZnNlKbkqdLP
         ZQ33w/Qm+w5Nx2B+IGUTH3ls3ODoPBnJCINwFmEB0oKbnNwM0GUD9xJt3EJBipjYrbVO
         3T+e3AMCTEp/+hvZX1RonpDJXERTAQVOAZjYrf4U2wmd0ZEudvVQTDPDwph7HWirk8wx
         MAL35Q8fG0Ahxghdw1E7yzXCu2LwEEFb0VYmzeumK+QKE7jFGMLE4OWzSAUL3pFJwTjh
         dAux+X21eF88gG8afc5B/4gLCSOVCD/uon+BPOLKK7maB1P4/XmJOIIw0hI/iLEV5JPO
         RbzQ==
X-Gm-Message-State: AOAM533mXszXOw5sSXNa82GbilT8gKIJxTs7SgkxeQ2E8/PX+mHrzPsD
        8LPKRzr4GGR7ydlIFO8DMcYB0w==
X-Google-Smtp-Source: ABdhPJzMkMfdY/Rbu2MnIw7q0PnF3+oC3R8Ea0tD3Cc39M74dTsRNErCUO25uk9h+2k7iyJC+vvCqw==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr7413564wmk.149.1594181397195;
        Tue, 07 Jul 2020 21:09:57 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w2sm3467154wrs.77.2020.07.07.21.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:09:56 -0700 (PDT)
Subject: Re: [PATCH v10 4/9] test_firmware: add partial read support for
 request_firmware_into_buf
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-5-scott.branden@broadcom.com>
 <202007071659.38721F7@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b62a45d4-3df0-9e2f-f328-153277b8236e@broadcom.com>
Date:   Tue, 7 Jul 2020 21:09:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071659.38721F7@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-07 4:59 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:04PM -0700, Scott Branden wrote:
>> Add additional hooks to test_firmware to pass in support
>> for partial file read using request_firmware_into_buf.
>> buf_size: size of buffer to request firmware into
>> partial: indicates that a partial file request is being made
>> file_offset: to indicate offset into file to request
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> I am a fan of tests. :) If Luis gives an Ack here, you're good.
There were not even any tests for request_firmware_into_buf before I 
started this partial read support.
Fortunately those base changes have already been accepted so I think 
this change is a simple addition to those accepted patches.
>

