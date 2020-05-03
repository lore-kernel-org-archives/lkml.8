Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7BFC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 03:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530EB20707
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 03:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ju9Fo+gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgECD2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 23:28:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:47906 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbgECD2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 23:28:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588476497; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=38CwaZVZhRUHC/p6LzfUrxvI9XPpaLMCJGwUs68QbLQ=; b=ju9Fo+gvj8BWoxJu5dgtr1uzpSh00m/Z2VVIrJENWjIqg/vmqcxv9+uo3cVBXGvrg9peuN8i
 iGAmzw9uoIpq6zRcceUXnW5CHo3dI+BN1tnp7eT2YPzR6k6FQ84zVV6x9fOYaDr8tfdmfEPz
 6FcJoMCOCKACEgc+6Tc1EEDfpOw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eae3a3d.7f35333fea40-smtp-out-n01;
 Sun, 03 May 2020 03:27:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1510AC433BA; Sun,  3 May 2020 03:27:56 +0000 (UTC)
Received: from [192.168.1.10] (cpe-70-95-5-60.san.res.rr.com [70.95.5.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57422C433D2;
        Sun,  3 May 2020 03:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57422C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: [PATCH] scripts: headers_install: Exit with error on config leak
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1588370065-30312-1-git-send-email-sidgup@codeaurora.org>
 <CAK7LNARPH+hZdo-0_pmOzZNqTHj7rJTMQq9Nd_F-oyqK2zJrtQ@mail.gmail.com>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <2a04e6ca-4c44-f3b2-4c68-e7cdc26e9baf@codeaurora.org>
Date:   Sat, 2 May 2020 20:27:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARPH+hZdo-0_pmOzZNqTHj7rJTMQq9Nd_F-oyqK2zJrtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure I will make the recommended changes and send a v2 of the patch.

Thanks,
Siddharth

On 5/2/2020 8:03 AM, Masahiro Yamada wrote:
> On Sat, May 2, 2020 at 6:55 AM Siddharth Gupta <sidgup@codeaurora.org> wrote:
>> Misuse of CONFIG_* in UAPI headers should result in an error as it exposes
>> configuration of different targets to userspace.
>>
>> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
>> ---
>>   scripts/headers_install.sh | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
>> index a07668a..bd6c93a 100755
>> --- a/scripts/headers_install.sh
>> +++ b/scripts/headers_install.sh
>> @@ -109,7 +109,8 @@ do
>>          done
>>
>>          if [ "$warn" = 1 ]; then
>> -               echo "warning: $INFILE: leak $c to user-space" >&2
>> +               echo "error: $INFILE: leak $c to user-space" >&2
>> +               exit 1
>>          fi
>>   done
>
> If you want to change this,
> please update the comment at line 67.
>
> Also, rename the variable $warn to
> something else, $error or $leak_error, etc. ?
>
>
>
