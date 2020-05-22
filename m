Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5AAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DEE205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590160510;
	bh=cLN/1dFoaFcTKkp9vKon4k1Sk1kkm2Qiz0upGgWeafk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ajWyPcXPQWHR8zRPa9ZM1NwfKR2DoYPEcHcue5EogDFvjZI7PosPU03PnIYl81Ulo
	 sooMYg59NGOGiCCokF4At70dQm3rH+thCfX8Kz4GrLeJSCvI1tO22pohUjhLiH85Q+
	 GPYBIp42hNo8iREAM0QIV/PRHOdR3PexQvjxg6tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgEVPPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgEVPPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:15:08 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19F4205CB;
        Fri, 22 May 2020 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590160508;
        bh=cLN/1dFoaFcTKkp9vKon4k1Sk1kkm2Qiz0upGgWeafk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lAahHTbwTtpWoyeMHvVfIOgKx5WmFijyloooFCa/GtG4NHBJrLybwa8GWM2UnGAgK
         Wqgw7+4cRYEN7LUOf/jR3+oJTeFx1gRwoeMB3JAFOykemv/S8Sa/rldLYN8o4TV+CT
         EL1QjeO5NpAvjkYx6TCiPSSRkNcGeyMX8Rb2zi6A=
Subject: Re: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-4-broonie@kernel.org>
 <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
 <20200519174452.GR4611@sirena.org.uk>
 <0f1a7c29-340d-f61b-b102-d300932dc92c@kernel.org>
 <20200522151222.GJ5801@sirena.org.uk>
From:   shuah <shuah@kernel.org>
Message-ID: <278c9a47-4d68-0e0d-415d-53360337aa6c@kernel.org>
Date:   Fri, 22 May 2020 09:15:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522151222.GJ5801@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 9:12 AM, Mark Brown wrote:
> On Fri, May 22, 2020 at 08:55:50AM -0600, shuah wrote:
>> On 5/19/20 11:44 AM, Mark Brown wrote:
> 
>>>> WARNING: Missing a blank line after declarations
>>>> WARNING: Missing a blank line after declarations
>>>> #135: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:27:
>>>> +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
> 
>> A blank line after declarations here just like what checkpatch
>> suggests. It makes it readable.
> 
> That doesn't match the idiom used by any of the surrounding code :(
> 

I can't parse the idiom statement? Can you clarify it please.

thanks,
-- Shuah
