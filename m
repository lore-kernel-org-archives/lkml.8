Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA36C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED26B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581434420;
	bh=Be6Zsbal8nGWhLXNcPwHMCsqIgYS3+azBCOwQNEdmPc=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=ikfdD5pnKAuY0DlaWE+xyqg1MWFEsVYg7G1jT8+kqk3K/Iehcb+U3J9ODsWXoxQov
	 5yo92m2+noXelESI8ATz2J8kWveC3NkT0xxFFM3JLLF7wXpz6cwmskTfAxownpL66r
	 Ovbmy9aPiEH/UdeTPm4xPP4q0H1Aj0mLyxLu8gi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgBKPUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgBKPUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:20:18 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F49F2086A;
        Tue, 11 Feb 2020 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581434418;
        bh=Be6Zsbal8nGWhLXNcPwHMCsqIgYS3+azBCOwQNEdmPc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=zUHhURWQCUBRmuutm1dzvilmd3/emPKY+MziJgo3D7+JGOkdiwk6WWGndFe5kN+Tq
         iglQpVXrmMVxKRdsVygBI6f4CUMqqCHEntsT8lqtT+8t/jMCRRSE2qRMPQ7cKyteka
         s1U6bGyNVWGo4EgneWMVuvyn5vjB4OxTR/o5tieQ=
Subject: Re: [PATCH] Removing a duplicate condition.
To:     Isaac Young <isaac.young5@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200211113257.451781-1-isaac.young5@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3bace0e9-7ce7-aaea-9a6c-3949a6e52a08@kernel.org>
Date:   Tue, 11 Feb 2020 08:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211113257.451781-1-isaac.young5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please include subsystem and test name in the subject line.

On 2/11/20 4:32 AM, Isaac Young wrote:
> Signed-off-by: Isaac Young <isaac.young5@gmail.com>

Missing commit log

> ---
>   tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> index 098bcae5f827..0954c7a8aa08 100644
> --- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> @@ -823,7 +823,7 @@ void test_select_reuseport(void)
>   
>   	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
>   	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
> -	if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)

This might not be the right fix. I think the check should be
if (saved_tcp_fo < 0 || saved_tcp_syncookie < 0)

at least makes the most sense based on the code.


> +	if (saved_tcp_syncookie < 0)
>   		goto out;
>   
>   	if (enable_fastopen())
> 

thanks,
-- Shuah
