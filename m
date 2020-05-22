Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDDA206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590187219;
	bh=6VBOAlJoPz7ULVbRUKA5Ubh9oBBqQcvYDNDgMR9WFV0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=x7AIgvi4bJxqg2RQAZuPik1j6HCdH1Jbf8RpWmThveRP+vlL75gPPGJ95VjDaE7JQ
	 XPDrVDlj1eq+3mAueyzNCjv5wZTNTPId9otjyrVUCljC7VQxCirvkTbHUk3gMWH/L8
	 f8BhF9/RuOzKs92/axdXVAj82EooiicAx2q+NlUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgEVWkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgEVWkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:40:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BAD204EA;
        Fri, 22 May 2020 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590187217;
        bh=6VBOAlJoPz7ULVbRUKA5Ubh9oBBqQcvYDNDgMR9WFV0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sLAEowTmi27guJYKxjE/VKhXLyK8DZ6lvfw1B89SHMNT6kak7yzdTRwF8hFe4AxYK
         4b7GNkzsTpyWAmxTxcck5pvku4zKB10WJdFmRyJvE5OYjEF4C+xMboOt+EAbACr2Lt
         j/hS/M8Q1nTfERX9RPmPq1dxmvnyoTlMLVNQGL5M=
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
To:     Brendan Higgins <brendanhiggins@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Gow <davidgow@google.com>, shuah <shuah@kernel.org>
References: <20200414230950.83665-1-vitor@massaru.org>
 <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
Date:   Fri, 22 May 2020 16:40:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 5:11 PM, Brendan Higgins wrote:
> On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>>
>> To make KUnit easier to use, and to avoid overwriting object and
>> .config files, the default KUnit build directory is set to .kunit
>>
>>   * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221
>>
>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Applied the patch to kselftest/kunit on top of

45ba7a893ad89114e773b3dc32f6431354c465d6
kunit: kunit_tool: Separate out config/build/exec/parse

from David's work resolving merge conflicts. Please check if it is
sane.

thanks,
-- Shuah
