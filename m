Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DF4C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3B4206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579205593;
	bh=fPP11jfjDsjW6JkTbSPKOQE44w8JcAdCqd6Zok8K0Rk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ay3CzjfU/3z2bfQBr78VTWh/GrdBnMdFZwlij4Mg36JQZfTrUq/n8StOQyNlf03Yi
	 L9v6Hcr9y0wDsp1mVyJ9jCJ2CaNH2ZpImCiufZfGvcK2QYpd7PW3x9emFGtEnHzjjM
	 wCQ7sb0EVUHA8rBuIhMC0mnBnWHo0bZDPJniOe+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgAPUNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730031AbgAPUNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:13:11 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3CB20663;
        Thu, 16 Jan 2020 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579205590;
        bh=fPP11jfjDsjW6JkTbSPKOQE44w8JcAdCqd6Zok8K0Rk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MjYBJTb4mO0VQE47tEHcptW+/xfnm8QuiiE8Z1Ru88f4hTrfdiYh7WnjYvvbx1mrD
         03v48LZXueLLw5+ZWjTSx0oX9S0Mswd+RSAynxTUcewAeCLgOEO6SeNkGMsUrEr/Qb
         vAKYYdmQ4EF+NCi+ruEEaqhu6rLxIZKSah6Laa1U=
Subject: Re: [PATCH][next] selftests: fix spelling mistake "chainged" ->
 "chained"
To:     Colin King <colin.king@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20191210112455.171482-1-colin.king@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2a02d10f-2ae1-acfc-d5c3-fe49dee9cba3@kernel.org>
Date:   Thu, 16 Jan 2020 13:13:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210112455.171482-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 4:24 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a literal string, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/testing/selftests/openat2/resolve_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
> index 7a94b1da8e7b..bbafad440893 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -230,7 +230,7 @@ void test_openat2_opath_tests(void)
>   		{ .name = "[in_root] garbage link to /root",
>   		  .path = "cheeky/garbageself",	.how.resolve = RESOLVE_IN_ROOT,
>   		  .out.path = "root",		.pass = true },
> -		{ .name = "[in_root] chainged garbage links to /root",
> +		{ .name = "[in_root] chained garbage links to /root",
>   		  .path = "abscheeky/garbageself", .how.resolve = RESOLVE_IN_ROOT,
>   		  .out.path = "root",		.pass = true },
>   		{ .name = "[in_root] relative path to 'root'",
> 

It didn't apply to linux-kselftest next

If this is going through opennat2 tree then,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If not I can this for 5.6-rc2

thanks,
-- Shuah
