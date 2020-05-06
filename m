Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0DC47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB20B206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="irmDAXio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgEFBqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 21:46:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35864 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgEFBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:46:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588729568; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=BK0DEhUgdXQYN+GhpaoU3mpZVemoOcCiMLZOzsspLKo=; b=irmDAXioY50HRo29rOoiDzCb7kW7fKuwrryClmh/Ld+iQsCbJ2TsZUey00qJm67X84SQbjNf
 qj/PcY/P5ckBHvxeLN+tpCNQW6Ucx1ikXib1tg2RTiP9D+fjtdkcYuqnGlTiUksyff9agt8P
 lsvZfhuIOw3PbyUsZEPX6NtpO74=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb216d0.7fcd1550cd88-smtp-out-n03;
 Wed, 06 May 2020 01:45:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4EEFC433F2; Wed,  6 May 2020 01:45:52 +0000 (UTC)
Received: from [192.168.1.10] (cpe-70-95-5-60.san.res.rr.com [70.95.5.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E803AC433D2;
        Wed,  6 May 2020 01:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E803AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: [PATCH v2] scripts: headers_install: Exit with error on config
 leak
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1588476545-21082-1-git-send-email-sidgup@codeaurora.org>
 <CAK7LNAQ55OPgiUOdoXDHqD_p3ntiUctqmVhAmO9fRuoq=uAV7g@mail.gmail.com>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <2407804b-d5eb-7de3-c639-add3132d39b6@codeaurora.org>
Date:   Tue, 5 May 2020 18:45:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ55OPgiUOdoXDHqD_p3ntiUctqmVhAmO9fRuoq=uAV7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2020 12:18 AM, Masahiro Yamada wrote:
> On Sun, May 3, 2020 at 12:29 PM Siddharth Gupta <sidgup@codeaurora.org> wrote:
>> Misuse of CONFIG_* in UAPI headers should result in an error as it exposes
>> configuration of different targets to userspace.
>
> Sorry, I missed to point out this.
>
> This statement is not precious; it does not expose the kernel
> configuration at all.
>
> include/generated/autoconf.h is not available from userspace.
> So, all the CONFIG options are undefined.
>
> Could you reword the commit somehow?
>
Sure. I just meant that if a CONFIG_* is present in the UAPI header it 
can be set in a
userspace application that includes the header to manipulate the control 
flow in a
kernel that might support multiple targets.

I'll update the commit text and send out an updated patch.

Thanks,
Siddharth

>
>
>
>> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
>> ---
>>   scripts/headers_install.sh | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
>> index a07668a..94a8335 100755
>> --- a/scripts/headers_install.sh
>> +++ b/scripts/headers_install.sh
>> @@ -64,7 +64,7 @@ configs=$(sed -e '
>>          d
>>   ' $OUTFILE)
>>
>> -# The entries in the following list are not warned.
>> +# The entries in the following list do not result in an error.
>>   # Please do not add a new entry. This list is only for existing ones.
>>   # The list will be reduced gradually, and deleted eventually. (hopefully)
>>   #
>> @@ -98,18 +98,19 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
>>
>>   for c in $configs
>>   do
>> -       warn=1
>> +       leak_error=1
>>
>>          for ignore in $config_leak_ignores
>>          do
>>                  if echo "$INFILE:$c" | grep -q "$ignore$"; then
>> -                       warn=
>> +                       leak_error=
>>                          break
>>                  fi
>>          done
>>
>> -       if [ "$warn" = 1 ]; then
>> -               echo "warning: $INFILE: leak $c to user-space" >&2
>> +       if [ "$leak_error" = 1 ]; then
>> +               echo "error: $INFILE: leak $c to user-space" >&2
>> +               exit 1
>>          fi
>>   done
>>
>> --
>> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>
>
