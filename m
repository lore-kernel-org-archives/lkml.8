Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38401 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgCKQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:27:30 -0400
Subject: Re: [PATCH 4.14 000/126] 4.14.173-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20200311130904.819648693@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <93f0b56a-f11c-5c29-5a80-041103273e41@roeck-us.net>
Date: Wed, 11 Mar 2020 09:27:25 -0700
MIME-Version: 1.0
In-Reply-To: <20200311130904.819648693@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/20 6:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.173 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2020 13:08:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.173-rc2.gz

For v4.14.172-127-gc23e0b0dc693:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 401 pass: 401 fail: 0

It would be helpful to have a more prominent indication that this is -rc2.

Thanks,
Guenter

